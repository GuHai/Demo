<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>账单_提取现金</title>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/static/css/base.css">
    <link rel="stylesheet" href="/ijob/static/css/mine/Bills_withdrawCash.css">
    <style>
        #process{
            zoom:0.5;
        }
    </style>
</head>
<body>
<div class="wrap">
    <script type="text/html" id="withdrawCash" data-url="api/WithdrawalsController/getsxf/{data.code}" data-type="POST">
        {{each list as withdraw}}
            <div class="wrap">
                <div class="head">
                    <p class="bank">
                       <i class="iconfont icon-weixin" style="color: #00b60d"></i>
                        <span>微信</span>
                    </p>
                    <p class="momey" id="whdrawMomey">￥{{withdraw.price  | money}}</p>
                    {{if withdraw.settlementState == 1}}
                    <p class="current">审批中</p>
                    {{else if  withdraw.settlementState == 2}}
                    <p class="current">已到账</p>
                    {{else if  withdraw.settlementState == 3}}
                    <p class="current">已拒绝</p>
                    {{/if}}
                </div>
                <div class="handle hand-bar">

                    <%--<canvas id="process"  ></canvas>--%>
                    <h4 class="title">提现处理进度</h4>
                    <ul class="step">
                        <li class="normal current">
                            <sub></sub>
                            <div class="txt">
                                <p>已申请</p>
                                <p>{{withdraw.launchTime |dateFormat:'MM-dd hh:mm'}}</p>
                            </div>
                        </li>
                        <li class="normal {{if withdraw.settlementState==2 }} current {{/if}}">
                            <sub></sub>
                            <div class="hr"></div>
                            <div class="txt">
                                <p>已审核</p>
                                <p>{{withdraw.auditTime |dateFormat:'MM-dd hh:mm'}}</p>
                            </div>
                        </li>
                        <li class="normal {{if withdraw.settlementState==2 }} current {{/if}}">
                            <sub></sub>
                            <div class="hr"></div>
                            <div class="txt">
                                <p id="type">
                                    {{withdraw.settlementState==3?'已拒绝':'已扣除'}}
                                </p>
                                {{if withdraw.settlementState==2}}
                                <p>{{withdraw.releaseTime |dateFormat:'MM-dd hh:mm'}}</p>
                                {{/if}}
                            </div>
                        </li>
                    </ul>
                </div>
                <ul class="infoList">
                    <li>
                        <span class="list-name">类别</span>
                        <span class="list-info">提现手续费</span>
                    </li>
                    <li>
                        <span class="list-name">订单号</span>
                        <span class="list-info">{{withdraw.settlementOrderNumber}}</span>
                    </li>
                </ul>
                <div class="remarks">
                    <h2>备注</h2>
                    <div class="remarks-text">
                        {{withdraw.remarks}}
                    </div>
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
    $("#withdrawCash").loadData().then(function(result){
        /* var bill = result.data.list[0];
         console.log(result);
         var arr = [];
         arr.push({name:'已提交',time:ijob.dateFormat(bill.createTime,'MM-dd hh:mm'),state:1});
         arr.push({name:'已审核',time:ijob.dateFormat(bill.updateTime,'MM-dd hh:mm'),state:bill.isPass!=null?1:0});
         arr.push({name:(bill.status==3?'已拒绝':'已扣除'),time:ijob.dateFormat(bill.updateTime,'MM-dd hh:mm'),state:bill.isPass!=null?1:0});
         ijob.showProcess('process', arr,"提现处理进度");*/
    });
</script>




<%--
<script>
    $("#withdrawCash").loadData().then(function(result){
        console.log(result);
    });
    $(".selectList>li").on("click", function () {
        $(".wrap").hide();
        $("#chooseResume").show();
    })
</script>--%>
