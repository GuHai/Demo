<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>提成详情</title>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <script src="/ijob/lib//lib-flexible.js"></script>
    <script src="/ijob/lib/mui/js/mui.min.js"></script>
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/static/css/base.css">
    <link rel="stylesheet" href="/ijob/static/css/mine/Bills_Margin.css">
</head>
<body>
<div class="wrap">
<script type="text/html" id="SettlementPerson" data-url="api/SettlementpersonController/getRewardInfo/{data.orderNo}" data-type="POST">
    <div class="head-top">
        <div class="h_list">
            <div class="title">提成</div>
        </div>
        <div class="head" id="money">

        </div>
    </div>

    <ul class="infoList">
        <li>
            <span class="list-name">订单号</span>
            <span class="list-info" id="orderNo">123456789</span>
        </li>
        <li>
            <span class="list-name">结算时间</span>
            <span class="list-info">
                <em class="list-info-month" id="month">2017-12-28</em>
                <em class="list-info-time" id="time">19:20:25</em>
            </span>
        </li>
        <li>
            <span class="list-name">兼职名称</span>
            <span class="list-info">{{list[0].title}}</span>
        </li>
    </ul>
    <div class="remarks">
        <h2>备注</h2>
        <div class="remarks-text" id="mark">

        </div>
    </div>
</script>
</div>
<div id="homepage"></div>
</body>
</html>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});
    $("#SettlementPerson").loadData().then(function(result){
        console.log(ijob.storage.get("data.result"))
        $("#mark").text(ijob.storage.get("data.result").mark);
        $("#money").text("￥"+ijob.storage.get("data.result").money);
        $("#orderNo").text(ijob.storage.get("data.result").orderNo);
        $("#month").text(template.dateFormat(ijob.storage.get("data.result").datetime,'yyyy-MM-dd'));
        $("#time").text(template.dateFormat(ijob.storage.get("data.result").datetime,'hh:mm:ss'));
        //ijob.storage.get("data.result").datetime
        /*var datearrrs =  result.data.list[0].settlementDate;
        var datearr = ijob.getDateList(datearrrs);
        var html = "";
        for(var index in datearr){
            html += "<span>"+datearr[index]+"</span>"
        }
        $("#settledate").html(html);*/
    });
</script>