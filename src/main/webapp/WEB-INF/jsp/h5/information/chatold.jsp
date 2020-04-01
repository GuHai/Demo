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
        <div class="chat">
            <%--职位详情 start--%>
            <div class="list-container">
                <script type="text/html" id="positionInfo"  data-url="/ijob/api/PositionController/detail/{position.id}" data-type="POST">
                    {{each list as posi}}
                        <div class="list-title">
                            <span class="title-content">{{posi.position.title}}</span>
                            <span class="titel-note"></span>
                        </div>
                        <div class="list-content">
                            <div class="content-tit" style="background-color:{{posi.position.huntingtype.codeGrade |getTypeColor}}!important;">
                                {{posi.position.huntingtype.name}}
                            </div>
                            <div class="content-msg">
                                <div class="content-msg1">
                                    <span class="content-msg1-lf"><i class="iconfont icon-shizhong"></i>{{posi.position.startTime |dateFormatByMinute}}-{{posi.position.endTime |dateFormatByMinute}}</span>
                                    <span class="content-msg1-rt">{{posi.position.dailySalary |money}}元/天</span>
                                </div>
                                <div class="content-msg2">
                                    <span class="content-msg2-lf"><span class="sexRequirements">{{posi.position.sexRequirements  | enums:'SexRequirements'}}</span>&nbsp;<span class="line"></span>&nbsp;<span class="renshu"><%--{{posi.position.beenRecruitedSum | ifNull:'0'}}/--%>{{posi.position.recruitsSum | ifNull:'1'}}人</span></span>
                                    <span class="content-msg2-rt">{{posi.position.settlement  | enums:'SettlementType' }}</span>
                                </div>
                                <div class="content-msg3">
                                    <span class="content-msg3-lf">{{posi.position.workPlace | ifNull:'未知城市','cityName'}}&nbsp; 0.37km</span>
                                    <span class="content-msg3-rt">{{posi.position.contacts }}</span>
                                </div>
                            </div>
                        </div>
                    {{/each}}
                </script>
            </div>
            <%--职位详情 end--%>
            <ul id="showMsg" style="margin-top: 10px;">
                <input type="hidden" name="sendUser" id="sendUser" value="<shiro:principal property="id"/>"/>
                <input type="hidden" name="toUser" id="toUser" value=""/>
                <input type="hidden" name="nickName" id="nickName" value=""/>
                <input type="hidden" name="tosrc" id="toSrc" value=""/>
                <input type="hidden" name="formsrc" id="formSrc" value=""/>
                <script  type="text/html" id="historyChatInfo"  data-url="/ijob/api/SocketInformationController/getHistoryChatInfoPage" data-type="POST">
                    {{each list as info}}
                    <li>
                        <%-- &lt;%&ndash;<p class="time"><span>15:18</span></p>&ndash;%&gt;--%>
                        <div class="{{info.needbr}}">
                            <img class="avatar" width="30" height="30"src="/ijob/upload/{{info.fromUserObj.infoHeadImg}}" onerror="this.src='{{info.fromUserObj.weixin.headimgurl}}';this.onerror=null">
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
    var toUser = ijob.storage.get("touser.id");
    document.getElementById("toUser").value = ijob.storage.get("touser.id");
    var sendUserImg ;
    var positionID = ijob.storage.get("position.id");
    if(positionID == 0 || positionID == null){
        $(".list-container").css("display","none");
    }else{
        $("#positionInfo").loadData().then(function(result){
            if(result.data.list == null|| result.data.list.length == 0){
                $(".nodata").remove();
                $(".icon").remove();
            }
        });
    }
    $.post("/ijob/api/SocketInformationController/getC2CUserInfo",{"sendUser":sendUser,"toUser":toUser},function(data){
        console.log(data)
        if(data.data.toUser.realName){
            $("#nickName").val(data.data.toUser.realName);
        }else{
            $("#nickName").val(data.data.toUser.nickName);
        }
        $("#toSrc").val(data.data.toUser.headimgurl);
        $("#formSrc").val(data.data.sendUser.headimgurl);
        sendUserImg = data.data.sendUser.headimgurl;
        $("#title").text($("#nickName").val());
    })
    var reloadCount = 0;
    function login(){
        if('WebSocket' in window){
            websocket = new WebSocket("ws://${site}/websocket/" + sendUser);
        }else{
            alert('Not support websocket')
        }

        //连接发生错误的回调方法
        websocket.onerror = function(event){
            /*if(reloadCount<3){
                reloadCount++;
                login();
            }else if(reloadCount == 3){
                reloadCount++;
                mui.alert("您的聊天暂不可用，请检查您的网络设置或者重新进入我们平台");
            }*/
        };

        //连接成功建立的回调方法
        websocket.onopen = function(event){
            $("#historyChatInfo").loadData({pageSize: "10", currentPage: "1",condition:{"sendUser":sendUser,"touser":toUser}}).then(function (result) {
                if(result.data.list == null || result.data.list.length == 0){
                    $("#showMsg p").remove();
                    $(".nodata").remove();
                    $(".icon").remove();
                }
                var sessionID = ijob.storage.get("touser.sessionID");
                $.post("/ijob/api/SocketInformationController/updateMessageType/"+sessionID + "/0",{},function(data){
                    if(data.code == 200&&positionID&&positionID!=0){
                        var jsonMsg = {"sendUser":sendUser,"toUser":toUser,"message":"positionID:"+positionID}
                        websocket.send(JSON.stringify(jsonMsg));
                        var message = "<div class=\"position_box\">\n" +
                            "    <h4 class=\"title\">"+$(".title-content").text()+"</h4>\n" +
                            "    <div class=\"media-cate\">\n" +
                            "        <div class=\"cate\">"+$(".content-tit").text()+"</div>\n" +
                            "        <div class=\"content\">\n" +
                            "            <div class=\"content-msg\">\n" +
                            "                <span class=\"content-msg-lf\">\n" +
                            "                   <i class=\"iconfont icon-shizhong\"></i>\n" +
                            "                    <span>"+$(".content-msg1-lf").text()+"</span>\n" +
                            "                </span>\n" +
                            "            </div>\n" +
                            "            <div class=\"content-msg\">\n" +
                            "                <span class=\"content-msg-lf\">\n" +
                            "                    <span>"+$(".sexRequirements").text()+"</span>\n" +
                            "                    <span class=\"line\"></span>\n" +
                            "                    &nbsp;<span> "+$(".renshu").text()+"</span>\n" +
                            "                </span>\n" +
                            "                <span class=\"content-msg-rt\">"+$(".content-msg1-rt").text()+"</span>\n" +
                            "            </div>\n" +
                            "        </div>\n" +
                            "    </div>\n" +
                            "</div>";
                        var li = createLiTag(sendUserImg,message,"self");
                        document.getElementById('showMsg').innerHTML += (li);
                    }
                    var divArr = $(".text");
                    for (var i = 0;i<divArr.length;i++){
                        if($(divArr[i]).text().indexOf("<div class=\"position_box\"")>=0){
                            $(divArr[i]).html($(divArr[i]).text());
                        }
                    }
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
        if(serverInfo[0] == document.getElementById("toUser").value){
            var src = $("#toSrc").val();
            //img+document.getElementById("nickName").value +":";
            var message;
            if(serverInfo[1].indexOf("{\"dailySalary\":")>=0){
                var obj = JSON.parse(serverInfo[1]);
                message = "<div class=\"position_box\">\n" +
                    "    <h4 class=\"title\">"+obj.title+"</h4>\n" +
                    "    <div class=\"media-cate\">\n" +
                    "        <div class=\"cate\">"+obj.name+"</div>\n" +
                    "        <div class=\"content\">\n" +
                    "            <div class=\"content-msg\">\n" +
                    "                <span class=\"content-msg-lf\">\n" +
                    "                   <i class=\"iconfont icon-shizhong\"></i>\n" +
                    "                    <span>"+template.dateFormatByMinute(obj.startTime)+"-"+template.dateFormatByMinute(obj.endTime)+"</span>\n" +
                    "                </span>\n" +
                    "            </div>\n" +
                    "            <div class=\"content-msg\">\n" +
                    "                <span class=\"content-msg-lf\">\n" +
                    "                    <span>"+obj.sexRequirements+"</span>\n" +
                    "                    <span class=\"line\"></span>\n" +
                    "                    &nbsp;<span> "/*+obj.beenRecruitedSum+"/"*/+obj.recruitsSum+"人</span>\n" +
                    "                </span>\n" +
                    "                <span class=\"content-msg-rt\">"+obj.dailySalary+"元/天</span>\n" +
                    "            </div>\n" +
                    "        </div>\n" +
                    "    </div>\n" +
                    "</div>";
                $.post("/ijob/api/SocketInformationController/updateForDiv",{"id":serverInfo[2],"messsag":message},function(data){
                });
            }else{
                message = handlerMessage(serverInfo[1]);
            }
            var li = createLiTag(src,message,"he");
            document.getElementById('showMsg').innerHTML += (li);
            var div = document.getElementsByClassName("chat");
            div[0].scrollTop = div[0].scrollHeight;
        }else{
            $.post("/ijob/api/SocketInformationController/updateMessageType/"+serverInfo[2] + "/1",{},function(data){
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
        setTimeout(function () {
            if($('#showMsg').children("li:last-child")[0]){
                ($('#showMsg').children("li:last-child")[0]).scrollIntoView();
            }
        },100);
    }

    setTime();

    //发送消息
    function send(){
        count = 2;
        var toUser = document.getElementById("toUser").value;
        var message = document.getElementById("message").value;
        var showMessage = handlerMessage(message);
        if(message == null || message.trim() == ""){
            mui.alert("不能发送空消息！");
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
            //contentcontent.scrollTop=document.getElementById("chat").scrollTop;
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