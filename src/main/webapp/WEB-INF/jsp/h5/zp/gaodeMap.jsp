<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/15
  Time: 17:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <title>设置地图显示内容</title>
    <link rel="stylesheet" href="http://cache.amap.com/lbs/ijob/static/main1119.css"/>
    <script type="text/javascript"
            src="http://webapi.amap.com/maps?v=1.4.5&key=8fd6ba6786943444555c2d2d3d44dc7a&plugin=AMap.CitySearch"></script>
    <script type="text/javascript" src="http://cache.amap.com/lbs/ijob/static/addToolbar.js"></script>
</head>
<body>
<div>
    <input type="button" value="选择地址" onclick="initGaoDeMap">
</div>
<div id="container" class="map"></div>
<div class='button-group' style="background-color: #0d9bf2;right: 40%">
    <input type="button" onclick="alert(marker.getPosition())" value="坐标值">
    <%--<input type='checkbox' onclick='refresh()' checked name='bg'>背景
    <input type='checkbox' onclick='refresh()' checked name='road'>道路
    <input type='checkbox' onclick='refresh()' checked name='building'>建筑物
    <input type='checkbox' onclick='refresh()' checked name='point'>标注--%>
</div>
<div id="tip"></div>
<script type="text/javascript">
    var map = new AMap.Map('container', {
        resizeEnable: true,
        zoom: 17,
        center: [112.977951, 28.209487]
    });
    var marker = new AMap.Marker({
        position: map.getCenter(),
        draggable: true,
        cursor: 'move',
        raiseOnDrag: true
    });
    marker.setMap(map);
    // 设置点标记的动画效果，此处为无效果
    marker.setAnimation('AMAP_ANIMATION_NONE');
    //设置地图显示的东西
    /*function refresh() {
        var boxes = document.getElementsByTagName('input');
        var features = [];
        for (var i = 0; i < boxes.length; i += 1) {
            if (boxes[i].checked === true) {
                features.push(boxes[i].name);
            }
        }
        map.setFeatures(features);
    }*/
    map.setFeatures(["bg","road","building","point"]);
    map.setMapStyle('amap://styles/6eac5cdf97c77908297ae42fb18dd73d');
   /* //获取用户所在城市信息
    function showCityInfo() {
        //实例化城市查询类
        var citysearch = new AMap.CitySearch();
        //自动获取用户IP，返回当前城市
        citysearch.getLocalCity(function(status, result) {
            if (status === 'complete' && result.info === 'OK') {
                if (result && result.city && result.bounds) {
                    /!*var cityinfo = result.city;
                    var citybounds = result.bounds;
                    document.getElementById('tip').innerHTML = '您当前所在城市：'+cityinfo;
                    //地图显示当前城市
                    map.setBounds(citybounds);*!/
                }
            } else {
                document.getElementById('tip').innerHTML = result.info;
            }
        });
    }*/
</script>
</body>
</html>

