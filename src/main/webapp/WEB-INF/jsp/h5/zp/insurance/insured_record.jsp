<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/1/8
  Time: 16:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>参保记录</title>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/insurance/insurance.css?version=4">
</head>
<body>
<div class="record-list">
    <div class="list-box">
        <ul>
            <script type="text/html" id="recordList" data-url="/ijob/api/InsuranceController/getInsRecordListMap" data-type="POST">
                {{each list as record}}
                    {{if  record.id != null}}
                    <li onclick="ijob.gotoPage({path:'/h5/zp/insurance/insured_coverage_detail?record.id={{record.id}}'})">
                        <div class="title">
                            <span class="txt">{{record.insType.name}}</span>
                            <span class="link"><span class="time">生效月份：{{record.date |dateFormat:'yyyy年MM月'}}</span><span class="iconfont icon-arrow-right"></span></span>
                        </div>
                        <div class="ensure">最高<em>{{record.insFee.insuredAmount}}</em>万保障</div>
                        <div class="flex-box">
                            <span class="num">被保人：共{{record.count}}人</span>
                            <span class="time">上传名单：{{record.updateTime |dateFormat:'yyyy年MM月dd日'}}</span>
                        </div>
                    </li>
                    {{/if}}
                {{/each}}
            </script>
        </ul>
    </div>
    <%--返回首页--%>
    <div id="homepage"></div>
</div>
</body>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});
    $("#recordList").loadData().then(function (result) {
        if(result.data.list.length == 0){
            $(".list-box").after("<div class='nodata'  class=\"hd_result\">\n" +
                "            <div class=\"icon\">\n" +
                "                <span style='color: #999;font-size: 100px;line-height: 1;' class=\"iconfont icon-jiarugouwuche00-copy-copy-copy\"></span>\n" +
                "            </div>\n" +
                "            <p  class=\"tips\">正如你所见，里面空空如也</p>\n" +
                "        </div>");
        }
        console.log(result);
    });
</script>
</html>
