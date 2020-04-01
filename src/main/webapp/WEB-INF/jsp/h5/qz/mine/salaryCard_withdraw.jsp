<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>提现</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/salaryCard_withdraw.css?version=4">
    <jsp:include page="../base/resource.jsp"/>
</head>
<body>
<script>
    (function ($) {
        window.addEventListener('pageshow', function (e) {
            // 通过persisted属性判断是否存在 BF Cache
            if (e.persisted) {
                location.reload();
            }
        });
    })(mui);
</script>

<div class=wrap>
    <!--浮动层-->
    <div class="pay_password" style="display: none;">
        <div class="pass-content">
            <div class="input-box">
                <div class="payment-title">
                    <span class="tit">请输入支付密码</span>
                    <span class="iconfont icon-guanbi close"></span>
                </div>
                <div class="wages">
                    <div class="title">提现</div>
                    <div class="price"></div>
                </div>
                <ul class="input_password">
                    <li></li><li></li><li></li><li></li><li></li><li></li>
                </ul>
                <div class="forgot_password">
                    <a href="/ijob/api/InformationController/h5/mine/mySettings_changePassword_again">忘记密码？</a>
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



    <header class="head">
        暂时只支持提现到微信，每日限额5000元！
    </header>
    <div class="selectCard">
        <i class="iconfont icon-weixin font" style="color: #00b60d"></i>
        <span class="left">微信 <span>零钱</span></span>
    </div>
    <div class="amount">
        <p class="sxf"><em id="sxftips">额外扣除0.6%的手续费</em><em id="sxf"></em></p>
        <p class="all_amount border">
            <span><label>￥</label> <input  onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"  id="amount" type="number" placeholder="50元-1000元" maxlength="20"></span>
            <span class="zhch" onclick="zhch()">全部转出</span>
        </p>
    </div>
    <div class="reason" id="rechargep" style="display: none">
        <span class="yg t_yg">有<em  id="recharge"></em>元不可提现</span>
        <span class="zhch rechargemsg" id="rechargemsg" >查看原因</span>
    </div>
    <div class="prompt prompt_tips" style="text-align: left;line-height: 0.427rem;padding-top: 4px;">
        <span>尊敬的用户，为积极响应国家监管政策及微信要求，平台提现存在一定手续费，敬请谅解。</span>
        <span>提现即代表同意《<a id="showMask" href="javascript:void(0);">提现支付手续</a>》</span>
    </div>
    <div class="btnBox">
        <a  data-url="/ijob/api/AccountController/applyWithdraw"  id="cash" class="btn">立即提现</a>
    </div>
</div>
<div class="mask">
    <div class="MSG">
        <div class="close m_close">
            <h1>I Job兼职平台提现服务协议</h1>
            <span class="iconfont icon-guanbi"></span>
        </div>
        <div class="desc-content">
            <%--<h1>I Job兼职平台提现服务协议</h1>--%>
            <h2>一、提现规则</h2>
            <h3>微信提现：</h3>
            <h4>1.为确保资金安全，于本平台提现必须经过实名认证，才给予提现服务。</h4>
            <h4>2.微信账户名错误、微信未激活、微信未经实名制认证，我们不进行检测，将严格按照用户资料进行支付，一旦支付后造成的金额被退回、冻结、消失概与本平台无关；</h4>
            <h4>3.对于无法支付的提现申请，我们将进行退回处理；</h4>
            <h4>4.如果提现失败，需要联系客服人员核对相关信息后申请；在此笔未支付成功的情况下，后续仍可提现。</h4>
            <h2>二、用户申明</h2>
            <h4>1.用户申明在I Job兼职平台所填写的资料真实有效，如因误填造成的一切损失由用户本人承担，与本平台无关。</h4>
            <h4>2.所有用户只得操作自己的账号，如果非法盗取他人账号，I Job兼职平台有权追究其责任并移动公安机关处理。</h4>
            <h2>三、免责条款</h2>
            <h4>因用户保管不善造成账户被他人盗取造成的损失本平台不承担任何程度的责任。</h4>
            <h3>提现说明：</h3>
            <h4>1.微信提现：最低提现金额为50元人民币，每次扣除0.6%手续费，不足0.01元按0.01元算。当日累计提现金额不得超过1000元人民币，申请提现后1-2个工作日内到账。</h4>
            <h4>2.绑定微信或银行卡后将不能解除绑定，请使用自己的账号，不要借用他人账号来绑定。</h4>
        </div>
        <div class="comfirmbtns">
            <input type="button" value="确认" class="btn" >
        </div>
</div>
</div>
<div id="homepage"></div>
</body>
</html>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>
    var surplus = Math.ceil(5000);
    $("#homepage").freshPage({path:"/h5/homepage"});
    $("#amount").attr("placeholder","可提现"+ijob.storage.get("account.money")+"元");
    if(ijob.storage.get("account.recharge")){
        $("#rechargep").show();
        $("#recharge").html(ijob.storage.get("account.recharge"));
        $("#rechargemsg").click(function(){mui.alert("根据相关部门规定，充值的金额只能用于给求职者结算工资，不能用于提现!");});
    }
    $.ajax({
        type: "post",
        url: "/ijob/api/WithdrawalsController/getSurplusMoney",
        cache:false,
        async:false,
        contentType: 'application/json',
        dataType: 'json',
        success: function(data){
            surplus = data.data;
        }
    });

    $('#amount').bind('input propertychange', function() {
        $('#sxf').html(Math.ceil($("#amount").val()*0.6)/100+"元");
        $("#sxftips").text("手续费");
    });
    function zhch(){
        var sxf = getMaxSxf();
        $('#sxf').text(sxf+"元");
        $("#sxftips").text("手续费");
        $("#amount").val(Math.floor(100*(ijob.storage.get("account.money")-sxf))/100);

       // $("#amount").val(ijob.storage.get("account.money")-Math.round($("#amount").val()*1.5)/100);
    }

    function getMaxSxf(){
        var keyong = ijob.storage.get("account.money")/1.006;
        var sxf = 0;
        if(keyong>0){
            var sxf = 0.01;
            if(keyong*0.6/100>0.01){
                var sxf = Math.ceil(keyong*0.6)/100;
            }
        }
        return sxf;
    }

    function getMaxMoney(){

        var keti = Math.floor(100*(ijob.storage.get("account.money")-getMaxSxf()))/100;
        $("#keyong").text( keti);
        return keti ;
    }
    getMaxMoney();

    $(function () {
        var slide = null;
        $("#amount").blur(function () {
            if (this.value==null||this.value==""||this.value==undefined){
                this.value="";
            }
            if($(this).val()<0){
                this.value = 0-$(this).val();
            }
        });
        $("#cash").click(function(){
            var _this = $(this);
            if($("#amount").val()==0){
                mui.alert("提现金额不能为0");
            }else if(parseFloat($("#amount").val())>5000){
                mui.alert("当日提现金额不能超过5000");
            }else if(parseFloat($("#amount").val()) > surplus&&surplus==5000){
                mui.alert("当日最多可提现5000元");
            }else if(parseFloat($("#amount").val()) > surplus&&surplus<5000){
                mui.alert("你当日剩余可提现额度为"+surplus + "元");
            }else if($("#amount").val()>getMaxMoney()){

                var btnArray = ['取消', '全部提现'];
                mui.confirm('扣除手续费部分后，当前最大可提现金额为'+getMaxMoney()+'元', '是否全部提现', btnArray, function(e) {
                    if (e.index == 1) {//点击是
                        zhch();
                        $("#cash").click();
                    }
                });

                // mui.alert("提现金额不能大于可提现余额");
            }
            else if($("#amount").val()<50 || $("#amount").val() > 5000){
                mui.alert("提现金额不能超过5000元人民币，或者少于50元人民币");
            }
            else{
                $.getJSON("/ijob/api/PersonalauthenController/qz/checkFinalVerification",function(result){
                    if(result.code==200){
                        $(".price").text("￥"+$("#amount").val());
                        $(".pay_password").show();
                        slide = new Slide($(".wrap"),$(".pay_password"),".pass-content");
                        slide.disTouch();
                    }else{
                        var btnArray = ['去认证'];
                        mui.confirm('根据相关部门规定，必须实名认证，才能进行下一步操作。', '', btnArray, function(e) {
                            if (e.index == 0) {
                                ijob.storage.set("personal.needCardID",true);
                                ijob.gotoPage({path:"/h5/qz/index/personalInform"});
                            }
                        });
                    }
                });
            }
        });

        //关闭浮动
        $(".payment-title .close").click(function(){
            $(".pay_password").hide();
            $(".input_password li").removeClass("curr");
            $(".input_password li").attr("data","");
            i = 0;
            slide.ableTouch();
        });

        var i = 0;
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
                           }else{
                               $(".payment-title .tit").text("密码校验成功，生成提现申请中...");
                               $(".payment-title .close").click();
                               $("#cash").btPost({price:$("#amount").val()},function(data){
                                  if(data.success){
                                      ijob.gotoPage({path:'/h5/qz/mine/withdraw_result?data.money='+$("#amount").val()});
                                  }else{
                                      mui.toast(data.msg);
                                  }
                              });
                           }
                       })

                };
            }
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

        //打开与关闭遮罩层
        $("#showMask").on("click",function(){
            $(".mask").show();
            slide = new Slide($(".mask"),$(".MSG"),".desc-content");
            slide.disTouch();
        })

        $(".comfirmbtns .btn,.mask .MSG .m_close span").on("click",function(){
            $(".mask").hide();
            slide.ableTouch();

        });
        // 点击空白处隐藏选项
        $("body>*").on('click', function (e) {
            if ($(e.target).hasClass('mask')) {
                $(".mask").hide();
                slide.ableTouch();
            }
        });
    });
</script>