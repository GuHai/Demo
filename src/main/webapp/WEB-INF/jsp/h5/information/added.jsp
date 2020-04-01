<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>朋友圈</title>
    <script src="/ijob/static/js/jquery-3.1.1.min.js"></script>
    <script src="/ijob/lib//lib-flexible.js"></script>
    <link rel="stylesheet" href="/ijob/lib/mui/fonts/mui.ttf">
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <script src="/ijob/lib/mui/js/mui.min.js"></script>
    <script src="/ijob/static/js/ijob.js"></script>
    <script src="/ijob/static/js/attachment.js"></script>
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/static/css/base.css">
    <link rel="stylesheet" href="/ijob/static/css/infprmation/added.css">
    <style>
        #result {
            margin-right: 0.453rem;
            font-size: 0.400rem;
            font-weight: normal;
            font-stretch: normal;
            text-align: right;
            letter-spacing: 0px;
            color: #999999;
        }
    </style>
</head>
<body>
<div class="wrap">
    <form action="" id="partForm" data-url="/ijob/api/ParttimeinformationController/add">
        <%--<div class="">--%>
        <%--<textarea name="releaseContent" id="" cols="30" rows="10"></textarea>--%>
        <%--</div>--%>
        <div class="textareaBox">
                <textarea id="releaseContent" name="releaseContent" wrap="physical" cols="30" rows="8"
                          placeholder="这一刻的想法..." maxlength="200"></textarea>
            <p id="result">0/200</p>
        </div>
        <div class="img-box">
            <section class="img-section">
                <%--<div class="z_photo upimg-div clearfix" id="photes">
                    <section  class="z_file fl">
                        <i class="iconfont icon--jia"></i>
                        <input type="file" data-editable="true" class="file" data-name="attachmentList0" data-type="Photos"
                              data-id="" style="height: 100%;width: 100%"
                              src="#" alt=""
                              onerror="this.src='/ijob/static/images/a11.png';this.onerror=null">
                    </section>
                </div>--%>

                <div class="z_photo upimg-div clearfix" id="photes">
                    <section class="z_file fl">
                        <img data-editable="true" class="attachment up-img" data-name="attachmentList0"
                             data-type="Photos"
                             id="attachmentList"
                             data-id="" style="height: 100%;width: 100%"
                             src="#" alt=""
                             onerror="this.src='/ijob/static/images/a9.png';this.onerror=null">
                    </section>
                </div>


            </section>
        </div>
    </form>
    <div class="btnBox">
        <input type="button" class="btn" id="submit_enter" value="发送">
    </div>
</div>
</body>
</html>

<script>

    $(document).on("input propertychange", '#releaseContent', function () {
        var len = $("#releaseContent").val().length;
        $('#result').text(len + '/200');
        $("#submit_enter").css({"background-color":""});
        if (len > 200) {
            $("#submit_enter").css({"background-color":"#999"});
        }
    });
    // $(document).on("click", '#submit_enter', function () {
    //     if ($("#releaseContent").val().length <= 200) {
    //         $("form").submit();
    //     }else{
    //         mui.toast("内容过多！");
    //     }
    // });

    var index = 0;
    $("#photes").attachment();
    $("#photes").on("deleteEvent",function(){
        if( $("#photes img[src*='/ijob/static/images/a9.png']").length == 0){
            $(this).prepend("<section  class=\"z_file fl\">\n" +
                "    <img data-editable=\"true\" class=\"attachment up-img\" data-name=\"attachmentList" + index + "\" data-type=\"Photos\"\n" +
                "          data-id=\"\" style=\"height: 100%;width: 100%\"\n" +
                "          src=\"#\" alt=\"\"\n" +
                "          onerror=\"this.src='/ijob/static/images/a9.png';this.onerror=null\">\n" +
                "</section>");
            setTimeout(function () {
                $("#photes").find("section").eq(0).attachment();
            }, 100);
        }
    });
    $("#photes").on("uploadCompletionEvent", function () {
        if($("#photes section").length<9){
            index++;
            $(this).prepend("<section  class=\"z_file fl\">\n" +
                "    <img data-editable=\"true\" class=\"attachment up-img\" data-name=\"attachmentList" + index + "\" data-type=\"Photos\"\n" +
                "          data-id=\"\" style=\"height: 100%;width: 100%\"\n" +
                "          src=\"#\" alt=\"\"\n" +
                "          onerror=\"this.src='/ijob/static/images/a9.png';this.onerror=null\">\n" +
                "</section>");
            setTimeout(function () {
                $("#photes").find("section").eq(0).attachment();
            }, 100);
        }
    });


    $("#submit_enter").click(function () {
        if ($("#releaseContent").val().length <= 200) {
            if($("#releaseContent").val()==null || $("#releaseContent").val() == "" || $("#attachmentList").attr("src") == '/ijob/static/images/a9.png' ){
                mui.toast("文字描述和图片不能为空！");
            }else{
                var obj = $("#partForm").serializeObjectJson();
                obj = ijob.parseFromFormObject(obj, ["attachmentList"]);
                $("#partForm").btPost(obj, function (data) {
                    // setTimeout(function(){
                    //     window.location.href="/ijob/api/ParttimeinformationController/detail/"+data.data.id;
                    // },1000);
                    ijob.menu.set("information:myFocus");
                    ijob.reback("新增成功");
                });
            }
        }else{
            mui.toast("内容过多！");
        }
    });

</script>