<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/30
  Time: 11:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>结算给自己</title>
    <jsp:include page="qz/base/resource.jsp"/>
    <jsp:include page="qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/salaryCard.css?version=5">
    <script>
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
</head>
<body style="background-color: #ffff">
<div class="wrap">
    <script id="cashTemplate" type="text/html"  data-url="/ijob/api/AccountController/getRechargeSum"  data-type="POST" >
        {{each list as user}}
            <div class="page_cash">
                <div class="per-info">
                    <div class="photo">
                        <img id="headImg" src="/ijob/upload/{{user.attachment |absolutelyPath}}"
                             onerror="this.src='{{user.weixin.headimgurl}}';this.onerror=null"/>
                    </div>
                    <div class="title">{{user.mainName}}</div>
                </div>
                <div class="input_box">
                    <p class="tit">结算金额</p>
                    <div class="input">
                        <span class="yuan">￥</span>
                        <input type="number" oninput="if(value.length>7)value=value.slice(0,7)" placeholder="请输入金额" class="money">
                    </div>
                    <p class="tips">根据国家税法规定，结算给自己需要正常缴税。每天限额1万元</p>
                </div>
                <div class="footer" id="jiesuan" style="display: none;" data-url="/ijob/api/AccountController/jieSuanMySalary">
                    <a href="javascript:void(0);" class="btns settlement">确认结算</a>
                </div>
                <div class="footer" id="zhuanzhang" style="display: none;" data-url="/ijob/api/AccountController/giveOtherMoney">
                    <a href="javascript:void(0);" class="btns settlement">确认转账</a>
                </div>
                <%--输入密码--%>
                <div class="pay_password" style="display: none;">
                    <div class="pass-content">
                        <div class="input-box">
                            <div class="payment-title">
                                <span class="tit">请输入支付密码</span>
                                <span class="iconfont icon-guanbi close"></span>
                            </div>
                            <div class="wages">
                                <div class="title passTitle">提现</div>
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
            </div>
        {{/each}}
    </script>
</div>
<%--返回首页--%>
<div id="homepage"></div>
</body>
</html>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});
    var obj = {};
    if(ijob.storage.get("rechargeJs.userID")!=null&&ijob.storage.get("rechargeJs.userID")!=''&&ijob.storage.get("rechargeJs.userID")!=undefined){
        obj.id = ijob.storage.get("rechargeJs.userID");
    }
    $("#cashTemplate").loadData({condition:obj}).then(function (result) {
        if(!result.data){
            $(".nodata").remove();
            mui.toast("正在跳转支付密码设置页面");
            window.history.replaceState('','', "/indexMain");
            ijob.gotoPage({path:'/h5/qz/mine/mySettings_changePassword_again'});
        }else{
            init(result);
        }
    });
    function init(result){
        $(".money").blur(function () {
            console.log(this.value);
            if (this.value == undefined || this.value == null || this.value==0){
                this.value = 0;
            }else{
                if(this.value.indexOf(".")!=-1){
                    var len = 2,data = this.value ;
                    data += 0.00001;
                    data  = new String(data);
                    if(data.indexOf('.')>-1){
                        data = (data+"00");
                    }else{
                        data = data+".00";
                    }
                    data = data.substring(0,(data.indexOf(".")+len+1));
                    this.value = data ;
                }
            }
        });
        var  slide = null;
        if(ijob.storage.get("rechargeJs.type")==1){
            $(".passTitle").text("转账");
            document.title = "转账";
            $(".input_box .tit").html(" <p class=\"tit\"> 转账金额</p>");
            $(".input_box .tips").hide();
            $("#zhuanzhang").show();
        }else if(ijob.storage.get("rechargeJs.type")==2){
            $(".passTitle").text("结算给自己");
            document.title = "结算给自己";
            $("#jiesuan").show();
            $(".input_box .tit").html(" <p class=\"tit\"> 结算金额</p>");
        }

        $(".settlement").click(function () {
            if(ijob.storage.get("rechargeJs.type")==2){
                if($(".money").val() == '' || $(".money").val() == undefined || $(".money").val() == null){
                    mui.alert("请输入金额");
                }else if($(".money").val()<=0){
                    mui.alert("金额必须大于0元")
                }else if($(".money").val() > 10000){
                    mui.alert("每日限额10000元人民币");
                }else if((parseFloat($(".money").val())+parseFloat(result.data.list[0].mySettle)) > 10000){
                    mui.alert("你今日剩余结算给自己的金额为"+(10000-result.data.list[0].mySettle) +"元");
                }else if($(".money").val() > result.data.list[0].money){
                    mui.alert("支付金额大于你拥有的充值金额");
                }else {
                    $(".pay_password").show();
                    slide = new Slide($(".wrap"),$(".pay_password"),".pass-content");
                }
            }else if(ijob.storage.get("rechargeJs.type")==1){
                if($(".money").val() == '' || $(".money").val() == undefined || $(".money").val() == null){
                    mui.alert("请输入金额");
                }else if($(".money").val()<=0){
                    mui.alert("金额必须大于0元")
                }else if($(".money").val() > result.data.list[0].money){
                    mui.alert("支付金额大于你拥有的充值金额");
                }else {
                    $(".pay_password").show();
                    slide = new Slide($(".wrap"),$(".pay_password"),".pass-content");
                }
            }
        })
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
                            $(".payment-title .tit").text("密码校验成功，"+document.title+"中...");
                            $(".payment-title .close").click();
                            if(ijob.storage.get("rechargeJs.type")==1){
                                $("#zhuanzhang").btPost({
                                    price:$(".money").val(),
                                    userID:ijob.storage.get("rechargeJs.userID")
                                },function(data){
                                    if(data.success){
                                        ijob.gotoPage({path:'/h5/rechargeSalary?data.money='+$(".money").val()});
                                    }else{
                                        mui.toast(data.msg);
                                    }
                                });
                            }else if(ijob.storage.get("rechargeJs.type")==2){
                                $("#jiesuan").btPost({price:$(".money").val()},function(data){
                                    if(data.success){
                                        ijob.gotoPage({path:'/h5/rechargeSalary?data.money='+$(".money").val()});
                                    }else{
                                        mui.toast(data.msg);
                                    }
                                });
                            }
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
    }
</script>