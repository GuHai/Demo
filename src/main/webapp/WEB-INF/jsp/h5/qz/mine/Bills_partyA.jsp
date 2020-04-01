<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>账单_商家自动发放工资</title>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <script src="/ijob/lib//lib-flexible.js"></script>
    <script src="/ijob/lib/mui/js/mui.min.js"></script>
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/static/css/base.css">
    <link rel="stylesheet" href="/ijob/static/css/mine/Bills_Margin.css">
</head>
<body>
<script type="text/html" id="SettlementPerson" data-url="api/SettlementpersonController/qz/getSettlementpersonInfo/{data.code}/salary" data-type="POST">
    {{each list as Settlement}}
<div class="wrap">
    <div class="head-top">
        <div class="h_list">
            <div class="title">薪资</div>
            <div class="linkbtns">
                <%--<a href="">联系商家</a>--%>
                <%--<a href="">咨询</a>--%>
                <%--<a href="javascript:void(0)">申诉</a>--%>
            </div>
        </div>
        <div class="head">
            ￥{{Settlement.settlementMoney | money }}
        </div>
        <div class="statu" style="display: none;">未确认</div>
    </div>

    <ul class="infoList">
        <li>
            <span class="list-name">订单号</span>
            <span class="list-info">{{Settlement.settlement.settlementOrderNumber}}</span>
        </li>
        <%--<li>--%>
            <%--<span class="list-name">名称</span>--%>
            <%--<span class="list-info">{{Settlement.position.title}}<i class="iconfont icon-arrow-right"></i></span>--%>
        <%--</li>--%>

        <li>
            <span class="list-name">结算时间</span>
            <span class="list-info">
                <em class="list-info-month">{{Settlement.settlement.payTime | dateFormat:'yyyy-MM-dd'}}</em>
                <em class="list-info-time">{{Settlement.settlement.payTime | dateFormat:'hh:mm:ss'}}</em>
            </span>
        </li>
    </ul>
    <div class="accountList">
        <div class="datalist otherlist">
            <p class="list-name">结算日期</p>
            <p class="list-info" id="settledate">
                <%--<span>2018年5月31日</span>
                <span>2018年5月31日</span>
                <span>2018年5月31日</span>
                <span>2018年5月31日</span>
                <span>2018年5月31日</span>--%>
            </p>
        </div>
    </div>
    <div class="remarks">
        <h2>备注</h2>
        <div class="remarks-text">
            {{Settlement.settlement | ifNull:'无','remarks' }}（其中你占其中1项，薪资{{Settlement.settlementMoney | money }}元）
        </div>
    </div>
    <footer class="foot-flxed">
        <div class="footbtn">
            <a href="tel:{{Settlement.position.contactNumber}}" class="appeal">联系商家</a>
            <a href="#" class="payment">咨询</a>
        </div>
    </footer>
</div>
    {{/each}}
</script>
</body>
</html>
<script>

    $("#SettlementPerson").loadData().then(function(result){
        var datearrrs =  result.data.list[0].settlementDate;
        var datearr = ijob.getDateList(datearrrs);
        var html = "";
        for(var index in datearr){
            html += "<span>"+datearr[index]+"</span>"
        }
        $("#settledate").html(html);


        /*$(".infoList").append("<li>\n" +
            "                    <span class=\"list-name\">支付方式</span>\n" +
            "                    <span class=\"list-info\">"+(ijob.storage.get("data.virtual")==true?"余额支付":"微信支付")+"</span>\n" +
            "                </li>");*/

    });
</script>