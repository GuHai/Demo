<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>发票详情</title>
    <jsp:include page="qz/base/link.jsp"/>
    <jsp:include page="qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/recharge.css?version=4">
</head>
<body>
<div class="wrap">
    <script id="invoiceHistoryTemplate" type="text/html"  data-url="/ijob/api/RechargeController/getInvoiceHistoryInfoList/{invoice.id}">
        {{each list as invoice}}
            <div class="page_openInvoice">
                <div class="input-type-list">
                    <div class="row-tips">
                        <p class="suzane">纸质发票已开票</p>
                        <p class="time">{{invoice.createTime |dateFormat:'yyyy-MM-dd hh:mm:ss'}}</p>
                    </div>
                    <%--企业单位--%>
                    <div class="mode">发票详情</div>
                    <div class="type_main_list company_list">
                        <div class="mui-input-row">
                            <div class="title">发票抬头</div>
                            <div class="input">
                                {{invoice.title}}
                            </div>
                        </div>
                        <div class="mui-input-row">
                            <div class="title">税号</div>
                            <div class="input">
                                {{invoice.paragraph}}
                            </div>
                        </div>
                        <div class="mui-input-row">
                            <div class="title">发票金额</div>
                            <div class="input">
                                <span>{{invoice.money |money}}</span>元
                            </div>
                        </div>
                        <div class="mui-input-row">
                            <div class="title">发票内容</div>
                            <div class="input">
                                人力资源服务费*服务费
                            </div>
                        </div>
                        <div class="mode">接收方式</div>
                        <div class="mui-input-row">
                            <div class="title">收件人</div>
                            <div class="input">
                                {{invoice.recipients.name}}
                            </div>
                        </div>
                        <div class="mui-input-row">
                            <div class="title">联系电话</div>
                            <div class="input">
                                {{invoice.recipients.phoneNumber}}
                            </div>
                        </div>
                        <div class="mui-input-row">
                            <div class="title">所在地区</div>
                            <div class="input">
                                {{invoice.recipients.localtion}}
                            </div>
                        </div>
                        <div class="mui-input-row">
                            <div class="title">详细地址</div>
                            <div class="input">
                                {{invoice.recipients.detail}}
                            </div>
                        </div>
                    </div>
                    <div class="view" onclick="ijob.gotoPage({path:'/h5/invoiceDetails?data.voucher.invoiceID={{invoice.id}}'})">
                        <span>一张发票，含<span>{{invoice.counts}}</span>笔充值记录</span>
                        <a href="javascript:void(0);">查看<span class="iconfont icon-arrow-right"></span></a>
                    </div>
                    <div class="contact">
                        <a href="tel:19976956597" class="service"><span class="iconfont icon-dianhua"></span>联系客服</a>
                    </div>
                    <div class="clearfix" style="height: 1rem;clear: both;content: '';"></div>
                </div>
            </div>
        {{/each}}
    </script>
</div>
<script>
    $("#invoiceHistoryTemplate").loadData().then(function (result) {

    })
</script>
</body>
</html>


