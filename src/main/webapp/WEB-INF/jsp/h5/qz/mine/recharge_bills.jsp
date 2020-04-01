<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/2
  Time: 13:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>充值详情</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="../../css/mine/Bills_Margin.css">
    <style>
        #process{
            zoom:0.5;
        }
        .remarks-text {
            text-indent: 2em;
            margin-top: 0.160rem;
            font-size: 0.320rem;
            font-weight: normal;
            font-stretch: normal;
            letter-spacing: 0px;
            color: #666666;
        }
    </style>
</head>
<body>
<div class="wrap">
    <script id="todayJob"   type="text/html"  data-url="/ijob/api/RechargeController/one"  >
        {{each list as bill}}
        <div class="head billhead">
            ￥{{bill.money |money}}
            <p class="current">已到账</p>
        </div>
        <ul class="infoList">
            <li>
                <span class="list-name">类别</span>
                <span class="list-info">充值</span>
            </li>
            <li>
                <span class="list-name">订单号</span>
                <span class="list-info">{{bill.orderNumber}}</span>
            </li>
            <li>
                <span class="list-name">到账时间</span>
                <span class="list-info">
                        <em class="list-info-month">{{bill.rechargeDate | dateFormat:'yyyy-MM-dd'}}</em>
                        <em class="list-info-time">{{bill.rechargeDate | dateFormat:'hh:mm:ss'}}</em>
                    </span>
            </li>
        </ul>
        <div class="handle" >
            <h3>备注</h3>
            <div class="remarks-text">
                余额充值：{{bill.money |money}}元
            </div>
        </div>
        {{/each}}
    </script>

</div>
</body>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>

    var orderNo = ijob.storage.get("orderNo");
    var obj = {condition:{orderNumber:orderNo}};
    $("#todayJob").loadData(obj).then(function(result){
       console.log(result);
    });

</script>
</html>
