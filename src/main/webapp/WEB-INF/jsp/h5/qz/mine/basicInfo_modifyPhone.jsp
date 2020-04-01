<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>修改手机号码</title>
    <link rel="stylesheet" href="/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/css/base.css">
    <link rel="stylesheet" href="/ijob/static/css/mine/basicInfo_modifyPhone.css">
    <script src="/ijob/lib/jquery-2.2.3.js"></script>
    <script src="/ijob/lib/mui/js/mui.min.js"></script>
    <script src="/ijob/lib//lib-flexible.js"></script>
</head>
<body>
    <div class="wrap">
        <form method="post" name="form" id="form">
            <div class="oldPhone"><shiro:principal property="phoneNumber" /></div>
            <div class="newPhone">
                <input type="hidden" id="id" value="<shiro:principal property="id" />" name="id">
                <input type="hidden" id="version" value="<shiro:principal property="version" />" name="version">
                <input type="text" name="phoneNumber" id="phoneNumber" placeholder="请输入新的手机号码">
            </div>
            <div class="verification">
                <input type="text" id="code" placeholder="请输入验证码">
                <input type="button" id="codeBtn" onclick="getCodeBtn()" value="获取验证码">
            </div>
            <div class="btn" onclick="submitForm()">修改手机</div>
        </form>
    </div>
</body>
<script>
    var code = null;
    var isClick = true;
    var myTime = 60;
    var intervalID = 0;
    var myreg=/^[1][3,4,5,7,8,9][0-9]{9}$/;

    /**
     * 提交表单方法
     */
    function submitForm() {
        if($("#phoneNumber").val() == null || $("#phoneNumber").val() == "" ){
          mui.alert("请输入手机号码!");
        }else if(!verifi()){
          mui.alert("请输入正确的手机号码！");
        }else{
            if(code == null){
              mui.alert("请获取验证码");
            }else if (code != $("#code").val()){
                mui.alert("验证码填写错误");
            }else{
                form.action="/ijob/api/InformationController/h5/mine/updatePhoneNumber";
                form.submit();
            }
        }
    }

    /**
     * 验证手机号码是否正确
     * @returns {boolean}
     */
    function verifi(){
        if (!myreg.test($("#phoneNumber").val())) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * 获得验证码方法
     */
    function getCodeBtn() {
        if($("#phoneNumber").val() == null || $("#phoneNumber").val() == "" ){
          mui.alert("请输入手机号码!");
        }else if(!isClick){
          mui.alert("请等下再获取！！");
        }else if(!verifi()){
          mui.alert("手机号码不正确哦！");
        }else{
            intervalID = setInterval("setValueOfCodeBtn()",1000);
            $.post("/ijob/api/ContentsendrecordController/sendSMSCode",{"phoneNumber" : $("#phoneNumber").val(),"businessType":1 },function(data){
                if(data.code == "200" ){
                    console.log(data.data.msgContent);
                    code = data.data.msgContent;
                }else if(data.code == "500"){
                  mui.alert("参数异常！");
                }else if(data.code == "510"){
                  mui.alert("对不起，你的可接收短信已到达上限，请明天再来。");
                }else if(data.code == "511"){
                    mui.alert(data.msg);
                }
            });
        }
    }

    /**
     * 设置验证码按钮状态
     */
    function setValueOfCodeBtn(){
        if (myTime > 0){
            $("#codeBtn").val("重新获取(" + myTime + "S)");
            myTime--;
            isClick = false;
        }else{
            $("#codeBtn").val("获取验证码");
            myTime = 60;
            clearInterval(intervalID);
            isClick = true;
        }
    }
</script>
</html>