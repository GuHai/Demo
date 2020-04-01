<%@ page import="com.yskj.utils.IJobSecurityUtils" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/8
  Time: 10:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>经纪人</title>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/broker/broker.css?version=4">
</head>
<body>
<div class="broker-index">
    <div class="index-hd">
        <div class="hd-main">
            <div class="photo">
                <img id="img" <%--src="/ijob/upload/<%=IJobSecurityUtils.getLoginUser().getAttachment().getAbsolutelyPath()%>"--%>
                    <%--onerror="this.src='<%=IJobSecurityUtils.getLoginUser().getWeixin().getHeadimgurl()%>';this.error=null"--%>
                />
            </div>
            <div id="name" class="name"><%--<%=IJobSecurityUtils.getLoginUser().getMainName()%>--%></div>
            <div class="positions" onclick="ijob.gotoPage({path:'/h5/zp/broker/stay_broker'})">
                在招职位
                <span class="icon">
                    <em></em>
                    <i></i>
                </span>
            </div>
        </div>
    </div>
    <div class="list-box">
        <div class="index-list">
            <ul>
                <script id="personInfo" type="text/html" data-url="/ijob/api/FullTimeController/getMyRecommendInfo">
                    {{each list as type}}
                        <li onclick="ijob.gotoPage({path:'/h5/zp/broker/recommend_broker'})">
                            <div class="icon icon1">
                                <img src="/ijob/static/images/icon1.png"/>
                            </div>
                            <div class="txt">
                                <div class="title">已推荐</div>
                                <div class="num">{{type.type1}}</div>
                            </div>
                        </li>
                        <li onclick="ijob.gotoPage({path:'/h5/zp/broker/entry_broker'})">
                            <div class="icon icon2">
                                <img src="/ijob/static/images/icon2.png"/>
                            </div>
                            <div class="txt entry">
                                <div class="title">已入职</div>
                                <div class="num">{{type.type2}}</div>
                            </div>
                        </li>
                        <li onclick="ijob.gotoPage({path:'/h5/zp/broker/absence_broker'})">
                            <div class="icon icon3">
                                <img src="/ijob/static/images/icon3.png"/>
                            </div>
                            <div class="txt absence">
                                <div class="title">未入职</div>
                                <div class="num">{{type.type3}}</div>
                            </div>
                        </li>
                        <li onclick="ijob.gotoPage({path:'/h5/zp/broker/leave_broker'})">
                            <div class="icon icon4">
                                <img src="/ijob/static/images/icon4.png"/>
                            </div>
                            <div class="txt leave">
                                <div class="title">已离职</div>
                                <div class="num">{{type.type4}}</div>
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

    $("#personInfo").loadData().then(function (result) {
        console.log(result);

        if(result.data.list[0].user.attachment == null){
            $("#img").attr("src",result.data.list[0].user.weixin.headimgurl);
        }else{
            $("#img").attr("src","/ijob/upload/"+template.absolutelyPath(result.data.list[0].user.attachment));
            $("#img").error(function () {
                this.src = result.data.list[0].user.weixin.headimgurl;
            });
        }
        $("#name").text(result.data.list[0].user.mainName);
    });
</script>
</html>
