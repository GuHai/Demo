<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/29
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>设置密码</title>
    <script src="../../../ijob/lib//lib-flexible.js"></script>
    <script src="../../../ijob/lib/mui/js/mui.min.js"></script>
    <link rel="stylesheet" href="../../iconfont/iconfont.css">
    <link rel="stylesheet" href="../../../ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="../../css/base.css">
    <link rel="stylesheet" href="../../css/mine/mySettings_changePassword.css">
    <jsp:include page="../../qz/base/resource.jsp"/>
    <style>
        .newPas{
            margin-top: 0;
        }
    </style>
</head>
<body>
<div class="wrap">
    <script id="todayJob"   type="text/html"  data-url="/ijob/api/InformationController/h5/mine/getInfoPass"  >
        {{each list as information}}
        <form action="">
            <div class="newPas">
                <input type="hidden" name="id"  value="{{information.id}}"/>
                <input type="hidden" name="version"  value="{{information.version}}"/>
                <label for="">密码</label>
                <input type="password" maxlength="6" minlength="6" name="payPassword" id="payPassword" placeholder="输入新密码(密码由6位数字组成)">
            </div>
            <div class="verify">
                <label for="">确认密码</label>
                <input type="password" maxlength="6" minlength="6" name="oldPassword" id="oldPassword" placeholder="请再次输入新密码">
            </div>
            <div class="btnBox">
                <a href="javascript:void(0);">
                    <div class="btn" data-url="/ijob/api/InformationController/update" onclick="addORupdate()">保存</div>
                </a>
            </div>
        </form>
        {{/each}}
    </script>
</div>
</body>
<script>
    $("#todayJob").loadData();
    function addORupdate(){
        if($("#payPassword").val() != $("#oldPassword").val()){
            clearPass();
            mui.toast("两次密码不一致");
        }else if($("#payPassword").val().trim()==""){
            clearPass();
            mui.toast("请输入正确的密码");
        }else if($("#payPassword").val().length != 6){
            clearPass();
            mui.toast("支付密码只能为6位数");
        }else if(isNaN($("#payPassword").val())||isNaN($("#oldPassword").val())){
            clearPass();
            mui.toast("支付密码只能为纯数字");
        }else{
            $(".btn").btPost(JSON.stringify($("form").serializeObjectJson()),function(data){
                if(data.code == '200'){
                    mui.toast("设置成功");
                    ijob.storage.set("hasPw",true);
                    ijob.reback();
                }else{
                    mui.alert("数据不正确!");
                }
                clearPass();
            });
        }
    }
    function clearPass(){
        $("#payPassword").val("");
        $("#oldPassword").val("");
    }
</script>
</html>
