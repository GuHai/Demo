<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/18
  Time: 16:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>结算详情</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/My_part-time/SettlementApplication_detail.css">
</head>
<body>
<div class="wrap">
    <ul class="topList">
        <li class="listMoney">
            <span>申请结算薪酬</span>
            <span id="applyPay"></span>
        </li>
        <li class="listTime">
            <span>申请时间</span>
            <span id="time">2017年12月24日<em>18:30:20</em></span>
        </li>
    </ul>
    <div class="listReason">
        申请原由
        <p id="applyReason">由于个人原由，不能继续工作</p>
    </div>
    <div class="handle">
        <div class="handle_time">
            <span>处理时间</span>
            <span id="dotime"><em></em></span>
        </div>
        <div class="handle_opinion">
            <span>处理意见</span>
            <span id="flag"></span>
        </div>
        <p class="msg" id="reason">完工后统一进行结算</p>
    </div>
    <div class="btnBox">
        <a href="javascript:void(0)" onclick="tosettlelist()" class="btn_link">申请结算记录</a>
        <input type="button" class="btn_back" value="返回">
    </div>
</div>
</body>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>
    var settle = ijob.storage.get("settle");
    var applyReason = settle.applyReason ;
    var applyPay = settle.applyPay ;
    $("#time").html(ijob.dateFormat(settle.createTime,"yyyy年MM月dd日<em>hh-mm-ss</em>"));
    if(settle.createTime!=settle.updateTime)$("#dotime").html(ijob.dateFormat(settle.updateTime,"yyyy年MM月dd日<em>hh-mm-ss</em>"));
    $('#applyReason').text(applyReason);
    $("#applyPay").text(applyPay+"元");
    $("#reason").text(settle.reason);
    var state = settle.state;
    $("#flag").text((state&&state!=0)?(state==1?"同意":"不同意"):"待处理");

    $(".btn_back").click(function(){
        ijob.back();
    });

    function tosettlelist(){
        window.location.href='/ijob/api/ApplySettlementController/list/'+settle.positionID;
    }
</script>
</html>
