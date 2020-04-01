package com.yskj.controller;

import com.alibaba.druid.support.json.JSONUtils;
import com.google.gson.Gson;
import com.yskj.models.GroupChatNoread;
import com.yskj.models.Grouplist;
import com.yskj.models.QueryParam;
import com.yskj.models.SocketInformation;
import com.yskj.service.GroupChatNoreadService;
import com.yskj.service.GrouplistService;
import com.yskj.service.PositionService;
import com.yskj.service.SocketInformationService;
import com.yskj.utils.DateUtils;
import com.yskj.utils.SpringContextUtil;
import com.yskj.utils.UUIDGenerator;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@ServerEndpoint("/websocket/{sendUser}")
public class WebSocketController {

    //
    //@Autowired
    private SocketInformationService socketInformationService ;

    private GrouplistService grouplistService ;

    private PositionService positionService ;

    private GroupChatNoreadService groupChatNoreadService ;

    // 用户在线数
    private static int onLineCount = 0;
    // 当前的websocket对象
    private static ConcurrentHashMap<String, WebSocketController> webSocketMap = new ConcurrentHashMap<String, WebSocketController>();
    // 当前会话,属于websocket的session
    private Session session;
    // 聊天信息
    private String sendUser;// 当前用户
    private String toUser;// 接收人
    private String message;// 聊天信息
    /**
     * 连接建立成功调用的方法
     * @param session 可选的参数。session为与某个客户端的连接会话，需要通过它来给客户端发送数据
     * @PathParam("sendUser") 表示可以在访问的时候带上参数，参数：sendUser为  @ServerEndpoint("/chatDemo/{sendUser}")
     * @throws IOException
     */
    @OnOpen
    public void onOpen(@PathParam("sendUser") String sendUser, Session session) throws IOException {
        if(!"0".equals(sendUser)){
            this.sendUser = sendUser;
            this.session = session;
            addOnlineCount();
            /*System.out.println("有新连接加入！当前在线人数为" + getOnlineCount() + " 当前session是" + session.hashCode());*/

            webSocketMap.put(sendUser, this);//当前用户的websocket
        /*// 刷新在线人数
        for (WebSocketController chat : webSocketMap.values()) {
            //使用if判断是要统计人数还是发送消息
            chat.sendMessage("count",getOnlineCount() + "");
        }*/
        }
    }

    /**
     * 连接关闭所调用的方法
     *
     * @return
     * @throws IOException
     */
    @OnClose
    public void onClose() throws IOException {
        // 在线数减1
        subOnlineCount();
        for (WebSocketController chat : webSocketMap.values()) {
            //说明当前的session已经被关闭
            if(chat.session != this.session){
                /*System.out.println("连接关闭！");*/
            }
        }
        webSocketMap.remove(sendUser);
        System.out.println("有一连接关闭！当前在线人数为" + getOnlineCount());
    }

    /**
     * 收到客户端的消息后所调用的方法
     *
     * @param session  可选的参数，同上
     * @throws IOException
     */
    @OnMessage
    public void onMessage(String jsonMsg, Session session) throws Exception {
        Map<String,String> msgMap = (Map<String,String>)JSONUtils.parse(jsonMsg);
        SocketInformation socketInformation = new SocketInformation();

        sendUser = msgMap.get("sendUser");

        toUser = msgMap.get("toUser");

        message = msgMap.get("message");
        if (toUser.indexOf("group_") == -1){
            userC2CSend(socketInformation);
        }else{
            groupSendMsg(socketInformation);
        }

    }

    /**
     *  群消息发送。
     * @param socketInformation
     * @throws IOException
     */
    public void groupSendMsg(SocketInformation socketInformation) throws Exception{
        List<Grouplist> grouplistList = getGrouplistService().getGroupUser(toUser);
        socketInformation.setMesssag(message);
        socketInformation.setFromuser(sendUser);
        socketInformation.setTouser(toUser);
        SocketInformation obj = getSocketInformationService().getGrouplistSessionID(toUser);
        if (obj == null){
            socketInformation.setSessionID("group_"+UUIDGenerator.randomUUID());
        }else{
            socketInformation.setSessionID(obj.getSessionID());
        }
        socketInformation.setId(UUIDGenerator.randomUUID());
        socketInformation.setVersion(1);
        socketInformation.setCreateTime(new Date());
        getSocketInformationService().getDao().add(socketInformation);
        for (Grouplist grouplist : grouplistList){
            boolean tempFlag = true ;
            WebSocketController user = webSocketMap.get(grouplist.getUserID());
            WebSocketController user1 = webSocketMap.get(grouplist.getUserID() + "-");
            WebSocketController user2 = webSocketMap.get(grouplist.getUserID() + "+");
            if(!grouplist.getUserID().equals(sendUser)){
                if (user1 != null){
                    user = user1 ;
                    tempFlag = false ;
                }else if (user2 != null){
                    user = user2 ;
                    tempFlag = false ;
                }else if (user == null && user1 == null && user2 == null ){
                    tempFlag = false ;
                }

                QueryParam queryParam = new QueryParam("groupID",toUser);
                queryParam.put("userID",grouplist.getUserID());
                GroupChatNoread groupChatNoread = getGroupNoreadService().getNoReadCount(queryParam);
                if(groupChatNoread == null){
                    groupChatNoread = new GroupChatNoread();
                    groupChatNoread.setGroupID(toUser);
                    groupChatNoread.setUserID(grouplist.getUserID());
                    groupChatNoread.setNoreadcount(1);
                }else{
                    groupChatNoread.setNoreadcount(groupChatNoread.getNoreadcount() + 1);
                }
                if(groupChatNoread.getUserID() != sendUser){
                    if (!tempFlag){
                        getGroupNoreadService().persistence(groupChatNoread);
                    }
                    if(user != null){
                        user.groupSendMessage(socketInformation,grouplist.getGroupID());
                    }
                }
            }
        }
    }

    /**
     * 单人聊天消息发送。
     * @param socketInformation
     * @throws IOException
     */
    public void userC2CSend(SocketInformation socketInformation) throws IOException{
        if(message.indexOf("positionID:")!=-1){
            String [] arr = message.split(":");
            try {
                Map position = getPositionService().selectPositionForChat(arr[1]);
                if(position.get("sexRequirements") == null||"2".equals(position.get("sexRequirements").toString())){
                    position.put("sexRequirements","男女不限");
                }else if("1".equals(position.get("sexRequirements").toString())){
                    position.put("sexRequirements","仅限男性");
                }else{
                    position.put("sexRequirements","仅限女性");
                }
                if (position.get("beenRecruitedSum")==null){
                    position.put("beenRecruitedSum","0");
                }
                message = new Gson().toJson(position);
                String tempMsg = "<div class=\"position_box\">\n" +
                        "    <h4 class=\"title\">"+position.get("title")+"</h4>\n" +
                        "    <div class=\"media-cate\">\n" +
                        "        <div class=\"cate\">"+position.get("name")+"</div>\n" +
                        "        <div class=\"content\">\n" +
                        "            <div class=\"content-msg\">\n" +
                        "                <span class=\"content-msg-lf\">\n" +
                        "                   <i class=\"iconfont icon-shizhong\"></i>\n" +
                        "                    <span>"+ DateUtils.formatByNum((Integer) position.get("startTime"))+"-"+DateUtils.formatByNum((Integer) position.get("endTime"))+"</span>\n" +
                        "                </span>\n" +
                        "            </div>\n" +
                        "            <div class=\"content-msg\">\n" +
                        "                <span class=\"content-msg-lf\">\n" +
                        "                    <span>"+position.get("sexRequirements")+"</span>\n" +
                        "                    <span class=\"line\"></span>\n" +
                        "                    &nbsp;<span> "/*+position.get("beenRecruitedSum")+"/"*/+position.get("recruitsSum")+"</span>\n" +
                        "                </span>\n" +
                        "                <span class=\"content-msg-rt\">"+Double.parseDouble(position.get("dailySalary").toString())+"元/天</span>\n" +
                        "            </div>\n" +
                        "        </div>\n" +
                        "    </div>\n" +
                        "</div>";
                socketInformation.setMesssag(tempMsg);
            }catch (Exception e){
                System.out.println(e.getMessage());
            }
        }else{
            socketInformation.setMesssag(message);
        }

        socketInformation.setFromuser(sendUser);

        socketInformation.setTouser(toUser);

        QueryParam queryParam = new QueryParam("fromuser",sendUser);

        queryParam.put("touser" ,toUser);

        try {
            String sessionID = getSocketInformationService().getSessionID(queryParam);
            if (sessionID != null){
                socketInformation.setSessionID(sessionID);
            }else{
                socketInformation.setSessionID(UUIDGenerator.randomUUID());
            }
        }catch (Exception e ){
            e.printStackTrace();
        }
        // 得到接收人
        WebSocketController user = webSocketMap.get(toUser);
        WebSocketController user1 = webSocketMap.get(toUser + "-");
        WebSocketController user2 = webSocketMap.get(toUser + "+");
        if(user1 != null){
            try{
                socketInformation.setType(true);
                getSocketInformationService().add(socketInformation);
            }catch (Exception e){
                e.printStackTrace();
            }
            user = user1 ;
        }else if(user2 != null){
            try{
                socketInformation.setType(true);
                getSocketInformationService().add(socketInformation);
            }catch (Exception e){
                e.printStackTrace();
            }
            user = user2 ;
        } else if (user == null && user1 == null && user2 == null ) {//如果接收人不存在则保持到数据库

            socketInformation.setType(true);

            try{
                getSocketInformationService().add(socketInformation);
            }catch (Exception e){
                e.printStackTrace();
            }

            return;
        } else{
            try{
                socketInformation.setType(false);
                getSocketInformationService().add(socketInformation);
            }catch (Exception e){
                e.printStackTrace();
            }
        }

        user.sendMessage(socketInformation);
    }
    /**
     * 发成错误所调用的方法
     * @param session
     * @param error
     */
    @OnError
    public void onError(Session session, Throwable error) {
        System.out.println("发生错误");
        //error.printStackTrace();
    }

    /**
     * 这个方法与上面几个方法不一样。没有用注解，是根据自己需要添加的方法。
     * @param socketInformation
     * @throws IOException
     */
    public void sendMessage(SocketInformation socketInformation) throws IOException {
        //String json = "{\"fromuser\": "+socketInformation.getFromuser()+",\"message\": "+socketInformation.getMesssag()+"}";
        String message = socketInformation.getFromuser() +"-" +socketInformation.getMesssag() + "-" + socketInformation.getId();
        this.session.getBasicRemote().sendText(message);//提供阻塞式的消息发送方式
        // this.session.getAsyncRemote().sendText(message);//提供非阻塞式的消息传输方式。
    }

    public void groupSendMessage(SocketInformation socketInformation,String _toUser) throws IOException{
        String message = socketInformation.getFromuser() +"-" + socketInformation.getMesssag() + "-" + socketInformation.getId() + "-" +_toUser;
        this.session.getBasicRemote().sendText(message);//提供阻塞式的消息发送方式
    }

    // 获得当前在线人数
    public static synchronized int getOnlineCount() {
        return onLineCount;
    }

    // 新用户
    public static synchronized void addOnlineCount() {
        WebSocketController.onLineCount++;
    }

    // 移除退出用户
    public static synchronized void subOnlineCount() {
        WebSocketController.onLineCount--;
    }

    public SocketInformationService getSocketInformationService(){
        if (socketInformationService == null )
            socketInformationService = SpringContextUtil.getApplicationContext().getBean(SocketInformationService.class);
        return socketInformationService ;
    }

    public GrouplistService getGrouplistService(){
        if (grouplistService == null )
            grouplistService = SpringContextUtil.getApplicationContext().getBean(GrouplistService.class);
        return grouplistService ;
    }

    public PositionService getPositionService(){
        if (positionService == null )
            positionService = SpringContextUtil.getApplicationContext().getBean(PositionService.class);
        return positionService ;
    }

    public GroupChatNoreadService getGroupNoreadService(){
        if (groupChatNoreadService == null )
            groupChatNoreadService = SpringContextUtil.getApplicationContext().getBean(GroupChatNoreadService.class);
        return groupChatNoreadService ;
    }
}
