<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/21
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>投诉历史</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/SubmitFeedback.css?version=4">
</head>
<body>
<div class="wrap page_complaint">
    <div class="list-box">
        <ul class="allList">
            <script id="myHistoryFeedBack" type="text/html" data-url="/ijob/api/FeedbackController/findPage" data-type="POST" >
                {{each list as feed}}
                    <li onclick="ijob.gotoPage({path:'/h5/zp/report_details?data.feedbackID={{feed.id}}'})">
                        <div class="top-flex">
                            <div class="left">
                                <h3>{{feed.type | enums:'FeedType'}}</h3>
                                <p>{{feed.updateTime | dateFormat:'yyyy-MM-dd hh:mm'}}</p>
                            </div>
                            <div class="right">
                                <span>{{feed.status | enums:'FeedStatus'}}</span>
                                <span class="iconfont icon-arrow-right"></span>
                            </div>
                        </div>
                        <div class="content">
                            {{feed.feedContent}}
                        </div>
                    </li>
                {{/each}}
            </script>
        </ul>
    </div>
</div>
<div id="homepage"></div>
</body>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});
    initHistoryFeedback();
    function initHistoryFeedback() {
        var page = {
            "pageSize": "10",
            "currentPage": "1"
        };
        var ijobRefresh = new IJobRefresh({
            container: '.allList',
            up: function () {
                $("#myHistoryFeedBack").appendData(page, ijobRefresh).then(function (result) {
                    console.log(result)
                    page.currentPage = result.nextPage;
                });
            }
        });
    }
</script>
</html>