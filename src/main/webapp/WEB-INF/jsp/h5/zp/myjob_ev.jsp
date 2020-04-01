<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>

</head>
<body>
<div class="main">
    <div class="list">
        <ul class="list-ul">
            <script type="text/html" id="mypositiontemplate5" data-url="/ijob/api/PositionController/zp/getUserPositionWaitEvaluateInfo/0/isnull">
                {{each list as posi}}
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
            class="iconfont icon-shizhong"></i>{{posi.setDate | dateFormat:'MM月dd日' }} ({{posi.setDate | dateFormat:'周W' }})</span>
                                    <span class="content-msg1-rt">{{ posi.dailySalary }}元/天</span>
                                </div>
                                <div class="content-msg2">
    <span class="content-msg2-lf">{{ posi.sexRequirements | enums:"SexRequirements" }}&nbsp;<span
            class="line"></span>&nbsp;{{posi.beenRecruitedSum}}/{{posi.recruitsSum}}人</span>
                                    <span class="content-msg2-rt">{{posi.salaryType | enums:"SettlementType"}}</span>
                                </div>
                                <div class="content-msg3">
                                    <span class="content-msg3-lf">{{posi.workPlace |ifNull:'未知','city.cityName'}}&nbsp; 0.37km</span>
                                    <span class="content-msg3-rt">信用保证金<i class="CM-trI">{{posi.liquidatedDamages}}元</i></span>
                                </div>
                            </div>
                        </div>
                        <div class="duty-man">
                            <div class="Dman-name">
                                <div class="Dman-qq">
                                    {{if posi.beenrecruitedList!=null}}
                                    <img src="/ijob/upload/{{posi.beenrecruitedList[0].resume.user.attachment | absolutelyPath}}" onerror="this.src='{{posi.beenrecruitedList[0].resume.user.weixin.headimgurl}}';this.onerror=null;" />
                                    {{else}}
                                    <img src="/ijob/static/images/default.jpg" />
                                    {{/if}}
                                </div>
                                <div class="Dnam-t" style="height: 1.467rem;">
                                    <div class="Dnam-tT">
                                        <p class="DT-p1">{{posi.beenrecruitedList[0].resume.user.realName}}</p>
                                    </div>
                                    <div class="Dnam-tF">
                                        <p class="DT-p1">交易结束</p>
                                    </div>
                                    <a href="javascript:void(0);" class="Dnam-m">评价</a>
                                </div>
                            </div>
                        </div>
                        <a onclick="ijob.gotoPage({path:'/h5/zp/evaluate_no?id={{posi.id}}'})"class="duty-more">查看更多<i
                                class="iconfont icon-arrow-down1"></i></a>
                    </div>
                </li>
                {{/each}}
                </script>
            </ul>
        </div>
    </div>
<script>
    $("#mypositiontemplate5").loadData().then(function (result) {
        $(window).scroll(function() {
            var win_top = $(this).scrollTop();
            if (win_top >= 170) {
                $(".JobVtwo ").addClass("sfixed");
            }else if (win_top < 170) {
                $(".JobVtwo ").removeClass("sfixed");
            }
        })
        //result 服务器响应过来的数据
        if(result.data.list.length == 0){
            $('.main').append("<p style='text-align: center;margin-top: 8rem;'>没有相关职位！</p>");
        }
    });
</script>
</body>
</html>
