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
<div class="insured_coverage_detail">
    <script type="text/html" id="recordInfo" data-url="/ijob/api/InsuranceController/getInsRecordMap/{record.id}" data-type="POST">
        {{each list as record}}
            <div class="list-box">
                <ul>
                    <li>
                        <div class="title">
                            <span class="txt">{{record.insType.name}}</span>
                            <span class="link"><span class="time">生效月份：{{record.date |dateFormat:'yyyy年MM月'}}</span></span>
                        </div>
                        <div class="flex-box">
                            <span class="ensure">最高<em>{{record.insFee.insuredAmount}}</em>万保障</span>
                            <span class="time">上传名单：{{record.updateTime |dateFormat:'yyyy年MM月dd日'}}</span>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="insured-inform">
                <div class="title">
                    <h3>被保人信息</h3>
                    <span class="num">共{{record.count}}人</span>
                </div>
                <div class="insured-box">
                    <ul>
                        {{each record.insRecordPersonList as insRecordPerson}}
                            <li>
                                <div class="flex">
                                    <span class="left"><span class="name">{{insRecordPerson.insPerson.name}}</span><span class="sex">{{insRecordPerson.insPerson.sex | enums:'SexType'}}</span></span>
                                    <span class="right"><span class="position">{{insRecordPerson.insProfessionType.name}}</span></span>
                                </div>
                                <div class="flex">
                                    <span class="left"><span class="identity">{{insRecordPerson.insPerson.cardID}}</span></span>
                                    <span class="right"><span class="type">普通行业</span></span>
                                </div>
                            </li>
                        {{/each}}
                    </ul>
                </div>
            </div>
        {{/each}}
        <div class="clearfix" style="clear: both;content: '';height: 1.7rem;"></div>
        <div class="foot-flex">
            <a href="javascript:void(0);" class="rules" onclick="ijob.gotoPage({path:'/h5/zp/insurance/claimRules'})">理赔细则</a>
        </div>
    </script>

</div>
</body>
<script>
    $("#recordInfo").loadData().then(function (result) {
        console.log(result);
    });
</script>
</html>
