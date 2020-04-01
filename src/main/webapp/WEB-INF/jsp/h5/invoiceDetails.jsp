<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>发票详情</title>
    <jsp:include page="qz/base/resource.jsp"/>
    <jsp:include page="qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/recharge.css?version=4">
</head>
<body>
<div class="wrap">
    <div class="page_invoiceDetails">
        <div class="month-row-list">
            <script id="rechargeHistoryTemplate" type="text/html"  data-url="/ijob/api/RechargeController/getRechargeListByInvoiceID/{invoice.id}">
                {{each list as recharge}}
                    <div class="input-row">
                        <div class="table-list">
                            <div class="desc-row">
                                <div class="txt">{{recharge.voucher.remittanceName}}</div>
                                <div class="time">{{recharge.createTime |dateFormat:'yyyy-MM-dd hh:mm:ss'}}</div>
                            </div>
                        </div>
                        <div class="money">
                            <span class="num reg_num">{{recharge.money |money}}</span>
                            <span class="yuan">元</span>
                        </div>
                    </div>
                {{/each}}
            </script>
        </div>
    </div>
</div>
</body>
</html>
<script src="/ijob/static/js/count.js" charset="UTF-8" ></script>
<script>
    $("#rechargeHistoryTemplate").loadData().then(function(result){
        console.log(result);
    });
</script>
