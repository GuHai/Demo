<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/29
  Time: 14:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"    import="com.yskj.service.base.DictCacheService" %>
<html>
<head>
    <title>返回首页</title>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, viewport-fit=cover">
    <meta http-equiv=”Content-Type” content=”text/html; charset=utf-8” />
    <link rel="stylesheet" href="/ijob/static/css/part/partstyle.css?version=<%=DictCacheService.Version%>">
</head>
<body>
<div class="wrap">
    <div class="home-block-r">
        <a href="javascript:void(0);" class="homepage">
            <span class="iconfont icon-zhuye"></span>
        </a>
    </div>
</div>
</body>
<script>
    $(".homepage:first").click(
        function(){
            if(ijob.storage.get("homepageType")){
                ijob.gotoPage({path:'/ijob/h5/zp/paysalary/salaryIndex'})
            }else{
                window.location.href = "/ijob/indexMain";
            }
        }
    );
    $(document).ready(function () {
        var clientHeight=document.clientHeight||document.documentElement.clientHeight;
        var clientWidth=document.clientWidth||document.documentElement.clientWidth;

        var home;
        $(document).ready(function () {
            home = $(".home-block-r a:first");
        });
        $(".home-block-r").on('touchmove',function(ev){
            ev.preventDefault();
            var _touch = ev.originalEvent.targetTouches[0];
            var _y= _touch.pageY;
            var _x= _touch.pageX;

            $(this).css("right",clientWidth-_x-home.width()*4/3+"px");
            $(this).css("bottom",clientHeight-_y-home.height()/2+"px");

        });
        $(".home-block-r").on('touchend',function(ev){
            var w =$(this).css("right").substring(0,$(this).css("right").length-2);
            var h = $(this).css("bottom").substring(0,$(this).css("bottom").length-2);
            if(w<0){
                $(this).css("right",-home.width()/2+"px");
            }
            if(w>clientWidth-home.width()*2){
                $(this).css("right",clientWidth-home.width()*2+"px");
            }
            if(h<0){
                $(this).css("bottom",home.height()/2+"px");
            }
            if(h>clientHeight-home.width()*4/3){
                $(this).css("bottom",clientHeight-home.height()*4/3+"px");
            }
        });
    });


</script>
</html>
