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

    <script type="text/html" id="SettlementPerson" data-url="api/SettlementpersonController/getRedPacketBackInfo/{data.orderNo}" data-type="POST">
        <div class="head-top">
            <div class="h_list">
                <div class="title">红包退款</div>
            </div>
            <div class="head" id="money">
            </div>
        </div>

        <ul class="infoList">
            <li>
                <span class="list-name">订单号</span>
                <span class="list-info"id="orderNo"></span>
            </li>
            <li>
                <span class="list-name">退还时间</span>
                <span class="list-info">
                    <em class="list-info-month" id="month"></em>
                    <em class="list-info-time" id="time"></em>
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
</body>

<script>

    $("#SettlementPerson").loadData().then(function(result){
        $("#mark").text(ijob.storage.get("data.result").mark);
        $("#money").text("￥"+ijob.storage.get("data.result").money);
        $("#orderNo").text(ijob.storage.get("data.result").orderNo);
        $("#month").text(template.dateFormat(ijob.storage.get("data.result").datetime,'yyyy-MM-dd'));
        $("#time").text(template.dateFormat(ijob.storage.get("data.result").datetime,'hh:mm:ss'));
    });
</script>
</html>
