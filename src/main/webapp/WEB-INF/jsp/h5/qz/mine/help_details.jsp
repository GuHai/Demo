<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/27
  Time: 15:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>保证金</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/using_help.css?version=4">
</head>
<body>
<div class="wrap">
    <div class="page_help_details">
        <div class="hd-main">
            <div class="title">为什么要交保证金</div>
        </div>
        <div class="content_details">
            <div class="box">
            </div>
        </div>
        <div class="details-foot">
            <button type="button" class="btns useful" data-type="1" data-url="/ijob/api/DictstatiController/add"><span class="iconfont icon-zan"></span>有用</button>
            <button type="button" class="btns useless" data-type="0" data-url="/ijob/api/DictstatiController/add"><span class="iconfont icon-dianzan"></span>没用</button>
        </div>
    </div>
</div>
</body>
</html>
<script type="text/javascript">
    $(function () {
        $(".details-foot .btns").click(function () {
            $(this).toggleClass("active").siblings().attr("disabled",true).addClass("disabled");
            if (!$(this).hasClass("active")){
                $(this).siblings().attr("disabled",false).removeClass("disabled");
            }
            $(".btns").btPost(
                {
                    'dictID':ijob.storage.get("data.id"),
                    'status':$(this).data("type")
                },
                function(data){
                console.log(data);
                if(data.code==200){
                    history.back();
                }
            });
        })
        document.title = ijob.storage.get("data.title");
        $(".title").text(ijob.storage.get("data.title"));
        $(".box").text(ijob.storage.get("data.dictContent"));
    })
</script>
