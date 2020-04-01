<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/6
  Time: 17:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>签到记录</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/My_part-time/signIn_Record.css">
</head>
<body>
<div class="wrap">
    <h1>${title}</h1>
    <div class="sort1">
        <ul class="sort1List">
            <script id="todayJob"   type="text/html"  data-url="/ijob/api/SigninController/findList2List/${positionID}"   >
                {{each list as sign}}
                <li>
                    <div class="workin_top">
                        <span>{{sign.signTime | dateFormat:'yyyy年MM月dd日' }}<em>星期{{sign.signTime | dateFormat:'W'}}</em></span>
                        <span>{{sign.signinType | enums:'SignStatus'}}</span>
                    </div>
                    <div class="workin_but">
                        <p><i class="iconfont icon-fujin"></i><span>{{sign.address.detailedAddress | ifNull :'没有定位地址' }}</span></p>
                        <p>{{sign.signTime | dateFormat:'hh:mm' }}</p>
                    </div>
                </li>
                {{/each}}
            </script>
        </ul>
    </div>
</div>
</body>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>
    $("#todayJob").loadData({
        positionID:"${positionID}"
    });
</script>
</html>
