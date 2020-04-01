<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/11
  Time: 16:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>全职管理</title>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/fullTime/fullTime.css?version=4">
</head>
<body>
<div class="wrap">
    <div class="full-index">
        <div class="index-hd">
            <div class="list-flex">
                <ul>
                    <li  onclick="ijob.gotoPage({path:'/h5/zp/fullTime/fullPosts?full.id=0'})">
                        <span class="iconfont icon-fabu2"></span>
                        <span class="txt">发布全职</span>
                    </li>
                    <li onclick="ijob.gotoPage({path:'/h5/zp/fullTime/fullRecruiting'})">
                        <span class="iconfont icon-zzzw"></span>
                        <span class="txt">在招职位</span>
                    </li>
                    <li onclick="ijob.gotoPage({path:'/h5/zp/fullTime/fullOffline'})">
                        <span class="iconfont icon-xxzw"></span>
                        <span class="txt">下线职位</span>
                    </li>
                </ul>
            </div>
        </div>
        <div class="list-box">
            <div class="index-list">
                <ul>
                    <script id="fullTimeStatus" type="text/html" data-url="/ijob/api/FullTimeController/allFullStatusInfo">
                        <li onclick="ijob.gotoPage({path:'/h5/zp/fullTime/fullenlist?full.jobType=1'})">
                            <div class="icon icon1">
                                <img src="/ijob/static/images/icon7.png"/>
                            </div>
                            <div class="txt enroll">
                                <div class="title">已报名</div>
                                <div class="num">{{list[0].type1}}</div>
                            </div>
                        </li>
                        <li onclick="ijob.gotoPage({path:'/h5/zp/fullTime/fullenlist?full.jobType=2'})">
                            <div class="icon icon2">
                                <img src="/ijob/static/images/icon6.png"/>
                            </div>
                            <div class="txt colloquio">
                                <div class="title">待面试</div>
                                <div class="num">{{list[0].type2}}</div>
                            </div>
                        </li>
                        <li onclick="ijob.gotoPage({path:'/h5/zp/fullTime/fullenlist?full.jobType=3'})">
                            <div class="icon icon3">
                                <img src="/ijob/static/images/icon5.png"/>
                            </div>
                            <div class="txt entry">
                                <div class="title">待入职</div>
                                <div class="num">{{list[0].type3}}</div>
                            </div>
                        </li>
                        <li onclick="ijob.gotoPage({path:'/h5/zp/fullTime/fullenlist?full.jobType=4'})">
                            <div class="icon icon4">
                                <img src="/ijob/static/images/icon2.png"/>
                            </div>
                            <div class="txt absence">
                                <div class="title">已入职</div>
                                <div class="num">{{list[0].type4}}</div>
                            </div>
                        </li>
                        <li onclick="ijob.gotoPage({path:'/h5/zp/fullTime/fullenlist?full.jobType=5'})">
                            <div class="icon icon5">
                                <img src="/ijob/static/images/icon4.png"/>
                            </div>
                            <div class="txt leave">
                                <div class="title">已离职</div>
                                <div class="num">{{list[0].type5}}</div>
                            </div>
                        </li>
                    </script>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    $("#fullTimeStatus").loadData().then(function (result) {
        console.log(result);
    })
</script>
</html>
