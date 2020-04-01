<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/29
  Time: 13:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>举报</title>
    <jsp:include page="../../qz/base/link.jsp"/>

    <link rel="stylesheet" href="/ijob/static/css/mine/report.css">
    <style>
        #fontSize {
            margin-right: 0.453rem;
            font-size: 0.400rem;
            font-weight: normal;
            font-stretch: normal;
            text-align: right;
            letter-spacing: 0px;
            color: #999999;
        }
        .jesuan {
            margin-top: .267rem;
            padding: 0 .453rem;
            height: 1.067rem;
            background-color: #fff;
            border-bottom: 1px solid #f2f5f7;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .jesuan .jesuan_lf {
            font-size: .400rem;
            font-weight: normal;
            font-stretch: normal;
            letter-spacing: 0;
            color: #333;
        }
        .jesuan .jesuan_rt {
            font-size: .320rem;
            font-weight: normal;
            font-stretch: normal;
            letter-spacing: 0;
            color: #999;
        }
        .jesuan .jesuan_rt i{font-size: 0.32rem}
    </style>
</head>
<body>
<jsp:include page="../../qz/base/resource.jsp"/>
<div class="wrap">
    <form id="form">
        <input type="hidden" id="positionID" name="positionID" value="">
        <div class="jesuan" id="showpicker">
            <input name="appealType"  type="hidden" id="appealType" value="1">
            <span class="jesuan_lf">申诉类型</span>
            <span class="jesuan_rt"><span id="userResult">不予结算薪资</span><i class="iconfont icon-arrow-right"></i></span>
        </div>
        <div class="textareaBox">
            <textarea class="textarea" name="appealReason" id="appealReason" cols="30" rows="8" wrap="physical"
                      placeholder="请简要描述你的问题和意见"></textarea>
            <p id="fontSize">0/200</p>
        </div>
        <div class="img-box">
            <section class=" img-section">
                <div class="z_photo upimg-div clearfix"  id="photes">
                    <section class="z_file fl">
                    <img data-editable="true" class="attachment up-img" data-name="attachmentList0"
                         data-type="Photos"
                         data-id="" style="height: 100%;width: 100%"
                         src="#" alt=""
                         onerror="this.src='/ijob/static/images/a9.png';this.onerror=null"></section>
                </div>
            </section>
        </div>
        <div class="btnBox">
            <input id="submit"  type="button"  data-url="/ijob/api/AppealhandleController/add" value="提交" class="btn">
        </div>
    </form>
</div>
</body>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>
    var position=ijob.storage.get("data.positionID");
    $("#positionID").val(position);



    var picker = new mui.PopPicker();
    picker.setData([{
        text: '虚假职位信息',
        index:1
    }, {
        text: '不予结算薪资',
        index:2
    }, {
        text: '薪资结算错误',
        index:3
    }, {
        text: '其他',
        index:4
    }]);
    var appealType = 1;
    $("#showpicker").on('tap', function (event) {
        picker.show(function (items) {
            $("#userResult").html(items[0].text);
            appealType = items[0].index;
            $("#appealType").val(appealType);
        });
    });
    $(function () {
        var index=0;
        $("#photes").attachment();
        $("#photes").on('deleteEvent',function(){
        });
        $("#photes").on("uploadCompletionEvent", function () {
            index++;
            if(index<9) {
                $(this).prepend("<section  class=\"z_file fl\">\n" +
                    "    <img   data-editable=\"true\" class=\"attachment up-img\" data-name=\"attachmentList" + index + "\" data-type=\"Photos\"\n" +
                    "          data-id=\"\" style=\"height: 100%;width: 100%\"\n" +
                    "          src=\"#\" alt=\"\"\n" +
                    "          onerror=\"this.src='/ijob/static/images/a9.png';this.onerror=null\">\n" +
                    "</section>");
                setTimeout(function () {
                    $("#photes").find("section").eq(0).attachment();
                }, 100);
            }
        });



        $("#submit").click(function () {
            if($("#appealReason").val()==null || $("#appealReason").val()==""){
                mui.toast("举报内容不能为空！");
            }else if ($("#appealReason").val().length <= 200) {
                var obj = $("#form").serializeObjectJson();
                obj = ijob.parseFromFormObject(obj, ["attachmentList"]);
                console.log(obj);
                $("#submit").btPost(JSON.stringify(obj),function (data) {
                    if(data.code == "200"){
                        mui.alert("我们已经收到您的举报。",function () {
                            ijob.gotoPage({path:'/h5/qz/index/part_time_detail'});
                        });
                    }
                });
            }else{
                mui.toast("内容过多！");
            }
        })
    });

    $(document).on("input propertychange", '#appealReason', function () {
        var len = $("#appealReason").val().length;
        $('#fontSize').text(len + '/200');
        $(".btn").css({"background-color":""});
        if (len > 200) {
            $(".btn").css({"background-color":"#999"});
        }
    });
</script>
</html>
