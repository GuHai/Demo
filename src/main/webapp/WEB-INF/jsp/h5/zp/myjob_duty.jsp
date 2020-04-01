<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>

</head>
<body>
<div class="main">
    <div class="list">
        <ul class="list-ul">
            <script type="text/html" id="mypositiontemplate3" data-url="/ijob/api/PositionController/zp/getPositionOfStateIsWaitToPosition" >
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
                                    <span class="content-msg1-lf"><i class="iconfont icon-shizhong"></i>{{posi.recruitStartTime | dateFormat:'MM月dd日' }} ({{posi.recruitStartTime | dateFormat:'周W' }})</span>
                                    <span class="content-msg1-rt">{{ posi.dailySalary }}元/天</span>
                                </div>
                                <div class="content-msg2">
                                    <span class="content-msg2-lf">{{if posi.sexRequirements == '' || posi.sexRequirements == null}}男女不限{{/if}}{{ posi.sexRequirements | enums:"SexRequirements" }}&nbsp;<span class="line"></span>&nbsp;{{posi.personNumDay}}人/天</span>
                                    <span class="content-msg2-rt">{{posi.salaryType | enums:"SettlementType"}}</span>
                                </div>
                                <div class="content-msg3">
                                    <span class="content-msg3-lf">{{posi.workPlace.city |ifNull:'未知','cityName'}}&nbsp; {{posi.workPlace | getDistance }}</span>
                                    <span class="content-msg3-rt">商家已缴纳保证金<i class="CM-trI">{{posi.liquidatedDamages*posi.personNumDay | money}}元</i></span>
                                </div>
                            </div>
                        </div>
                        <div class="duty-man" style="padding: 0;background: none;">
                            <div class="btnBox">
                                <form id="{{posi.id}}">
                                    <input type="hidden" name="id" value="{{posi.id}}">
                                    <input type="hidden" name="title" value="{{posi.title}}">
                                    <input type="hidden" name="dailySalary" value="{{ posi.dailySalary }}元/天">
                                    <input type="hidden" name="recruitsSum" value="{{posi.personNumDay}}">
                                    <input type="hidden" name="city" value="{{posi.workPlace.city |ifNull:'未知','cityName'}}">
                                    <input type="hidden" name="recruitStartTime" value="{{posi.recruitStartTime | dateFormat:'MM月dd日' }} {{if posi.personNumDay!=posi.recruitsSum}} - {{posi.recruitEndTime | dateFormat:'MM月dd日' }}{{/if}}">
                                    <input type="hidden" name="jobContent" value="{{posi.jobContent}}">
                                </form>
                                <input type="button" value="分享签到二维码" class="viewshare" data-index="{{posi.id}}">
                                <input type="button" value="查看录取详情" class="viewDetails" onclick="ijob.gotoPage({path:'/h5/zp/page_enroll_details?position.id={{posi.id}}'})">
                                <input type="button" value="查看到岗详情" onclick="ijob.gotoPage({path:'/h5/zp/myjob_signindex?position.id={{posi.id}}'})"  class="posibtns">
                            </div>
                        </div>
                    </div>
                </li>
                {{/each}}
                </script>
            </ul>
        </div>
    </div>
<script>
    $("#mypositiontemplate3").loadData().then(function (result) {
        var navH = $(".JobVtwo").offset().top; //定位元素距离浏览器顶部的距离
        $(window).scroll(function(){
            var scroH = $(this).scrollTop();//获取滚动条的滑动距离
            if(scroH >= navH){
                $(".JobVtwo").css({"position":"fixed","top":"0"});
            }else if(scroH < navH){
                $(".JobVtwo").css({"position":"static"});
            }
        });
        if(result.data.list.length == 0){
            $(".nodata").remove();
            $('.main').append("<p style='text-align: center;margin-top: 5rem;'>没有相关职位！</p>");
        }

        /*分享签到二维码*/
        $(function () {
            var slide = null;
            $(".viewshare").click(function () {
                var scan = {position:$("#"+$(this).data("index")).serializeObjectJson(),type:1};
                ijob.gotoPage({path:"/h5/zp/scan",data:{scan:scan}});
            });
            // 点击空白处隐藏选项
            $("body>*").on('click', function (e) {
                if ($(e.target).hasClass('share_code_code')) {
                    $(".share_code_code").hide();
                    slide.ableTouch();
                }
            });
        })

    });
</script>
</body>
</html>
