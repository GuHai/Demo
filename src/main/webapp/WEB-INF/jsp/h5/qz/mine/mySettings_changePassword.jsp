<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>修改密码</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/mySettings_changePassword.css?version=4">
</head>
<body>
<div class="wrap">
    <form action="">
        <div class="oldPas">
            <label for="">原始密码</label>
            <input type="hidden" id="userID" value="<shiro:principal property="id" />">
            <input type="hidden" id="account" value="<shiro:principal property="accountNo" />">
            <input type="hidden" id="id" value="${sessionScope.Information.id}">
            <input type="hidden" id="version" value="${sessionScope.Information.version}">
            <input type="password" id="oldPayPassword" maxlength="6" placeholder="请输入原始密码">
        </div>
        <div class="newPas">
            <label for="">新密码</label>
            <input type="password" id="newPayPassword" maxlength="6" placeholder="输入新密码(密码由6位数字组成)">
        </div>
        <div class="verify">
            <label for="">确认密码</label>
            <input type="password" id="againNewPayPassword" maxlength="6" placeholder="请再次输入新密码">
        </div>
        <p class="msg"><a href="/ijob/api/InformationController/h5/mine/mySettings_changePassword_again">忘记原始密码？</a></p>
        <div class="btnBox">
            <div class="btn" onclick="updatePayPass()">确认修改</div>
        </div>
    </form>
    <script src="/ijob/lib/jquery-2.2.3.js"></script>
    <script>

        function updatePayPass(){
            var reg =/\d{6}/;
            if($("#oldPayPassword").val() == null || $("#oldPayPassword").val() == "" ){
               mui.alert("请输入原始密码！");
            }else if (!reg.test($("#oldPayPassword").val())){
               mui.alert("原始密码格式不正确！")
            }else if (!reg.test($("#newPayPassword").val())){
               mui.alert("新密码格式不正确！")
            }else if($("#newPayPassword").val() == null || $("#newPayPassword").val() == "" ){
               mui.alert("请输入新密码！");
            }else if($("#newPayPassword").val() != $("#againNewPayPassword").val() ){
               mui.alert("两次输入的新密码不一致！");
            }else if($("#newPayPassword").val() == $("#oldPayPassword").val() ){
               mui.alert("新密码不能和原始密码一样！");
            }else{
                $.post("/ijob/api/InformationController/updatePayPassword",{
                    "oldPayPassword":$("#oldPayPassword").val(),
                    "newPayPassword":$("#newPayPassword").val(),
                    "userID":$("#userID").val(),
                    "account":$("#account").val(),
                    "id":$("#id").val(),
                    "version":$("#version").val()
                },function(data){
                    if(data.code == "200"){
                        mui.toast("修改成功！");
                        if(ijob.storage.get("homepageType")){
                            ijob.gotoPage({path:'/h5/zp/paysalary/salaryIndex'})
                        }else{
                            window.location.href = "/ijob/api/InformationController/h5/mine/mySettings";
                        }
                    }else if(data.code == "500"){
                       mui.alert(data.msg);
                    }else if (data.code == "501"){
                        mui.alert(data.msg);
                    }
                })
            }
        }
    </script>
</div>
</body>
</html>