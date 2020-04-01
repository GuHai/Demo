<%@ page import="com.yskj.service.base.DictCacheService" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/7/29
  Time: 17:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<%--
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, viewport-fit=cover">
--%>
    <title>求职者</title>
    <jsp:include page="../h5/qz/base/link.jsp"/>
    <jsp:include page="../h5/qz/base/resource.jsp"/>
    <script src="https://res.wx.qq.com/open/js/jweixin-1.2.0.js" type="text/javascript"></script>
    <script src="/ijob/static/js/wxlocation.js?version=2"></script>
    <script src="/ijob/static/js/ijobbase.js?version=<%=DictCacheService.Version%>"></script>
    <style>
        .selected{
            color:#108ee9!important;
        }
        .unselected{
            color:#8f8f94;
        }

    </style>
</head>
<body>
<div class="wrap">
    <div id="mainPage">
        欢迎来的推广大使活动页面，这个页面需要等前端来完善。
    </div>
</div>
<script>
    ijobbase.checkSubscribe();
</script>
</body>
</html>
