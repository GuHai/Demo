<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/6
  Time: 10:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  import="com.yskj.service.base.DictCacheService" %>
<html>
<head>
    <title>招聘者</title>
    <jsp:include page="../zp/base/resource.jsp"/>
   <%-- <script src="http://webapi.amap.com/maps?v=1.4.6&key=dfd42cc657511c1daf483e8a46865a16"></script>
    <script src="/ijob/static/js/map2.js"></script>--%>
    <script src="https://res.wx.qq.com/open/js/jweixin-1.2.0.js" type="text/javascript"></script>
    <script src="/ijob/static/js/wxlocation.js?version=1"></script>
    <script src="/ijob/static/js/ijobbase.js?version=<%=DictCacheService.Version%>"></script>
    <style>
        .wrap .head .head-fixe .head-find > a .mui-placeholder{display:none;}
        .wrap .head .head-fixe .head-find > a > input[type=search]{opacity:1;background-color: rgba(255,255,255,.2);padding:0.267rem;}
        .h-sousuo{position:absolute;top:2px;left:5px;color:#fff;}
        .selected{color: #108ee9!important;}
    </style>
</head>
<body>
<div class="wrap rx_wrap">
    <div id="mainPage"></div>
    <jsp:include page="../zp/base/foot.jsp"/>
</div>
</body>
<script type="text/javascript">
    /*ijob.gotoPage({path:'/h5/perfect_inform'});*/
    var version  = "<%=DictCacheService.Version%>";
    ijob.database.clear("html",version);
    $(function () {
        var isPageHide = false;
        window.addEventListener('pageshow', function () {
            if (isPageHide) {
                window.location.reload();
            }
        });
        window.addEventListener('pagehide', function () {
            isPageHide = true;
        });
    });
    var menu  =  ijob.menu.parse("${menu}");
    var myloc = {
        lng:"${mylocaltion.lng}",
        lat:"${mylocaltion.lat}",
        cityID:"${mylocaltion.cityID}",
        cityName:"${mylocaltion.cityName}",
        addr:"${mylocaltion.addr}",
        districtID:"${mylocaltion.districtID}",
        districtName:"${mylocaltion.districtName}"
    }

    if(window.location.href.indexOf("localhost")!=-1&& myloc.cityName){ //测试环境
        ijob.location.set2(myloc);
    }

    // 从sessionStorage删除所有保存的数据 除了定位的数据
    ijob.storage.clear();
    var _main = $("#mainPage");
    var _current;
    function tgClass(temp){
        if(temp){
            temp.find("span").toggleClass("selected");
            temp.find("p").toggleClass("selected");
        }
    }
    $(".foot").on('click','a',function(e){
        e.preventDefault();
        var _this  = $(this);
        ijob.menu.set(menu = _this.data("menu"));
        if(_this.attr("href")){
            _main.loadPage({path:_this.attr("href")});
        }else {
            _main.loadPage({url:_this.attr("url")});
        }
        tgClass( _current);
        tgClass( _this);
        _current =  _this;

        var icon = $(this).find("span").data("icon");
        if(icon.indexOf("1")>0){
            $(this).find("span").removeClass(icon+"1").addClass(icon);
        }else{
            $(this).find("span").removeClass(icon).addClass(icon+"1");
        }
        changeIcon($(this));
    });

    function changeIcon(div){
        div.siblings().each(function(i,item){
            var icon = $(this).find("span").data("icon");
            $(this).find("span").removeClass(icon+"1").addClass(icon);
        });
    }

    var lastPage = {};
    loadPage=function(param,callback){
        lastPage = param;
        $('#mainPage').loadPage(param,callback);
    }

    function clickHandler(){
        document.title = "招聘者";
        if(menu){
            if(menu.indexOf("findJob")>-1){
                $(".foot").find("a").eq(0).trigger('click');
            }else if(menu.indexOf("myjob")>-1){
                $(".foot").find("a").eq(1).trigger('click');
            }else if(menu.indexOf("information")>-1){
                $(".foot").find("a").eq(2).trigger('click');
            }else if(menu.indexOf("personal")>-1){
                $(".foot").find("a").eq(3).trigger('click');
            }else{
                $(".foot").find("a").eq(0).trigger('click');
            }
        }else{
            $(".foot a:first").trigger('click');
        }
        ijobbase.checkSubscribe();
        ijobbase.checkAndToPay();
    };

    $(document).ready(function(){
        document.title = "获取地理位置中...";
        wxlocation.location(myloc).then(function(local){
            clickHandler();
        })
    });
    window.history.replaceState('','', "forward?path=/h5/zp/index");
</script>
</html>
