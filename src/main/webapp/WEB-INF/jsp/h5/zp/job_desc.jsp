<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/8
  Time: 17:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>职位描述</title>
    <jsp:include page="../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/postjob.css">
</head>
<body>
    <div class="desc_content_list">
        <div class="desc_content_main">
            <textarea class="textarea" name="textarea" id="textarea" ></textarea>
        </div>
        <footer class="nav_footer">
            <a href="javascript:void(0);" class="resetting" id="resetting" data-url="/ijob/api/PositionController/setToSession">取消</a>
            <a href="javascript:void(0);" class="confirm" id="confirm" data-url="/ijob/api/PositionController/setToSession">确认</a>
        </footer>
    </div>
<script>
    // 提示信息有分段效果
    var placeholder = '请输入工作要求、工作内容、注意事项等，建议使用短句并分条列出，如下：\n工作要求：\n1，... \n2，... \n工作内容： \n1，... \n2，...';
    if(ijob.storage.get("jobContent")){
        $("#textarea").val(ijob.storage.get("jobContent"));
    }else {
        $('.desc_content_main .textarea').val(placeholder);
    }
    $('.desc_content_main .textarea').focus(function() {
        if ($(this).val().indexOf("请输入工作要求、工作内容、注意事项等，建议使用短句并分条列出，如下") != -1) {
            $(this).val('');
        }
    });

    $('.desc_content_main .textarea').blur(function() {
        if ($(this).val() == '') {
            $(this).val(placeholder);
        }
    });

    $("#textarea").text(ijob.storage.get("jobContent"));
    $("#confirm").click(function () {
        if ($('.desc_content_main .textarea').val().indexOf("请输入工作要求、工作内容、注意事项等，建议使用短句并分条列出，如下") != -1) {
            $('.desc_content_main .textarea').val('');
        }
        ijob.storage.set("jobContent",$("#textarea").val());
        var positionObj = ijob.storage.get("positionObj");
        positionObj.jobContent = $("#textarea").val();
        positionObj.labelList = ijob.storage.get("labelList");
        $(this).btPost(JSON.stringify(positionObj),function (data) {
            if(data.code == 200){
                if(ijob.storage.get("isTemp")){
                    if (ijob.storage.get("id") == "" || ijob.storage.get("id") == null || ijob.storage.get("id") == undefined ){
                        ijob.gotoPage({path:'/h5/zp/location_tem?positionTemp.id=0'});
                    }else{
                        ijob.gotoPage({path:'/h5/zp/location_tem?positionTemp.id='+ijob.storage.get("id")});
                    }
                    ijob.storage.set("isTemp",null);
                }else{
                    if (ijob.storage.get("id") == "" || ijob.storage.get("id") == null || ijob.storage.get("id") == undefined ){
                        ijob.gotoPage({path:'/h5/zp/postJob2?positionTemp.id=0'});
                    }else{
                        ijob.gotoPage({path:'/h5/zp/postJob2?positionTemp.id='+ijob.storage.get("id")});
                    }
                }

            }
        })
    });
    $("#resetting").click(function () {
        var positionObj = ijob.storage.get("positionObj");
        positionObj.labelList = ijob.storage.get("labelList");
        positionObj.jobContent = ijob.storage.get("jobContent");
        $(this).btPost(JSON.stringify(positionObj),function (data) {
            if(data.code == 200){
                if(ijob.storage.get("isTemp")){
                    if (ijob.storage.get("id") == "" || ijob.storage.get("id") == null || ijob.storage.get("id") == undefined ){
                        ijob.gotoPage({path:'/h5/zp/location_tem?positionTemp.id=0'});
                    }else{
                        ijob.gotoPage({path:'/h5/zp/location_tem?positionTemp.id='+ijob.storage.get("id")});
                    }
                    ijob.storage.set("isTemp",null);
                }else{
                    if (ijob.storage.get("id") == "" || ijob.storage.get("id") == null || ijob.storage.get("id") == undefined ){
                        ijob.gotoPage({path:'/h5/zp/postJob2?positionTemp.id=0'});
                    }else{
                        ijob.gotoPage({path:'/h5/zp/postJob2?positionTemp.id='+ijob.storage.get("id")});
                    }
                }

            }
        })
    });
</script>
</body>
</html>
