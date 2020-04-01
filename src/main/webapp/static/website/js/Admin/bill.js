/****************************** 会员中心 **************************/
$(function () {
    /*确认支付*/
    var times = 0;
    $(".paybtns").click(function () {
        $("#paymsg").text("");
        var k = 0;
        if ($("#sxfbtn").prop("checked")) {
            k = 0.006;
        }
        var scanSettle  = {id:ijob.storage.get("scanSettle.id"),scanSettleMemberList:[]};
        var msg = "";
        $(".Check:checked").each(function(i,item){
            var salary = $(this).closest(".trbox").find(".price");
            var obj = {
                id:salary.data("id"),
                version:salary.data("version"),
                salary:Math.ceil(100*salary.data("salary"))/100+Math.ceil(100*salary.data("salary")*k)/100||0,
                sxf:(Math.ceil(100*salary.data("salary")*k)/100)||0
            };
            if(obj.salary<0.01){
                msg+="最小支付金额为0.01元";
                return false;
            }else{
                scanSettle.scanSettleMemberList.push(obj);
            }

        });
        if(msg==""&&scanSettle.scanSettleMemberList.length==0){
            msg += "请至少选择一项";
        }
        if(!msg){
            $(".dialog-mask").show();
            $("#codemsg").text(600);
            $(".paybtns").btPost(scanSettle,function(result1){
                if(result1.success){
                    $("#qrcodeimg").empty();
                    var pw =  $(".login-wrap").height();
                    var width = pw;
                    var height = width;
                    var code = result1.data.code;
                    var urlQrcode = "http://"+site+"/share/pay/"+code;
                    var qrcode = new QRCode(document.getElementById("qrcodeimg"), {
                        text:  urlQrcode,
                        width: width, //生成的二维码的宽度
                        height: height, //生成的二维码的高度
                        colorDark : "#000000", // 生成的二维码的深色部分
                        colorLight : "#ffffff", //生成二维码的浅色部分
                        correctLevel : QRCode.CorrectLevel.H
                    });
                    var count =0;
                    times = setInterval(function(){
                        if(++count>=600){
                            $("#codemsg").text(dict.SalaryExcel.Expire);
                            $("#qrcodeimg").html("<img src=\"/static/images/loading.gif\" style=\"width: auto;height: auto;position: absolute;top: 40%;left: 44%;\">");
                            clearInterval(times);
                        }
                        $("#codemsg").text(600-count);
                        $.getJSON("/api/ApplySettlementController/getPayResult/"+code,function(result){
                            if(result.code==200&&result.data=="success"){
                                $("#loginstatus").text(dict.SalaryExcel.OK);
                                setTimeout(function(){
                                    $(".dialog-close").click();
                                    loadPageByUrl('guanwang/salary?data.againID=all');
                                },1000);
                            }
                        });
                    },1000);
                }
            });
        }else{
            $("#paymsg").text(msg);
        }


    })
    $(".dialog-close").click(function () {
        $(".dialog-mask").hide();
        clearInterval( times);
    })

})

/*判断手机号码*/
function validatemobile(){
    if($('.phone').val()  == ''){
        $("#paymsg").text('请输入手机号码！');
        $('.phone').focus();
        return false;
    }
    if($('.phone').val().length!=11){
        $("#paymsg").text('手机号码不能大于11位数！');
        $('.phone').focus();
        return false;
    }

    var myreg = /(^1[3|4|5|7|8]\d{9}$)|(^09\d{8}$)/;
    if(!myreg.test($('.phone').val())){
        $("#paymsg").text('手机号码格式错误！');
        $('.phone').focus();
        return false;
    }
}

var count = 60; //间隔函数，1秒执行
var InterValObj1; //timer变量，控制时间
var curCount1;//当前剩余秒数

function sendMessage() {
    curCount1 = count;
    //设置button效果，开始计时
    $(".verifyCodeSend").attr("disabled", "true");
    $(".verifyCodeSend").val( + curCount1 + "秒再获取");
    InterValObj1 = window.setInterval(SetRemainTime, 1000); //启动计时器，1秒执行一次
}
function SetRemainTime() {
    if (curCount1 == 0) {
        window.clearInterval(InterValObj1);//停止计时器
        $(".verifyCodeSend").removeAttr("disabled");//启用按钮
        $(".verifyCodeSend").val("重新发送");
    }
    else {
        curCount1--;
        $(".verifyCodeSend").val( + curCount1 + "秒再获取");
    }
}