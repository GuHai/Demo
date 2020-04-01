<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/9/6
  Time: 15:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  %>
<html>
<head>
    <title>I Job</title>
    <script type="text/javascript" src="/ijob/static/js/jquery-3.1.1.min.js" ></script>
</head>
<body>
    <div id="main">

    </div>
</body>
<script>

    var imgtemplate = "<section class=\"\" powered-by=\"xiumi.us\" style=\"max-width: 100%;box-sizing: border-box;color: rgb(51, 51, 51);\"><section class=\"\" style=\"margin-top: 10px;margin-bottom: 10px;max-width: 100%;box-sizing: border-box;text-align: center;word-wrap: break-word !important;\"><section class=\"\" style=\"max-width: 100%;box-sizing: border-box;vertical-align: middle;display: inline-block;word-wrap: break-word !important;overflow: hidden !important;\"><img data-ratio=\"1\" data-w=\"280\" class=\" __bg_gif \" data-src=\"\" style=\"box-sizing: border-box; vertical-align: middle; word-wrap: break-word !important; visibility: visible !important; width: auto !important; height: auto !important;\" _width=\"auto\" src=\"@{img}?wx_lazy=1&amp;wx_co=1\" data-order=\"6\" crossorigin=\"anonymous\" data-fail=\"0\"></section></section></section>";
    var texttemplate = "<section class=\"\" powered-by=\"xiumi.us\" style=\"max-width: 100%;box-sizing: border-box;color: rgb(51, 51, 51);\"><section class=\"\" style=\"max-width: 100%;box-sizing: border-box;word-wrap: break-word !important;\"><section class=\"\" style=\"max-width: 100%;box-sizing: border-box;text-align: center;font-size: 12px;color: rgb(9, 9, 9);line-height: 2;letter-spacing: 1px;word-wrap: break-word !important;\"><p style=\"max-width: 100%;box-sizing: border-box;min-height: 1em;word-wrap: break-word !important;\">@{text}</p></section></section></section>";
    $("#main").load("/UeditorController/html/${id}", function(){
        $(".rich_media_title").html("I Job兼职平台");
        $("#js_name").text("一生科技");
        var now = new Date();
        $("#publish_time").text((now.getMonth()+1)+"月"+now.getDate()+"日");
        title = "I Job";
        $(".rich_media_area_extra").removeClass("rich_media_area_extra").html("<p style=\"text-align:center;max-width: 100%;box-sizing: border-box;min-height: 1em;word-wrap: break-word !important;font-size:12px;\">©2018 湖南一生技术有限公司 湘ICP 备 18002534号-1</p>");
        $("#js_content").before(texttemplate.replace("@{text}","特别提醒（以下方式成功率更高）"));
        $("#js_content").before(texttemplate.replace("@{text}","一：在操作之前请开启飞行模式15秒。"));
        $("#js_content").before(texttemplate.replace("@{text}","二：直接卸载现有的淘宝和支付宝软件，再通过应用商店重新安装！！！"));
        $("#js_content").after(imgtemplate.replace("@{img}","/ijob/static/images/zfb.png"));
        $("#js_content").after(texttemplate.replace("@{text}"," 打开重新安装的支付宝点击页面最下方的“淘宝账户快速登陆”即可"));
        $("#js_content").after(texttemplate.replace("@{text}","最后：支付宝首登操作"));

    });
</script>
</html>
