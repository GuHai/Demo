<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.yskj.service.base.DictCacheService" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>我的二维码</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/QRcode.css">
    <style>
        html,body{
            background-color: #2e3132 !important;
        }
    </style>
</head>
<body >
<div class="wrap">
    <div class="content QRcodeContent">
        <script type="text/html" id="qrcode" data-url="/ijob/api/InformationController/h5/mine/getQRcode" data-type="POST">
            {{each list as qrcode}}
                <div class="head">
                    <div class="imgBox">
                        <img class="photoImg" id="myhead" src="{{qrcode.user.imgPath }}"
                             alt=""
                             onerror="this.src='/ijob/static/images/default.jpg';this.onerror=null">
                    </div>
                    <div class="infoBox">
                        <p class="nameP">{{qrcode.user.nickName | ifNull:'暂无昵称'}}</p>
                        <p class="noteP">工作号：
                            {{qrcode.Information.workNumber | ifNull:'无工作号'}}
                        </p>
                    </div>
                </div>
                <div class="codeBox" id="qrcodeimg">
                    <%--<img src="/ijob/upload/{{qrcode.Information.qrCodeObj | absolutelyPath}}" alt="">--%>
                </div>
                <div class="msgBox">扫一扫二维码图案，关注我的动态</div>
            {{/each}}
        </script>
    </div>
    <div class="content" style=" position: absolute;width: 90% ;left:5%;margin-top: 2rem;">
        <script type="text/html" id="workNumberQrcode" data-url="/ijob/api/InformationController/h5/mine/getSchoolCode/{data.id}" data-type="POST">
            {{each list as qrcode}}
            <div class="head">
                <div class="imgBox">
                    <img class="photoImg" id="workNumberHead" src="/ijob/upload/{{qrcode.hdImage.absolutelyPath}}"
                         alt=""
                         onerror="this.src='/ijob/static/images/default.jpg';this.onerror=null">
                </div>
                <div class="infoBox">
                    <p class="nameP">{{qrcode.name | ifNull:'暂无昵称'}}</p>
                    <%--<p class="noteP">工作号：
                        {{qrcode.Information.workNumber | ifNull:'无工作号'}}
                    </p>--%>
                </div>
            </div>
            <div class="codeBox" id="schoolqrcodeimg">
                <%--<img src="/ijob/upload/{{qrcode.Information.qrCodeObj | absolutelyPath}}" alt="">--%>
            </div>
            <div class="msgBox">扫一扫二维码图案，关注学校动态</div>
            {{/each}}
        </script>
    </div>
</div>
<jsp:include page="../../qz/base/resource.jsp"/>
<script src="/ijob/static/js/utf.js"></script>
<script src="/ijob/static/js/qrcode.min.js"></script>
<script>
    if(ijob.storage.get("data.id")==null){
        $("#qrcode").loadData().then(function (result) {
            //让二维码上下居中
            /*var top=(window.screen.height-$(".content").height())/2;
            $(".content").css("margin-top",top+'px');*/

            var pw =  $(".codeBox").height();
            var width = pw;
            var height = width;
            var qrcode = new QRCode(document.getElementById("qrcodeimg"), {
                text:  "http://${url}/follow/"+result.data.list[0].user.id,
                width: width, //生成的二维码的宽度
                height: height, //生成的二维码的高度
                colorDark : "#000000", // 生成的二维码的深色部分
                colorLight : "#ffffff", //生成二维码的浅色部分
                correctLevel : QRCode.CorrectLevel.H
            });


            //jquery-qrcode.js
            /*var pw =  $(".codeBox").height();
            var width = pw;
            var height = width;
            var x = width * 0.4;
            var y = height * 0.4;
            var lw = width * 0.2;
            var lh = height * 0.2;
            var qrcode = $('#qrcodeimg').qrcode({
                render : "canvas",
                width: width,
                height: height,
                background : "#ffffff",       //二维码的后景色
                foreground : "#000000",        //二维码的前景色
                text:"这是修改了官文的js文件，此时生成的二维码支持中文和LOGO",
                src: result.data.list[0].user.imgPath
            });
            $("#qrcodeimg canvas")[0].getContext('2d').drawImage($("#myhead")[0], x, y, lw, lh);*/
        });
    }else{//加载学校二维码。
        $("#workNumberQrcode").loadData().then(function (result) {
            console.log(result)
            var pw =  $(".codeBox").height();
            var width = pw;
            var height = width;
            var qrcode = new QRCode(document.getElementById("schoolqrcodeimg"), {
                text:  "http://${url}/follow/"+ijob.storage.get("data.id"),
                width: width, //生成的二维码的宽度
                height: height, //生成的二维码的高度
                colorDark : "#000000", // 生成的二维码的深色部分
                colorLight : "#ffffff", //生成二维码的浅色部分
                correctLevel : QRCode.CorrectLevel.H
            });
        });
    }

</script>
</body>
</html>