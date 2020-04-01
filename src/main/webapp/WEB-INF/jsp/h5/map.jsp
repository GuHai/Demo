<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/22
  Time: 10:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="/ijob/lib/jquery-2.2.3.js"></script>
    <script src="/ijob/static/js/ijob.js"></script>
    <script charset="utf-8" src="http://map.qq.com/ijob/api/js?v=2.exp&libraries=convertor"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>获取地理位置</title>
    <style type="text/css">
        *{
            margin:0px;
            padding:0px;
        }
        body, button, input, select, textarea {
            font: 12px/16px Verdana, Helvetica, Arial, sans-serif;
        }
        #container{
            min-width:600px;
            min-height:767px;
        }
    </style>
    <script charset="utf-8" src="/ijob/static/js/map.js"></script>
    <script>
        function getLocation(){
            //判断是否支持 获取本地位置
            if (navigator.geolocation)
            {
                navigator.geolocation.getCurrentPosition(showPosition);
            }
            else{x.innerHTML="浏览器不支持定位.";}
        }
        function showPosition(position)
        {
            var lat=position.coords.latitude;
            var lng=position.coords.longitude;
//调用地图命名空间中的转换接口   type的可选值为 1:GPS经纬度，2:搜狗经纬度，3:百度经纬度，4:mapbar经纬度，5:google经纬度，6:搜狗墨卡托
            qq.maps.convertor.translate(new qq.maps.LatLng(lat,lng), 1, function(res){
                //取出经纬度并且赋值
                latlng = res[0];
                var markersArray = [];
                var map = new qq.maps.Map(document.getElementById("container"),{
                    center:  latlng,
                    zoom: 13
                });
                //设置marker标记
                var marker = new qq.maps.Marker({
                    map : map,
                    position : latlng
                });
                markersArray.push(marker);

                //添加dom监听事件
                qq.maps.event.addDomListener(map, 'click', function(event) {
                    addMarker(event.latLng);
                });

                //添加标记
                function addMarker(location) {
                    if (markersArray) {
                        for (i in markersArray) {
                            markersArray[i].setMap(null);
                        }
                    }
                    var marker = new qq.maps.Marker({
                        position: location,
                        map: map
                    });

                    ijob.storage.set("data.latlng.value",location);
                    markersArray.push(marker);
                }
            });
        }

        var map,marker = null;

        var init = function() {


           var data = ijob.storage.data();
           if(data && data.data && data.data.localtion&&data.data.localtion.lng){
               var lng = data.data.localtion.lng;
               var lat = data.data.localtion.lat;
               var center = new qq.maps.LatLng(lat,lng);
               map = new qq.maps.Map(document.getElementById('container'),{
                   center: center,
                   zoom: 13
               });
               //设置marker标记
               marker = new qq.maps.Marker({
                   map: map,
                   position: center
               });

           }else{
               getLocation();
           }
       }
    </script>
</head>

<body onload="init()">
<div id="container"></div>
</body>
<script>
</script>
</html>
