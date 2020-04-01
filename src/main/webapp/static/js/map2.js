
var demo = {   "module":"geolocation",
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
var site={
    data:{
        nation:'',
        province:'',
        city:'',
        district:'',
        adcode:'',
        addr:'',
        lat:'',
        lng:''
    },
    localtion:function(){
        site.data = {};
        return new Promise(function(callback){
           /* var geolocation = new qq.maps.Geolocation("OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77", "myapp");
            geolocation.getLocation(function(position){
                site.data = $.extend(site.data,position);
                callback(position);
            }, null,null);*/


            $("body").append("<iframe id=\"geoPage\" width=0 height=0 frameborder=0  style=\"display:none;\" scrolling=\"no\"\n" +
                "        src=\"https://apis.map.qq.com/tools/geolocation?key=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77&referer=myapp\">\n" +
                "</iframe>");
            window.addEventListener('message', function(event) {
                // 接收位置信息
                var loc = event.data;
                if(loc){
                    site.data = $.extend(site.data,loc);
                    callback(loc);
                    $("body").find("iframe").remove();
                    window.removeEventListener('message',function(){},false);
                }
            }, false);

               /* var map = new AMap.Map('iCenter');
                var geolocation = null;
                // var geocoder = null

               /!* // 加载地理位置编码插件
                AMap.service('AMap.Geocoder', function() { //回调函数
                    //实例化Geocoder
                    geocoder = new AMap.Geocoder({
                        city: "010" //城市，默认：“全国”
                    });
                    //TODO: 使用geocoder 对象完成相关功能
                });*!/
                // 加载定位插件
                map.plugin('AMap.Geolocation', function() {
                    // 初始化定位插件
                    geolocation = new AMap.Geolocation({
                        enableHighAccuracy: true, //是否使用高精度定位，默认:true
                        timeout: 10000, //超过10秒后停止定位，默认：无穷大
                        maximumAge: 0, //定位结果缓存0毫秒，默认：0
                        convert: true, //自动偏移坐标，偏移后的坐标为高德坐标，默认：true
                        showButton: true, //显示定位按钮，默认：true
                        buttonPosition: 'LB', //定位按钮停靠位置，默认：'LB'，左下角
                        buttonOffset: new AMap.Pixel(10, 20), //定位按钮与设置的停靠位置的偏移量，默认：Pixel(10, 20)
                        showMarker: false, //定位成功后在定位到的位置显示点标记，默认：true
                        showCircle: false, //定位成功后用圆圈表示定位精度范围，默认：true
                        panToLocation: true, //定位成功后将定位到的位置作为地图中心点，默认：true
                        zoomToAccuracy: true //定位成功后调整地图视野范围使定位位置及精度范围视野内可见，默认：false
                    });
                    // 把定位插件加入地图实例
                    map.addControl(geolocation);

                    // 添加地图全局定位事件
                    AMap.event.addListener(geolocation, 'complete', onComplete); //返回定位信息
                    AMap.event.addListener(geolocation, 'error', onError); //返回定位出错信息

                    // 调用定位
                    geolocation.getCurrentPosition();

                    function onComplete(data){
                        var loc = {
                            lng:data.position.lng-0.0065,
                            lat:data.position.lat-0.0060,
                            addr:data.formattedAddress,
                            city:data.addressComponent.city,
                            district:data.addressComponent.district
                        };
                        callback(loc);
                    }
                    function onError(data){
                        var str = '定位失败,';
                        str += '错误信息：'
                        switch(data.info) {
                            case 'PERMISSION_DENIED':
                                str += '浏览器阻止了定位操作';
                                break;
                            case 'POSITION_UNAVAILBLE':
                                str += '无法获得当前位置';
                                break;
                            case 'TIMEOUT':
                                str += '定位超时';
                                break;
                            default:
                                str += '未知错误';
                                break;
                        }
                        alert(str)
                    }
                });*/


           /* var map, geolocation;
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
                    var loc = {
                        lng:data.position.lng-0.0065,
                        lat:data.position.lat-0.0060,
                        addr:data.formattedAddress,
                        city:data.addressComponent.city,
                        district:data.addressComponent.district
                    };
                    callback(loc);
                });//返回定位信息
            });*/

        });
    },
    region:{
        id:function(name){
            var cityId = "";
            $.ajax({
                url:"/ijob/api/CityController/matching/"+name ,
                type: "GET",
                dataType: 'json',
                async:false,
                success: function(data) {
                    cityId = data.data.id;
                }
            });
            return cityId;
        },
        parse:function (addr,name,callback){
            $.ajax({
                url:"/ijob/api/CityController/matching/"+addr ,
                type: "GET",
                dataType: 'json',
                async:false,
                success: function(data) {
                    if(data.data==null){
                        $.ajax({
                            url:"/ijob/api/CityController/matching/"+encodeURI(encodeURI(name)) ,
                            type: "GET",
                            dataType: 'json',
                            async:false,
                            success: function(data) {
                                callback(data.data);
                            }
                        });
                    }else{
                        callback(data.data);
                    }
                }
            });
        },
        parent:function(name){
            var parent = {};
            $.ajax({
                url:"/ijob/api/CityController/parent/"+name ,
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
                url:"/ijob/api/CityController/childs/"+name ,
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