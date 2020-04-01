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
    <script id="todayJob"   type="text/html"  data-url="/ijob/api/BondtransactionController/getBondDetail2"  >
        {{each list as bill}}
        <div class="head billhead">
            ￥{{bill.money | money}}
            <p class="current">{{bill.status | enums:'BillType'}}</p>
        </div>
        <div class="handle" >
            <h4 class="title">保证金{{bill.status==4?'赔付':'退回'}}进度</h4>

            <ul class="step">
                <li class="normal current">
                    <sub></sub>
                    <div class="txt">
                        <p>已支付</p>
                        <p>{{bill.submitTime |dateFormat:'MM-dd hh:mm'}}</p>
                    </div>
                </li>
                <li class="normal current">
                    <sub></sub>
                    <div class="hr"></div>
                    <div class="txt">
                        <p>平台托管</p>
                        <p>{{bill.ensureTime |dateFormat:'MM-dd hh:mm'}}</p>
                    </div>
                </li>
                <li class="normal {{if bill.status==3 ||bill.status==4 }} current {{/if}}">
                    <sub></sub>
                    <div class="hr"></div>
                    <div class="txt">
                        <p id="type">{{bill.status==4?'已赔付':'已退回'}}</p>
                        {{if bill.status==3|| bill.status==4}}
                        <p>{{bill.arrival |dateFormat:'MM-dd hh:mm'}}</p>
                        {{/if}}
                    </div>
                </li>
            </ul>
            <%--<canvas id="process" ></canvas>--%>
        </div>
        <ul class="infoList">
            <li>
                <span class="list-name">名称</span>
                <span class="list-info">{{bill.name}}</span>
            </li>
            <li>
                <span class="list-name">订单号</span>
                <span class="list-info">{{bill.code}}</span>
            </li>
            <li>
                <span class="list-name">发放时间</span>
                <span class="list-info">
                        <em class="list-info-month">{{bill.payTime | dateFormat:'yyyy-MM-dd'}}</em>
                        <em class="list-info-time">{{bill.payTime | dateFormat:'hh:mm:ss'}}</em>
                    </span>
            </li>
        </ul>
        <div class="handle" >
            <h3>备注</h3>
            <div class="remarks-text">
                {{bill.cpename}}{{bill.mark}}
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
    var obj = {condition:{orderNumber:orderNo}};
    $("#todayJob").loadData(obj).then(function(result){
        $(".infoList").append("<li>\n" +
            "                    <span class=\"list-name\">支付方式</span>\n" +
            "                    <span class=\"list-info\">"+(ijob.storage.get("data.virtual")==true?"余额支付":"微信支付")+"</span>\n" +
            "                </li>");
    });

</script>
