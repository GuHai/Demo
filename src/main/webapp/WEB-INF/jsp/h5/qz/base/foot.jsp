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
    <script>
        if(!ijob.storage.get("chat")){
            ijob.storage.set("chat",{});
        }
        var site = "${site}"||ijob.storage.get("chat.site");
        var chatIP = "${chatIP}"||ijob.storage.get("chat.chatIP");
        // chatIP = "localhost";
        if(site){
            ijob.storage.set("chat.site",site);
        }
        if(chatIP){
            ijob.storage.set("chat.chatIP",chatIP);
        }
        $(document).off('NewMessageEvent').on('NewMessageEvent',function(event,message){
            if($(".main>.news-content").length==0 && !$("#socketInfoTag").hasClass("hint")){
                $("#socketInfoTag").addClass("hint");
            }
        });
        $(document).off('NoReadEvent').on('NoReadEvent',function(event,message){
            if(message==true||message=="true"){ //如有有未读消息，显示
                if($(".main>.news-content").length==0 && !$("#socketInfoTag").hasClass("hint")){
                    $("#socketInfoTag").addClass("hint");
                }
            }
        });


    </script>
    <script src="/ijob/static/js/chat.js?version=<%=DictCacheService.Version%>"></script>
    <%--<jsp:include page="resource.jsp"/>--%>
</head>
<body>
<input id="myuserID" value="<shiro:principal property="id" />" type="hidden">
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
    <a href="/h5/information/information" class="unselected information" data-menu="information">
        <span class="iconfont icon-xiaoxi1" data-icon="icon-xiaoxi"></span>
        <p>信息</p>
        <i id="socketInfoTag"></i>
    </a>
    <a href="/h5/qz/mine/mine"  data-url="/ijob/api/PositionController/hasDSHPosition" class="unselected hd" data-menu="personal">
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
            WeixinJSBridge.call('closeWindow');
        }
    }
    $(function(){

        setTimeout(function(){
            $("#getRedInfo").btPost(null,function(data){
                if (data.data.list[0].count!=0){
                    $("#redPacketCount").text(data.data.list[0].count);
                    $("#redPacketMoney").text(data.data.list[0].sumMoney);
                    $(".red_packet_box").show();
                }
            })
        },2000);

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

