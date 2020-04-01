
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>已结算</title>
    <jsp:include page="../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/part/myjob.css?version=4">
</head>
<body>
<div class="wrap">
    <script id="endDetailsTemplate" type="text/html" data-url="/ijob/api/PositionController/selectYiJieSuan/{position.id}">
    <header class="head-flex-top">
        <div class="head-flex">
            <ul class="list-ul">
                <li>
                    <p class="num">{{list[0].sum}}</p>
                    <p class="txt">结算总人数</p>
                </li>
                <li>
                    <p class="num">{{list[0].count}}</p>
                    <p class="txt">结算总金额</p>
                </li>
            </ul>
        </div>
    </header>
    <div class="main" >
        <ul class="endList">
                {{each list[0].list as object}}
                    <li>
                        <a href="javascript:void(0);">
                            <div class="pers-list">
                                <div class="duty-man">
                                    <div class="Dman-name">
                                        <div class="pers-img">
                                            <img src="{{object.infoHeadImg}}"
                                                 onerror="this.src='{{object.headimgurl}}';this.onerror=null;"/>
                                        </div>
                                        <div class="pers-name">
                                            <div class="Dnam-tT">
                                                <p class="DT-p1">{{object.realName}}</p>
                                            </div>
                                            <div class="Dnam-tF">
                                                <p class="Ds-p2">工作完成</p>
                                            </div>
                                        </div>
                                        <div class="statu">已结算</div>
                                    </div>
                                </div>
                            </div>
                            <div class="record">
                                <span class="txt"><i>签到记录：</i><span>{{object.signinDay}}</span>天<%--，共<span>{{object.singinCount}}</span>次--%>，预计薪资<span>{{object.dailySalary*object.signinDay }}元</span></span>
                                <%--<span class="iconfont icon-arrow-right"></span>--%>
                            </div>
                            <div class="accounts">
                                <span class="txt"><i>结算总额：</i><span class="yen">{{object.settlementSum}}元</span>，总笔数<span>{{object.settlementCount}}</span>笔</span>
                                <%--<span class="iconfont icon-arrow-right"></span>--%>
                            </div>
                        </a>
                    </li>
                {{/each}}
            <%--<li>
                <a href="javascript:void(0);">
                    <div class="pers-list">
                        <div class="duty-man">
                            <div class="Dman-name">
                                <div class="pers-img">
                                    <img src="/ijob/static/images/default.jpg" title="头像">
                                </div>
                                <div class="pers-name">
                                    <div class="Dnam-tT">
                                        <p class="DT-p1">梁超</p>
                                    </div>
                                    <div class="Dnam-tF">
                                        <p class="Ds-p2">工作完成</p>
                                    </div>
                                </div>
                                <div class="statu">已结算</div>
                            </div>
                        </div>
                    </div>
                    <div class="record">
                        <span class="txt"><i>签到记录：</i><span>5</span>天，共<span>10</span>次，预计薪资<span>400元</span></span>
                        <span class="iconfont icon-arrow-right"></span>
                    </div>
                    <div class="accounts">
                        <span class="txt"><i>结算总额：</i><span class="yen">380元</span>，总笔数<span>10</span>笔</span>
                        <span class="iconfont icon-arrow-right"></span>
                    </div>
                </a>
            </li>--%>
        </ul>
    </div>
    </script>
</div>
<div id="homepage"></div>
</body>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});
    $("#endDetailsTemplate").loadData().then(function (result) {
        console.log(result);
    });
</script>
</html>
