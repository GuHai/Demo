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
    <title>账单详情</title>
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
    <script id="detail"   type="text/html"  data-url="/ijob/api/AccountController/getDetail"  >
        {{each list as bill}}
            <div class="head billhead">
                ￥{{bill.money |money}}
                <p class="current">已支付</p>
            </div>
            <ul class="infoList">
                <li>
                    <span class="list-name">订单号</span>
                    <span class="list-info">{{bill.orderNo}}</span>
                </li>
                <li>
                    <span class="list-name">支付时间</span>
                    <span class="list-info">
                        <em class="list-info-month">{{bill.createTime | dateFormat:'yyyy-MM-dd'}}</em>
                        <em class="list-info-time">{{bill.createTime | dateFormat:'hh:mm:ss'}}</em>
                    </span>
                </li>
            </ul>
            <div class="handle" >
                <h3>备注</h3>
                <div class="remarks-text">
                    {{bill.mark}}
                </div>
            </div>
        {{/each}}
    </script>
</div>
<div id="homepage"></div>
</body>
</html>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>


    $("#homepage").freshPage({path:"/h5/homepage"});
    var orderNo = ijob.storage.get("orderNo");
    var obj = {condition:{orderNo:orderNo}};
    $("#detail").loadData(obj).then(function(result){
        var bill  = result.data.list[0];
        var arr = [];
        if(ijob.storage.get("type")==17||ijob.storage.get("type")==30){
            $(".current").text('已到账');
            ijob.storage.set("type",null);
        }
    });

</script>
