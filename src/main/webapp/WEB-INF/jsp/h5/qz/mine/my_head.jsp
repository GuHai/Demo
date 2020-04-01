<%@ page contentType="text/html;charset=UTF-8" language="java"   import="com.yskj.service.base.DictCacheService" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <style type="text/css">
        #result{
            height: 80%;
            width: 80%;
            margin:20px auto;
            border:1px solid #eee;
        }
        #result img{
            height: 100%;
            width: 100%;
        }
        input{
            width: 70px;
            margin-top: 10px;
        }
        .btnBox {
            margin-top: 10px;
        }
        .btnBox .btn_save {
            width: 90%;
            height: 40px;
            background-color: #108ee9;
            border-radius: 20px;
            margin: 0.55rem;
            padding: 0;
            font-size: 15px;
            font-weight: normal;
            font-stretch: normal;
            line-height: 40px;
            letter-spacing: 0px;
            color: #ffffff;
            border: none;
        }
        @-moz-document url-prefix() { input { width:65px; } }/*单独对火狐进行设置*/
    </style>
     <script src="/ijob/lib//lib-flexible.js"></script>
    <script src="/ijob/lib/mui/js/mui.min.js"></script>
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <script src="/ijob/static/js/enums.js"></script>
    <script src="/ijob/lib/jquery-2.2.3.js"></script>
    <script src="/ijob/static/js/ijob.js"></script>
    <script src="/ijob/static/js/dict.js"></script>
    <script src="/ijob/static/js/cutPhoto.js"></script>
    <script src="/ijob/static/js/html2canvas.min.js"></script>
    <script src="/ijob/static/js/attachment.js"></script>
    <link rel="stylesheet" href="/ijob/static/css/loading.css">
</head>
<body>
<form>
    <input name="id" value="<shiro:principal property="id"/>" type="hidden">
    <input name="version" value="<shiro:principal property="version"/>" type="hidden">
    <div id = "result">
        <img  id="myhead"  data-cut="true" class="attachment" data-name="attachment" data-type="Head"
               data-id="<shiro:principal property="infoHeadImg"/>" style="height: 100%;width: 100%"
               src="<shiro:principal property="imgPath"/>" alt=""
               onerror="this.src='/ijob/static/images/a11.png';this.onerror=null">
    </div>
    <div class="btnBox">
        <input type="button"  value="更换照片" class="btn_save"  id="signUpBnt" data-url="/UserController/h5/changeMyHead">
    </div>
</form>

</body>
<script>

    $(document).ready(function(){
        $("#result").attachment();

        $("#signUpBnt").click(function(){
            $(this).btPost(JSON.stringify($("form").serializeObjectJson()),function(){
                window.location.href = "/ijob/api/InformationController/h5/mine/basicInfo" ;
            });
        });
    });

</script>
</html>