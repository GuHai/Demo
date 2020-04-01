<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>提交成功</title>
    <jsp:include page="qz/base/resource.jsp"/>
    <jsp:include page="qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/recharge.css?version=4">
</head>
<body>
<div class="wrap">
    <div class="page_success">
        <div class="hd_result">
            <div class="icon">
                <span class="iconfont icon-cuowu"></span>
            </div>
            <p class="state">错误提示</p>
            <p  class="tips">该职位在待结算列表中已存在，或正在工作中</p>
        </div>
        <div class="btnbox" style="margin-top: 70px;">
            <a href="javascript:void(0)" class="back error_back" onclick="ijob.gotoPage({path:'/h5/salaryCard'})">返回首页</a>
        </div>
    </div>
</div>
</body>
</html>

