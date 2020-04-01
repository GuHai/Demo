<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>证件</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/add_document.css">
</head>
<body>
<div class=wrap>
    <form action="">
        <div class="theName">
            <span>证件名称</span>
            <label for="">
                <input type="hidden" id="id" name="id" value="">
                <input type="hidden" id="version" name="version" value="">
                <input type="hidden" id="resumeID" name="resumeID" value="">
                <input type="text" id="documentName" value="" name="documentName" placeholder="请输入证件名" maxlength="13">
            </label>
        </div>
        <div class="validity">
            <span>有效期至</span>
            <input type="hidden" id="effective" name="effective" value="">
            <a href="javascript:void(0);" id="Validity"></a>
        </div>
        <div class="Upload">
            <h1>证件照片</h1>
            <label for="file" id="result">
                <img id="focumentImg" class="attachment" data-name="attachment" data-type="Certificate"
                     style="height: 100%;width: 100%" data-id=""
                     src="" alt=""
                     onerror="this.src='/ijob/static/images/a9.png';this.onerror=null">
            </label>
        </div>
    </form>
    <div class="btn_fixed">
        <div id="save" class="btn" data-url="/ijob/api/DocumentController/h5/mine/add" onclick="addORupdate()">保存</div>
    </div>
</div>
</body>
</html>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>
    //图片，主要为了缓存到session中，看是否改变，如果没改变会报错
    $(function () {
        //初始化
        var id = ijob.storage.get("documentid");
        $('#resumeID').val(ijob.storage.get('Resume.id'));
        var tempDocument;

        $.ajax({    //使用jquery下面的ajax开启网络请求
            type: "POST",   //http请求方式为POST
            url: '/ijob/api/DocumentController/myDocument/' + id,  //请求接口的地址
            dataType: 'json',   //当这里指定为jsfromon的时候，获取到了数据后会自动解析的，只需要 返回值.字段名称 就能使用了
            success: function (result) {  //请求成功，http状态码为200。返回的数据已经打包在data中了。
                if (result.code == '200') {
                    //渲染
                    tempDocument = result.data.list[0];
                    $("#id").val(tempDocument.id);
                    $("#version").val(tempDocument.version);
                    $("#documentName").val(tempDocument.documentName);
                    $("#effective").val(ijob.dateFormat(tempDocument.effective - 0, "yyyy-MM-dd"));
                    $("#Validity").text(ijob.dateFormat(tempDocument.effective - 0, "yyyy-MM-dd"));
                    if (tempDocument.attachment) {
                        $("#focumentImg").prop("src", "/ijob/upload/" + template.absolutelyPath(tempDocument.attachment));
                    }
                    //拿到结果再运行代码，不然会报错
                    commonality();
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

            var data1 = timestampToTime(tempDocument.effective);
            $("#focumentImg").attachment();
            var dtpicker = new mui.DtPicker({
                "type": "date",
                "value": data1,
                beginDate: new Date(2000, 00, 01),//设置开始日期
                endDate: new Date(2025, 12, 25),//设置结束日期
            });
            $("#Validity").on("tap", function () {
                dtpicker.show(function (e) {
                    $("#Validity").html(e.text);
                    $("#effective").val(e.text)
                })
            });

            if (id == 0) {
                $("#Validity").text("请选择");
            } else {
                //不是新的添加,就增加删除按钮
                $("#save").after('<div id="delete" onclick="deleteDocumet()" class="btn" style="background-color: red;">删除</div>');
            }
            $("#focumentImg").on("uploadStart", function () {
                $("#save").attr("disabled", "disabled");
            });
            $("#focumentImg").on("uploadCompletion", function () {
                $("#save").removeAttr("disabled");
            });
        }
    });


    function deleteDocumet() {

        $.post(
            "/ijob/api/DocumentController/delete",
            {
                "id": $("#id").val(),
                "version": $("#version").val(),
            }, function (data) {
                // mui.toast("删除成功！");
                history.go(-1);
            });
    };


    function addORupdate() {
        if ($("#documentName").val() == null || $("#documentName").val() == "") {
            mui.alert("请输入证件名称！");
        } else if ($("#effective").val() == null || $("#effective").val() == "") {
            mui.alert("请选择有效时间！");
        } else {
            var id = ijob.storage.get("documentid");
            var tempDocument = $("form").serializeObjectJson();
            //不是由新增简历进入的
            if (id == 0) {
                //添加
                $("#save").btPost(tempDocument, function (data) {
                    if (data.code == '200') {
                        history.go(-1);
                    } else {
                        mui.alert("数据不正确!");
                    }
                });
            } else {
                //修改

                $("#save").attr("data-url", "/ijob/api/DocumentController/update");
                $("#save").btPost(tempDocument, function (data) {
                    if (data.code == 200) {
                        history.go(-1);
                    } else {
                        mui.alert("数据格式不正确！");
                    }
                });
            }
        }
    }


</script>