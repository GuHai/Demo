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
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/static/css/infprmation/information.css">
    <style>
        ::-webkit-scrollbar{
            display:none;
        }
        .new{
            color: #ff0000;
        }
        .nonew{
            display: none;
        }
        .grouphead{
            width:1.33rem;height:1.33rem; background-color: #f2f5f7;
        }
    </style>
</head>
<body>
<div class="wrap">
    <div class="main">
        <!--信息-->
        <div class="news-content" style="margin-top: 0rem!important;">
            <ul class="sesslist" id="hh1">
                <script type="text/html" id="chatcatelog" >
                    {{each list as message}}
                        <li data-id="{{message.userID}}" data-type="{{message.type}}" class="sessinfo catalog{{message.groupID}}" data-group="{{message.groupID}}"  >
                            <div class="sessinfo-lf" >
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
                            </div>
                            <div class="sessinfo-rt">
                                <div class="nameDiv">{{message | realName}}</div>
                                <div class="msgDiv" data-pid="{{message.context}}">{{#message | parse}}</div>
                                <div class="timeDiv">{{message.date | subTime}}前 <span class="new">{{message | isNewMessage}}</span></div>
                            </div>
                        </li>
                    {{/each}}
                </script>
            </ul>
        </div>
        <div></div>
    </div>

    <script>
        var callcatalog = false;
        var userimg = "<img class=\"faceImg\" src=\"@{user}\" onerror=\"this.src='@{weixin}';this.onerror=null\" >";
        $("#socketInfoTag").removeClass("hint");
        template.helper("isNewMessage",function (data) {
            return data.date==data.lastTime?'':'新消息'
        });

        template.helper("head",function(data){
            if(data.userlist&&data.userlist.length){  //第一次进来群聊，或者新增的是群聊，必须要有用户信息
                var uhead = "";
                for(var i in data.userlist){
                    var u = data.userlist[i];
                    uhead += "<img  class='groupImg' src='/upload/"+u.userimg+"' onerror=\"this.src='"+u.weixinimg+"';this.onerror=null\" alt=''>";
                }
                return "<div class='grouphead'>"+uhead+"</div>";
            }else if(data.user){//第一次进来是单聊
                return "<img  class='faceImg' src='/upload/"+data.user.userimg+"' onerror=\"this.src='"+data.user.weixinimg+"';this.onerror=null\" alt=''>";
            }else{//已存在的单聊用户
                return "<img  class='faceImg' src='/upload/"+template.getUserImg(data.userID)+"' onerror=\"this.src='"+template.getWeixinImg(data.userID)+"';this.onerror=null\" alt=''>";
            }
        });


        var parse = function (data) {
            if(data.type=="Text"){
                return data.context;
            }else if(data.type=="Position"){
                return "职位【】";
            }else if(data.type=="Image"){
                return "图片";
            }else if(data.type=="Audio"){
                return "语音";
            }else if(data.type=="Video"){
                return "视频";
            }else if(data.type=="Emoji"){
                return "<img style='width: 20px;height: 20px' src='/ijob/static/emoji/"+data.context+".png' >";
            }else if(data.type=="Location"){
                return "位置【"+data.context.address+"】";
            }
        };
        template.helper("parse",parse);

        template.helper("realName",function (data) {
            if(data.name){
                return data.name;
            }else{
                if(data.user!=null){
                    return data.user.realName;
                }else if(data.userlist&&data.userlist.length){
                    var  name = "";
                    for(var i in data.userlist){
                        name += data.userlist[i].realName+",";
                    }
                    if(name){
                        name = name.substring(0,name.length-1);
                    }
                    return name;
                }else{
                    return template.getUserInfo(data.userID).realName||'未知';
                }
            }

        });

        function loadInfo($catalog) {
            $catalog.each(function(i,item){
                setTimeout(function () {
                    var type = $(item).data("type");
                    if(type=="Position"){
                        var position  = template.getPosition($(item).find(".msgDiv").data("pid"));
                        $(item).find(".msgDiv").text("职位【"+position.title+"】");
                    }
                },1);
            });
        }

        var localcatalog ,currentlog;
        //读取本地文件初始化start
        $(document).ready(function(){
            localcatalog = ijob.database.get('catalog')||[];
            currentlog = localcatalog.length>0?localcatalog[0]:null;
            if(localcatalog.length>0){
                setTimeout(function(){
                    var html = template("chatcatelog", {list:localcatalog},null);
                    $("#chatcatelog").nextAll().remove();
                    $("#hh1").append(html);
                    loadInfo($("#hh1>li"));
                },10);
            }
        });
        //读取本地文件初始化end

        $(document).off('NewMessageEvent').on('NewMessageEvent',function(event,message){
            var menu = $(".catalog"+message.groupID);
           if(menu&&menu.length){
               menu.find(".new").text("新消息");
               menu.find(".msgDiv").html(parse(message));
               $("#hh1>li:first").before(menu);
           }else{
               var html = template("chatcatelog", {list:[message]},null);
               if($("#hh1>li").length){
                   $("#hh1>li:first").before(html);
                   loadInfo($("#hh1>li:first"));
               }else{
                   $("#hh1").append(html);
                   loadInfo($("#hh1>li:last"));
               }
           }
            saveCatalog("groupID:"+message.groupID,message);
       });



       $(document).off('CatalogEvent').on('CatalogEvent',function(event,message){
            if(message&&message.length){
                var fisrt = message[0];
                if(currentlog==null || fisrt.lastTime!=currentlog.lastTime ||localcatalog.length!=message.length){
                    var html = template("chatcatelog", {list:message},null);
                    $("#chatcatelog").nextAll().remove();
                    $("#hh1").append(html);
                    loadInfo($("#hh1>li"));
                    saveCatalog(message);
                }
            }else{
                mui.toast("没有聊天记录");
                saveCatalog([]);
                var html = template("chatcatelog", {list:[]},null);
                $("#chatcatelog").nextAll().remove();
                $("#hh1").append(html);
            }
       });

       function  saveCatalog(item,message) {
           setTimeout(function () {
               localcatalog = ijob.database.list('catalog',item,message);
               currentlog = localcatalog.length>0?localcatalog[0]:null;
           },1000);
       }
       
       $(document).off('OpenEvent').on('OpenEvent',function (event) {
           catalog();
       })

        function catalog() {
            if(websocket.readyState == WebSocket.OPEN && callcatalog==false) { //如果WebSocket是打开状态
                callcatalog = true;
                var obj = {"type":"Catalog","userID":$("#myuserID").val()};
                websocket.send(JSON.stringify(obj));
            }
        }
        catalog();
       
       
       $("#hh1").on('click','li',function () {
           // ijob.gotoPage({path:'/h5/information/chat?chat.title='+$(this).find(".nameDiv").text()+'&chat.groupID='+$(this).data("group")});
                ijobbase.toChat({groupID:$(this).data("group"),title:$(this).find(".nameDiv").text()});

       });

        var longtouch ;
        $("#hh1").on('touchstart','li',function () {
            var _this  = $(this);
            longtouch = setTimeout(function(){
                var btnArray = ['是', '否'];
                mui.confirm('是否删除该聊天？', null, btnArray, function(e) {
                    clearTimeout(longtouch);
                    if (e.index == 0) {//点击是
                        var obj = {"type":"Remove","userID":$("#myuserID").val(),"groupID":_this.data("group")};
                        websocket.send(JSON.stringify(obj));
                        _this.remove();
                        saveCatalog("groupID:"+_this.data("group"),null);
                    }
                });
            },1000);
        });
        $("#hh1").on('touchend','li',function () {
            clearTimeout(longtouch);
        });
        $("#hh1").on('touchmove','li',function () {
            clearTimeout(longtouch);
        });

    </script>

</div>
</body>
</html>