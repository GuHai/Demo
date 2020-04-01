<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>红包</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/salaryCard.css">
</head>
<body>
<div class="wrap">
    <div class="page_envelopes_content">
        <div class="main">
            <script type="text/html" id="findListByUserIdPage"
                    data-url="/ijob/api/RedPacketReceiveController/findListByUserIdPage" data-type="GET">
                <ul class="list">
                    {{each list as info}}
                    <li>
                        <div class="box">
                            <div class="money"><em>&yen;</em><span class="num">{{info.oneOfMoney}}</span></div>
                            <div class="inform">
                                <div class="portrait">
                                    <img src="{{info.forward.user.infoHeadImg}}"/>
                                </div>
                                <div class="namebox">
                                    <div class="per_name">{{info.forward.user.nickName}}的红包</div>
                                    <div class="pro_name">{{info.forward.position.title}}</div>
                                </div>
                            </div>
                        </div>
                        <div class="tips">该红包已存入工资卡余额</div>
                    </li>
                    {{/each}}
                </ul>
            </script>
            <%--<li>--%>
            <%--<div class="box">--%>
            <%--<div class="money"><em>&yen;</em><span class="num">10</span></div>--%>
            <%--<div class="inform">--%>
            <%--<div class="portrait">--%>
            <%--<img src="/ijob/static/images/default.jpg"/>--%>
            <%--</div>--%>
            <%--<div class="namebox">--%>
            <%--<div class="per_name">Amin的红包</div>--%>
            <%--<div class="pro_name">公司7月诚聘传单派发学生可兼职</div>--%>
            <%--</div>--%>
            <%--</div>--%>
            <%--</div>--%>
            <%--<div class="tips">该红包已存入工资卡余额</div>--%>
            <%--</li>--%>
            <%--<li>--%>
            <%--<div class="box">--%>
            <%--<div class="money"><em>&yen;</em><span class="num">3</span></div>--%>
            <%--<div class="inform">--%>
            <%--<div class="portrait">--%>
            <%--<img src="/ijob/static/images/default.jpg"/>--%>
            <%--</div>--%>
            <%--<div class="namebox">--%>
            <%--<div class="per_name">Amin的红包</div>--%>
            <%--<div class="pro_name">急招模特兼职</div>--%>
            <%--</div>--%>
            <%--</div>--%>
            <%--</div>--%>
            <%--<div class="tips">该红包已存入工资卡余额</div>--%>
            <%--</li>--%>
            </ul>
        </div>
    </div>
</div>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>
    $("#findListByUserIdPage").loadData().then(function (result) {
    })
</script>
</body>
</html>
