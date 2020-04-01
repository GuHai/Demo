<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>订单详情</title>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <script src="/ijob/lib//lib-flexible.js"></script>
    <script src="/ijob/lib/mui/js/mui.min.js"></script>
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/static/css/base.css">
    <link rel="stylesheet" href="/ijob/static/css/mine/salaryList.css">
</head>
<body>
    <div class="wrap">
        <script type="text/html" id="SettlementPerson" data-url="api/SettlementpersonController/zp/getSettlementpersonGroupInfo/{settlePersonGroup.id}" data-type="POST">
            {{each list as spg}}
                <div class="top">
                    <div class="title" style="display: flex;justify-content: space-between">
                        <span>薪资</span>
                        {{if spg.isPay==false}}
                        <a href="javascript:void(0);" class="cancanBtn"  style="text-decoration: underline ;color: #fff;" data-url="/ijob/api/SettlementpersonController/zp/cancelPay/{settlePersonGroup.id}">取消支付</a>
                        {{/if}}
                    </div>
                    <div class="head">
                        {{spg.totalMoney}}
                    </div>
                    <div class="statu" style="display: block;">{{spg.isPay == true?'已支付':'等待付款'}}</div>
                </div>
                <ul class="infoList">
                    <li>
                        <span class="list-name">订单号</span>
                        <span class="list-info">{{spg.wxorder.code}}</span>
                    </li>
                    <li>
                        <span class="list-name">{{spg.isPay == true?'结算':'下单'}}时间</span>
                        <span class="list-info">{{spg.updateTime  | dateFormat:'yyyy-MM-dd hh:mm:ss'}}</span>
                    </li>
                </ul>
                <div class="accountList">
                    <div class="datalist otherlist">
                        <p class="list-name">结算日期</p>
                        <p class="list-info">
                            {{each spg.applySettlements as apply}}
                            <span>{{apply.workDate |  datestrFormat}}</span>
                            {{/each}}
                        </p>
                    </div>
                    <div class="perslist otherlist">
                        <p class="list-name">结算人员</p>
                        <p class="list-info">
                            {{each spg.applySettlements as apply}}
                            <span>{{apply.name}}</span>
                            {{/each}}
                        </p>
                    </div>
                </div>
                <div class="remarks">
                    <h2>备注</h2>
                    <div class="remarks-text">
                        {{spg.wxorder.description}}
                    </div>
                </div>
                {{if spg.isPay==false}}
                <div style="clear: both;content: '';height: 1.33rem"></div>
                <footer class="foot-fixed">
                    <div class="money">共计：<span>&yen{{spg.totalMoney}}</span></div>
                    <div class="payment">
                        <a href="javascript:void(0)" class="pay">去结算</a>
                    </div>
                </footer>
                {{/if}}
            {{/each}}
        </script>
    </div>
</body>
<script>

    $(".wrap").on('click','.cancanBtn',function(){
        $(this).btPost({},function(result){
            if(result.success){
                ijob.reback(result.msg)
            }
        });
    });

    $("#SettlementPerson").loadData().then(function(result){
        $(".pay").click(function(){
            var  order = {order:{status:result.data.list[0].wxorder.status,code:result.data.list[0].wxorder.code,name:result.data.list[0].wxorder.name,id:result.data.list[0].wxorder.id,refID:result.data.list[0].wxorder.refID,fee:result.data.list[0].wxorder.fee,description:result.data.list[0].wxorder.description,type:enums.WxOrderType.Settlement}};
            ijob.url.next.set("/ijob/api/ApplySettlementController/settleCallback");
            ijob.gotoPage({url:'/ijob/api/WeixinController/order',data:order});
        });
    });



</script>
</html>
