<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/6
  Time: 17:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>签到记录</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/My_part-time/signIn_Record.css">
</head>
<body>
<div class="wrap">
    <div class="sort1">
        <ul class="sort1List">
            <script id="todayJob"   type="text/html"  data-url="/ijob/api/SigninController/findList3List"   >
                {{each list as sign}}
                <li>
                    <div class="workin_top">
                        <span>{{sign.signTime | dateFormat:'yyyy年MM月dd日' }}<em>星期{{sign.signTime | dateFormat:'W'}}</em></span>
                        <span class="text">{{sign.signinType | enums:'SignStatus'}}</span>
                    </div>
                    <div class="workin_but" onclick="ijob.gotoPage({path:'/h5/qz/myjob/sign_in_view?sign.id={{sign.id}}'})">
                        <p><i class="iconfont icon-fujin"></i><span>{{sign.address.detailedAddress | ifNull :'没有定位地址' }}</span></p>
                        <p>{{sign.signTime | dateFormat:'hh:mm' }}</p>
                        <span class="iconfont icon-arrow-right"></span>
                    </div>
                    <div class="workin_but" onclick="ijob.gotoPage({path:'/h5/qz/myjob/sign_in_view?sign.id={{sign.id}}'})">
                        <p><i class="iconfont icon-fujin"></i><span>{{sign.backAddress.detailedAddress | ifNull :'没有定位地址' }}</span></p>
                        <p>{{sign.signBack | dateFormat:'hh:mm' }}</p>
                        <span class="iconfont icon-arrow-right"></span>
                    </div>
                </li>
                {{/each}}
            </script>
        </ul>
    </div>
</div>
<div id="homepage"></div>
</body>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});
    var positionID = ijob.storage.get("sign.positionID");
    var userID = ijob.storage.get("sign.userID");
    $("#todayJob").loadData({
        condition:{
            positionID:positionID,
            userID:userID
        }
    });
</script>
</html>
