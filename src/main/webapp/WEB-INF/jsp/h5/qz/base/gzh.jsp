<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/6/26
  Time: 10:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="/ijob/static/css/mine/QRcode.css?version=4">
    <style>
        .modal-mask {position: fixed;top: 0;left: 0; z-index: 999; width: 100%;height: 100%;background: rgba(0, 0, 0, .5);}
    </style>
    <title>公众号</title>
</head>
<body>
<div class="modal-mask">
    <div class="content" style=" position: absolute;top: 10%;width: 90% ;left:5%;margin-top: 0.2rem;">
        <div class="head">
            <div class="imgBox">
                <img class="photoImg" id="myhead" src="/ijob/static/images/logo.jpg"
                     alt=""
                     onerror="this.src='/ijob/static/images/default.jpg';this.onerror=null">
            </div>
            <div class="infoBox">
                <p class="nameP">IJob兼职</p>
                <p class="noteP">一个专注兼职的平台</p>
            </div>
            <div class="close iconbtns"><span class="iconfont icon-guanbi"></span></div>
        </div>
        <div class="tipstxt">为了您更好的体验，请关注我们的公众号</div>
        <div class="codeBox" id="qrcodeimg">
            <a href="/ijob/upload/iJob/images/resource/gzh.jpg" >
                <img class="qrcode" src="/ijob/upload/iJob/images/resource/gzh.jpg" width="100%" />
            </a>
        </div>
        <div class="msgBox">长按二维码关注公众号</div>
    </div>
</div>
</body>
<script>


    function touchHandler(event) {
        event.preventDefault();
    }
    $(".wrap").on('touchmove',touchHandler);
    $(".modal-mask").click(function(){
        $(".wrap").off('touchmove',touchHandler);
        $(".modal-mask").hide();
        $("#maskpanel").remove();
    });
    $(".content").click(function(e){
        e.stopPropagation();
    });
    $(".iconbtns").click(function(e){
        $(".wrap").off('touchmove',touchHandler);
        $(".modal-mask").hide();
        $("#maskpanel").remove();
    });
</script>
</html>
