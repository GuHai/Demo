<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>红包</title>
    <jsp:include page="../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/salaryCard.css?version=4">
</head>
<body>
    <div class="wrap">
        <div class="page_packet">
            <div class="informBox">
                <div class="header">
                    <div class="head">
                        <a href="javascript:void(0);">关闭</a>
                        <a href="javascript:void(0);"  onclick="ijob.gotoPage({path:'/h5/qz/mine/redEnvelopes'})">红包记录</a>
                    </div>
                </div>
                <div class="person">
                    <div class="portrait">
                        <div class="photo">
                            <img src="/ijob/static/images/default.jpg"/>
                        </div>
                        <p>Amin的红包</p>
                    </div>
                    <div class="name">
                        <p class="pro_name">公司真心诚聘传单派发学生可兼职</p>
                        <p class="type">分享奖励</p>
                    </div>
                </div>
            </div>
            <div class="receive_box_list">
                <div class="num">领取<span>2/8</span>人</div>
                <ul>
                    <li>
                        <div class="portrait"><img src="/ijob/static/images/default.jpg"/></div>
                        <div class="contenBox">
                            <p class="list-title" style="width: 300px">啦啦啦</p>
                            <p class="list-time" style="width: 200px">2018-07-07 23:59:01</p>
                        </div>
                        <div class="fr money">
                            <p>5.00元</p>
                        </div>
                    </li>
                    <li>
                        <div class="portrait"><img src="/ijob/static/images/default.jpg"/></div>
                        <div class="contenBox">
                            <p class="list-title" style="width: 300px">啦啦啦</p>
                            <p class="list-time" style="width: 200px">2018-07-07 23:59:01</p>
                        </div>
                        <div class="fr money">
                            <p>5.00元</p>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <div id="homepage"></div>
</body>
</html>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});
</script>
