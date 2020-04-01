<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/1/17
  Time: 16:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"   import="com.yskj.service.base.DictCacheService" %>
<html>
<head>
    <script type="text/javascript" src="/ijob/lib/jquery-2.2.3.min.js" ></script>
    <script charset="UTF-8" src='/ijob/static/js/ijob.js?version=<%=DictCacheService.Version%>'></script>
    <script>
        $(document).ready(function(){
            setTimeout(function(){
                $("body").loadPage({path:sessionStorage.getItem("path")});
            },1000);
        });
    </script>
</head>
<body>
</body>
</html>
