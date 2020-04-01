<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>身份切换</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <script src="https://res.wx.qq.com/open/js/jweixin-1.2.0.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/ijob/static/css/mine/switchIdentity_personal.css">

</head>
<body>
<div class="wrap">
    <header class="head">
        <script  type="text/html" id="jobtemplate"  data-url="/ijob/api/InformationController/h5/mine/loadInformation" data-type="GET">
            {{each list as info}}
            <div class="pic_logo">
                <input type="hidden" id="identityType" value="{{info.identityType}}">
                <input type="hidden" id="id" value="{{info.id}}">
                <input type="hidden" id="version" value="{{info.version}}">
                <img id="identityTypeImg" src="{{info.identityType | enums:'identityTypeImg'}}" alt="">
            </div>
            <h1 id="text" class="title">您当前的身份是{{info.identityType | enums:'identityType'}}</h1>
            <div class="btnBox">
                <input data-type="{{info.identityType}}" data-url="/ijob/api/InformationController/update" type="button" value="切换为{{info.identityType  | enums:'identityTypeChange'}}" class="btnCutover">
                <input type="button" id="back" onclick="back()" value="返回" class="btnBalck">
            </div>
            {{/each}}
        </script>
    </header>
</div>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>

    var result = $("#jobtemplate").loadData().then(function(data){

        $.getJSON("/ijob/api/WeixinController/getJSAuthSignature?url="+window.location.href,function(data){
            wx.config({
                debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                appId: data.data.appId, // 必填，公众号的唯一标识
                timestamp: data.data.timestamp, // 必填，生成签名的时间戳
                nonceStr: data.data.noncestr, // 必填，生成签名的随机串
                signature: data.data.signature,// 必填，签名
                jsApiList: ["closeWindow"] // 必填，需要使用的JS接口列表
            });
        });
        wx.ready(function(){

        });

        $(".btnCutover").click(function(){
            var _this = $(this);
            var obj = {
                "id":$("#id").val(),
                "identityType":(_this.data("type")=='1'?2:1),
                "version":$("#version").val()
            };
            _this.btPost(obj,function(){

               /* ijob.storage.set("indexPage",obj.identityType);
                // ijob.gotoPage({url:"/indexMain"});
                ijob.gotoIndex();*/
                <%--window.location.href = 'http://${site}';--%>
              /*  wx.closeWindow();
                window.location.href = 'http://${site}';*/
                mui.toast("切换身份后需要请重新进入平台");
                setTimeout(function(){
                    wx.closeWindow();
                },1000);
            });
        });
    });

    function back() {
       ijob.gotoPage({url:"/ijob/indexMain"});
    }

</script>
</body>
</html>