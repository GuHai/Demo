<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/13
  Time: 11:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>正在跳转...</title>
    <jsp:include page="../h5/qz/base/link.jsp"/>
    <jsp:include page="../h5/qz/base/resource.jsp"/>
    <script src="https://res.wx.qq.com/open/js/jweixin-1.2.0.js" type="text/javascript"></script>
    <script src="/ijob/static/js/wxlocation.js"></script>
    <script src="/ijob/static/js/ijobbase.js"></script>
</head>
<body>

</body>
<script>
    var myloc = {
        lng:"${mylocaltion.lng}",
        lat:"${mylocaltion.lat}",
        cityID:"${mylocaltion.cityID}",
        cityName:"${mylocaltion.cityName}",
        addr:"${mylocaltion.addr}",
        districtID:"${mylocaltion.districtID}",
        districtName:"${mylocaltion.districtName}"
    };
    $(document).ready(function(){
        wxlocation.location(myloc).then(function(local){
            ijob.gotoPage({url:'/ijob/api/InformationController/h5/mine/examineUserInfo/'+local.lng+'/'+local.lat+'/${id}'})
        })
    });
</script>
</html>
