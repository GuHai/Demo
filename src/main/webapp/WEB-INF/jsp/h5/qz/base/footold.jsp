<%--
  Created by IntelliJ IDEA.
  User: zhouchuang
  Date: 2018/1/20
  Time: 19:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  import="com.yskj.service.base.DictCacheService" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<html>
<head>
    <title>foot</title>
    <link rel="stylesheet" href="/ijob/static/css/base.css?version=<%=DictCacheService.Version%>">
    <link rel="stylesheet" href="/ijob/static/css/index/index.css?version=<%=DictCacheService.Version%>">
    <%--<jsp:include page="resource.jsp"/>--%>
</head>
<body>
<%--开启红包--%>
<div class="red_packet_box" style="display: none;">
    <div class="content">
        <div class="person">
            <div class="close_btn"><span class="iconfont icon-guanbi"></span></div>
            <div class="informBox">
                <div class="portrait">
                    <%--<div class="photo">
                        <img src="/ijob/static/images/default.jpg"/>
                    </div>--%>
                    <p>收到<span id="redPacketCount">4</span>个红包</p>
                </div>
                <div class="name">
                    共<span id="redPacketMoney">72.23</span>元
                    <%--<p class="pro_name">公司真心诚聘传单派发学生可兼职</p>
                    <p class="type">分享奖励</p>--%>
                </div>
            </div>
            <div class="open"><img src="/ijob/static/images/openview.png"/></div>
        </div>
    </div>
</div>
<input type="hidden" id="getRedInfo" data-url="/ijob/api/RedPacketReceiveController/getNoSureRedPacket">
<div class="foot_margin"></div>
<footer class="foot">
    <input type="hidden" name="sendUser" id="sendUser" value="<shiro:principal property="id"/>"/>
    <a href="/h5/qz/index/home" class="unselected home" data-menu="findJob">
        <span class="iconfont icon-zhuye" data-icon="icon-zhuye"></span>
        <p>首页</p>
    </a>
    <%--<a href="/h5/qz/myjob/my_part_time_job" class="unselected myJob" data-menu="myjob">--%>
        <%--<span class="iconfont icon-jianzhi"></span>--%>
        <%--<p>我的兼职</p>--%>
    <%--</a>--%>
    <a url="/ijob/api/ApiNettyController/toInformation" class="unselected information" data-menu="information">
        <span class="iconfont icon-xiaoxi1" data-icon="icon-xiaoxi"></span>
        <p>信息</p>
        <i id="socketInfoTag"></i>
    </a>
    <a url="/ijob/api/InformationController/h5/mine/mine" data-url="/ijob/api/PositionController/hasDSHPosition" class="unselected hd" data-menu="personal">
        <span class="iconfont icon-wode"  data-icon="icon-wode"></span>
        <p>我的</p>
        <i id="examine"></i>
    </a>
</footer>
<!-- socket 功能 -->
<script type="text/javascript">
    $(".hd").btPost(null,function(result){
        if(result.data > 0 && result.data != null){
            $(".hd").addClass("mine");
        }
    });
    var sendUser = $("#sendUser").val();
    var websocket1 = null;
    function login22(){
        if('WebSocket' in window){
            websocket1 = new WebSocket("ws://${site}/websocket/" + sendUser + "+");
        }else{
            alert('Not support websocket')
        }

        //连接发生错误的回调方法
        websocket1.onerror = function(){
            /*document.getElementById('status').innerHTML="error";*/
        };

        //连接成功建立的回调方法
        websocket1.onopen = function(event){
            $.post("/ijob/api/SocketInformationController/getUserMass",{},function (data) {
                if(data.code == 200){
                    if(data.data == 0){
                        $("#socketInfoTag").removeClass("hint");
                    }else{
                        $("#socketInfoTag").addClass("hint");
                    }
                }
            });
        }

        //接收到消息的回调方法
        websocket1.onmessage = function(event){
            if(!$("#socketInfoTag").hasClass("hint")){
                $("#socketInfoTag").addClass("hint");
            }
        }

        //连接关闭的回调方法
        websocket1.onclose = function(){
            /*document.getElementById('status').innerHTML="连接被成功关闭";*/
        }

        //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
        window.onbeforeunload = function(){
            websocket1.close();
        }
    }
    //将消息显示在网页上
    /* function setMessageInnerHTML(innerHTML){
         var serverInfo = innerHTML.split("-");
         if(serverInfo[0] == document.getElementById("toUser").value){
             var src = document.getElementById(""+serverInfo[0]).src;
             //img+document.getElementById("nickName").value +":";
             var li = createLiTag(src,serverInfo[1],"he");
             document.getElementById('showMsg').innerHTML += (li);
         }
     }*/

    //创建dom 节点。
    /*function createLiTag(src,message,className){
        var li ="<li><div class=\""+className+"\">" ;
        var img = "<img class=\"avatar\" width=\"30\" height=\"30\" src=\""+src+"\"><div class=\"text\">";
        li += img ;
        li += message ;
        li += "</div></div></li>"
        return li;
    }*/

    //关闭连接
    function closeWebSocket1(){
        websocket1.close();
    }

    //发送消息
    /*function send(){
        var toUser = document.getElementById("toUser").value;
        var message = document.getElementById("message").value;
        var jsonMsg = {"sendUser":sendUser,"toUser":toUser,"message":message}
        websocket.send(JSON.stringify(jsonMsg));
        $("#message").val("");
        var li = createLiTag(sendUserImg,message,"self")
        document.getElementById('showMsg').innerHTML += li;
        $("#sockettemplate").loadData();
    }*/

    $(".unselected").click(function(){
        if($(this).data("menu") != "information"){
            login22();
        }else{
            if (websocket1){
                closeWebSocket1();
            }
        }
    })
    getSize();

    function getSize() {
        if (screen.width === 375 && screen.height === 812) {
            $('html,body').css('padding-bottom', '34px');
        }
    }

    history.pushState({page : 'state1'},'state','#state1');
    history.pushState({page : 'state2'},'state','#state2');
    window.onpopstate = function(event) {
        if (event.state.page === 'state1') {
            closeWebSocket1();
            WeixinJSBridge.call('closeWindow');
        }
    }
    $(function(){

        $("#getRedInfo").btPost(null,function(data){
            if (data.data.list[0].count!=0){
                $("#redPacketCount").text(data.data.list[0].count);
                $("#redPacketMoney").text(data.data.list[0].sumMoney);
                $(".red_packet_box").show();
            }
        })
        var slide = null;
        if($(".red_packet_box").css("display") == "block"){
            slide = new Slide($(".wrap"),$(".red_packet_box"),".content");
            slide.disTouch();
        }
        // 拆开红包
        $(".red_packet_box .open").on("click",function(e){
            $(".red_packet_box .open").addClass("animation");
            if ($(".red_packet_box .open").hasClass("animation")){
                //三秒后跳转
                setTimeout(function(){
                    ijob.gotoPage({path:"/h5/qz/mine/Bills",data:{
                        billobj:{
                            condition:{btype:"'04','11','12'"},
                            btntype:'redpacket'
                        }}
                    });
                },2000)
            }

        });
        $(".close_btn").on("click",function(e){
            $(".red_packet_box").hide();

            slide.ableTouch();
        })
    })
</script>

</body>
</html>

