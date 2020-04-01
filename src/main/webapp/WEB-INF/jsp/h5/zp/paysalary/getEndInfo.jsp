<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/31
  Time: 18:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.yskj.utils.DateUtils,com.yskj.utils.IJobUtils" %>
<html>
<head>
    <title>扫码已结算</title>
    <%--<jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>--%>
    <link rel="stylesheet" href="/ijob/static/css/My_part-time/My_part-time_job.css">
</head>
<body>
<div class="wrap">
    <div class="scan_list_box">
        <div class="main">
            <ul class="scan_list">
                <script id="scanYJSTemplate" type="text/html" data-url="/ijob/api/ApplySettlementController/findScanYJSList" data-type="POST">
                    {{each list as posi}}
                    <li>
                        <div class="title">{{posi.title}}</div>
                        <div class="time">
                            <span class="hour">{{posi.updateTime |dateFormat:'yyyy-MM-dd hh:mm'}}</span>
                            <span class="money">{{posi.salary |money}}元</span>
                        </div>
                    </li>
                    {{/each}}
                </script>
            </ul>
        </div>
    </div>
</div>
</body>
<script>
    $("#scanYJSTemplate").loadData().then(function (result) {
        console.log(result);
    });
</script>
</html>
