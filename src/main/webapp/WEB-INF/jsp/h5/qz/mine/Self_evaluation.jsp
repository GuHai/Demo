<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>自我评价</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <style>
        .textareaBox > textarea {
            border: none;
            font-size: 15px;
            border-radius: inherit;
            padding: 5px 17px;
        }

        ::placeholder {
            font-size: 15px;
            font-weight: normal;
            font-stretch: normal;
            letter-spacing: 0px;
            color: #999999;
        }

        .textareaBox > p {
            text-align: right;
            font-size: 15px;
            padding-right: 17px;
            letter-spacing: 0px;
            color: #999999;
        }

        .btn {
            width: 91%;
            height: 40px;
            margin: 10px auto;
            background-color: #108ee9;
            border-radius: 20px;
            font-size: 15px;
            font-weight: normal;
            font-stretch: normal;
            line-height: 40px;
            text-align: center;
            letter-spacing: 0px;
            color: #ffffff;
        }
    </style>
</head>
<body>
<div class="wrap">
    <form name="form" action="" method="post" id="input_example">
        <input type="hidden" id="id" name="id" value="">
        <input type="hidden" id="version" name="version" value="">
        <div class="textareaBox">
            <textarea id="evaluation" name="evaluation" cols="30" rows="10"
                      placeholder="请输入自我评价"></textarea>
            <p id="result">0/200</p>
        </div>
        <div class="btn" data-url="/ijob/api/ResumeController/update">
            保存
        </div>
    </form>
</div>
<div id="queryEvaluation" data-type="GET" data-url="/ijob/api/ResumeController/get/"></div>
</body>
</html>
<script>
    $(function () {
        //初始化
        $("#queryEvaluation").data("url",$("#queryEvaluation").data("url")+ijob.storage.get("resume.id"));
        $("#queryEvaluation").btPost(null, function (data) {
            $("#id").val(data.data.id);
            $("#version").val(data.data.version);
            $("#evaluation").val(data.data.evaluation);
        });
        $('#result').text($("#evaluation").val().length + '/200');
    });
    $(document).on("input propertychange", '#evaluation', function () {
        var len = $("#evaluation").val().length;
        $('#result').text(len + '/200');
        if (len > 200) {
            $(".btn").css({"background-color": "#999"});
        } else {
            $(".btn").css({"background-color": ""});
        }
    });

    $(".btn").click(function () {
        var _this = $(this);
        if ($("#evaluation").val().length <= 200) {
            //不是由新增简历进入的
            _this.btPost(JSON.stringify($("#input_example").serializeObjectJson()), function (data) {
                history.go(-1);
            });
        } else {
            mui.toast("内容过多！");
        }
    });
</script>