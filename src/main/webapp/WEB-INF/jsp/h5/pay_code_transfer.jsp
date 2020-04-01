<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.yskj.service.base.DictCacheService" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>收钱码</title>
    <jsp:include page="qz/base/resource.jsp"/>
    <jsp:include page="qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/QRcode.css?version=4">
    <style>
        html,body{
            background-color: #2e3132 !important;
        }
    </style>
</head>
<body >
<div class="wrap" style="position:relative;">
    <script id="infoTemplate" type="text/html" data-url="/ijob/api/AccountController/getRechargeSum" data-type="POST">
        {{each list as user}}
            <div class="content page_pay_code">
                <div class="head">
                    <div class="imgBox">
                        <img class="photoImg" src="/ijob/upload/{{user.attachment |absolutelyPath}}" onerror="this.src='{{user.weixin.headimgurl}}';this.error=null">
                    </div>
                    <div class="infoBox">
                        <p class="nameP">{{user.mainName}}</p>
                        <p class="noteP">
                            工作号：{{user.information.workNumber}}
                        </p>
                    </div>
                </div>
                <div class="codeBox" id="schoolqrcodeimg">

                </div>
                <div class="msgBox">
                    <p id="text">扫一扫，向我转账</p>
                </div>
            </div>
        {{/each}}
    </script>
</div>

<script src="/ijob/static/js/utf.js"></script>
<script src="/ijob/static/js/qrcode.min.js"></script>
<script>

    $("#infoTemplate").loadData({condition:{'isMain':false}}).then(function(result){
        if(result.data.list[0].information.workNumber==null||result.data.list[0].information.workNumber==""||result.data.list[0].information.workNumber==undefined){
            $(".noteP").hide();
        }
        if(ijob.storage.get("zhuanzhang.type")==2){
            var p = "<p>扫一扫，向我转账</p>"
            $(".msgBox").html(p);
        }else{
            var p = "<p>暂无充值金额，请充值</p>\n" +
                "<p>或使用该二维码进行收钱</p>"
            $(".msgBox").html(p);
        }
        //让二维码上下居中
        var pw =  $(".codeBox").height();
        console.log(result.data.list[0].id);
        var width = pw;
        var height = width;
        var qrcode = new QRCode(document.getElementById("schoolqrcodeimg"), {
            text:  "${site}/share/ZZ/"+result.data.list[0].id,
            width: width, //生成的二维码的宽度
            height: height, //生成的二维码的高度
            colorDark : "#000000", // 生成的二维码的深色部分
            colorLight : "#ffffff", //生成二维码的浅色部分
            correctLevel : QRCode.CorrectLevel.H
        });
    });
</script>
</body>
</html>