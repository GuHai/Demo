<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>获取验证码</title>
    <jsp:include page="../base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/static/css/base.css">
    <link rel="stylesheet" href="/ijob/static/css/mine/mySettings_changePassword_verification.css">
</head>
<body>
<div class="wrap">
    <div class="head_msg">
        <p class="msg_info">我们正在发送<span>验证码</span>到您的手机</p>
        <p class="msg_phone"><shiro:principal property="phoneNumber" /></p>
    </div>
    <div class="verificationCode">
        <label for="" id="pw">
            <input type="number" maxlength="1">
            <input type="number" maxlength="1">
            <input type="number" maxlength="1">
            <input type="number" maxlength="1">
            <input type="number" maxlength="1">
            <input type="number" maxlength="1">
        </label>
        <p class="error">收不到验证码？<span id="time"></span></p>
    </div>
    <div class="btnBox">
        <a href="javascript:void(0)"><input type="button" class="btn_out" value="完成"></a>
    </div>
    <a data-url="/ijob/api/ContentsendrecordController/checkSMSCode/" id="verification"></a>
</div>
</body>
</html>
<script src="/ijob/lib/jquery-2.2.3.js"></script>
<script>

    var time = 60;
    var timeTemp = null;
    var phone = "<shiro:principal property="phoneNumber" />";
    function sendMessage(){
        if($(".msg_phone").text() == "" || $(".msg_phone").text() == "null" || $(".msg_phone").text() == null){
            mui.alert("请进行实名认证之后再来修改提现密码。",function(){
                window.history.go(-1);
            });
        }else{
            $.post(
                "/ijob/api/ContentsendrecordController/sendSMSCodeByPayPass",
                {"phoneNumber":phone, "businessType": 1},
                function (data) {
                    if (data.code == "200") {
                        $(".msg_info").html("我们已发送<span>验证码</span>到您的手机");
                        timeTemp = setInterval(flushTime,1000);
                    } else if (data.code == "500") {
                        mui.toast("参数异常！");
                    } else if (data.code == "510") {
                        mui.toast("对不起，你的可接收短信已到达上限，请明天再来。");
                    }else if (data.code == "512") {
                        mui.toast(data.msg);
                    }
                }
            );
        }
    }
    sendMessage();
    $("#pw").on('input','input',function(event){
        var text = $(this).val();
        if(/\d/.test(text)){
            $(this).next().focus();
        }else{
            $(this).val("");
        }
    });

    $(".btn_out").click(function(){
        var ps = "";
        $("#pw input").each(function(i,item){
            ps += $(item).val();
        });
        if(ps.length==6){
            $("#verification").data("url",$("#verification").data("url")+ps);
            $.ajax({
                url: $("#verification").data("url"),
                contentType: 'application/json',
                type: 'POST',
                data: null,
                dataType: 'json',
                success: function (data) {
                    ps=null;
                    if(data.code == 200){
                        ijob.gotoPage({path:'/h5/qz/mine/mySettings_changePassword_again'})
                    }else {
                        mui.toast(data.msg);
                    }
                }
            })
        }else{
            mui.toast("请输入6位数完整验证码");
        }
    });

    $("#pw").on('keydown','input',function(event){
        if(8==event.keyCode){
            $(this).val("");
            $(this).prev().focus();
            // event.preventDefault();
        }
    });

    function flushTime() {
        $("#time").unbind("click",sendMessage);
        if (time<1){
            $("#time").text("重新发送");
            window.clearInterval(timeTemp);
            $("#time").bind("click",sendMessage);
            time = 60 ;
        }else{
            $("#time").text(time+"S 后重新发送");
            time--;
        }
    }

</script>
