
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>已结算</title>
    <jsp:include page="../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/part/newAccount.css?version=4">
</head>
<body>
<div class="wrap">
    <script type="text/html" id="yjsinfotemplate" data-url="/ijob/api/ApplySettlementController/getQrcodeYJSInfo" >
        <header class="head-flex-top">
            <div class="head-flex">
                <ul class="list-ul">
                    <li>
                        <p class="num">{{list[0].count}}</p>
                        <p class="txt">结算总人数</p>
                    </li>
                    <li>
                        <p class="num">{{list[0].sum}}</p>
                        <p class="txt">结算总金额</p>
                    </li>
                </ul>
            </div>
        </header>
        <div class="main" >
            <ul class="endList">
                {{each list[0].list[0].scanSettleMemberList as user}}
                    <li>
                        <div class="left">
                            <div class="photo">
                                <img src="/ijob/upload/{{user.user.attachment |absolutelyPath}}"onerror="this.src='{{user.user.weixin.headimgurl}}';this.onerror=null;" >
                            </div>
                            <div class="inform">
                                <div class="name">{{user.user.mainName}}<span> | </span>{{user.user.sex == 1 ? "男":"女"}}</div>
                                <div class="tel">{{user.user.phoneNumber}}</div>
                            </div>
                        </div>
                        <%--{{user.status+1 |enums:'ScanSettleStatus'}}--%>
                        {{if user.status == 1}}
                            <div class="right">
                                <div class="price">{{user.salary}}元</div>
                            </div>
                        {{else}}
                        <div class="right">
                            <div class="price">--</div>
                        </div>
                        {{/if}}
                    </li>
                {{/each}}
            </ul>
        </div>
    </script>

</div>
<div id="homepage"></div>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});
    $("#yjsinfotemplate").loadData({condition:{id:ijob.storage.get("scanSettle.id")}}).then(function (result) {
        console.log(result);
    });
</script>
</body>
</html>
