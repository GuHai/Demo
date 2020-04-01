<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/1/8
  Time: 15:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title> 保险套餐</title>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/insurance/insurance.css?version=4">
</head>
<body>
<div class="insurance-index">
    <div class="index-hd">
        <div class="list-box">
            <ul>
                <li onclick="ijob.gotoPage({path:'/h5/zp/insurance/insured_details'})">
                    <div class="img">
                        <img src="/ijob/static/images/insurance.png"/>
                    </div>
                    <div class="txt">
                        <div class="title">
                            <span class="tit">分时工伤</span>
                            <span class="money">58元/月</span>
                        </div>
                        <div class="tips">
                            <span>最高保额80万元</span>
                            <a href="javascript:void(0);" class="details">查看详情</a>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <div class="foot-flex">
        <a href="javascript:void(0);" class="record" onclick="ijob.gotoPage({path:'/h5/zp/insurance/insured_record'})">参保记录</a>
    </div>
</div>
</body>
</html>
