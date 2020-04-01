<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/14
  Time: 15:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="/ijob/lib/mui/js/mui.min.js"></script>
<script src="/ijob/lib/jquery-2.2.3.js"></script>
<script src="https://res.wx.qq.com/open/js/jweixin-1.2.0.js" type="text/javascript"></script>
<script src="/ijob/static/js/enums.js"></script>
<script src="/ijob/static/js/ijob.js"></script>
<script src="/ijob/lib/template.js"></script>
<script src="/ijob/static/js/templateUtils.js"></script>
<html>
<head>
    <title>微信支付测试</title>
    <style>
        .btn_back{
            display: block;
            width: 100%;
            height: 2.667rem;
            background-color: #108ee9;
            border-radius: 0.453rem;
            border: none;
            color: #fff;
            font-size: 1.333rem;
            margin: 0.800rem auto;
        }
    </style>
</head>
<body style=" ">
<button   value="01"   class="btn_back"  onclick="pay('01','1');" >充话费（0.01元）</button>
<button   value="01"   class="btn_back"  onclick="pay('01','2');" >充话费（0.02元）</button>
<button   class="btn_back"   onclick="ijob.gotoPage({path:'/h5/qz/index'})">点击跳转到首页</button>


点击退款
<ul id="orderlist">
    <script id="todayJob"   type="text/html"  data-url="/ijob/api/WeixinController/getPayOrderList"  data-type="GET" >
        {{each list as order}}
            <li style="width: 100%;margin-top: 0.267rem;font-size: 0.853rem;"  id="{{order.id}}">{{order.fee}}分,{{order.nickName}},{{order.status}}</li>
        {{/each}}
    </script>
</ul>
<script>

    $("#todayJob").loadData().then(function(result){
        $("#orderlist").on('click','li',function(i,item){
            var id =  $(this).attr("id");
            $.getJSON("/ijob/api/WeixinController/refund?orderId="+id,function(data){
                if(data.success==false){
                   mui.alert("失败"+data.msg);
                }else{
                   mui.alert("成功");
                }
            });
        });
    });



    $.getJSON("/ijob/api/WeixinController/getJSAuthSignature?url="+window.location.href,function(data){
        wx.config({
            debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
            appId: data.data.appId, // 必填，公众号的唯一标识
            timestamp: data.data.timestamp, // 必填，生成签名的时间戳
            nonceStr: data.data.noncestr, // 必填，生成签名的随机串
            signature: data.data.signature,// 必填，签名
            jsApiList: ["chooseWXPay"] // 必填，需要使用的JS接口列表
        });
    });



    function pay(type,fee){
        //首先获取订单，然后拿到订单ID 为下面的支付方法提供必要的签名参数,然后调用支付签名方法后去签名后再调用chooseWXPay方法；
        $.getJSON("/ijob/api/WeixinController/getPayOrder?type="+type+"&fee="+fee,function( data){
            $.getJSON("/ijob/api/WeixinController/getPaySignature?prepay_id="+data.data.prepay_id,function(data2) {
                wx.chooseWXPay({
                    debug: true,
                    timestamp: data2.data.timeStamp, // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
                    nonceStr: data2.data.nonceStr, // 支付签名随机串，不长于 32 位
                    package: data2.data.package, // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=\*\*\*）
                    signType: data2.data.signType, // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
                    paySign: data2.data.paySign, // 支付签名
                    success: function (res) {
                        $.getJSON("/ijob/api/WeixinController/payOk?prepayID="+data.data.prepay_id,function(data){
                            if(data.success==false){
                               mui.alert("失败"+data.msg);
                            }else{
                               mui.alert("成功");
                            }
                        });
                    },
                    error: function (res) {
                       mui.alert("错误信息" + JSON.stringify(res));
                    },
                    cencel:function(res) {
                       mui.alert('cencel pay');
                    },

                    fail:function(res) {
                       mui.alert(JSON.stringify(res));
                    }
                });
            });
        });
    }

    wx.ready(function(){
        // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
       mui.alert("回调成功");
    });

    wx.error(function(res){
       mui.alert("错误信息"+JSON.stringify(res));
    });
</script>
</body>
</html>
