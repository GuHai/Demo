<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/26
  Time: 15:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="/ijob/lib/jquery-2.2.3.js"></script>
    <script src="/ijob/static/js/ijob.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>我的位置定位</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no">
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
<iframe id="geoPage"  width="100%" height="30%" frameborder=0 scrolling="no"
        src="https://apis.map.qq.com/tools/geolocation?key=3U3BZ-5PDWX-HFP4N-Z7GPP-T3LSH-LABHS&referer=ijob">
</iframe>
<script>


   var dome =  {   "module":"geolocation",
        "nation": "中国",
        "province": "广州省",
        "city":"深圳市",
        "district":"南山区",
        "adcode":"440305", //行政区ID，六位数字, 前两位是省，中间是市，后面两位是区，比如深圳市ID为440300
        "addr":"深圳大学杜鹃山(白石路北250米)",
        "lat":22.530001, //火星坐标(gcj02)，腾讯、Google、高德通用
        "lng":113.935364,
        "accuracy":13 //误差范围，以米为单位
    }


    window.addEventListener('message', function(event) {
        // 接收位置信息
        var loc = event.data;
        if(loc  && loc.module == 'geolocation') { //定位成功,防止其他应用也会向该页面post信息，需判断module是否为'geolocation'
            var markUrl = 'https://apis.map.qq.com/tools/poimarker' +
                '?marker=coord:' + loc.lat + ',' + loc.lng +
                ';title:我的位置;addr:' + (loc.addr || loc.city) +
                '&key=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77&referer=myapp';
            //给位置展示组件赋值
            document.getElementById('markPage').src = markUrl;
            ijob.storage.set("data.latlng.value",loc);
        }
    }, false);
    // self.location=document.referrer;
</script>
<iframe id="markPage" width="100%" height="70%" frameborder=0 scrolling="no" src=""></iframe>

</body>
</html>
