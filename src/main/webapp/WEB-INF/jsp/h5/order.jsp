<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/19
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>支付</title>
    <jsp:include page="qz/base/resource.jsp"/>
    <jsp:include page="qz/base/link.jsp"/>
    <script src="https://res.wx.qq.com/open/js/jweixin-1.2.0.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/ijob/static/css/My_part-time/GoToPay.css?version=4">
    <link rel="stylesheet" href="/ijob/static/css/mine/salaryCard_withdraw.css?version=4">

    <script>
        /*(function ($) {
            window.addEventListener('pageshow', function (e) {
                // 通过persisted属性判断是否存在 BF Cache
                if (e.persisted) {
                    location.reload();
                }
            });
        })(mui);*/


        $(function () {
            var isPageHide = false;
            window.addEventListener('pageshow', function () {
                if (isPageHide) {
                    window.location.reload();
                }
            });
            window.addEventListener('pagehide', function () {
                isPageHide = true;
            });

        });
    </script>
    <style>
        .active{
            color:#1006F1!important;
        }
    </style>
</head>
<body>
    <div class="wrap">

        <!--浮动层-->
        <div class="pay_password" style="display: none;">
            <div class="pass-content">
                <div class="input-box">
                    <div class="payment-title">
                        <span class="tit">请输入支付密码</span>
                        <span class="iconfont icon-guanbi close"></span>
                    </div>
                    <div class="wages">
                        <div class="title" id="paytips">提现工资</div>
                        <div class="price"></div>
                    </div>
                    <ul class="input_password">
                        <li></li><li></li><li></li><li></li><li></li><li></li>
                    </ul>
                    <div class="flex-wrap">
                        <div class="switch" id="switchPay">
                            <span class="iconfont icon-weixin"></span>
                            <span>切换为微信支付</span>
                        </div>
                        <div class="forgot-password">
                            <a href="/ijob/api/InformationController/h5/mine/mySettings_changePassword_again">忘记密码？</a>
                        </div>
                    </div>
                </div>
                <div class="keyboard_box">
                    <ul class="numList">
                        <li><a href="javascript:void(0);" class="zf_num">1</a></li>
                        <li><a href="javascript:void(0);" class="zj_x zf_num">2</a></li>
                        <li><a href="javascript:void(0);" class="zf_num">3</a></li>
                        <li><a href="javascript:void(0);" class="zf_num">4</a></li>
                        <li><a href="javascript:void(0);" class="zj_x zf_num">5</a></li>
                        <li><a href="javascript:void(0);" class="zf_num">6</a></li>
                        <li><a href="javascript:void(0);" class="zf_num">7</a></li>
                        <li><a href="javascript:void(0);" class="zj_x zf_num">8</a></li>
                        <li><a href="javascript:void(0);" class="zf_num">9</a></li>
                        <li><a href="javascript:void(0);" class="empty">清空</a></li>
                        <li><a href="javascript:void(0);" class="zj_x zf_num">0</a></li>
                        <li><a href="javascript:void(0);" class="del iconfont icon-Icon_deleteK"></a></li>
                    </ul>
                </div>
                <div class="popup-content"></div>
            </div>
        </div>



        <div class="head_title">
            <div class="head_title_lf">
                未支付
                <p id="notice">

                </p>
            </div>
            <div class="head_title_rt">
                <img src="/ijob/static/images/dzf.png" alt="">
            </div>
        </div>
        <div class="main">
            <div>
                <script  type="text/html" id="jobtemplate"  data-url="/ijob/api/WeixinController/getPayOrder" >
                    {{each list as order }}

                    <div class="ulBox">
                        <ul class="conterList">
                            <li class="layout">
                                <span>产品名称</span>
                                <span>{{order.name}}</span>
                            </li>
                           <li class="layout">
                                <span>描述</span>
                                <span >{{order.description}}</span>
                            </li>
                            <%-- <li class="layout">
                                <span>订单号</span>
                                <span>{{order.code}}</span>
                            </li>--%>
                            <li class="layout">
                                <span>应付金额</span>
                                <em class="p_money">{{order.fee/100}}元</em>
                            </li>
                            <li class="layout">
                                <span>支付状态</span>
                                <em class="p_money">{{order.status | enums:'PayState' }}</em>
                            </li>
                        </ul>
                    </div>

                    {{/each}}
                </script>
            </div>

            <div class="btnBox" >
                <div class="edit_post">
                    <div class="txt">
                        <p class="tips"></p>
                        <%--<span id="payType">使用${information.payType==1?'微信':'账户余额'}支付</span>--%>
                        <%--<a href="javascript:void(0);" class="editBtn">更改<span class="iconfont icon-arrow-right"></span></a>--%>
                    </div>
                    <%--<div class="edit-popup-backdrop" style="display: none">
                        <div class="select_content" data-url="/ijob/api/InformationController/update">
                             <div class="tit">选择支付方式</div>
                            <div class="row-lilst" data-type="2">
                                <span class="left  ${information.payType==1?'':'active'}">余额（剩余${information.money}）</span>
                                <a href="javascript:void(0);" class="tips" >&lt;%&ndash;余额不足&ndash;%&gt;<span class="iconfont icon-arrow-right"></span></a>
                            </div>
                            <div class="row-lilst last-child" data-type="1">
                                <span class="left ${information.payType==2?'':'active'}">微信</span>
                                <span class="iconfont icon-arrow-right"></span>
                            </div>
                            <div class="cancelbtn">取消</div>
                        </div>
                    </div>--%>
                </div>
                <input type="button" id="saveConfigBtn"  class="btn_save" style="display: block;"  disabled="disabled">
                <input type="button" id="payAgainBtn" data-url="/ijob/api/WeixinController/payError"  class="btn_save btnsave" value="已支付，出现问题？" style="display: block;margin-top: 5px;" >
            </div>
        </div>
    </div>
</body>
<script>

    var isReady = false;
    var payType = 2; //默认余额支付
    var i = 0;
    var repayId;
    var order ;
    var hasPw = ${information.payPassword eq null ? false:true};
    var balance = ${information.money}||0;
    var status;
    if(ijob.storage.get("hasPw")){
        hasPw= true;
    }
    $(".numList li .zf_num").click(function(){
        if(i<6){
            $(".payment-title .tit").text("输入密码中...");
            $(".input_password li").eq(i).addClass("curr");
            $(".input_password li").eq(i).attr("data",$(this).text());
            i++
            if (i==6) {
                var data = "";
                $(".input_password li").each(function(){
                    data += $(this).attr("data");
                });
                $(".payment-title .tit").text("正在校验密码...");
                $.post("/ijob/api/InformationController/qz/checkPayPw",{payPassword:data},function(result){
                    if(result.code==500){
                        $(".payment-title .tit").text("密码校验失败,请重新输入");
                        $(".numList li .empty").click();
                    }else if(result.code==302){
                        alert("您还没有设置过密码，请先设置");
                        ijob.gotoPage({path:'h5/qz/mine/mySettings_changePassword1'});
                    }else{
                        $(".payment-title .tit").text("密码校验成功，生成提现申请中...");

                        $("#saveConfigBtn").btPost({payType:payType,id:order.id,fee:order.fee,order:status},function(data) {
                            if (data.code == 500) {
                                mui.alert(data.msg);
                                return;
                            }
                            repayId = data.data.prepay_id;
                            $(".payment-title .close").click();
                            callback(repayId);
                        });
                    }
                })

            };
        }
    });

    $("#switchPay").click(function(){
        payType = 1 //修改为微信支付
        $(".payment-title .close").click();
    });

    $(".numList li .del").click(function(){
        if(i>0){
            i--
            $(".input_password li").eq(i).removeClass("curr");
            $(".input_password li").eq(i).attr("data","");
        }
    });

    $(".numList li .empty").click(function(){
        $(".input_password li").removeClass("curr");
        $(".input_password li").attr("data","");
        i = 0;
    });
    if(payType==2){
        $("#saveConfigBtn").removeAttr("disabled");
    }
    $(".select_content").on("click",".row-lilst",function (e) {
        var _this = $(this);
        $(".select_content").btPost({id:'${information.id}',version:${information.version},payType:_this.data("type")},function (result) {
            payType = result.data.payType
            $("#payType").html("使用"+(payType==1?'微信':'账户余额')+"支付");
            $(".select_content .left").removeClass("active");
            _this.find(".left").addClass("active");
            $(".cancelbtn").click();
            if(payType==2){
                $("#saveConfigBtn").removeAttr("disabled");
            }else{
                if(isReady){
                    $("#saveConfigBtn").removeAttr("disabled");
                }else{
                    $("#saveConfigBtn").attr("disabled","disabled");
                }
            }
        });
    });

    //关闭浮动
    $(".payment-title .close").click(function(){
        $(".pay_password").hide();
        $(".input_password li").removeClass("curr");
        $(".input_password li").attr("data","");
        i = 0;
        slide.ableTouch();
    });



    $(document).ready(function(){
        $.getJSON("/ijob/api/WeixinController/getJSAuthSignature?url="+window.location.href,function(data){
            if(data.code==200){
                wx.config({
                    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                    appId: data.data.appId, // 必填，公众号的唯一标识
                    timestamp: data.data.timestamp, // 必填，生成签名的时间戳
                    nonceStr: data.data.noncestr, // 必填，生成签名的随机串
                    signature: data.data.signature,// 必填，签名
                    jsApiList: ["chooseWXPay"] // 必填，需要使用的JS接口列表
                });
            }else{
                mui.toast(data.msg);
            }

        });
        wx.ready(function(){
            $("#saveConfigBtn").removeAttr("disabled");
            isReady = true;

        });

        wx.error(function(res){
            mui.alert("错误信息"+JSON.stringify(res));
            window.location.reload();
        });
    });



    $("#jobtemplate").loadData(ijob.storage.get("data.order")).then(function(result){
        if(result.code==500){
            ijob.rebackpage(result.msg,-2,500);
            return;
        }

        if($(".ulBox").length>1){ //如果有多条
            $(".ulBox:last").prevAll().hide();
            $(".ulBox:last").parent().before("<a class='showhistory' style='margin-right:10px;color:#666;text-decoration: underline;display: block;text-align: right;'>历史支付记录</a>");
            $(".showhistory").on('click',function(){
                if($(".ulBox:first").css("display")=='none'){
                    $(".ulBox:last").prevAll().show();
                }else{
                    $(".ulBox:last").prevAll().hide();
                }

            });
        }

        order = result.data.list[result.data.list.length-1];
        $("#paytips").text(order.name); //修改提示
        if(balance*100<order.fee){ //如果余额小于订单支付费用，则使用微信支付
            payType = 1;
            $(".tips").text("工资卡余额不足，将使用微信支付");
        }
        $("#notice").text(order.notice);
        $("#saveConfigBtn").val((order.status==3||order.status==4)?'已支付':'确认支付');
        $("#saveConfigBtn").data("url","/ijob/api/WeixinController/payOrder");
        status = result.data.list[result.data.list.length-1].status;
        if(status!='3'){
            $("#saveConfigBtn").click(function(){
                if(payType==2){  //如果是余额支付
                    if(hasPw==false){
                        alert("您还没有设置过密码，请先设置");
                        ijob.gotoPage({path:'h5/qz/mine/mySettings_changePassword1'});
                    }else{
                        $(".price").text("￥"+order.fee/100);
                        $(".pay_password").show();
                        slide = new Slide($(".wrap"),$(".pay_password"),".pass-content");
                        slide.disTouch();
                    }
                }else{ //如果是微信支付
                    $(this).btPost({payType:payType,id:order.id,fee:order.fee,order:status},function(data) {
                        if (data.code == 500) {
                            mui.alert(data.msg);
                            return;
                        }
                        $.getJSON("/ijob/api/WeixinController/getPaySignature?prepay_id=" + data.data.prepay_id, function (data2) {
                            wx.chooseWXPay({
                                debug: false,
                                timestamp: data2.data.timeStamp, // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
                                nonceStr: data2.data.nonceStr, // 支付签名随机串，不长于 32 位
                                package: data2.data.package, // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=\*\*\*）
                                signType: data2.data.signType, // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
                                paySign: data2.data.paySign, // 支付签名
                                success: function (res) {
                                    callback(data.data.prepay_id);
                                },
                                error: function (res) {
                                    mui.alert("错误信息" + JSON.stringify(res));
                                },
                                cencel: function (res) {
                                    mui.alert('cencel pay');
                                },
                                fail: function (res) {
                                    /*mui.alert(JSON.stringify(res));*/
                                }
                            });
                        });
                    });
                }
            });
        }else{
            $(".head_title_lf").text("已支付");
            $("#saveConfigBtn").attr("disabled","disabled");
        }
        $(".btnsave").click(function() {
            var _this = $(this);
            var obj =  ijob.storage.get("data.order");
            _this.btPost(obj,function(data2){
                if(data2.code=="202"){
                    $.getJSON("/ijob/api/WeixinController/payOk?prepayID="+data2.data.prepayID,function(data1){
                        ijob.url.next.call(data1.data.id);
                    });
                }else if(data2.code=="203"){
                    ijob.url.next.call(data2.data.id);
                }else{
                    mui.alert("未找到已支付订单，请确认支付");
                }
            });
        });

    });


    function callback(prepay_id){
        /*var btn = ['已支付', '未支付'];
        mui.confirm('是否已支付订单', '提示', btn, function (e) {
            if (e.index == 0){
                mui.toast("生成业务订单中...");
                $.getJSON("/ijob/api/WeixinController/payOk?prepayID="+prepay_id,function(data1){
                    ijob.url.next.call(data1.data.id);
                });
            }else{
                ijob.reback("返回上一页");
            }
        });*/
        $.getJSON("/ijob/api/WeixinController/payOk?prepayID="+prepay_id,function(data1){
            ijob.url.next.call(data1.data.id);
        });
    }
    // 更改支付方式
    var slide = null;
    $(".editBtn").click(function () {
        $(".edit-popup-backdrop").show();
        slide = new Slide($(".wrap"),$(".edit-popup-backdrop"),".select_content");
        slide.disTouch();
    })
    // 取消更改支付方式
    $(".cancelbtn").click(function () {
        $(".edit-popup-backdrop").hide();
        slide.ableTouch();
    })

</script>
</html>
