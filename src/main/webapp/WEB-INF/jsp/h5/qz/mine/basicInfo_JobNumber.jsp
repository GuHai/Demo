<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>修改工作号</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/basicInfo_JobNumber.css">
    <style>
        #save{
            float: right;
            width: 2.400rem;
            height: 0.933rem;
            padding: 0;
            text-align: center;
            background-color: #108ee9;
            border-radius: 5px;
            border: solid 1px #108ee9;
            font-size: 0.400rem;
            font-weight: normal;
            font-stretch: normal;
            line-height: 0.933rem;
            letter-spacing: 0px;
            color: #ffffff;
        }
    </style>
</head>
<body>
<div class="wrap">
    <form id="form" action="/ijob/api/InformationController/h5/mine/updateInfo" method="post">
        <div class="inputBox">
            <input type="hidden" value="${sessionScope.Information.version}" name="version">
            <input type="hidden" value="${sessionScope.Information.id}" name="id">

            <input type="text" name="workNumber" id="workNumber" value="${sessionScope.Information.workNumber}" placeholder="请输入工作号">
        </div>
        <p class="info">工作号一旦提交就不能再次修改，请谨慎操作。</p>
        <div class="btnBox">
            <input id="save" style="float: right;margin-right: 5%" type="button" value="保存" onclick="onSubmit();">
        </div>
    </form>
    <input type="hidden" value="${sessionScope.Information.workNumber }" id="Verification">
</div>
</body>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>

        function onSubmit(){
            if($("#workNumber").val().length > 15){
                mui.alert("工作号长度不能超过十五个汉字")
            }else if($("#Verification").val() != null&&$("#Verification").val() != ""){
                mui.alert("不可进行二次修改",function (){
                    window.location.href = "/ijob/api/InformationController/h5/mine/basicInfo";
                });
            }else if ($("#workNumber").val()==null||$("#workNumber").val().trim(" ")==""||$("#workNumber").val()==undefined){
                mui.alert("请填写工作号")
            }else{
                $("form").submit();
            }

        }
</script>
</html>