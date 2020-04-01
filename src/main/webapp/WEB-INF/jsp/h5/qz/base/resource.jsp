<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/30
  Time: 15:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"  import="com.yskj.service.base.DictCacheService" %>
<html>
<head id="head">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script>
        window.onerror = function(msg,url,l) {
            if(msg.indexOf('ijob')!=-1 || msg.indexOf('template')!=-1  ){
                if(<%=DictCacheService.Site.indexOf("com")!=-1%>)alert(msg);
                window.location.reload();
            }else{
                if(<%=DictCacheService.Site.indexOf("com")!=-1%>)alert(msg);
            }
        }
    </script>

    <script src='/ijob/static/js/dict.js?version=<%=DictCacheService.Version%>'></script>
    <script src='/ijob/static/js/enums.js?version=<%=DictCacheService.Version%>'></script>
    <script type="text/javascript" src="/ijob/lib/jquery-2.2.3.min.js" ></script>
    <script src='/ijob/lib//lib-flexible.js' ></script>
    <script src='/ijob/lib/mui/js/mui.min.js' ></script>
    <script src='/ijob/lib/template.js?version=<%=DictCacheService.Version%>' ></script>
    <script src='/ijob/lib/mui/js/mui.picker.min.js' ></script>
    <script charset="UTF-8"  src='/ijob/static/js/templateUtils.js?version=<%=DictCacheService.Version%>'></script>
    <script charset="UTF-8" src='/ijob/static/js/ijob.js?version=<%=DictCacheService.Version%>'></script>
    <script charset="UTF-8" src='/ijob/static/js/attachment.js?version=<%=DictCacheService.Version%>'></script>
    <script charset='utf-8' src='/ijob/static/js/mobile_data.js?version=<%=DictCacheService.Version%>' ></script>
    <script type='text/javascript' src='/ijob/static/js/pullload.js?version=<%=DictCacheService.Version%>'  charset="UTF-8"></script>
    <script type='text/javascript' src='/ijob/static/js/slide.js?version=<%=DictCacheService.Version%>'  charset="UTF-8"></script>
</head>
<body>
</body>
</html>
