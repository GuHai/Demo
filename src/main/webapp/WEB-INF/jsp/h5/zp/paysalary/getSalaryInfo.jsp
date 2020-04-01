<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/2/14
  Time: 14:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>领工资</title>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/part/newAccount.css?version=4">
    <style>
        .wrap .main .accountsList .account-list-ul .posi-list .head-flex .mui-switch.mui-active:before {
            content: '开放中';
            left: 0.133rem;
        }
        .wrap .main .accountsList .account-list-ul .posi-list .head-flex .mui-switch:before{
            content: '关闭';
        }
    </style>
</head>
<body>

<div class=wrap>
    <ul class="tabList" <%--style="display:none"--%>>
        <li class="active"><a href="javascript:void(0);">待结算</a></li>
        <li class=""><a href="javascript:void(0);">已结算</a></li>
    </ul>
    <div class="only" style="padding-top: 1.333rem">

    </div>
    <div id="homepage"></div>
</div>
</body>


<script src="/ijob/static/js/utf.js"></script>
<script src="/ijob/static/js/qrcode.min.js"></script>
<script src="/ijob/static/js/html2canvas.min.js"></script>
<script>
    $("#homepage").loadPage({path:"/h5/zp/paysalary/payInfoHomepage"});
    // div切换
    $(".tabList>li").on("click", function () {
        var _main = $(".only")
        var index = $(this).index();
        $(this).addClass("active").siblings().removeClass("active");
        $(".main .datalist>div").eq(index).show().siblings().hide();
        if(index == 0){
            _main.loadPage({path:'/h5/zp/paysalary/getMoney'});
        }else {
            _main.loadPage({path:'/h5/zp/paysalary/getEndInfo'});
        }
    })
    $(".tabList>li").eq(0).click();
</script>
</html>
