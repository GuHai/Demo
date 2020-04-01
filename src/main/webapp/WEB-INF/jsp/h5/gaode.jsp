<%--
  Created by IntelliJ IDEA.
  User: zhouchuang
  Date: 2018/5/17
  Time: 22:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>高德定位</title>
    <script src="http://webapi.amap.com/maps?v=1.4.6&key=dfd42cc657511c1daf483e8a46865a16"></script>

</head>
<body>
<span id="localtion">

</span>
<script>

    var map, geolocation;
    //加载地图，调用浏览器定位服务
    map = new AMap.Map('container', {
        resizeEnable: true
    });
    map.plugin('AMap.Geolocation', function() {
        geolocation = new AMap.Geolocation({
            enableHighAccuracy: false,//是否使用高精度定位，默认:true
            timeout: 20000,          //超过10秒后停止定位，默认：无穷大
            buttonOffset: new AMap.Pixel(10, 20),//定位按钮与设置的停靠位置的偏移量，默认：Pixel(10, 20)
            zoomToAccuracy: true,      //定位成功后调整地图视野范围使定位位置及精度范围视野内可见，默认：false
            buttonPosition:'RB'
        });
        geolocation.getCurrentPosition();
        AMap.event.addListener(geolocation, 'complete', function onComplete(data) {
            console.log(data);
            document.getElementById("localtion").innerHTML  =  JSON.stringify(data);
//            regeocoder([data.position.getLng(),data.position.getLat()])
        });//返回定位信息
    });

    function regeocoder(pos) {  //逆地理编码
        var geocoder = new AMap.Geocoder({
            radius: 1000,
            extensions: "all"
        });
        geocoder.getAddress(pos, function(status, result) {
            if (status === 'complete' && result.info === 'OK') {
                console.log(result)
            }
        });
    }


</script>
</body>
</html>
