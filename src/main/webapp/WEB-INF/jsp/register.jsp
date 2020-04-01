<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/19
  Time: 12:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
</head>
<body>

<title>注册页面</title>


<h3><a name="t1"></a>注册</h3>
<form method="post" action="/userController/register">
    姓名:
    <input type="text" name="username" placeholder="请输入姓名">
    密码:
    <input type="text" name="password" placeholder="请输入密码">
    <div>
        <button type="reset" class="btn">重写</button>
        <button id="submit" class="btn">注册</button>
    </div>
</form>
</body>
</html>
