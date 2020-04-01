<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>工资卡</title>
    <jsp:include page="qz/base/resource.jsp"/>
    <jsp:include page="qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/salaryCard.css?version=4">
</head>
<body>
<div class="wrap page_rechargeSalary">
    <script id="rechargeTemplate" type="text/html"  data-url="/ijob/api/AccountController/getRechargeSum"  data-type="POST" >
        {{each list as user}}
        <div class="over_blue">
            <p class="txt">充值金额</p>
            <div class="over-withdraw">{{user.money |money}}元</div>
            <div class="margin">
                <span>充值的金额不可以提现，只能用于发工资或转账。</span>
            </div>
        </div>
        <div class="popular">
            <ul id="hot">
            </ul>
        </div>
        <div class="withdraw b-border">
            <a href="javascript:void(0)">
                <span class="withdrawspan"><i class="iconfont icon-zhuanzhang"></i>转账</span>
                <span class="right-txt">扫对方收钱二维码即可转账<span class="iconfont icon-arrow-right"></span></span>
            </a>
        </div>
        <div class="withdraw">
            <a href="javascript:void(0)" onclick="ijob.gotoPage({path:'/h5/pay_code_transfer?zhuanzhang.type=2'})">
                <span class="withdrawspan"><i class="iconfont icon-chongzhi"></i>收钱</span>
                <span class="iconfont icon-arrow-right"></span>
            </a>
        </div>
        <div class="details">
            <a href="javascript:void(0)">
                <span class="detailsspan"><i class="iconfont icon-qia"></i>结算给自己</span>
                <span class="right-txt">结算后可用于提现<span class="iconfont icon-arrow-right"></span></span>
            </a>
        </div>
        {{/each}}
    </script>
</div>
</body>
<script src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js" type="text/javascript"></script>
<script>
    $("#rechargeTemplate").loadData({condition:{'isMain':false}}).then(function (result) {
        console.log(result);
        $(".details").click(function () {
            if(result.data.list[0].money <= 0){
                mui.alert("您的充值金额不足，无法进行结算！");
            }else{
                ijob.gotoPage({path:'/h5/cash?rechargeJs.type=2'})
            }
        });
        $(".b-border").click(function () {
            if(result.data.list[0].money <= 0){
                mui.alert("您的充值金额不足，无法进行转账！");
            }else{
                $(this).unbind();
                $.getJSON("/ijob/api/WeixinController/getJSAuthSignature?url="+window.location.href,function(data){
                    wx.config({
                        debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                        appId: data.data.appId, // 必填，公众号的唯一标识
                        timestamp: data.data.timestamp, // 必填，生成签名的时间戳
                        nonceStr: data.data.noncestr, // 必填，生成签名的随机串
                        signature: data.data.signature,// 必填，签名
                        jsApiList: ["scanQRCode"] // 必填，需要使用的JS接口列表
                    });
                })
                wx.ready(function () {
                    wx.scanQRCode({
                        needResult: 0, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                        scanType: ["qrCode","barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                        success: function (res) {
                            var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                        }
                    });
                });
            }
        });
    });
</script>
</html>
