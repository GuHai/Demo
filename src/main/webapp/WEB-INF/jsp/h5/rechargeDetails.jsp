<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>充值记录</title>
    <jsp:include page="qz/base/resource.jsp"/>
    <jsp:include page="qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/recharge.css?version=4">
</head>
<body>
<div class="wrap">
    <div class="page_invoiceDetails">
        <script id="voucherInfoTemplate" type="text/html"  data-url="/ijob/api/RechargeController/getVoucherInfo">
            <div class="month-row-list">
                <%--<script id="rechargeHistoryTemplate" type="text/html"  data-url="/ijob/api/RechargeController/getRechargeListByInvoiceID/{invoice.id}">
                    {{each list as recharge}}
                    #108EE9
                    {{/each}}
                </script>--%>
                {{each list as voucher}}
                    <div class="input-row">
                        <div class="table-list">
                            <div class="icon">
                                <span class="iconfont icon-chongzhi1"></span>
                            </div>
                            <div class="desc-row">
                                <div class="txt">{{voucher.remittanceName}}</div>
                                <div class="time">{{voucher.createTime | dateFormat:'yyyy-MM-dd hh:mm'}}</div>
                            </div>
                        </div>
                        <div class="money">
                            <div class="num reg_num">{{voucher.money | money}}</div>
                            {{if voucher.status == 0}}
                                <div class="examine">审核中</div>
                            {{else if voucher.status == 1}}
                                <div class="examine" style="color: #108EE9;">已通过</div>
                            {{else if voucher.status == 2}}
                                <div class="examine">已拒绝</div>
                            {{/if}}
                        </div>
                    </div>
                {{/each}}
            </div>
            <div class="fix-invoice-r">
                <a href="javascript:void(0);" class="maskBtn">
                    <i class="iconfont icon-fapiao"></i>
                    <p class="txt">发票</p>
                </a>
            </div>
            <div class="fixed-invoice-mask" style="display: none;">
                <div class="fixed-content">
                    <%--<a href="javascript:void(0);" class="mask-btn gotop1" onclick="ijob.gotoPage({path:'/h5/invoiceIndex'})">
                        <i class="iconfont icon-fapiao1"></i>
                        <p class="txt">开票</p>
                    </a>--%>
                    <a href="javascript:void(0);" class="mask-btn gotop2" onclick="ijob.gotoPage({path:'/h5/invoicehistory'})">
                        <i class="iconfont icon-fapiao"></i>
                        <p class="txt">历史</p>
                    </a>
                    <a href="javascript:void(0);" class="mask-btn gotop3">
                        <i class="iconfont icon-guanbi"></i>
                    </a>
                </div>
            </div>
        </script>
    </div>
</div>
</body>
</html>
<script src="/ijob/static/js/count.js" charset="UTF-8" ></script>
<script>
    $("#voucherInfoTemplate").loadData().then(function(result){
        console.log(result);
        if(result.data.list.length==0){
            $(".nodata").attr("style"," text-align: center; margin-top: 50%;");
        }
        var slide = null;
        $(".maskBtn").click(function(){
            $(".fixed-invoice-mask").show();
            slide = new Slide($(".wrap"),$(".fixed-invoice-mask"),".fixed-content");
            slide.disTouch();
        });

        // 点击空白处隐藏选项
        $("body>*").on('click', function (e) {
            if ($(e.target).hasClass("fixed-invoice-mask")) {
                $(".fixed-invoice-mask").hide();
                slide.ableTouch();
            }
        });
        $(".gotop3").click(function(){
            $(".fixed-invoice-mask").hide();
            slide.ableTouch();
        });
    });
</script>
