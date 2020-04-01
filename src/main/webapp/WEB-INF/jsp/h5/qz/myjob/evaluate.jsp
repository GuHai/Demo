<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/29
  Time: 20:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>评价</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/part/partstyle.css">
</head>
<body>
<style>
   /* .PostJob .upload {
        margin-top: 0.267rem;
        height: 3.467rem;
        width: 100%;
        background-color: #fff;
        padding: 0.266rem;
    }*/
   /* .PostJob .upload > img {
        width: 2.982rem;
        height: 2.982rem;
        border: none;
        margin-right: 4px;
    }*/

   .img-box {
       background-color: #fff;
   }
   .z_photo {
       padding: 0.480rem;
   }
   .z_photo .z_file {
       position: relative;
       width: 2.987rem;
       height: 2.987rem;
       background-color: #f2f5f7;
       text-align: center;
       line-height: 2.987rem;
   }
   .z_file .file {
       width: 100%;
       height: 100%;
       opacity: 0;
       position: absolute;
       top: 0px;
       left: 0px;
       z-index: 100;
   }
   .z_photo .up-section {
       position: relative;
       margin-right: 2px;
       margin-bottom: 0.267rem;
   }
   .up-section .close-upimg {
       position: absolute;
       top: 0.160rem;
       right: 0.213rem;
       display: none;
       z-index: 10;
   }
   .up-section .up-span {
       display: block;
       width: 100%;
       height: 100%;
       visibility: hidden;
       position: absolute;
       top: 0px;
       left: 0px;
       z-index: 9;
       background: rgba(0, 0, 0, 0.5);
   }
   .up-section:hover {
       border: 2px solid #f15134;
   }
   .up-section:hover .close-upimg {
       display: block;
   }
   .up-section:hover .up-span {
       visibility: visible;
   }
   .z_photo .up-img {
       display: block;
       width: 100%;
       height: 100%;
   }
   .upimg-div .up-section {
       width: 2.960rem;
       height: 2.987rem;
   }
   .img-box .upimg-div .z_file {
       width: 2.960rem;
       height: 2.987rem;
   }
   .z_file .add-img {
       display: block;
       width: 2.960rem;
       height: 2.987rem;
   }


    .PostJob .btnBox {
        margin-top: 0.533rem;
        width: 100%;
    }
    .PostJob .btnBox .btn_sub {
        display: block;
        width: 9.093rem;
        height: 0.933rem;
        background-color: #108ee9;
        border-radius: 0.453rem;
        color: #fff;
        padding: 0;
        border: none;
        margin: auto;
        text-align: center;
        font-size: 0.400rem;
        line-height: 0.933rem;
        letter-spacing: 0px;
    }
</style>


<div class="PostJob">
    <form name="form" action=""  method="post" id="input_example">
        <div class="hev">
            <span></span>
        </div>
        <div class="Hcease">
            <textarea name="" id="evaluateContent" placeholder="请输入评价"></textarea>
        </div>
        <p class="Hcease-hine">0/200</p>

        <div class="img-box">
            <section class="img-section">
                <div class="z_photo upimg-div clearfix" id="photes">
                    <section class="z_file fl">
                        <img data-editable="true" class="attachment up-img" data-name="attachmentList0"
                             data-type="Photos"
                             data-id="" style="height: 100%;width: 100%"
                             src="#" alt=""
                             onerror="this.src='/ijob/static/images/a11.png';this.onerror=null">
                    </section>
                </div>
            </section>
        </div>



        <div class="btnBox">
            <input type="button" class="btn_sub" value="发表评论" data-url="/ijob/api/EvaluateController/addQzContent">
        </div>
    </form>
</div>
</body>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>


    var index = 0;
    $("#photes").attachment();
    $("#photes").on("uploadCompletionEvent", function () {
        index++;
        $(this).prepend("<section  class=\"z_file fl\">\n" +
            "    <img   data-editable=\"true\" class=\"attachment up-img\" data-name=\"attachmentList" + index + "\" data-type=\"Photos\"\n" +
            "          data-id=\"\" style=\"height: 100%;width: 100%\"\n" +
            "          src=\"#\" alt=\"\"\n" +
            "          onerror=\"this.src='/ijob/static/images/a11.png';this.onerror=null\">\n" +
            "</section>");
        setTimeout(function () {
            $(".img-box").find("section").eq(0).attachment();
        }, 100);
    });
    $(".hev span").text(ijob.storage.get("evaluate.title"));
    $(".btn_sub").click(function(){
        var attachment = {
            "datestr":$("input[name='attachment.datestr']").val(),
            "path":$("input[name='attachment.path']").val(),
            "name":$("input[name='attachment.name']").val(),
            "type":$("input[name='attachment.type']").val(),
            "version":$("input[name='attachment.version']").val(),
            "id":$("input[name='attachment.id']").val(),
            "isDeleted":$("input[name='attachment.isDeleted']").val()
        }
        var _this  =  $(this);
        var obj = $("#input_example").serializeObjectJson();
        obj = ijob.parseFromFormObject(obj, ["attachmentList"]);
        _this.btPost({
            positionID:ijob.storage.get("evaluate.positionID"),
            evaluateContent:$("#evaluateContent").val(),
            attachmentList:obj.attachmentList
        },function(data){
            // ijob.goPreAndRefresh("评价成功")
            ijob.storage.set("been.state",6);
            ijob.back();
        });
    });
</script>
</html>
