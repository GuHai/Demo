<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>信息</title>
<%--
    <jsp:include page="../zp/base/resource.jsp"/>-
    <jsp:include page="../qz/base/link.jsp"/>

    {{if message.user!=null}}
        <img  class="faceImg" src="/ijob/upload/{{message.user.userimg}}" onerror="this.src='{{message.user.weixinimg}}';this.onerror=null" alt="">
        {{else if message.userlist!=null}}
        <div class="grouphead">
            {{each message.userlist as u}}
            <img  class="groupImg" src="/ijob/upload/{{u.userimg}}" onerror="this.src='{{u.weixinimg}}';this.onerror=null" alt="">
            {{/each}}
        </div>
        {{else}}
            <img  class="faceImg" src="/ijob/upload/{{message.userID | getUserImg}}" onerror="this.src='{{message.userID | getWeixinImg}}';this.onerror=null" alt="">
        {{/if}}
--%>
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <%--<link rel="stylesheet" type="text/css" href="/ijob/static/css/infprmation/chat.css"/>--%>
    <link rel="stylesheet" href="/ijob/static/css/infprmation/information.css">
    <style>
        ::-webkit-scrollbar{
            display:none;
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
</head>
<body>
<div class="wrap">
    <header class="head-fixed">
        <ul class="tabList">
            <li class="head-li news active">信息</li>
            <li class="line"></li>
            <li class="head-li groupChat">群聊</li>
            <%--<li class="head-li contact">关注</li>
            <li class="line"></li>
            <li class="head-li myFocus">粉丝</li>--%>
        </ul>
    </header>
    <div class="main">
        <!--信息-->
        <div class="news-content">
            <ul class="sesslist" id="hh1">
                <script type="text/html" id="sockettemplate" data-url="/ijob/api/SocketInformationController/recentChat" data-type="POST">
                    {{each list[0].socketInformationList as socketinfo}}
                        <input type="hidden" id="userImg" value="{{list[0].User.weixin.headimgurl}}">
                        <input type="hidden" id="id" value="{{socketinfo.id}}">
                        {{if socketinfo.fromuser == null}}
                            <li class="sessinfo" onclick="ijob.gotoPage({path:'/h5/information/chat?touser.id={{socketinfo.toUserObj.id}}&touser.sessionID={{socketinfo.sessionID}}'})"  <%--onclick="chatR(this)"--%> data-id="{{socketinfo.toUserObj.id}}" name="{{socketinfo.toUserObj.nickName}}">
                                <div class="sessinfo-lf">
                                    <img id="{{socketinfo.toUserObj.id}}" class="faceImg" src="/ijob/upload/{{socketinfo.toUserObj.attachment |absolutelyPath}}" onerror="this.src='{{socketinfo.toUserObj.weixin.headimgurl}}';this.onerror=null" alt="">
                                </div>
                                <div class="sessinfo-rt">
                                    <div class="nameDiv">{{if socketinfo.toUserObj.realName==null||socketinfo.toUserObj.realName == ''}}{{socketinfo.toUserObj.nickName}}{{else}}{{socketinfo.toUserObj.realName}}{{/if}}</div>
                                    <div class="msgDiv">{{socketinfo.messsag}}</div>
                                    <div class="timeDiv">{{socketinfo.createTime | subTime}}前</div>
                                </div>
                            </li>
                        {{else if socketinfo.touser == null}}
                            <li class="sessinfo" onclick="ijob.gotoPage({path:'/h5/information/chat?touser.id={{socketinfo.fromUserObj.id}}&touser.sessionID={{socketinfo.sessionID}}&position.id=0'})"  <%--onclick="chatR(this)"--%> data-id="{{socketinfo.fromUserObj.id}}" name="{{socketinfo.fromUserObj.nickName}}">
                                <div class="sessinfo-lf">
                                    <img id="{{socketinfo.fromUserObj.id}}" class="faceImg" src="/ijob/upload/{{socketinfo.fromUserObj.attachment |absolutelyPath}}" onerror="this.src='{{socketinfo.fromUserObj.weixin.headimgurl}}';this.onerror=null" alt="">
                                    {{if socketinfo.noReadCount != 0}}
                                        <em>
                                            {{if socketinfo.noReadCount < 100 }}
                                            {{socketinfo.noReadCount}}
                                            {{else}}
                                            ...
                                            {{/if}}
                                        </em>
                                    {{/if}}
                                </div>
                                <div class="sessinfo-rt">
                                    <div class="nameDiv">{{if socketinfo.fromUserObj.realName==null||socketinfo.fromUserObj.realName == ''}}{{socketinfo.fromUserObj.nickName}}{{else}}{{socketinfo.fromUserObj.realName}}{{/if}}</div>
                                    <div class="msgDiv">{{socketinfo.messsag}}</div>
                                    <div class="timeDiv">{{socketinfo.createTime | subTime}}前</div>
                                </div>
                            </li>
                        {{/if}}
                    {{/each}}
                </script>
            </ul>
        </div>
        <div></div>
        <!-- 群聊 -->
        <div class="groupchat_content" style="display: none;">
            <div class="mui-content">
                <div class="mui-indexed-list-inner" style="margin-top: 1.367rem;">
                    <script type="text/html" id="grouplisttemplate" data-url="/ijob/api/SocketInformationController/recentChatGroup" data-type="POST">
                        <ul>
                            {{each list as group }}
                                <li class="sessinfo" onclick="ijob.gotoPage({path:'/h5/information/groupchat?touser.id={{group.groupID}}&touser.sessionID={{group.sessionID}}&position.title={{group.groupName}}'})">
                                    <div class="sessinfo-lf content-tit"style='background-color:{{group.codeGrade |getTypeColor}}!important;'>
                                        {{group.name}}
                                        {{if group.noreadcount != 0 && group.noreadcount != null}}
                                        <em>
                                            {{if group.noreadcount < 100 }}
                                            {{group.noreadcount}}
                                            {{else if group.noreadcount > 100 }}
                                            ...
                                            {{/if}}
                                        </em>
                                        {{/if}}
                                    </div>
                                    <div class="sessinfo-rt">
                                        <div class="nameDiv">{{group.groupName}}</div>
                                        <div class="msgDiv">{{group.messsag |ifNull:'暂无消息'}}</div>
                                        <div class="timeDiv">
                                            {{if group.createTime != null }}
                                                {{group.createTime | subTime}}前
                                            {{/if}}
                                        </div>
                                    </div>
                                </li>
                            {{/each}}
                        </ul>
                    </script>
                </div>
            </div>
        </div>
        <!--关注-->
        <div class="contact-content" style="display: none">
            <div class="mui-content">
                <div id="list" class="mui-indexed-list" style="height: 692px;">
                    <div class="mui-indexed-list-search mui-input-row ">
                        <input type="search" id="searchVal" style="width: 7.093rem; " class="mui-indexed-list-search-input" placeholder="搜索联系人"
                               data-input-clear="1" data-input-search="1">
                        <button id="searchPerson" style="border: 0px;margin-top: 0.26rem;"><font style="color: #108ee9">搜索</font></button>
                    </div>
                    <div class="mui-indexed-list-inner" style="height: 657px;">
                        <script type="text/html" id="myfriendtemplate" data-url="/ijob/api/InformationController/h5/information/myInfoMassa/0" data-type="POST">
                        <ul class="mui-table-view">
                            {{each list[0].userList as user}}
                                <li data-value="AKU" data-tags="AKeSu" onclick="ijob.gotoPage({path:'/h5/information/chat?touser.id={{user.id}}&position.id=0'})" data-id="{{user.id}}" name="{{user.nickName}}" imgSrc="{{user.weixin.headimgurl}}" class="mui-table-view-cell mui-indexed-list-item sesslist">
                                    {{if user.attachment==null}}
                                        <img style="border-radius: 50%"  class="face" src="{{user.weixin.headimgurl}}" alt="">
                                    {{else}}
                                        <img style="border-radius: 50%"  class="face" src="/ijob/upload/{{user.attachment.absolutelyPath}}" onerror="this.src='{{user.weixin.headimgurl}}';this.onerror=null" alt="">
                                    {{/if}}
                                    {{user.nickName}}
                                </li>
                            {{/each}}
                        </ul>
                        <div style="text-align: center;padding-top: 0.26rem;" class="per-num"><span style="color: #9f9fa6;font-size: 0.34rem;">共{{list[0].size}}位联系人</span></div>
                        </script>
                         <div class=""></div>
                    </div>
                </div>
            </div>
        </div>
        <div></div>
       <!--粉丝-->
        <div class="fans-content" style="display: none">
            <div class="mui-content">
                <div id="list1" class="mui-indexed-list" style="height: 692px;">
                    <div class="mui-indexed-list-search mui-input-row ">
                        <input type="search" id="searchVal1" style="width: 7.093rem; " class="mui-indexed-list-search-input" placeholder="搜索联系人"
                               data-input-clear="1" data-input-search="1">
                        <button id="searchPerson1" style="border: 0px;margin-top: 0.26rem;"><font style="color: #108ee9">搜索</font></button>
                    </div>
                    <div class="mui-indexed-list-inner" style="height: 657px;">
                        <script type="text/html" id="myfanstemplate" data-url="/ijob/api/InformationController/h5/information/myInfoFans/0" data-type="GET">
                            <ul class="mui-table-view">
                                {{each list[0].userList as user}}
                                <li data-value="AKU" data-tags="AKeSu" onclick="ijob.gotoPage({path:'/h5/information/chat?touser.id={{user.id}}&position.id=0'})" data-id="{{user.id}}" name="{{user.nickName}}" imgSrc="{{user.weixin.headimgurl}}" class="mui-table-view-cell mui-indexed-list-item sesslist">
                                    {{if user.attachment==null}}
                                    <img style="border-radius: 50%"  class="face" src="{{user.weixin.headimgurl}}" alt="">
                                    {{else}}
                                    <img style="border-radius: 50%"  class="face" src="/ijob/upload/{{user.attachment.absolutelyPath}}" onerror="this.src='{{user.weixin.headimgurl}}';this.onerror=null" alt="">
                                    {{/if}}
                                    {{user.nickName}}
                                </li>
                                {{/each}}
                            </ul>
                            <div style="text-align: center;padding-top: 0.26rem;" class="per-num"><span style="color: #9f9fa6;font-size: 0.34rem;">共{{list[0].size}}位粉丝</span></div>
                        </script>
                        <div class=""></div>
                    </div>
                </div>
            </div>
            <input type="hidden" name="sendUser" id="sendUser" value="<shiro:principal property="id"/>"/>
        </div>
    </div>

    <script>
        var reloadCount = 0;
        var flag = false , flag1 = false ,flag2 = false;
        var sendUser = $("#sendUser").val();
        var websocket2 = null;
        function login(){
            if('WebSocket' in window){
                websocket2 = new WebSocket("ws://${site}/websocket/" + sendUser + "-");
            }else{
                mui.alert('Not support websocket')
            }

            //连接发生错误的回调方法
            websocket2.onerror = function(){
                /*if(reloadCount<3){
                    reloadCount++;
                    login();
                }else if(reloadCount == 3){
                    reloadCount++;
                    mui.alert("您的聊天暂不可用，请检查您的网络设置或者重新进入我们平台");
                }*/
            };

            //连接成功建立的回调方法
            websocket2.onopen = function(event){
            }

            //接收到消息的回调方法
            websocket2.onmessage = function(event){
                /*window.location.reload();*/
                if(!$("#socketInfoTag").hasClass("hint")){
                    $("#socketInfoTag").addClass("hint");
                }
                $("#sockettemplate").loadData().then(function (result) {
                    console.log(result)
                    if(result.data.list[0].socketInformationList == 0){
                        $('#sockettemplate').after("<p style='text-align: center;margin-top: 5rem;'>亲，您最近还没有联系过任何人哦！</p>");
                    }
                    var divArr = $(".msgDiv");
                    for (var i = 0;i<divArr.length;i++){
                        if($(divArr[i]).text().indexOf("<div class=\"position_box\"")>=0){
                            $(divArr[i]).text("职位信息");
                        }
                        if($(divArr[i]).text().indexOf("{\"dailySalary\":")>=0){
                            var obj = JSON.parse($(divArr[i]).text());
                            var msg = "<div class=\"position_box\">\n" +
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
                                "                    &nbsp;<span> "+obj.beenRecruitedSum+"/"+obj.recruitsSum+"人</span>\n" +
                                "                </span>\n" +
                                "                <span class=\"content-msg-rt\">"+obj.dailySalary+"元/天</span>\n" +
                                "            </div>\n" +
                                "        </div>\n" +
                                "    </div>\n" +
                                "</div>";
                            $.post("/ijob/api/SocketInformationController/updateForDiv",{"id":$("#id").val(),"messsag":msg},function(data){
                            });
                            $(divArr[i]).text("职位信息");
                        }
                    }
                });
                $("#grouplisttemplate").loadData().then(function (result) {
                });
            }

            //连接关闭的回调方法
            websocket2.onclose = function(){
                /*document.getElementById('status').innerHTML="连接被成功关闭";*/
            }

            //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
            window.onbeforeunload = function(){
                websocket2.close();
            }
        }

        var reloadChatList = ijob.storage.get("reloadChatList");
        setTimeout(function(){
            $("#sockettemplate").loadData().then(function (result) {
                console.log(result)
                login();
                if(result.data.list[0].socketInformationList == 0){
                    $('#sockettemplate').after("<p style='text-align: center;margin-top: 5rem;'>亲，您最近还没有联系过任何人哦！</p>");
                }
                var divArr = $(".msgDiv");
                for (var i = 0;i<divArr.length;i++){
                    if($(divArr[i]).text().indexOf("<div class=\"position_box\"")>=0){
                        $(divArr[i]).text("职位信息");
                    }
                    if($(divArr[i]).text().indexOf("{\"dailySalary\":")>=0){
                        $(divArr[i]).text("职位信息");
                    }
                }
            });
        },100);

        $(".head-li").click(function () {
            var nub = $(this).index();
            $(this).addClass("active").siblings('.head-li').removeClass("active");
            $(".main>div").eq(nub).show().siblings().hide();
            if($(this).text() == "关注" && !flag){
                $("#myfriendtemplate").loadData().then(function(result){
                    if(result.data.list[0].userList == 0){
                        $('#myfriendtemplate').after("<p style='text-align: center;margin-top: 5rem;'>亲，您还没有关注对象！</p>");
                        $(".mui-table-view,.per-num").css("display","none");
                    }
                });
                flag = true;
            }else if($(this).text() == "粉丝" && !flag1){
                $("#myfanstemplate").loadData().then(function(result){
                    if(result.data.list[0].userList == 0){
                        $('#myfanstemplate').after("<p style='text-align: center;margin-top: 5rem;'>亲，您还没有粉丝哦！</p>");
                        $(".mui-table-view,.per-num").css("display","none");
                    }
                });
                flag1 = true;
            }else if ($(this).text() == "群聊" && !flag2){
                $("#grouplisttemplate").loadData().then(function (result) {
                });
                ijob.storage.set("socket","socket:1")
                flag2 = true ;
            }else if($(this).text() == "信息"){
                ijob.storage.set("socket","socket:0");
            }

        });
        var socketMenu = ijob.storage.get("socket") ;
        function clickMenu(){
            if(socketMenu.indexOf(":")!=-1){
                $(".head-li").eq(socketMenu.split(":")[1]).click();
            }else{
                $(".head-li").eq(0).click();
            }
        }
        clickMenu();

    </script>


    <script>
        //动态搜索联系人事件（关注）
        $("#searchPerson").click(function () {
            var url = "/ijob/api/InformationController/h5/information/myInfoMassa/";
            var valTag = $("#searchVal");
            if(valTag.val() == null || valTag.val() == "" || valTag.val() == undefined ){
                url = url + "0";
            }else{
                url = url + valTag.val();
            }
            $("#myfriendtemplate").data("url",url);
            $("#myfriendtemplate").loadData().then(function (result) {
                if(result.data.list.length == 0){
                    $('.mui-indexed-list-inner').append("<p style='text-align: center;margin-top: 7rem;'>未查询到该用户</p>");
                }
            })
        });
    </script>
    <script>
        //动态搜索联系人事件（粉丝）
        $("#searchPerson1").click(function () {
            var url = "/ijob/api/InformationController/h5/information/myInfoFans/";
            var valTag = $("#searchVal1");
            if(valTag.val() == null || valTag.val() == "" || valTag.val() == undefined ){
                url = url + "0";
            }else{
                url = url + valTag.val();
            }
            $("#myfanstemplate").data("url",url);
            $("#myfanstemplate").loadData().then(function (result) {
                if(result.data.list.length == 0){
                    $('.mui-indexed-list-inner').append("<p style='text-align: center;margin-top: 7rem;'>未查询到该用户</p>");
                }
            })
        });

        window.history.replaceState('','', "/indexMain");
    </script>

</div>
</body>
</html>