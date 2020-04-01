<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/25
  Time: 15:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="/ijob/lib/jquery-2.2.3.js"></script>
    <script src="/ijob/static/js/ijob.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>位置选择</title>
    <style>
        * {margin: 0; padding: 0; border: 0;}
        body {
            position: absolute;
            width: 100%;
            height: 100%;
        }
        #geoPage, #markPage {
            position: relative;
        }
    </style>
</head>
<body>

<iframe id="geoPage" width="100%" height="100%" frameborder=0
        src="https://apis.map.qq.com/tools/locpicker?search=1&type=1&key=3U3BZ-5PDWX-HFP4N-Z7GPP-T3LSH-LABHS&referer=ijob">
</iframe>

<script>

    window.addEventListener('message', function(event) {
        // 接收位置信息，用户选择确认位置点后选点组件会触发该事件，回传用户的位置信息
        var loc = event.data;
        if (loc && loc.module == 'locationPicker') {//防止其他应用也会向该页面post信息，需判断module是否为'locationPicker'
            ijob.storage.set("data.latlng.value",loc);
            self.location=document.referrer;
        }
    }, false);
</script>

</body>
</html>
