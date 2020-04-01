<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/29
  Time: 14:25
  To change this template use File | Settings | File Templates.
--%>
<html>
<%@ page contentType="text/html;charset=UTF-8" language="java"  import="com.yskj.service.base.DictCacheService" %>
<head>
    <title>求职者</title>
    <jsp:include page="../qz/base/link.jsp"/>
    <jsp:include page="../qz/base/resource.jsp"/>
    <script src="https://res.wx.qq.com/open/js/jweixin-1.2.0.js" type="text/javascript"></script>
    <script src="/ijob/static/js/wxlocation.js?version=2"></script>
    <script src="/ijob/static/js/ijobbase.js?version=<%=DictCacheService.Version%>"></script>
    <style>
        .selected{
            color:#108ee9!important;
        }
        .unselected{
            color:#8f8f94;
        }

    </style>
</head>
<body>
<div class="wrap">
    <div id="mainPage"></div>
    <jsp:include page="../qz/base/foot.jsp"/>
</div>
</body>

<script>
    // ijob.gotoPage({path:'/h5/perfect_inform'});
    //判断需不需要清理版本
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
   /* if(ijob.storage.get("remenber")!='null'&&"${menu}"!="findJob:1"&&menu.indexOf("information")==-1&&menu.indexOf("personal")==-1){
        if(menu.split(":")[1]!=ijob.storage.get("remenber")){
            menu = menu.split(":")[0]+":"+ijob.storage.get("remenber");
        }
    }*/
    var myloc = {
        lng:"${mylocaltion.lng}",
        lat:"${mylocaltion.lat}",
        cityID:"${mylocaltion.cityID}",
        cityName:"${mylocaltion.cityName}",
        addr:"${mylocaltion.addr}",
        districtID:"${mylocaltion.districtID}",
        districtName:"${mylocaltion.districtName}"
    };
    if(window.location.href.indexOf("localhost")!=-1 && myloc.cityName){ //测试环境
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


    var lastPage = {};
    function loadPage (param,callback){
        lastPage = param;
        $('#mainPage').loadPage(param,callback);
    }

    $(".foot").on('click','a',function(e){
        $(window).unbind();
        e.preventDefault();
        var _this  = $(this);
        //如果切换别的，记录，否则会丢失精度
        ijob.menu.set(menu = _this.data("menu"));
        if(_this.data("menu")!="findJob"){ //如果切换别的，记录锚点
            try{
                remarkAnchors();
            }catch (err){

            }
        }
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


    function clickHandler() {
        document.title = "求职者";
        hasClick = true;
        if(menu){
            if(menu.indexOf("findJob")>-1){
                $(".foot").find("a").eq(0).trigger('click');
            }else if(menu.indexOf("information")>-1){
                $(".foot").find("a").eq(1).trigger('click');
            }else if(menu.indexOf("personal")>-1){
                $(".foot").find("a").eq(2).trigger('click');
            }else{
                $(".foot").find("a").eq(0).trigger('click');
            }
        }else{
            $(".foot a:first").trigger('click');
        }
        ijobbase.checkSubscribe();
        ijobbase.checkAndToPay();
    }


    $(document).ready(function(){
        document.title = "获取地理位置中...";
        wxlocation.location(myloc).then(function(local){
            clickHandler();
        })
    });
    window.history.replaceState('','', "forward?path=/h5/qz/index");
</script>
</html>