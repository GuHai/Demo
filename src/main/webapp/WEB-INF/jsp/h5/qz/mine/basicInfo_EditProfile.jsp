<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>修改简介</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/basicInfo_EditProfile.css">
</head>
<body>
<div class="wrap">
    <script type="text/html" id="getInformation" data-url="/ijob/api/InformationController/qz/getInformation"
            data-type="GET">
        <form action="/ijob/api/InformationController/h5/mine/updateInfo" method="POST">
            <input type="hidden" value="{{version}}" name="version">
            <input type="hidden" value="{{id}}" name="id">
            <textarea class="textarea" name="brief" id="brief" cols="30" rows="10" placeholder="请输入简介"
            >{{brief}}</textarea>
            <p class="note clearfix" id="result">0/200</p>
            <div class="submit" id="submit1">
                保存
            </div>
        </form>
    </script>
</div>
</body>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>
    $("#getInformation").loadData().then(function () {
        $('#result').text($("#brief").val().length + '/200');

        $(document).on("input propertychange", '#brief', function () {
            var len = $("#brief").val().length;
            $('#result').text(len + '/200');
            $("#submit1").css({"background-color":""});
            if (len > 200) {
                $("#submit1").css({"background-color":"#999"});
            }
        });

        $("#submit1").click(function(){
            if ($("#brief").val().length <= 200) {
                $("form").submit();
            }else{
                mui.toast("内容过多！");
            }
        });
    });


</script>
</html>
