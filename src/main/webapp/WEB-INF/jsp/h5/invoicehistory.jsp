<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>开票历史</title>
    <jsp:include page="qz/base/resource.jsp"/>
    <jsp:include page="qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/recharge.css?version=4">
</head>
<body>
<div class="wrap">
    <div class="page_invoicehistory">
        <script id="invoiceListTemplate" type="text/html"  data-url="/ijob/api/RechargeController/getInvoiceHistoryInfoList/0">
            {{each list as invoice}}
                {{if invoice.status == false && invoice.counts == 0}}
                <div class="row-list">
                {{else}}
                <div class="row-list" onclick="ijob.gotoPage({path:'/h5/openInvoice?data.invoice.id={{invoice.id}}'})">
                {{/if}}
                    <div class="hd-row">
                        <div class="time">{{invoice.createTime |dateFormat:'yyyy-MM-dd hh:mm:ss'}}</div>
                        <div class="link">
                            <a href="javascript:void(0);">
                                {{if invoice.status == false && invoice.counts == 0}}
                                    已拒绝
                                {{else if invoice.status == false && invoice.counts != 0}}
                                    审核中
                                    <span class="iconfont icon-arrow-right"></span>
                                {{else}}
                                    已开票
                                    <span class="iconfont icon-arrow-right"></span>
                                {{/if}}
                            </a>
                        </div>
                    </div>
                    <div class="genre-row">
                        <div class="type">
                            <p>纸质发票</p>
                            <p>代发工资</p>
                        </div>
                        <div class="money">
                            <span>{{invoice.money |money}}</span>元
                        </div>
                    </div>
                </div>
            {{/each}}
                </div>
        </script>
    </div>
</div>
</body>
</html>
<script>
    $("#invoiceListTemplate").loadData().then(function (result) {
        console.log(result);
    })

</script>