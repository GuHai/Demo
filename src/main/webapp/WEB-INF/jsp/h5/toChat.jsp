<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/2/26
  Time: 15:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="qz/base/resource.jsp"/>
    <script src="/ijob/static/js/ijobbase.js?version=5"></script>

    <title>聊天</title>
</head>
<body>
<script>
    ijobbase.toChat({toUserID:'${userID}'});

</script>
</body>
</html>
