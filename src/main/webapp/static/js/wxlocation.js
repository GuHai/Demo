var wxlocation = {
    location:function(myloc){
        return new Promise(function(callback){
            var localtion = ijob.location.get()||{};
            if(localtion&&localtion.hasOwnProperty("city")&&localtion.city){
                localtion.reload = false;
            }else{
                localtion = ijob.location.getLocal()||{};
                if(localtion &&localtion.hasOwnProperty("city") && localtion.city){
                    localtion.reload = true;
                    //先把本地的复制到session里面
                    ijob.persistence.set("mylocaltion",localtion);
                }else{
                    if(myloc&&myloc.cityName){
                        ijob.location.set2(myloc);
                        localtion = ijob.location.get()||{};
                    }
                    localtion.reload = true;
                }
            }
            if(localtion.hasOwnProperty("city")){
                callback(localtion);
            }
            if(localtion.reload==true){
                ijob.require("https://res.wx.qq.com/open/js/jweixin-1.2.0.js",function(){
                    $(document).ready(function(){
                        var oldlng =  localStorage.getItem("wx.lng");
                        var oldlat = localStorage.getItem("wx.lat");
                        $.getJSON("/ijob/api/WeixinController/getJSAuthSignature?url="+window.location.href,function(data){
                            wx.config({
                                debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                                appId: data.data.appId, // 必填，公众号的唯一标识
                                timestamp: data.data.timestamp, // 必填，生成签名的时间戳
                                nonceStr: data.data.noncestr, // 必填，生成签名的随机串
                                signature: data.data.signature,// 必填，签名
                                jsApiList: ["getLocation"] // 必填，需要使用的JS接口列表
                            });
                        });
                        wx.ready(function(){
                            wx.getLocation({
                                type: 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
                                success: function (res) {
                                    var lat = res.latitude; // 纬度，浮点数，范围为90 ~ -90
                                    var lng = res.longitude; // 经度，浮点数，范围为180 ~ -180。
                                    var speed = res.speed; // 速度，以米/每秒计
                                    var accuracy = res.accuracy; // 位置精度
                                    var dist =  getDisance(oldlat,oldlng,lat,lng);
                                    if(localtion.hasOwnProperty("city")==false || oldlat==null || dist>100) { //如果大于100米，则需要重新定位
                                        $.getJSON("/ijob/api/MylocaltionController/translate/"+lat+"/"+lng+"/1",function(result){
                                            localStorage.setItem("wx.lng",lng);
                                            localStorage.setItem("wx.lat",lat);
                                            ijob.location.set3(result.data);
                                            callback(ijob.location.get());
                                        });
                                    }
                                }
                            });
                        });
                    });
                });
            }
        });
    }
};


function toRad(d) {  return d * Math.PI / 180; };
function getDisance(lat1, lng1, lat2, lng2) {
    var dis = 0;
    var radLat1 = toRad(lat1);
    var radLat2 = toRad(lat2);
    var deltaLat = radLat1 - radLat2;
    var deltaLng = toRad(lng1) - toRad(lng2);
    var dis = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(deltaLat / 2), 2) + Math.cos(radLat1) * Math.cos(radLat2) * Math.pow(Math.sin(deltaLng / 2), 2)));
    return dis * 6378137;
};
