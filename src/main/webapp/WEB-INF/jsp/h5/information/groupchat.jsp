<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title id="title"></title>
    <jsp:include page="../qz/base/resource.jsp"/>
    <script src="/ijob/lib//lib-flexible.js"></script>
    <link rel="stylesheet" href="/ijob/static/css/base.css">
    <link rel="stylesheet" href="/ijob/static/css/infprmation/chat.css?version=4">
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <style>
        ::-webkit-scrollbar{
            display:none;
        }
        .m-text{
            position:fixed;
        }
    </style>
    <script>
        (function ($) {
            window.addEventListener('pageshow', function (e) {
                // 通过persisted属性判断是否存在 BF Cache
                if (e.persisted) {
                    location.reload();
                }
            });
        })(mui);
    </script>
    <script>
        $(function(){
            pushHistory();

            window.addEventListener("popstate", function(e) {  //popstate监听返回按钮
                closeWebSocket();
                ijob.gotoPage({url:'/indexMain'})    //执行
            }, false);
        });

        function pushHistory() {
            var state = {
                title: "myCenter",
                url: "indexMain"
            };
            window.history.pushState(state, state.title, state.url);
        }
    </script>
</head>
<body>
<div class="wrap">
    <div class="main1">
        <div class="headBox">
            <div class="head" onclick="ijob.gotoPage({path:'/h5/information/groupSet'})">
                点击修改群设置
            </div>
        </div>
        <div class="chat">
            <ul id="showMsg" style="margin-top: 1.1rem">
                <input type="hidden" name="sendUser" id="sendUser" value="<shiro:principal property="id"/>"/>
                <input type="hidden" name="toUser" id="toUser" value=""/>
                <input type="hidden" name="nickName" id="nickName" value=""/>
                <input type="hidden" name="tosrc" id="toSrc" value=""/>
                <input type="hidden" name="formsrc" id="formSrc" value=""/>
                <script  type="text/html" id="historyChatInfoGroup"  data-url="/ijob/api/SocketInformationController/getHistoryChatInfoPage" data-type="POST">
                    {{each list as info}}
                    <li>
                        <%-- &lt;%&ndash;<p class="time"><span>15:18</span></p>&ndash;%&gt;--%>
                        <div class="{{info.needbr}}">
                            <img class="avatar" width="30" height="30"src="/ijob/upload/{{info.headimgurl}}" onerror="this.src='{{info.headimgurl}}';this.onerror=null">
                            <div class="text">
                                {{if info.messsag == '哈哈哈'}}
                                <img src="/ijob/static/images/timg.jpg" width="100px" height="100px">
                                {{else}}
                                {{#info.messsag}}
                                {{/if}}
                            </div>
                        </div>
                    </li>
                    {{/each}}
                </script>
            </ul>
            <div class="clear" style="clear: both;content: '';height:1.1rem "></div>
        </div>
        <div class="m-text">
            <%--<input type="text" id="message" class="msgedit" >--%>
            <textarea name="textarea" id="message" class="msgedit"></textarea>
            <button style="margin-left: 0.4rem;" class="sendbtn" onclick="send()">发送</button>
        </div>
    </div>
</div>
<%--重点 不能删--%>
<script type="text/javascript">
    $(".msgedit").focus();
    $(".msgedit").blur();
    $(".msgedit").keyup(function(){
        var len = $(this).val().length;
        if(len > 17){
            $(".msgedit").height(36);
            $(".main1 .m-text .sendbtn").css({"margin":"0.32rem 0","margin-left":"0.4rem"});
        }
    })
</script>

<!-- socket 功能 -->
<script type="text/javascript">
    var websocket = null;
    ijob.storage.set("reloadChatList",false);
    var sendUser = document.getElementById("sendUser").value;
    var toUser = ijob.storage.get("chat.toUserID");
    if(ijob.storage.get("position.title").length > 6)
        $("#title").text(ijob.storage.get("position.title").substr(0,6) + "...");
    else
        $("#title").text(ijob.storage.get("position.title"));
    document.getElementById("toUser").value = ijob.storage.get("chat.toUserID");
    var sendUserImg ;
    $.post("/ijob/api/SocketInformationController/getC2CUserInfo",{"sendUser":sendUser,"toUser":toUser},function(data){
        sendUserImg = data.data.sendUser.headimgurl;
    });
    var reloadCount = 0;
    function login(){
        if('WebSocket' in window){
            websocket = new WebSocket("ws://${site}/websocket/" + sendUser);
        }else{
            alert('Not support websocket')
        }

        //连接发生错误的回调方法
        websocket.onerror = function(event){
           /* alert(1)
            if(reloadCount<3){
                reloadCount++;
                login();
            }else if(reloadCount == 3){
                reloadCount++;
                mui.alert("您的聊天暂不可用，请检查您的网络设置或者重新进入我们平台");
            }*/
            /*confirm("网络错误！是否返回？")*/
        };

        //连接成功建立的回调方法
        websocket.onopen = function(event){
            $("#historyChatInfoGroup").loadData({pageSize: "10", currentPage: "1",condition:{"sendUser":sendUser,"touser":toUser}}).then(function (result) {
                if(result.data.list == null || result.data.list.length == 0){
                    $("#showMsg p").remove();
                    $(".icon").remove();
                }
                $(".nodata").remove();
                $.post("/ijob/api/GroupChatNoreadController/updateMsgRead/"+toUser+"/"+sendUser,null,function(data){
                });
            });
        }

        //接收到消息的回调方法
        websocket.onmessage = function(event){
            setMessageInnerHTML(event.data);
        }

        //连接关闭的回调方法
        websocket.onclose = function(){
            /*document.getElementById('status').innerHTML="连接被成功关闭";*/
        }

        //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
        window.onbeforeunload = function(){
            websocket.close();
        }
    }
    //将消息显示在网页上
    function setMessageInnerHTML(innerHTML){
        var serverInfo = innerHTML.split("-");
        if(sendUser != serverInfo[0] &&serverInfo[3] == toUser ){
            var src = $("#toSrc").val();
            var message = handlerMessage(serverInfo[1]);
            $.post("/ijob/api/SocketInformationController/getHeadImgByID/"+serverInfo[0],null,function(data){
                var li = createLiTag(data.data.list[0],message,"he");
                document.getElementById('showMsg').innerHTML += (li);
                var div = document.getElementsByClassName("chat");
                div[0].scrollTop = div[0].scrollHeight;
            });
        }
    }

    function createLiTag(src,message,className){
        var li ="<li><div class=\""+className+"\">" ;
        var img = "<img class=\"avatar\" width=\"30\" height=\"30\" src=\""+src+"\"><div class=\"text\">";
        li += img ;
        li += message ;
        li += "</div></div></li>"
        return li;
    }

    //关闭连接
    function closeWebSocket(){
        websocket.close();
    }

    // 打开聊天界面时显示最新数据
    function setTime() {
        if($('#showMsg').children("li:last-child")[0]){
            setTimeout(function () {
                ($('#showMsg').children("li:last-child")[0]).scrollIntoView();
            },100);
        }
    }

    setTime();
    //发送消息
    function send(){
        count = 2;
        var toUser = document.getElementById("toUser").value;
        var message = document.getElementById("message").value;
        var showMessage = handlerMessage(message);
        if(message == null || message.trim() == ""){
            alert("不能发送空消息！");
        }else{
            var jsonMsg = {"sendUser":sendUser,"toUser":toUser,"message":message}
            websocket.send(JSON.stringify(jsonMsg));
            $("#message").val("");
            var li = createLiTag(sendUserImg,showMessage,"self")
            document.getElementById('showMsg').innerHTML += li;
            var div = document.getElementsByClassName("chat");
            var main1 = document.getElementsByClassName("main1");
            div[0].scrollTop = div[0].scrollHeight;
            main1[0].scrollTop = main1[0].scrollHeight;
            $(".msgedit").focus();
            $(".msgedit").blur();
        }
    }

    //回车事件监听
    $(document).keydown(function(event){
        if(event.keyCode == 13){
            send();
        }
    });

    //消息处理
    function handlerMessage(message) {
        if(message == "哈哈哈"){
            message = message.replace("哈哈哈","<img src=\"/ijob/static/images/timg.jpg\" width=\"100px\" height=\"100px\">")
        }
        return message;
    }

    if(toUser == null){
        closeWebSocket();
        websocket = null ;
    }
    login();
</script>
</body>
</html>