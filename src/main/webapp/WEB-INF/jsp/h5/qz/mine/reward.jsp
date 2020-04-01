<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>奖励</title>
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.picker.min.css">
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/static/css/base.css">
    <link rel="stylesheet" href="/ijob/static/css/mine/partnerPlan.css?version=4">
    <jsp:include page="../../qz/base/resource.jsp"/>
</head>
<body>
<div class="wrap">
    <%--头部--%>
    <div>
        <script  type="text/html" id="partnerinfo"  data-url="/ijob/api/PartnerController/getReward" data-type="POST">
            {{each list as partner}}
            <div class="headBox">
                <div class="inform">
                    <div class="left l_r_b">
                        <div class="num">{{partner.total | ifNull:'0'}}</div>
                        <div class="tag">累计奖励（元）</div>
                    </div>
                    <div class="right l_r_b">
                        <div class="num">{{partner.num}}</div>
                        <div class="tag">累计邀请（人）</div>
                    </div>
                </div>
            </div>
            <%--合伙人级别--%>
            <div class="mainBox">
                <div class="tabList rewardList">
                    <ul class="list">
                        <li class="head-li"><span class="num">{{partner.tj | ifNull:'0'}}</span><span>推荐奖</span></li>
                        <li class="line"></li>
                        <li class="head-li"><span class="num">{{partner.tg | ifNull:'0'}}</span><span>推广奖</span></li>
                        <li class="line"></li>
                        <li class="head-li"><span class="num">{{partner.td | ifNull:'0'}}</span><span>团队奖</span></li>
                    </ul>
                </div>
            </div>
            {{/each}}
        </script>
    </div>

    <div class="mainBox">
        <div class="main">
            <div class="mui-content-box gold" style="display: block">
                <div class="partner">
                    <%--推荐奖--%>
                    <div class="tab_list_box">
                        <ul class="list">
                            <script  type="text/html" id="rewardlist"  data-url="/ijob/api/PartnerController/rewardList" data-type="POST">
                                {{each list as partner}}
                                <li>
                                    <div class="left">
                                        <div class="img">
                                            <img src="/ijob/static/images/{{partner.partID | enums:'PartnerType' }}.png"/>
                                        </div>
                                        <div class="name">{{partner.nickName}}</div>
                                    </div>
                                    <div class="right">
                                        <span class="txt">奖励</span>
                                        <span class="num">{{partner.fee}}元</span>
                                    </div>
                                </li>
                                {{/each}}
                            </script>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
        <div id="homepage"></div>
</div>
</body>
</html>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});
    $(function () {

        $("#partnerinfo").loadData().then(function(result){


            //合伙人切换
            $(".head-li").click(function () {
                $(this).addClass("curr").siblings().removeClass("curr");
                $(".partner").eq($(this).index()).show().siblings(".partner").hide();
                var obj  = {
                    condition:{
                        layer:$(this).index()/2+1
                    }
                }
                $("#rewardlist").loadData(obj);
            });
            $(".list li:first").click();
        });



    })
    

</script>
