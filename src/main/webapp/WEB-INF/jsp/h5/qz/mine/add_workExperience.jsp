<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>工作经历</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/add_workExperience.css">
</head>
<body>
<div class="wrap">
    <ul class="list">
        <input type="hidden" id="resumeID" value="">
        <input type="hidden" id="id" value="">
        <input type="hidden" id="version" value="">
        <li>
            <span>公司名称</span>
            <label for="">
                <input style="text-align: right" type="text" id="companyName" value=""
                       name="companyName" placeholder="请输入公司名称" maxlength="13">
            </label>
        </li>
        <li>
            <span>职位名称</span>
            <label for="">
                <input style="text-align: right" type="text" id="jobName" value="" name="jobName"
                       placeholder="请输入职位名称" maxlength="13">
            </label>
        </li>
       <%-- <li id="workDtpicker">
            <span>时间段</span>
            <span>
                <input type="hidden" id="start" value="">
                    <input type="hidden" id="end" value="">
                <span id="month_begin"></span> 至 <span id="month_end"></span>
                <i class="iconfont icon-arrow-right"></i>
            </span>
        </li>--%>
    </ul>
    <div class="workText">工作内容</div>
    <div class="textareaBox">
                <textarea id="jobContent" name="jobContent" wrap="physical" cols="30" rows="5"
                          placeholder="请输入工作内容"></textarea>
        <p id="result">0/200</p>
    </div>
    <div class="btn_fixed">
        <div id="save" class="btn" style="border-radius :20px;" onclick="submitWorkExper()">
            保存
        </div>
    </div>
</div>
</body>
</html>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>

    $(function () {
        $('#resumeID').val(ijob.storage.get('Resume.id'));
        var id = ijob.storage.get("data.workId");
        var tempWorkexperience;
        //初始化
        $.ajax({    //使用jquery下面的ajax开启网络请求
            type: "POST",   //http请求方式为POST
            url: '/ijob/api/WorkexperienceController/get/' + id,  //请求接口的地址
            dataType: 'json',   //当这里指定为jsfromon的时候，获取到了数据后会自动解析的，只需要 返回值.字段名称 就能使用了
            success: function (result) {  //请求成功，http状态码为200。返回的数据已经打包在data中了。
                if (result.code == '200') {
                    //渲染
                    tempWorkexperience = result.data.list[0];
                    $("#id").val(tempWorkexperience.id);
                    $("#version").val(tempWorkexperience.version);
                    $("#companyName").val(tempWorkexperience.companyName);
                    $("#jobName").val(tempWorkexperience.jobName);
                    $("#jobContent").val(tempWorkexperience.jobContent);
                    /*var month_begin = tempWorkexperience.startTime == null ? '' : ijob.dateFormat(tempWorkexperience.startTime - 0, "yyyy-MM");
                    var month_end = tempWorkexperience.endTime == null ? '' : ijob.dateFormat(tempWorkexperience.endTime - 0, "yyyy-MM");
                    $("#start").val(month_begin);
                    $("#end").val(month_end);
                    $("#month_begin").text(month_begin);
                    $("#month_end").text(month_end);*/
                    //拿到结果再运行代码，不然会报错
                    // commonality();
                } else {    //请求失败
                    mui.toast("获取数据失败!");
                }
            }
        });

        function commonality() {
            function timestampToTime(timestamp) {
                var now = new Date(timestamp);
                var year = now.getFullYear();
                var month = now.getMonth() + 1 + "";
                var date = now.getDate() + "";
                if (month.length == 1) {
                    month = "0" + month;
                }
                if (date.length == 1) {
                    date = "0" + date;
                }
                return year + "-" + month + "-" + date;
            }

            var begin = timestampToTime(tempWorkexperience.startTime);
            var end = timestampToTime(tempWorkexperience.endTime);
            var dtpicker1 = new mui.DtPicker({
                "type": "month",
                "value": begin,
                beginDate: new Date(2000, 00),//设置开始日期
                endDate: new Date(2018, 12),//设置结束日期
            });
            var dtpicker2 = new mui.DtPicker({
                "type": "month",
                "value": end,
                beginDate: new Date(2000, 00),//设置开始日期
                endDate: new Date(2018, 12),//设置结束日期
            });

            $("#month_begin").on("tap", function () {
                document.getElementById("companyName").blur();
                document.getElementById("jobName").blur();
                dtpicker1.show(function (e) {
                    $("#month_begin").html(e.text);
                    $("#start").val(e.text);
                })
            });
            $("#month_end").on("tap", function () {
                document.getElementById("companyName").blur();
                document.getElementById("jobName").blur();
                dtpicker2.show(function (e) {
                    $("#month_end").html(e.text);
                    $("#end").val(e.text);
                })
            });

            if (id == 0) {
                //新添加，不用管是存 session 还是数据库
                $("#month_begin").text("请选择");
                $("#month_end").text("请选择");
            } else {
                //不是新的添加,就增加删除按钮
                $('#result').text($("#jobContent").val().length + '/200');
                $("#save").after('<div id="delete" class="btn" onclick="deleteWorkExperience()" style="background-color: #ff3b30;">删除</div>');
            }
        }
    });

    function deleteWorkExperience() {
        $.post(
            "/ijob/api/WorkexperienceController/delete",
            {
                "id": $("#id").val(),
                "version": $("#version").val(),
            }, function (data) {
                // mui.toast("删除成功！");
                history.go(-1);
            });
    };


    $(document).on("input propertychange", '#jobContent', function () {
        var len = $("#jobContent").val().length;
        $('#result').text(len + '/200');
        if (len > 200) {
            $("#save").prop("style", " background-color: #999;");
        } else {
            $("#save").prop("style", "");
        }
    });
    $(document).on("tap", '#save', function () {
        if ($("#jobContent").val().length <= 200) {
            //submitWorkExper();
        } else {
            mui.alert("工作内容过多！");
        }
    });


    function submitWorkExper() {
        if ($("#companyName").val() == null || $("#companyName").val() == "") {
            mui.alert("请填写公司名称！");
        } else if ($("#jobName").val() == null || $("#jobName").val() == "") {
            mui.alert("请填写职位名称！");
        } /*else if (!($("#start").val() && $("#end").val())) {
            mui.alert("请输入时间！");
        } else if ($("#start").val() > $("#end").val()) {
            mui.alert("开始时间不能大于结束时间！");
        } */else if ($("#jobContent").val() == null || $("#jobContent").val() == "") {
            mui.alert("请输入工作内容！");
        } else {
            var id = ijob.storage.get("data.workId");
            var url = "/ijob/api/WorkexperienceController/update";
            var msg = "修改成功！";
            var tempWorkexperience = {
                "id": $("#id").val(),
                "version": $("#version").val(),
                "resumeID": $("#resumeID").val(),
                "companyName": $("#companyName").val(),
                "jobName": $("#jobName").val(),
                /*"startTime": $("#start").val() + '-01',
                "endTime": $("#end").val() + '-01',*/
                "jobContent": $("#jobContent").val(),
            };
            if (id == 0) {
                url = "/ijob/api/WorkexperienceController/add";
                msg = "添加成功！";
            }
            //不是由新增简历进入的
            $.post(url, tempWorkexperience, function (data) {
                if (data.code == '200') {
                    // mui.toast(msg);
                    history.go(-1);
                } else {
                    mui.alert("数据不正确");
                }
            });
        }
    }
</script>
