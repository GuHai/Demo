<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>充值</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/recharge.css?version=4">
</head>
<body>
<div class="wrap">
    <div class="page_recharge">
        <div class="record-box">
            <a href="javascript:void(0);" class="record-btns" onclick="ijob.gotoPage({path:'/h5/rechargeDetails'})">充值记录</a>
        </div>
        <div class="hd-recharge">
            <div class="txt">银行转账，进行充值</div>
            <div class="desc"><span>安全</span><span>快速</span><span>无限额</span></div>
        </div>
        <div class="img_list">
            <img src="/ijob/static/images/info.png"/>
        </div>
        <div class="info-list">
            <div class="post"><span>手机银行或网上银行</span>&nbsp;&nbsp;<span>转账至 一生科技</span></div>
            <div class="bank"><span class="txt">工商银行:</span> <span class="a_number" id="a_number">1901&nbsp;1002&nbsp;0902&nbsp;0149&nbsp;715</span></div>
            <div class="tips">转账后上传回执凭证，审核通过后充值到余额</div>
        </div>
        <div class="btnBox">
            <p class="tips"><span>注：</span>由于税法改革，暂不支持开具发票<br></p>
            <p class="tips" style="margin-left: 0.613rem">（财务做账请采用临时工工资表的形式完成）</p>
            <a href="javascript:void(0);" class="nextbtn" onclick="ijob.gotoPage({path:'/h5/qz/myjob/upload_voucher'})">已转账，下一步</a>
        </div>
    </div>
</div>
</body>
</html>
