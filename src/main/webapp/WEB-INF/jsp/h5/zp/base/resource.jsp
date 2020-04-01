<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/30
  Time: 15:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"   pageEncoding="UTF-8"  language="java"    import="com.yskj.service.base.DictCacheService" %>
<html>
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, viewport-fit=cover">
    <meta http-equiv=”Content-Type” content=”text/html; charset=utf-8” />
    <script>
        window.onerror = function(msg,url,l) {
            if(msg.indexOf('ijob')!=-1 || msg.indexOf('template')!=-1  ){
                window.location.reload();
            }else{
                if(<%=DictCacheService.Site.indexOf("com")!=-1%>)alert(msg);
            }
        }
    </script>
    <%--<link rel="stylesheet" href="/ijob/lib/mui/fonts/mui.ttf">--%>
    <script src='/ijob/static/js/dict.js?version=<%=DictCacheService.Version%>'></script>
    <script src="/ijob/static/js/enums.js?version=<%=DictCacheService.Version%>" charset="UTF-8"></script>
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css?version=<%=DictCacheService.Version%>">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css?version=<%=DictCacheService.Version%>">
    <link rel="stylesheet" href="/ijob/static/css/base.css?version=<%=DictCacheService.Version%>">
    <link rel="stylesheet" href="/ijob/static/css/data.css?version=<%=DictCacheService.Version%>">
    <link rel="stylesheet" href="/ijob/static/css/part/partstyle.css?version=<%=DictCacheService.Version%>">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.indexedlist.css?version=<%=DictCacheService.Version%>">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.picker.min.css?version=<%=DictCacheService.Version%>">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.poppicker.css?version=<%=DictCacheService.Version%>">


    <script src="/ijob/lib/jquery-2.2.3.min.js?version=<%=DictCacheService.Version%>"  charset="UTF-8"></script>
    <script src="/ijob/lib/mui/js/mui.min.js?version=<%=DictCacheService.Version%>" charset="UTF-8"></script>
    <script src="/ijob/lib//lib-flexible.js?version=<%=DictCacheService.Version%>" charset="UTF-8"></script>
    <script src="/ijob/lib/template.js?version=<%=DictCacheService.Version%>" charset="UTF-8"></script>
    <script src="/ijob/static/js/templateUtils.js?version=<%=DictCacheService.Version%>" charset="UTF-8"></script>
    <script src="/ijob/static/js/ijob.js?version=<%=DictCacheService.Version%>"  charset="UTF-8"></script>
    <script src="/ijob/static/js/mobile_data.js?version=<%=DictCacheService.Version%>" charset="UTF-8"></script>

<%--
    <script src="https://apis.map.qq.com/tools/geolocation/min?key=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77&referer=myapp"></script>
--%>
    <%--<script charset=\"utf-8\" src="http://map.qq.com/ijob/api/js?v=2.exp&libraries=convertor"></script>--%>
   <%-- <script src="http://webapi.amap.com/maps?v=1.4.6&key=dfd42cc657511c1daf483e8a46865a16"></script>
    <script src="/ijob/static/js/map2.js"></script>--%>


    <script src="/ijob/lib/zpz/dateRange.js?version=<%=DictCacheService.Version%>" charset="UTF-8"></script>
    <script src="/ijob/lib/zpz/iscroll.js?version=<%=DictCacheService.Version%>" charset="UTF-8"></script>
    <script src="/ijob/lib/zpz/jquery.range.js?version=<%=DictCacheService.Version%>" charset="UTF-8"></script>
    <script src="/ijob/lib/zpz/jquery.touchSwipe.min.js?version=<%=DictCacheService.Version%>" charset="UTF-8"></script>
    <script src="/ijob/lib/zpz/navbarscroll.js?version=<%=DictCacheService.Version%>" charset="UTF-8"></script>
    <script src="/ijob/lib/zpz/selectarea.js?version=<%=DictCacheService.Version%>" charset="UTF-8"></script>
    <script src="/ijob/lib/mui/js/mui.picker.min.js?version=<%=DictCacheService.Version%>" charset="UTF-8"></script>
    <script src="/ijob/lib/mui/js/mui.poppicker.js?version=<%=DictCacheService.Version%>" charset="UTF-8"></script>
    <script type="text/javascript" src="/ijob/static/js/pullload.js?version=<%=DictCacheService.Version%>" charset="UTF-8"></script>
    <script type="text/javascript" src="/ijob/static/js/slide.js?version=<%=DictCacheService.Version%>" charset="UTF-8"></script>
</head>
<body>

</body>
</html>
