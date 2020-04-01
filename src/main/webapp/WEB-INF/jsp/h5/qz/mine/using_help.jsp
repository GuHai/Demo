<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/27
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>选择问题类型</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/using_help.css?version=4">
</head>
<body>
<div class="wrap">
    <div class="page_using_help">
        <div class="hd-main">
            <div class="list-box">
                <ul>
                    <li onclick="ijob.gotoPage({path:'/h5/qz/mine/deposit?data.type=1'})">
                        <span class="iconfont icon-baozhengjin"></span>
                        <span class="txt">保证金</span>
                    </li>
                    <li onclick="ijob.gotoPage({path:'/h5/qz/mine/deposit?data.type=2'})">
                        <span class="iconfont icon-qia"></span>
                        <span class="txt">提现</span>
                    </li>
                    <li onclick="ijob.gotoPage({path:'/h5/qz/mine/deposit?data.type=3'})">
                        <span class="iconfont icon-zhaoshanghezuo"></span>
                        <span class="txt">合伙人</span>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
</html>

