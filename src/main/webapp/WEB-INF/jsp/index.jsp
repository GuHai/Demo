<%--
  Created by IntelliJ IDEA.
  User: zhouchuang
  Date: 2018/1/15
  Time: 18:31
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- 可选的 Bootstrap 主题文件（一般不用引入） -->
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script type="text/javascript" src="/ijob/static/js/jquery.ajaxfileupload.js"></script>
<script type="text/javascript" src="/ijob/static/js/ijob.js"></script>
<script type="text/javascript">

    function init(){
        $("#menuPanel").on('click','a',function(){
            gotoPage($(this).data("url"));
            clearActive();
            $(this).addClass("list-group-item-info");
        });
        gotoPage($("#menuPanel a:first").data("url"));

    }
    function clearActive(){
        $("#menuPanel a").removeClass("list-group-item-info");
    }
    function gotoPage(url){
        $('#mainContent').html("");
        $.ajax({
            type:"GET",
            url:url,
            dataType: "html",   //返回值类型	 使用json的话也可以，但是需要在JS中编写迭代的html代码，如果格式样式
            cache:false,
            success:function(data){
                $('#mainContent').html(data);
            },
            error:function(error){alert(error);}
        });
    }
</script>

<head>
    <title>iJob管理系统→详情</title>
    <link href="/ijob/static/css/login2.css" rel="stylesheet" type="text/css"/>
</head>
<html>
<body onload="init()">
<a id="skippy" class="sr-only sr-only-focusable" href="#content"><div class="container"><span class="skiplink-text">Skip to main content</span></div></a>
<jsp:include page="top.jsp"/>
<div class="row">
    <div class="col-xs-3 col-md-2" >
        <jsp:include page="menu.jsp"/>
    </div>
    <div class="col-xs-15 col-md-10"  >
        <div class="panel panel-default">
            <div class="panel-body" id="mainContent"></div>
        </div>
    </div>
</div>
</body>
</html>