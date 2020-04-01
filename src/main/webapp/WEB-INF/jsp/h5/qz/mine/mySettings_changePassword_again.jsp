<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>修改密码_设置新密码</title>
    <%--<jsp:include page="../base/resource.jsp"/>--%>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/mySettings_changePassword.css?version=4">
</head>
<body>
<div class="wrap">
    <form action="">
        <div class="newPas">
            <label for="">新密码</label>
            <input id="newPayPassword" type="password" placeholder="输入新密码(密码由6位数字组成)">
        </div>
        <div class="verify">
            <label for="">确认密码</label>
            <input id="againPayPassword" type="password" placeholder="请再次输入新密码">
        </div>
        <div class="btnBox">
            <div class="btn" onclick="updatePayPass();">确认修改</div>
        </div>
        <input type="hidden" id="userID" value="<shiro:principal property="id" />">
        <input type="hidden" id="version" value="<shiro:principal property="version" />">
        <input type="hidden" id="account" value="<shiro:principal property="accountNo" />">
    </form>
</div>
</body>
<script src="/ijob/lib/jquery-2.2.3.js"></script>
<script>
    function updatePayPass() {
        var reg = /\d{6}/;
        console.log();
        if (!reg.test($("#newPayPassword").val())) {
            mui.alert("新密码格式不正确！")
        } else if ($("#newPayPassword").val() != $("#againPayPassword").val()) {
            mui.alert("两次输入的新密码不一致！");
        } else {

            $.post("/ijob/api/InformationController/qz/updatePayPasswordForForget",{
                "againPayPassword":$("#againPayPassword").val(),
                "newPayPassword":$("#newPayPassword").val(),
                "userID":$("#userID").val(),
                "account":$("#account").val(),
                "id":$("#userID").val(),
                "version":$("#version").val()
            },function(data){
                if(data.code == "200"){
                    if(ijob.storage.get("rechargeJs.type")){
                        ijob.gotoPage({path:'/h5/cash'})
                    }else if(ijob.storage.get("homepageType")){
                        ijob.gotoPage({path:'/h5/zp/paysalary/salaryIndex'})
                    }else{
                        window.history.replaceState('','', "/ijob/forward?path=/h5/qz/index");
                        window.location.href = "/ijob/api/InformationController/h5/mine/mySettings";
                    }
                }else if(data.code == "501"){
                    mui.alert(data.msg);
                }else if(data.code == "500"){
                    mui.alert("服务器繁忙");
                }
            })
        }
    }

</script>
</html>