<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/5
  Time: 19:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>举报详情</title>
    <jsp:include page="../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/SubmitFeedback.css?version=4">
    <style>


    </style>
</head>
<body>
<div class="wrap">
    <script id="myHistoryFeedBackDetail" type="text/html" data-url="/ijob/api/FeedbackController/getHistoryFeedBackDetail/{data.feedbackID}" data-type="POST" >
        {{each list as feed}}
            <div class="page_report_details">
                <div class="report-list">
                    <div class="r-hd">
                        <span class="left">
                            <span class="tit">{{feed.type |enums:'FeedType'}}</span>
                            <span class="time">{{feed.updateTime | dateFormat:'yyyy-MM-dd hh:mm'}}</span>
                        </span>
                        <span class="right">
                            <span class="statu">{{feed.status | enums:'FeedStatus'}}</span>
                        </span>
                    </div>
                    {{if feed.mainName!=null&&feed.tel!=null}}
                    <div class="tel-box">
                        <p><span class="tit">举报人:</span><span class="name">{{feed.mainName}}</span></p>
                        <p><span  class="tit">联系方式:</span><a href="tel:{{feed.tel}}">{{feed.tel}}</a></p>
                    </div>
                    {{/if}}
                    {{if feed.contacts!=null&&feed.contactNumber!=null}}
                    <div class="tel-box">
                        <p><span  class="tit">被举报人:</span><span class="name">{{feed.contacts}}</span></p>
                        <p><span  class="tit">联系方式:</span><a href="tel:{{feed.contactNumber}}">{{feed.contactNumber}}</a></p>
                    </div>
                    {{/if}}
                    <div class="main-box">
                        <div class="content">
                            {{if feed.positionID != null && feed.positionID != ''}}
                                <div class="title">{{feed.positionTitle}}</div>
                            {{/if}}
                            <div class="desc">
                                {{feed.feedContent}}
                            </div>
                        </div>
                        <%--图片列表--%>
                        {{if feed.feedImgObj != null}}
                            <div class="img-box">
                                <section class=" img-section">
                                    <div class="z_photo upimg-div clearfix" >
                                        <section class="z_file fl">
                                            <a href="/ijob/upload/{{feed.feedImgObj | absolutelyPath}}">
                                                <img class="up-img" src="/ijob/upload/{{feed.feedImgObj | absolutelyPath}}" onerror="this.src='/ijob/static/images/default.jpg';this.onerror=null"/>
                                            </a>
                                        </section>
                                    </div>
                                </section>
                            </div>
                        {{/if}}
                        <%--图片列表 end--%>
                    </div>
                </div>
            </div>
        {{/each}}
    </script>
</div>
</body>
<script src="/ijob/static/js/slidePhoto.js"></script>
<script>
    $("#myHistoryFeedBackDetail").loadData().then(function(result){
        console.log(result);
    });
</script>
</html>
