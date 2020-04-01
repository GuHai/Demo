<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/29
  Time: 14:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"    import="com.yskj.service.base.DictCacheService" %>
<html>
<head>
    <title>提示</title>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, viewport-fit=cover">
    <meta http-equiv=”Content-Type” content=”text/html; charset=utf-8” />
    <link rel="stylesheet" href="/ijob/static/css/part/partstyle.css?version=<%=DictCacheService.Version%>">
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css?version=<%=DictCacheService.Version%>">
    <script src="/ijob/lib/jquery-2.2.3.min.js?version=<%=DictCacheService.Version%>"  charset="UTF-8"></script>
    <script src="/ijob/static/js/ijob.js?version=<%=DictCacheService.Version%>"  charset="UTF-8"></script>
</head>
<body>
<div class="wrap">
    <div class="main_list_content">
        <div class="align">
            <div class="icon">
                <span class="iconfont icon-cuowu"></span>
            </div>
            <div class="txt">
                <p class="title">错误提示</p>
                <p class="desc">${result}</p>
            </div>
            <div class="button">
                <a id="homepage" class="homepage">返回首页</a>
            </div>
        </div>
    </div>
</div>
</body>
<script>

    var msg = sessionStorage.getItem("error");
    if(msg){
        $(".desc").text(msg);
        sessionStorage.setItem("error",null);
    }
    var type = "${type}";
    document.getElementById("homepage").onclick = function(){
        if(type==1||type=="1"){
            ijob.gotoPage({path:'/h5/zp/paysalary/salaryIndex'})
        }else{
            window.location.href = "/indexMain";
        }
    }
</script>
</html>
