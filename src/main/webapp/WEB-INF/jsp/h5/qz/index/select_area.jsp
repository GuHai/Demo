<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/2/28
  Time: 15:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>地区</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <%--<script src="http://webapi.amap.com/maps?v=1.4.6&key=dfd42cc657511c1daf483e8a46865a16"></script>
    <script src="/ijob/static/js/map2.js"></script>--%>
    <script src="https://res.wx.qq.com/open/js/jweixin-1.2.0.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/ijob/static/css/index/selectarea.css?version=4">
    <style>
        .fix-block-r {
            width: 1.9rem;
            position: fixed;
            z-index: 5;
            right: -0.21rem;
            bottom: 2rem;
        }
        .fix-block-r a {
            display: block;
            width: 1.3rem;
            height: 1.3rem;
            border-radius: 100%;
            border: solid 1px #108ee9;
            background-color: rgba(255, 255, 255, 0.7);
        }
        .fix-block-r a span {
            display: block;
            font-size: 0.8rem;
            text-align: center;
            line-height: 1.3rem;
            color: #108ee9;
        }
    </style>
</head>
<body>
<div class="wrap">
    <div class="mui-content">

        <div id="list" class="mui-indexed-list">
            <div class="mui-indexed-list-search mui-input-row mui-search">
                <i class="mui-icon mui-icon-search"></i>
                <input type="text" id="search" class="mui-input-clear" placeholder="搜索城市名或者拼音" maxlength="20">
            </div>
            <div class="mui-indexed-list-inner">
                <ul class="mui-table-view">
                    <div class="module-indexed-box">
                        <!--定位-->
                        <div class="positioning">
                            <p data-group="定位" class="module-address module-limit-after">
                                当前定位城市
                            </p>
                            <div class="positioning-map">
                                <i class="iconfont icon-jiazaizhong" ></i><span id="currcity" data-id="">定位中</span>
                            </div>
                        </div>
                        <!--最近访问城市-->
                        <div class="recent">
                            <p data-group="最近" class="module-address module-limit-before">
                                最近访问城市
                            </p>
                            <ul class="recent-area clearfix"  id="myCitysPanel" >
                                <script type="text/html" id="myCitys"  data-url="/ijob/api/CityController/getMyCityList"  >
                                    {{each list as mycity}}
                                        <li data-id="{{mycity.city.id}}"  data-lng="{{mycity.city.lng}}"  data-lat="{{mycity.city.lat}}" data-cityname="{{mycity.city.cityName}}" >{{mycity.city.cityName | substr}}</li>
                                    {{/each}}
                                </script>
                            </ul>
                        </div>
                        <!--热门城市-->
                        <div class="hot ">
                            <p data-group="热门" class="module-address">
                                热门城市
                            </p>
                            <ul class="hot-area clearfix"   id="hotCitysPanel" >
                                <script type="text/html" id="hotCitys" data-url="/ijob/api/CityController/findList" data-type="POST">
                                    {{each list as city}}
                                     <li data-id="{{city.id}}" data-lng="{{city.lng}}"  data-lat="{{city.lat}}" data-cityname="{{city.cityName}}" >{{city.cityName | substr}}</li>
                                    {{/each}}
                                </script>
                            </ul>
                        </div>
                    </div>
                    <!--全部城市-->
                    <!--<p data-group="定位" class="module-address">-->
                    <!--全部城市-->
                    <!--</p>-->
                    <div id="refreshContainer">
                        <div class="more_city_box">
                            <p data-group="更多城市" class="module-address">
                                更多城市
                            </p>
                            <ul class="city_list" id="flagList">
                                <a href="javascript:void(0);"  class="">A</a>
                                <a href="javascript:void(0);"  class="">B</a>
                                <a href="javascript:void(0);"  class="">C</a>
                                <a href="javascript:void(0);"  class="">D</a>
                                <a href="javascript:void(0);"  class="">E</a>
                                <a href="javascript:void(0);"  class="">F</a>
                                <a href="javascript:void(0);"  class="">G</a>
                                <a href="javascript:void(0);"  class="">H</a>
                                <a href="javascript:void(0);"  class="">I</a>
                                <a href="javascript:void(0);"  class="">J</a>
                                <a href="javascript:void(0);"  class="">K</a>
                                <a href="javascript:void(0);"  class="">L</a>
                                <a href="javascript:void(0);"  class="">M</a>
                                <a href="javascript:void(0);"  class="">N</a>
                                <a href="javascript:void(0);"  class="">O</a>
                                <a href="javascript:void(0);"  class="">P</a>
                                <a href="javascript:void(0);"  class="">Q</a>
                                <a href="javascript:void(0);"  class="">R</a>
                                <a href="javascript:void(0);"  class="">S</a>
                                <a href="javascript:void(0);"  class="">T</a>
                                <a href="javascript:void(0);"  class="">U</a>
                                <a href="javascript:void(0);"  class="">V</a>
                                <a href="javascript:void(0);"  class="">W</a>
                                <a href="javascript:void(0);"  class="">X</a>
                                <a href="javascript:void(0);"  class="">Y</a>
                                <a href="javascript:void(0);"  class="">Z</a>
                            </ul>
                        </div>
                        <div class="cityListPanel" id="cityListPanel">
                            <ul class="list">
                                <script type="text/html" id="cityList"  data-url="/ijob/api/CityController/findList" >
                                    {{each list as city}}
                                    <li data-id="{{city.id}}"  data-lng="{{city.lng}}"  data-lat="{{city.lat}}" data-cityname="{{city.cityName}}" class="mui-table-view-cell mui-indexed-list-item">{{city.cityName}}</li>
                                    {{/each}}
                                </script>
                            </ul>
                        </div>
                    </div>

                </ul>
            </div>
        </div>
    </div>
</div>
<div class="fix-block-r" style="display:none"  id="upBtn">
    <a href="javascript:void(0);"   class="gotop-btn gotop" id="goTopBtn">
        <span class="mui-icon  mui-icon-arrowup"></span>
    </a>
</div>
</body>
</html>
<jsp:include page="../../qz/base/resource.jsp"/>
<script src="../../../ijob/lib/mui/js/mui.indexedlist.js"></script>

<script>

    var searchnum ;
    $("#search").on('input',function(){
        var keyword  = $("#search").val()||null;
        if(keyword){
            clearTimeout(searchnum);
            searchnum = setTimeout(function(){
                if($("#search").val()){
                    cityParam = {condition:{keyword:$("#search").val()}};
                    $(".module-indexed-box").hide();
                    $("#cityListPanel").show();
                    $(".more_city_box").hide();
                    $("#cityList").loadData(cityParam);
                }
            },1000);
        }else{
            $(".module-indexed-box").show();
            $("#cityListPanel").hide();
            $(".more_city_box").show();
            $("#flagList a").removeClass("current");
        }
    });

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
                    $.getJSON("/ijob/api/MylocaltionController/translate/"+lat+"/"+lng+"/1",function(result){
                        localStorage.setItem("wx.lng",lng);
                        localStorage.setItem("wx.lat",lat);
                        //ijob.location.set3(result.data);
                        init(result.data);
                    });
                }
            });
        });


        function init(loc){

            myloc  = {
                lng:loc.result.location.lng,
                lat:loc.result.location.lat,
                cityID:'',
                cityName:loc.result.address_component.city,
                addr:loc.result.formatted_addresses.recommend,
                districtID:"",
                districtName:loc.result.address_component.district,
                city:loc.result.address_component.city
            };

            $("#currcity").text(template.substr(myloc.city));
            // $("#currcity").data("id",site.region.id(loc.city));
            $("#currcity").prev().removeClass("icon-jiazaizhong").addClass("icon-fujin");
            var curr = 65;
            var loading = true;
            var panel = document.getElementsByClassName("mui-indexed-list-inner")[0];
        }
    });



    $("#hotCitys").loadData({condition:{cityType:2,isHot:1}}).then(function(result){
        $("#myCitys").loadData().then(function(result2){
            $("#flagList").on('click','a',function(){
                $(".module-indexed-box").hide();
                $("#flagList a").removeClass("current");
                $(this).addClass("current");
                $("#cityListPanel").show();
                var flagC = $(this).text();
                curr = flagC.charCodeAt();
                $("#upBtn").css("display","block");
                $("#cityList").loadData({condition:{cityType:2,p:flagC}}).then(function(result){
                    $("#cityFlag").html(flagC);
                    $("#cityFlag").data("group",flagC);
                });
            })

            $("#cityListPanel").on('click','li',function(){
                changeCityHandler($(this));
            });

            $("#myCitysPanel").on('click','li',function(){
                changeCityHandler($(this));
            });

            $("#hotCitysPanel").on('click','li',function(){
                changeCityHandler($(this));
            });

            $("#currcity").on('click',function(){

                $.getJSON("/ijob/api/CityController/add",myloc,function(result){
                    myloc.cityID = result.data.mylocaltion.cityID;
                    myloc.districtID = result.data.mylocaltion.districtID;
                    ijob.location.set2(myloc);
                    ijob.reback();
                });
            });

            $("#upBtn").on('click',function(){
                $(".module-indexed-box").show();
                $("#cityListPanel").hide();
                $(this).css("display","none");
                $("#flagList a").removeClass("current");
            });

            function changeCityHandler(item){

                $("body").before(ijob.mask);
                myloc = {
                    lat:$(item).data("lat"),
                    lng:$(item).data("lng"),
                    cityID:$(item).data("id"),
                    cityName:$(item).data("cityname")
                };
                $.getJSON("/ijob/api/CityController/add",myloc,function(result){
                    myloc.cityID = result.data.mylocaltion.cityID;
                    myloc.districtID = result.data.mylocaltion.districtID;
                    ijob.location.set2(myloc);
                    ijob.reback("切换城市成功！");
                    $("body").prev(".loading").remove();
                });
            }
        });
    });


</script>