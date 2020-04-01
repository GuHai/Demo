//引入微信的地图js
/*var newscript = document.createElement('script');
newscript.setAttribute('type','text/javascript');
newscript.setAttribute('charset','utf-8');
newscript.setAttribute('src','http://map.qq.com/api/js?v=2.exp&libraries=convertor');
var head = document.getElementsByTagName('head')[0];
head.appendChild(newscript);*/

var site={
    //获取经纬度
    localtion:{
        latlng:function(){
            //判断是否支持 获取本地位置
            if (navigator.geolocation)
            {
                return  new Promise((function(callback){
                    function Location(position){
                        var lat=position.coords.latitude;
                        var lng=position.coords.longitude;
                        //调用地图命名空间中的转换接口   type的可选值为 1:GPS经纬度，2:搜狗经纬度，3:百度经纬度，4:mapbar经纬度，5:google经纬度，6:搜狗墨卡托
                        qq.maps.convertor.translate(new qq.maps.LatLng(lat,lng), 1, function(res){
                            //取出经纬度并且赋值
                            latlng = res[0];
                            callback(latlng);
                        });
                    }
                    navigator.geolocation.getCurrentPosition(Location);
                }));
            }else{
                mui.toast("浏览器不支持定位");
            }
        },
        position:function(latlng) {
            if(latlng){
                latlng = new qq.maps.LatLng(latlng.lat,latlng.lng);
                return new Promise(function (callback) {
                    var citylocation = new qq.maps.CityService({
                        complete: function (results) {
                            results.detail.detail = results.detail.detail.split(",").reverse().join("");
                            callback(results);
                        }
                    });
                    citylocation.searchCityByLatLng(latlng);
                });
            }else{
                return new Promise(function(callback){
                    site.localtion.latlng().then(function(latlng){
                        citylocation = new qq.maps.CityService({
                            complete: function (results) {
                                results.detail.detail = results.detail.detail.split(",").reverse().join("");
                                callback(results);
                            }
                        });
                        citylocation.searchCityByLatLng(latlng);
                    });
                });
            }
        }
    },
    //打开地图
    map:{
        show:function(panel,zoom){
            zoom  = zoom||13;
            site.localtion.latlng().then(function(latlng){
                var map = new qq.maps.Map(panel,{
                    center:  latlng,
                    zoom: zoom
                });
                //设置marker标记
                var marker = new qq.maps.Marker({
                    map : map,
                    position : latlng
                });
            });
        }
    },
    //获取城市的名称
    city:{
        name:function(latlng){
            return site.localtion.position(latlng).then(function(data){
                return data.detail.name;
            });
        },
        detail:function(latlng){
            return site.localtion.position(latlng).then(function(data){
                return data.detail.detail.split(",").reverse().join("");
            });
        },
        cityID:function(name){
            var cityId = "";
            $.ajax({
                url:"/api/CityController/matching/"+name ,
                type: "GET",
                dataType: 'json',
                async:false,
                success: function(data) {
                    cityId = data.data.id;
                }
            });
            return cityId;
        },
        parent:function(name){
            var parent = {};
            $.ajax({
                url:"/api/CityController/parent/"+name ,
                type: "GET",
                dataType: 'json',
                async:false,
                success: function(data) {
                    parent = data.data;
                }
            });
            return parent;
        },
        childs:function(name){
            var childs = [];
            $.ajax({
                url:"/api/CityController/childs/"+name ,
                type: "GET",
                dataType: 'json',
                async:false,
                success: function(data) {
                    childs = data.data;
                }
            });
            return childs;
        }
    }
}


