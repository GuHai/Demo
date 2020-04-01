<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>提现-完成</title>
    <script src="/ijob/lib//lib-flexible.js"></script>
    <script src="/ijob/lib/mui/js/mui.min.js"></script>
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/static/css/base.css">
    <link rel="stylesheet" href="/ijob/static/css/mine/withdraw_Complete.css">
</head>
<body>
<div class="wrap">
    <div class="gouBox">
        <div class="gou"><i class="iconfont icon-gou"></i></div>
        <p>提现申请已提交</p>
    </div>
    <div class="schedule">
        <div class="bar"><span></span></div>
        <ul class="list">
            <li>
                <div class="sub">
                    <p>已提交</p>
                    <p>1月10 17:45:23</p>
                </div>
            </li>
            <li>
                <div class="audit">
                    <p>审核中</p>
                    <p>预计2个工作日</p>
                </div>
            </li>
            <li>
                <div class="arrived">
                    <p>到账</p>
                    <p>预计2个工作日</p>
                </div>
            </li>
        </ul>
    </div>
    <div class="btnBox">
        <input type="button" value="完成" class="btn">
    </div>
</div>
</body>
</html>