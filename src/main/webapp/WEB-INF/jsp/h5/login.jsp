<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/6/21
  Time: 15:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<html>
<head>
    <title>登录授权</title>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="/ijob/static/css/common/common.css" />
    <script src="/ijob/static/js/jquery-3.1.1.min.js"></script>
</head>
<body>
<div  class="wrap">
    <div class="page_login">
        <div class="hd-main">
            <div class="photos">
                <img src="/ijob/static/website/images/m_logo.png">
            </div>
            <div class="title">
                <p>I Job兼职</p>
            </div>
        </div>
        <div class="tips-box">
            <div class="t_title">即将登录I Job兼职，确认是本人操作</div>
            <ul>
                <li>使用你的账号登录该应用</li>
            </ul>
        </div>
        <div class="btn-input-button">
            <button onclick="loginAuth();"  id="msg">授权网页端登录</button>
        </div>
    </div>
</div>
</body>
<script src="https://res.wx.qq.com/open/js/jweixin-1.2.0.js" type="text/javascript"></script>
<script>

    $.getJSON("/ijob/api/WeixinController/getJSAuthSignature?url="+window.location.href,function(data){
        wx.config({
            debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
            appId: data.data.appId, // 必填，公众号的唯一标识
            timestamp: data.data.timestamp, // 必填，生成签名的时间戳
            nonceStr: data.data.noncestr, // 必填，生成签名的随机串
            signature: data.data.signature,// 必填，签名
            jsApiList: ["closeWindow"] // 必填，需要使用的JS接口列表
        });
    });
    wx.ready(function(){

    });


    function  loginAuth() {
        $.getJSON('/authorizedLogin/<shiro:principal property="authCode"/>',function(){
            $("#msg").text("授权成功");
            $("#msg").attr("disabled", "disabled");
            setTimeout(function(){
                wx.closeWindow();
            },1000);
        });
    }
    
</script>
</html>
