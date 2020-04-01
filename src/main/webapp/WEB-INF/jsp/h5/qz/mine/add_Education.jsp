<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>教育背景</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/part/partstyle.css">
    <link rel="stylesheet" href="/ijob/static/css/mine/add_Education.css">
</head>
<body>
<div class="wrap">
    <ul class="list">
        <li>
            <input type="hidden" id="resumeID" value="${sessionScope.Resume.id}">
            <input type="hidden" id="id" value="">
            <input type="hidden" id="version" value="">
            <span>学校</span>
            <span>
                <input type="text" style="text-align: right" id="schoolName" name="schoolName" placeholder="请填写学校名称"
                       maxlength="13" value="">
            </span>
        </li>
        <li>
            <span>专业</span>
            <span>
                  <input type="text" style="text-align: right" id="major" name="major" placeholder="请填写专业名称"
                         maxlength="13" value="">
            </span>
        </li>
        <li id="educationSelect">
            <input type="hidden" id="educationType" value="">
            <span>学历</span>
            <span>
                    <span id="education"></span>
                    <i class="iconfont icon-arrow-right"></i>
                </span>
        </li>
        <li id="schoolDtPicker">
            <span>时间段</span>
            <input type="hidden" id="start" value="">
            <input type="hidden" id="end" value="">
            <span>
                    <span id="month_begin"></span> 至 <span id="month_end"></span>
                    <i class="iconfont icon-arrow-right"></i>
                </span>
        </li>
    </ul>
    <div class="workText">在校经历</div>
    <div class="textareaBox">
            <textarea id="association" name="association" cols="30" rows="5"
                      placeholder="请输入在校经历"></textarea>
        <p id="result">0/200</p>
    </div>
    <div class="btn_fixed">
        <div id="save" class="btn" onclick="save()">
            保存
        </div>
    </div>

</div>
</body>
</html>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>

    $(function () {
        //初始化
        var id = ijob.storage.get("data.eduId");
        var tempEducational;
        var tempEducationals = JSON.parse(ijob.storage.get("tempEducationals"));
        if (ijob.storage.get("tempResume") && id != 0) {
            //在 session 中拿数据渲染
            //这里的 id 是 session 数据中的下标+1的结果,所以要-1
            tempEducational = tempEducationals[+id - 1];
            $("#schoolName").val(tempEducational.schoolName);
            $("#major").val(tempEducational.major);
            $("#education").text(tempEducational.education);
            $("#educationType").val(tempEducational.educationLeavl);
            //因为保存的时候 +"-01" 了, 显示不需要精确到日
            var month_begin = tempEducational.timeSlot.substring(0,tempEducational.timeSlot.length-3);
            var month_end = tempEducational.timeEnd.substring(0,tempEducational.timeSlot.length-3);
            $("#start").val(month_begin);
            $("#end").val(month_end);
            $("#month_begin").text(month_begin);
            $("#month_end").text(month_end);
            $("#association").val(tempEducational.association);
            commonality();
        } else {
            $.ajax({    //使用jquery下面的ajax开启网络请求
                type: "POST",   //http请求方式为POST
                url: '/ijob/api/EducationalController/get/' + id,  //请求接口的地址
                data: JSON.parse(ijob.storage.get("tempEducationals")),
                dataType: 'json',   //当这里指定为jsfromon的时候，获取到了数据后会自动解析的，只需要 返回值.字段名称 就能使用了
                success: function (result) {  //请求成功，http状态码为200。返回的数据已经打包在data中了。
                    if (result.code == '200') {
                        //渲染
                        tempEducational = result.data.list[0];
                        $("#id").val(tempEducational.id);
                        $("#version").val(tempEducational.version);
                        $("#schoolName").val(tempEducational.schoolName);
                        $("#major").val(tempEducational.major);
                        $("#education").text(tempEducational.education);
                        $("#educationType").val(tempEducational.educationLeavl);
                        var month_begin = tempEducational.timeSlot == null ? '' : ijob.dateFormat(tempEducational.timeSlot-0,"yyyy-MM");
                        var month_end = tempEducational.timeEnd == null ? '' : ijob.dateFormat(tempEducational.timeEnd-0,"yyyy-MM");
                        $("#start").val(month_begin);
                        $("#end").val(month_end);
                        $("#month_begin").text(month_begin);
                        $("#month_end").text(month_end);
                        $("#association").val(tempEducational.association);
                        //拿到结果再运行代码，不然会报错
                        commonality();

                    } else {    //请求失败
                        mui.toast("获取数据失败!");
                    }
                }
            })

        }


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

            var begin = timestampToTime(tempEducational.timeSlot);
            var end = timestampToTime(tempEducational.timeEnd);

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
                document.getElementById("schoolName").blur();
                document.getElementById("major").blur();
                dtpicker1.show(function (e) {
                    $("#month_begin").html(e.text);
                    $("#start").val(e.text);
                })
            });
            $("#month_end").on("tap", function () {
                document.getElementById("schoolName").blur();
                document.getElementById("major").blur();
                dtpicker2.show(function (e) {
                    $("#month_end").html(e.text);
                    $("#end").val(e.text);
                })
            });
            //学历 1,小学,2,初中,3,高中,4,中专,5,大专,6,本科,7,研究生,8博士
            var picker = new mui.PopPicker();
            picker.setData([{
                text: '小学',
                value: '1'
            }, {
                text: '初中',
                value: '2'
            }, {
                text: '高中',
                value: '3'
            }, {
                text: '中专',
                value: '4'
            }, {
                text: '大专',
                value: '5'
            }, {
                text: '本科',
                value: '6'
            }, {
                text: '研究生',
                value: '7'
            }, {
                text: '博士',
                value: '8'
            }]);
            var education = $("#educationType").val();
            picker.pickers[0].setSelectedValue(education, tempEducational.education);
            $("#educationSelect").on('tap', function (event) {
                document.getElementById("schoolName").blur();
                document.getElementById("major").blur();
                picker.show(function (items) {
                    $("#education").html(items[0].text);
                    $("#educationType").val(items[0].value);
                    //返回 false 可以阻止选择框的关闭
                    //return false;
                });
            });

            if (id == 0) {
                //新添加，不用管是存 session 还是数据库
                $("#education").text("小学");
                $("#educationType").val("1");
                $("#month_begin").text("请选择");
                $("#month_end").text("请选择");
            } else {
                $('#result').text($("#association").val().length + '/200');
                $("#save").after('<div id="delete" onclick="deleteEducation()" class="btn" style="background-color: red;">删除</div>');
            }
        }
    });

    $(document).on("input propertychange", '#association', function () {
        var len = $("#association").val().length;
        $('#result').text(len + '/200');
        $("#save").off("click");
        if (len > 200) {
            $("#save").prop("style", " background-color: #999;");
        } else {
            $("#save").prop("style", "");
        }
    });

    function save() {
        if ($("#association").val().length <= 200) {
            submitEducation();
        } else {
            mui.toast("内容过多,修改失败！");
        }
    };

    //删除
    function deleteEducation() {
        if (ijob.storage.get("tempResume")) {
            //在 session 中添加删除
            var tempEducationals = JSON.parse(ijob.storage.get("tempEducationals"));
            //因为 eduid 之前为了避免冲突 +1 了，所以现在要 -1
            tempEducationals.splice(ijob.storage.get("eduId") - 1, 1);
            if(tempEducationals.length ==0){
                ijob.storage.set("tempEducationals",null);
            }
            // ijob.storage.set('isChooseResumeAddReLoad',true);
            history.go(-1);
        } else {
            $.post(
                "/ijob/api/EducationalController/delete",
                {
                    "id": $("#id").val(),
                    "version": $("#version").val(),
                }, function (data) {
                    // mui.toast("删除成功！");
                    // ijob.storage.set('isChooseResumeAddReLoad',true);
                    history.go(-1);
                });
        }
    };


    function submitEducation() {
        var education = $("#education").text();
        var educationType = $("#educationType").val();

        if ($("#schoolName").val() == null || $("#schoolName").val() == "") {
            mui.toast("请填写学校名称！");
        } else if ($("#major").val() == null || $("#major").val() == "") {
            mui.toast("请填写专业！");
            // } else if (educationLeavl == 9 || educationLeavl == undefined) {
            //     mui.toast("请输入学历！");
        } else if (!($("#start").val() && $("#end").val())) {
            mui.toast("请输入时间！");
        } else if ($("#start").val() > $("#end").val()) {
            mui.toast("开始时间不能大于结束时间！");
        } else if ($("#association").val() == null || $("#association").val() == "") {
            mui.toast("请输入教育经历！")
        } else {
            $("body").before(ijob.mask);
            var id = ijob.storage.get("data.eduId");
            var url = '';
            var msg = '';
            var tempEducational = {
                "id": $("#id").val(),
                "version": $("#version").val(),
                "resumeID": $("#resumeID").val(),
                "schoolName": $("#schoolName").val(),
                "major": $("#major").val(),
                "timeSlot": $("#start").val() + '-01',
                "timeEnd": $("#end").val() + '-01',
                "association": $("#association").val(),
                "education": education,
                "educationLeavl": educationType
            };
            if (id == 0) {
                url = "/ijob/api/EducationalController/add";
                msg = "添加成功！";
            } else {
                url = "/ijob/api/EducationalController/update";
                msg = "修改成功！";
            }

            if (ijob.storage.get("tempResume")) {
                //在 session 中添加修改
                //是由新增简历进入的
                //保存学历的数组
                var tempEducationals = JSON.parse(ijob.storage.get('tempEducationals'));
                //由于是从新增简历进入的，所以 id 可能是 0 或数组的下标,为避免冲突下标已 +1
                if (id == 0) {
                    tempEducational.id = null;
                    tempEducational.version = null;
                    tempEducational.resumeID = null;
                    //新增
                    if (!ijob.storage.get("tempEducationals")) {
                        //tempEducationals 是空的
                        ijob.storage.set("tempEducationals", '[' + JSON.stringify(tempEducational) + ']');
                    } else {
                        tempEducationals.push(tempEducational);
                        ijob.storage.set("tempEducationals", JSON.stringify(tempEducationals));
                    }
                } else {
                    //修改
                    tempEducationals.splice(+id-1, 1, tempEducational);
                    ijob.storage.set("tempEducationals", JSON.stringify(tempEducationals));
                }
                //返回上一页
                // ijob.storage.set('isChooseResumeAddReLoad',true);
                history.go(-1);
            } else {
                //直接对数据库进行修改
                //不是由新增简历进入的
                $.post(url, tempEducational, function (data) {
                    $("body").prev(".loading").remove();
                    if (data.code == '200') {
                        // mui.toast("修改成功！");
                        // ijob.storage.set('isChooseResumeAddReLoad',true);
                        history.go(-1);
                    } else {
                        mui.toast("数据不正确！");
                    }
                });
            }

        }
    }

</script>