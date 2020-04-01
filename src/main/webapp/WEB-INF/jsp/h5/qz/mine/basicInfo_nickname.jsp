<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>修改昵称</title>
    <script src="/ijob/lib//lib-flexible.js"></script>
    <script src="/ijob/lib/mui/js/mui.min.js"></script>
    <link rel="stylesheet" href="/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/css/base.css">
    <link rel="stylesheet" href="/ijob/static/css/mine/basicInfo_nickname.css">
</head>
<body>
<div class="wrap">
    <form action="/ijob/api/InformationController/h5/mine/updatePhoneNumber" method="post">
        <div class="inputBox">
            <input type="hidden" value="${requestScope.user.version}" name="version">
            <input type="text" MAXLENGTH="16" name="nickName" id="nickName" placeholder="昵称" value="${requestScope.user.nickName}">
        </div>
        <div class="btnBox">
            <input type="submit" value="保存" class="btn" />
        </div>
    </form>
</div>
</body>
</html>