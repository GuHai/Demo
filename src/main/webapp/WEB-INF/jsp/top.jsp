<%--
  Created by IntelliJ IDEA.
  User: zhouchuang
  Date: 2018/1/20
  Time: 19:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"  %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="javascript:void(0);">湖南一生科技    IJob</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-5">
            <p class="navbar-text navbar-right"><span class="glyphicon glyphicon-user" aria-hidden="true"></span><a href="javascript:void(0);" class="navbar-link"><shiro:principal property="realName" /></a></p>
        </div>
    </div>
</nav>
<%--
<header class="navbar navbar-static-top bs-docs-nav" id="top">
    <div class="container">
        <nav id="bs-navbar" class="collapse navbar-collapse">
            <ul class="nav navbar-nav">

            </ul>
            <ul class="nav navbar-nav navbar-right">
                <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                <shiro:principal property="name" />
            </ul>
        </nav>
    </div>
</header>--%>
</body>
</html>
