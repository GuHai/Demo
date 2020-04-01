<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.yskj.service.base.DictCacheService" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>收钱码</title>
    <jsp:include page="qz/base/resource.jsp"/>
    <jsp:include page="qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/QRcode.css?version=4">
    <style>
        html,body{
            background-color: #2e3132 !important;
        }
    </style>
</head>
<body >
<div class="wrap" style="position:relative;">
    <div class="content page_pay_code">
            <div class="head">
                <div class="imgBox">
                    <img class="photoImg" src="/ijob/static/images/default.jpg">
                </div>
                <div class="infoBox">
                    <p class="nameP">实名认证的姓名</p>
                    <p class="noteP">
                        工作号：中南大学兼职负责人
                    </p>
                </div>
            </div>
            <div class="codeBox" id="schoolqrcodeimg">
                <img src="/ijob/static/images/ghz.jpg" alt="二维码">
            </div>
            <div class="msgBox">
                <p>暂无充值金额，请充值</p>
                <p>或使用该二维码进行收钱</p>
            </div>
    </div>
</div>

<script src="/ijob/static/js/utf.js"></script>
<script src="/ijob/static/js/qrcode.min.js"></script>
</body>
</html>