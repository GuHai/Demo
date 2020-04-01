<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title id="title"></title>
    <link rel="stylesheet" href="/ijob/static/css/base.css">
    <link rel="stylesheet" href="/ijob/static/css/infprmation/chat.css?version=4">
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">

    <style>
        ::-webkit-scrollbar{
            display:none;
        }
        .m-text{
            position:fixed;
        }
        .messagetype{
            float: left;
            height: 30px;
            width: 28px;
            background-color: #108ee9;
            color: #ffffff;
            border-radius: 6px;
            margin: 10px 0;
        }
        video::-webkit-media-controls {
            display:none !important;
        }
        .audioPanel{
            position:fixed;
            top: 50%;
            left: 50%;
            background: rgba(0, 0, 0, 0.4);
            width: 120px;
            height: 120px;
            z-index:999;
            border-radius: 0.16rem;
            -webkit-transition-duration:400ms;
            transition-duration:400ms;
            -webkit-transform:translate3d(-50%,-50%,0) scale(1);
            transform:translate3d(-50%,-50%,0) scale(1);
        }
        .date{
            color:#999;
            text-align:center;
        }
        .chatname{
            line-height:1;font-size: 10px;margin-bottom:5px!important;
        }
    </style>
    <jsp:include page="../qz/base/resource.jsp"/>
    <script src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js" type="text/javascript"></script>
    <script src="/ijob/lib//lib-flexible.js"></script>
    <script src="/ijob/static/js/chatimage.js?version=2"></script>
    <script src="/ijob/static/js/chatAudio.js?version=2"></script>
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
    <div class="main1">
        <div class="chat" id="chat">
            <div  class="audioPanel" style="display: none;">
                <a>
                    <i class="mui-icon mui-icon-mic" style="font-size: 120px;color: #fff"></i>
                    <div id="audioProgress" class="mui-progressbar" style="height: 4px;">
                        <span></span>
                    </div>
                </a>
            </div>
            <div  id="position" class="sendposition" style="display: none">
                <div class="mainbox">
                    <div class="popup-inner">
                        <div class="popup-title">职位名称</div>
                        <div class="popup-text" id="posiname"></div>
                    </div>
                    <div class="popup-buttons">
                        <span class="popup-button popup-button-bold">取消</span>
                        <span class="popup-button">发送</span>
                    </div>
                </div>
            </div>
            <ul id="showMsg" style="margin-top: 10px;">
                <script  type="text/html" id="chatList"  >
                    {{each list as message}}
                        <li data-type="{{message.type}}" data-pid="{{message.context | parsemsg}}" data-date="{{message.date}}">
                            <div class="{{message.userID | head}}">
                                {{if message.user!=null}}
                                    <img class="avatar" width="30" height="30" src="/ijob/upload/{{message.user.userimg}}" onerror="this.src='{{message.user.weixinimg}}';this.onerror=null">
                                {{else}}
                                    <img class="avatar" width="30" height="30" src="/ijob/upload/{{message.userID | getUserImg}}" onerror="this.src='{{message.userID | getWeixinImg}}';this.onerror=null">
                                {{/if}}
                                <p class="chatname">{{message | getUserName}}</p>
                                <div class="text {{message.type | textClass}}">
                                    {{#message | parse}}
                                </div>
                            </div>
                        </li>
                    {{/each}}
                </script>
            </ul>
        </div>
        <div class="m-text">
            <div class="hd-top">
                <a href="javascript:void(0);" style="-webkit-touch-callout: none;" class="speech gotop2">
                    <i class="iconfont icon-luyin"></i>
                </a>
                <textarea name="textarea" id="message" class="msgedit"></textarea>
                <input  id="imageHandler" type="file" accept = 'image/*'  data-type="image" hidden='hidden' />
                <div class="icon-select">
                    <a href="javascript:void(0);" class="mask-btn expression">
                        <i class="iconfont icon-biaoqing-xue"></i>
                    </a>
                    <a href="javascript:void(0);" class="mask-btn video">
                        <i class="mui-icon mui-icon-plus"></i>
                    </a>
                </div>
            </div>
            <div class="expression-show reveal-list" style="display: none">
                <div class="show-list">
                    <ul>
                    </ul>
                </div>
            </div>
            <%--图片、视频--%>
            <div class="send-show reveal-list" style="display: none">
                <div class="show-list" id="mediaPanel">
                    <ul>
                        <li>
                            <a href="javascript:void(0);" data-type="image">
                                <i class="mui-icon mui-icon-image" style="font-size: 0.533rem"></i>
                                <p class="txt" style="margin-top: 5px;">图片</p>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:void(0);" data-type="video">
                                <i class="iconfont icon-shipin" style="font-size: 0.666rem"></i>
                                <p class="txt">视频</p>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:void(0);" data-type="location">
                                <i class="iconfont icon-fujin" style="font-size: 0.48rem"></i>
                                <p class="txt"style="margin-top: 2px;">位置</p>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="postionTemplate">
    {{each list as position}}
    <div class="position_box">
        <h4 class="title">{{position.title}}</h4>
        <div class="media-cate">
            <div class="cate">{{position.name}}</div>
            <div class="content">
                <div class="content-msg">
                <span class="content-msg-lf">
                   <i class="iconfont icon-shizhong"></i>
                    <span>{{position.startTime | dateFormatByMinute}}-{{position.endTime | dateFormatByMinute}}</span>
                </span>
                </div>
                <div class="content-msg">
                <span class="content-msg-lf">
                    <span>{{position.sexRequirements | enums:'SexRequirements'}}</span>
                    <span class="line"></span>
                    <span>{{position.personNumDay}}</span>
                </span>
                    <span class="content-msg-rt">{{position.dailySalary}}元/天</span>
                </div>
            </div>
        </div>
    </div>
    {{/each}}
</script>
<script type="text/javascript">
    var chatIP = "${chatIP}"||ijob.storage.get("chat.chatIP");
   // chatIP = "localhost";
    var mediaUrl = "http://"+chatIP+":8091/upload/";
    if(chatIP){
        ijob.storage.set("chat.chatIP",chatIP);
    }

    $(".msgedit").focus();
    $(".msgedit").blur();
    $(".msgedit").keyup(function(){
        var len = $(this).val().length;
        if(len > 17){
            $(".msgedit").height(36);
            $(".main1 .m-text .sendbtn").css({"margin":"0.32rem 0","margin-left":"0.4rem"});
        }
    });


    var chat = ijob.storage.get("chat");
    var positionName = chat.positionName;
    var userID = '<shiro:principal property="id" />';
    var toUserID = chat.toUserID;
    var groupID = chat.groupID;
    var isGroup = chat.isGroup;
    var title = chat.title;
    var positionID = chat.positionID;
    var websocket;
    var errormsg = ijob.storage.pop("errormsg");
    var latlng = ijob.storage.pop("data.latlng");
    // var positionID  =  ijob.storage.pop("chat.positionID");
    var pidMap = {};
    if(title){
        document.title = title;
    }


    template.helper("getUserName",function (data) {
        if(data.user){
            return data.user.realName;
        }else{
            return template.getUserInfo(data.userID).realName;
        }
    });

    template.helper("head",function (data) {
       return userID==data?'self':'he';
   });
    template.helper("textClass",function (type) {
        if(type=="Video"||type=="Image"||type=="Emoji"){
            return "media-inform";
        }else{
            return '';
        }
    });
    template.helper("parsemsg",function (type) {
        if(typeof type=="string"){
            return type;
        }else if(typeof type=="object"){
            var id = chatImage.randomString(6);
            pidMap[id] =  type;
            return id;
        }
    });
   template.helper("parse",function (data) {
       if(data.type=="Text"){
           return data.context;
       }else if(data.type=="Position"){
           return "职位【加载中】";
       }else if(data.type=="Image"){
           return "<div class='box-media'><img  class='zoom' onload='loadHandler()' style='width:100%' src='"+mediaUrl+data.context+"' ></div>";
       }else if(data.type=="Audio"){
          return "<div class='audioplay'><div ><em></em><span data-status='0' data-uid='"+data.userID+"' data-time='"+data.context.split(",")[1]+"'  class='iconfont icon-yuyin1-copy'></span><em></em></div></div>";
       }else if(data.type=="Video"){
           return "<div class='box-media'><div class='video-img-masked'></div><img onload='loadHandler()' style='width:100%' src='"+mediaUrl+data.context.split("\.")[0]+".jpg' >" +
               "<video preload=\"auto\" poster='' x5-video-player-fullscreen='true' webkit-playsinline='true' x-webkit-airplay='true' playsinline='true' x5-playsinline  style='width:100%;display: none;'  onplaying='locationPlaySrollTop(this)' onpause='cancelVideoPlay(this)'     src='"+mediaUrl+data.context+"' ></video></div>";
       }else if(data.type=="Emoji"){
           return "<div class='fullbox-media'><img style='width:50px;height: 50px;' src='/ijob/static/emoji/"+data.context+".png' ></div>";
       }else if(data.type=="Location"){
           return "<div class='location'><span class='iconfont icon-fujin'></span><b class='title'>"+data.context.name+"</b><br /><!--<a class='mui-icon mui-icon-location'></a>-->"+data.context.address+"</div>";
       }
   });

   var lastItem=null;
   function loadInfo($catalog) {

       $catalog.each(function(i,item){
           var type = $(item).data("type");
           if(type=="Position"){
               var position  = template.getPosition($(item).data("pid"));
               var html = template("postionTemplate", {list:[position]},null);
               $(item).find(".text").html(html);
           }else if(type=="Audio"){
               var audio = $(item).find("span:first");
               showAudioStyle($(item).find("span:first"),audio.data("uid"),audio.data("time"));
           }
           if( lastItem==null ||  $(item).data("date")-lastItem.data("date")>300000){
               $(item).before("<li ><div class='date'>"+parseDate($(item).data("date"))+"</div></li>");
           }
           lastItem = $(item);
       });
   }
   function parseDate(date){
       var now = new Date();
       var d = new Date(date);
       if(now.getDate()==d.getDate()){//一天之类
           return template.dateFormat(date,'hh:mm');
       }else if(new Date(date+24*3600000).getDate()==now.getDate()){//昨天
           return template.dateFormat(date,'昨天 hh:mm');
       }else if(d.getFullYear()==now.getFullYear()){
           return template.dateFormat(date,'MM月dd hh:mm');
       }else{
           return template.dateFormat(date,'yyyy年MM月dd hh:mm');
       }
   }

   //位置
    $("#showMsg").on('click','.location',function(){
        var pid = $(this).closest("li").data("pid");
        var pdata = pidMap[pid];
        var center = pdata.lat+","+pdata.lng;
        window.location.href='http://apis.map.qq.com/tools/poimarker?type=0&marker=coord:'+center+';title:'+pdata.name+';addr:'+pdata.address+'&key=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77&referer=myapp';
    });
   var clientY = 0;
    $("#showMsg").on('click','.zoom',function(evt){
        var _this = $(this);
        clientY = _this.parent().offset().top;
        _this.parent().toggleClass("big-media box-media");
        var scrollDom = document.getElementById("chat");
        setTimeout(function(){
            if(_this.parent().hasClass("big-media"))
                scrollDom.scrollTop += (clientY-10);
        },100);
    });
   //播放
    $("#showMsg").on('click','.video-img-masked',function(evt){
        clientY = $(this).parent().offset().top;
        var video = $(this).parent().find("video:first");
        video.get(0).play();
    });
    var playInterval = 0;
    var audioID ;
    var lastAudio ;
    $("#showMsg").on('click','.audioplay',function(){
        var _this  = $(this).find("span:first");
        var date = _this.closest("li").data("date");
        var isOver3Day = ((new Date().getTime()-parseFloat(date))>3*24*3600000);
        clearInterval(playInterval);
        if(audioID){
            if(isOver3Day){
                mp3path = mediaUrl+"iJob/voice/chat/"+_this.closest("li").data("pid").split(",")[2]+".mp3";
                _this.empty();
            }else{
                wx.stopVoice({
                    localId: audioID // 需要停止的音频的本地ID，由stopRecord接口获得
                });
            }

        }
        if(audioID==null){ //暂停状态，开始播放
            lastAudio = _this;
            _this.data("status",'1');
            audioID = _this.closest("li").data("pid").split(",")[0];
            if(isOver3Day){ //如果大于3天
                mp3path = mediaUrl+"iJob/voice/chat/"+_this.closest("li").data("pid").split(",")[2]+".mp3";
                _this.html("<audio autoplay='autoplay' src='"+mp3path+"'></audio>");
            }else{
                wx.playVoice({
                    localId: audioID// 需要播放的音频的本地ID，由stopRecord接口获得
                });
            }
            var time = parseInt(_this.data("time"));
            showAudioStyle(_this,_this.data("uid"),time,'#F00');
            playInterval = setInterval(function(){
                time--;
                showAudioStyle(_this,_this.data("uid"),time,'#F00');
                if(time<=0){
                    audioID = null;
                    lastAudio = null;
                    showAudioStyle(_this,_this.data("uid"),_this.data("time"));
                    clearInterval(playInterval);
                }
            },1000);

        }else{
            if(lastAudio){
                showAudioStyle(lastAudio,lastAudio.data("uid"),parseInt(lastAudio.data("time")));
            }
            if(_this.closest("li").data("pid").split(",")[0]!=audioID){//不是自己 启动
                audioID = null;
                _this.closest(".audioplay").click();
            }else{//是自己，不启动
                audioID = null;
            }


        }
    });

    function showAudioStyle(_this,uID,times,color){
        var cla = (uID==userID?'margin-left':'margin-right');
        // $(_this).text(times+"″");
        if(uID==userID){
            $(_this).prev("em").text(times+"″");
            $(_this).css({"display":"inline-block","transform":"rotate(180deg)","-webkit-transform":"rotate(180deg)"})
        }else{
            $(_this).next("em").text(times+"″");
        }
        $(_this).parent().css(cla,parseInt(times)*300/40+"px");
        $(_this).css('color',color||'#333');
    }
   //退出播放
   function cancelVideoPlay(_this){
        $(_this).parent().find(":not(video)").show();
        $(_this).hide();
        $(_this).get(0).pause();
        $(_this).parent().css("width","55%");
       loadHandler();
   }
   //回到播放前高度
    function locationPlaySrollTop(_this) {
        var scrollDom = document.getElementById("chat");
        setTimeout(function(){
            $(_this).show();
            $(_this).parent().css("width","100%");
            $(_this).parent().find(":not(video)").hide();
            scrollDom.scrollTop += (clientY-10);
        },300);
    }
   //刷新高度
   function loadHandler() {
       var scrollDom = document.getElementById("chat");
       scrollDom.scrollTop = scrollDom.scrollHeight;
   }

    function  saveChatlog(item,message) {
        setTimeout(function () {
            chatlog = ijob.database.list('chatlog'+groupID,item,message);
            lastlog =  chatlog[chatlog.length-1];
        },1000);
    }

    //读取本地文件初始化start
    var chatlog = [];
    var lastlog = {};
    $(document).ready(function(){
        if(ijob.isNotNull(groupID)){
            chatlog = ijob.database.get('chatlog'+groupID)||[];
            if(chatlog.length>0){
                lastlog =  chatlog[chatlog.length-1];
                $("#chatList").nextAll().remove();
                var html = template("chatList", {list:chatlog},null);
                $("#showMsg").append(html);
                loadInfo($("#showMsg>li"));
            }
        }
    });
    //读取本地文件初始化end



    window.onbeforeunload=function(e){
        websocket.close();
    }
    //如果浏览器支持WebSocket
    if(window.WebSocket){
        websocket = new WebSocket("ws://"+chatIP+":8989/ws");  //获得WebSocket对象
        //当有消息过来的时候触发
        websocket.onmessage = function(event){
            var result = JSON.parse(event.data);
            if(result.type==4){//聊天记录
                if(result.data){ //如果有聊天记录，则记录，如果没有则不记录
                    var last  = result.data[result.data.length-1];
                    if(lastlog==null || lastlog.date!=last.date){ //如果有变化，记录
                        $("#chatList").nextAll().remove();
                        var html = template("chatList", {list:result.data},null);
                        $("#showMsg").append(html);
                        loadInfo($("#showMsg>li"));
                        saveChatlog(result.data);
                    }
                }
                if(errormsg){//如果有最后一次未发送的消息，重新发送次消息
                    request(errormsg);
                }else if(latlng){ //如果有定位，则发送定位
                    if (latlng.key == "sharePlace" && latlng.value) {
                        var locat = {lat:latlng.value.latlng.lat,lng:latlng.value.latlng.lng,address:latlng.value.poiaddress,name:latlng.value.poiname};
                        request({
                            "type": "Location",
                            "context": locat,
                            "groupID": groupID,
                            "userID": userID
                        });
                    }
                }else{//如果有职位，则加载职位
                    //加载职位
                    if(positionID){
                        $("#position").show();
                        $("#posiname").text(positionName);
                        $("#position").on('click','.popup-button',function(){
                            var text = $(this).text();
                            if(text=="发送"){
                                request({"type":"Position","groupID":groupID,"userID":userID,context:positionID});
                            }
                            $("#position").hide();
                        });
                    }
                }
            }else if(result.type==5){ //获取GroupID 然后根据GroupID登录
                groupID = result.data;
                if(groupID){
                    request({"type":"Login","groupID":groupID,"userID":userID});
                }else{
                    mui.toast("无法获聊天ID");
                }
            }else{ //聊天
                var html = template("chatList", {list:[result.data]},null);
                $("#showMsg").append(html);
                loadInfo($("#showMsg>li:last"));

            }
            var scrollDom = document.getElementById("chat");
            scrollDom.scrollTop = scrollDom.scrollHeight;

        }

        //连接关闭的时候触发
        websocket.onclose = function(event){
            console.log("断开连接");
        }

        //连接打开的时候触发
        websocket.onopen = function(event){
            console.log("建立连接");
            //第一布，判断有没哟groupID 如果有则直接登录
            if(groupID){
                request({"type":"Login","groupID":groupID,"userID":userID});
            }else{
                if(isGroup==true||isGroup=='true'){
                    if(positionID && positionID!="null"){
                        request({"type":"Team","groupID":positionID+";;"+positionName,"context":toUserID,"userID":userID});
                    }else{
                        mui.toast("职位ID不能为空");
                    }
                }else{
                    if(toUserID&&toUserID!='undefined'&&toUserID!='null'&&toUserID!='placeholder'){
                        if(toUserID!=userID){
                            request({"type":"Group","context":toUserID,"userID":userID});
                        }else{
                            mui.toast("不能和自己聊天");
                        }
                    }else{
                        mui.toast("聊天对象不存在");
                    }
                }
            }
        }
        function request(obj){
            if(obj.userID&&obj.userID!='placeholder'){
                if(obj.hasOwnProperty("groupID")&&(obj.groupID==null||obj.groupID==undefined||obj.groupID=="")){
                    mui.toast("无法获取你的GroupID，请稍后再试");
                }else{
                    if(window.WebSocket){
                        if(websocket.readyState == WebSocket.OPEN) { //如果WebSocket是打开状态
                            websocket.send(JSON.stringify(obj)); //send()发送消息
                        }else{//重新连接
                            ijob.storage.set("errormsg",obj);
                            window.location.reload();
                        }
                    }
                }

            }else{
                mui.toast("无法获取你的ID");
            }

        }

    }else{
        alert("浏览器不支持WebSocket");
    }

   $("#imageHandler").off('ImageUploadOverEvent').on("ImageUploadOverEvent",function (event,data,type) {
       if(type=="image"){
           request({"type":"Image","context":data.absolutelyPath,"groupID":groupID,"userID":userID});
       }else if(type=="video"){
           request({"type":"Video","context":data.absolutelyPath,"groupID":groupID,"userID":userID});
       }
   });

    $.getJSON("/ijob/api/WeixinController/getJSAuthSignature?url="+window.location.href,function(data){
        wx.config({
            debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
            appId: data.data.appId, // 必填，公众号的唯一标识
            timestamp: data.data.timestamp, // 必填，生成签名的时间戳
            nonceStr: data.data.noncestr, // 必填，生成签名的随机串
            signature: data.data.signature,// 必填，签名
            jsApiList: ["openLocation","startRecord","stopRecord","onVoiceRecordEnd","playVoice","pauseVoice","stopVoice","onVoicePlayEnd","uploadVoice"] // 必填，需要使用的JS接口列表
        });
    });


    $(document).on('LocationEvent',function(){
        ijob.gotoPage({url: "/ijob/api/WeixinController/map", data: {latlng: {key: "sharePlace"}}});
    });

   wx.ready(function () {
        //发送图片语言相关
        var recode  = 0;
        var recodeTime = 0;
        var recodeInter = 0;
        var audios;
        var audioe;
        function stopRd(){
            if(recode==1){
                clearInterval(recodeInter);
                $(".audioPanel").hide();
                audioe = new Date().getTime();
                var times = Math.round((audioe-audios)/1000);
                if(times>=1){
                    wx.stopRecord({
                        success: function (res) {
                            wx.uploadVoice({
                                localId: res.localId, // 需要上传的音频的本地ID，由stopRecord接口获得
                                isShowProgressTips: 1, // 默认为1，显示进度提示
                                success:function(res1){
                                    mui.toast("上传录音");
                                    request({"type":"Audio","context":res.localId+","+times+","+res1.serverId,"groupID":groupID,"userID":userID});
                                    /*mui.toast(res1);
                                    var serverId = res1.serverId; // 返回音频的服务器端ID
                                    $.getJSON(  "http://"+chatIP+":8091/fileUpload/uploadVoice",{mediaId:serverId,path:'iJob/voice/chat'},function(res2){
                                        mui.toast(res2);
                                    });*/
                                }
                            });
                        }
                    });
                }else{
                    mui.toast("无效录音");
                }
                mui("#audioProgress").progressbar({progress:1}).show();
                recode = 0;
            }
        }
        $(".speech").on('touchstart',function(){
            mui.toast("开始录音");
            if(recode==0){
                recode = 1;
                recodeTime = 0;
                $(".audioPanel").show();
                audios = new Date().getTime();
                wx.startRecord();
                recodeInter = setInterval(function(){
                    mui("#audioProgress").progressbar({progress:++recodeTime*5}).show();
                    if(recodeTime>=20){
                        stopRd();
                    }
                },1000);
            }
        });
        $(".speech").on('touchend',function(){
            stopRd();
        });
  });

   wx.error(function(res){
       mui.alert("错误信息"+JSON.stringify(res));
   });

</script>
</body>
</html>