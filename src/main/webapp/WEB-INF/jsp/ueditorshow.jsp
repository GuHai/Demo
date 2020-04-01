<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/10
  Time: 16:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>查看</title>
    <style>
        .main{
            width: 80%; margin-left: auto; margin-right: auto;
            margin-top: 100px;
        }
        .title{
            word-break: break-word!important;
            word-break: break-all;
            margin: 20px 0 0;
            font-family: -apple-system,SF UI Display,Arial,PingFang SC,Hiragino Sans GB,Microsoft YaHei,WenQuanYi Micro Hei,sans-serif;
            font-size: 34px;
            font-weight: 700;
            line-height: 1.3;
        }
        .title1{
            word-break: break-word!important;
            word-break: break-all;
            margin: 20px 0px 50px 0px;
            font-family: -apple-system,SF UI Display,Arial,PingFang SC,Hiragino Sans GB,Microsoft YaHei,WenQuanYi Micro Hei,sans-serif;
            font-size: 20px;
            font-weight: 500;
            line-height: 1;
            color: #6a6a6c;
        }
        .content{
            color: #2f2f2f;
            word-break: break-word!important;
            word-break: break-all;
            font-size: 16px;
            font-weight: 400;
            line-height: 1.7;
        }
        .meta{
            margin-top: 5px;
            color: #969696;
        }
        .info{
            font-size: 12px;
            vertical-align: middle;
            display: inline-block;
            color: #969696;
        }
    </style>
</head>
<body>
<div class="main">
    <h1 class="title">${news.title}</h1>
    <h1 class="title1">${news.description}</h1>
    <div class="info">
        <span >作者：${news.author}</span>
        <div class="meta">
            <span >时间：${news.publishTime}</span>
        </div>
    </div>

    <div class="content">
        ${news.content}
    </div>
</div>
</body>
</html>
