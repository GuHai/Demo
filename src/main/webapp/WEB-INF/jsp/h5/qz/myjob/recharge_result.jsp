<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>充值结果</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/recharge.css">
</head>
<body>
<div class="wrap">
    <div class="page_recharge_result">
        <div class="hd_result">
            <div class="icon">
                <span class="iconfont icon-shijian"></span>
            </div>

            <p class="state">审核中</p>
            <p class="money">20,000.00元</p>
            <p  class="tips">预计24小时内充值到余额</p>
        </div>
        <div class="btnbox">
            <a href="javascript:void(0)" class="back" onclick="ijob.gotoPage({path:'/h5/salaryCard'})">返回</a>
        </div>
    </div>
</div>
</body>
<script>
    $(".money").text(template.money(parseFloat(ijob.storage.get("money")))+"元");
</script>
</html>

