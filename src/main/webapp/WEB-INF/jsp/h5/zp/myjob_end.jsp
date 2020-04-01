
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>已结算</title>
    <link rel="stylesheet" href="/ijob/static/css/part/myjob.css">
</head>
<body>
<div class="main">
    <div class="notes" style="display:block">
        <a href="javascript:void(0);" class="endlink history" onclick="ijob.gotoPage({path:'/h5/zp/historyPosition'})">
            <div class="txt-left" >
                <span class="iconfont icon-guanlikehu"></span>历史职位
            </div>
            <div class="right">
                <span class="iconfont icon-arrow-right"></span>
            </div>
        </a>
    </div>
    <div class="list" >
        <ul class="list-ul">
            <script type="text/html" id="mypositiontemplate5" data-url="/ijob/api/PositionController/zp/getUserPositionWaitApplySettlementInfo/4">
                {{each list as posi index}}
                <li class="list-li">
                    <div class="list-container">
                        <div class="list-title">
                            <span class="title-content">{{posi.title}}</span>
                        </div>
                        <div class="list-content">
                            <div class="content-tit">
                                {{posi.huntingtype.name}}
                            </div>
                            <div class="content-msg">
                                <div class="content-msg1">
                                <span class="content-msg1-lf"><i
                                        class="iconfont icon-shizhong"></i>{{posi.recruitStartTime | dateFormat:'MM月dd日' }} ({{posi.recruitStartTime | dateFormat:'周W' }})</span>
                                    <span class="content-msg1-rt"><strong>{{ posi.dailySalary }}元/天</strong></span>
                                </div>
                                <div class="content-msg2">
                                <span class="content-msg2-lf">{{if posi.sexRequirements == '' || posi.sexRequirements == null}}男女不限{{/if}}{{ posi.sexRequirements | enums:"SexRequirements" }}&nbsp;<span
                                        class="line"></span>&nbsp;{{posi.personNumDay}}人/天</span>
                                    <span class="content-msg2-rt">{{posi.salaryType | enums:"SettlementType"}}</span>
                                </div>
                                <div class="content-msg3">
                                    <span class="content-msg3-lf">{{posi.workPlace.city |ifNull:'未知','cityName'}}&nbsp; {{posi.workPlace | getDistance }}</span>
                                    <span class="content-msg3-rt">商家已缴保证金<i class="CM-trI">{{posi.liquidatedDamages*posi.personNumDay | money}}元</i></span>
                                </div>
                            </div>
                        </div>

                        {{each posi.signins as sign index}}
                        <div class="pers-list">
                            <div class="duty-man">
                                <div class="Dman-name">
                                    <div class="Dman-qq">
                                        <img src="/ijob/upload/{{sign.user.attachment | absolutelyPath}}" onerror="this.src='{{sign.user.weixin.headimgurl}}';this.onerror=null;" />
                                    </div>
                                    <div class="Dnam-t">
                                        <div class="Dnam-tT">
                                            <p class="DT-p1">{{sign.user.realName }}</p>
                                        </div>
                                        <div class="Dnam-tF">
                                            <p class="Ds-p2">签到记录：<span>{{sign.num }}</span>次</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        {{/each}}
                        <div class="more">
                            <a href="javascript:void(0);"  class="duty-more" onclick="ijob.gotoPage({path:'/h5/zp/myjob_end_details?position.id={{posi.id}}'})">查看更多</a>
                        </div>
                    </div>
                </li>
                {{/each}}
            </script>
            </ul>
        </div>
    </div>
<script>
    $("#mypositiontemplate5").loadData().then(function (result) {
        var navH = $(".JobVtwo").offset().top; //定位元素距离浏览器顶部的距离
        $(window).scroll(function(){
            var scroH = $(this).scrollTop();//获取滚动条的滑动距离
            if(scroH >= navH){
                $(".JobVtwo").css({"position":"fixed","top":"0"});
            }else if(scroH < navH){
                $(".JobVtwo").css({"position":"static"});
            }
        });
        //result 服务器响应过来的数据
        ijob.storage.set("position",result.data);
        if(result.data.list.length == 0){
            $(".nodata").remove();
            $('.main').append("<p style='text-align: center;margin-top: 5rem;'>没有相关职位！</p>");
        }
    });
</script>
</body>
</html>
