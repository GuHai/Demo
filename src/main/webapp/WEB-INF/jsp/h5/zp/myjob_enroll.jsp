
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<style>
    .wrap .main .list .list-ul .list-li .more .duty-more{ margin-left: 0.4rem;}
</style>
</head>
<body>
    <div class="main">
        <div class="list">
            <ul class="list-ul">
                <script type="text/html" id="mypositiontemplate2" data-url="/ijob/api/PositionController/zp/getPositionOfStateIsNoSure">
                    {{each list as posi}}
                <li class="list-li">
                    <div class="list-container">
                        <input type="hidden" id="id" value="{{posi.id}}" >
                        <input type="hidden" id="version" value="{{posi.version}}">
                        <input type="hidden" id="beenRecruitedSum" value="{{posi.beenRecruitedSum}}">
                        <div class="list-title">
                            <span class="title-content">{{posi.title}}</span>
                        </div>
                        <div class="list-content">
                            <div class="content-tit">
                                {{posi.huntingtype.name | ifNull:'无'}}
                            </div>
                            <div class="content-msg">
                                <div class="content-msg1">
    <span class="content-msg1-lf"><i
            class="iconfont icon-shizhong"></i>{{posi.recruitStartTime | dateFormat:'MM月dd日' }} ({{posi.recruitStartTime | dateFormat:'周W' }})</span>
                                    <span class="content-msg1-rt">{{ posi.dailySalary }}元/天</span>
                                </div>
                                <div class="content-msg2">
    <span class="content-msg2-lf">{{if posi.sexRequirements == '' || posi.sexRequirements == null}}男女不限{{/if}}{{ posi.sexRequirements | enums:"SexRequirements" }}&nbsp;<span
            class="line"></span>&nbsp;{{posi.personNumDay}}人/天</span>
                                    <span class="content-msg2-rt">{{posi.salaryType | enums:"SettlementType"}}</span>
                                </div>
                                <div class="content-msg3">
                                    <span class="content-msg3-lf">{{posi.workPlace |ifNull:'未知','city.cityName'}}&nbsp; {{posi.workPlace | getDistance }}</span>
                                    <span class="content-msg3-rt">商家已缴纳保证金<i class="CM-trI">{{posi.liquidatedDamages*posi.personNumDay | money}}元</i></span>
                                </div>
                            </div>
                        </div>
                        {{if posi.beenrecruitedList!=null}}
                            <div class="duty-man" style="display: none;">
                                <div class="Dman-name">
                                    <div class="Dman-qq">
                                        {{if posi.beenrecruitedList!=null}}
                                        <img src="/ijob/upload/{{posi.beenrecruitedList[0].resume.user.attachment | absolutelyPath}}" onerror="this.src='{{posi.beenrecruitedList[0].resume.user.weixin.headimgurl}}';this.onerror=null;" />
                                        {{else}}
                                        <img src="/ijob/static/images/default.jpg" />
                                        {{/if}}
                                    </div>
                                    <div class="Dnam-t">
                                        <div class="Dnam-tT">
                                            <p class="DT-p1">
                                                <span>{{posi.beenrecruitedList[0].resume.user.realName}}</span>
                                                <span class="DS1">|</span>
                                                    {{each posi.beenrecruitedList[0].resume.educationalList as educational index}}
                                                        {{if index==0}}
                                                        <span class="DS2"> {{educational.education | ifNull:'暂无学历'}}</span>
                                                        {{/if}}
                                                    {{/each}}
                                            </p>
                                            <p class="DT-p2"><a href="/ijob/api/ResumeController/h5/zp/index/previewOtherUserResume/{{posi.beenrecruitedList[0].resume.id}}">查看简历</a></p>
                                        </div>
                                        <div class="Dnam-tF">
                                            <p>{{posi.beenrecruitedList[0].resume.user.birthday | dateFormat:'AA'}}岁</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="Dman-enroll">
                                    <div class="De-le">报名时间：{{posi.beenrecruitedList[0].signUp | dateFormat:'yyyy年MM月dd日' }}</div>
                                    <div class="De-ri">
                                        <a href="javascript:void(0);" name="{{posi.beenrecruitedList[0].version}}" positionID="{{posi.id}}" positionVersion="{{posi.version}}" recruitsSum="{{posi.recruitsSum}}" beenRecruitedSum="{{posi.beenRecruitedSum |ifNull:'0'}}" data-url="/ijob/api/BeenrecruitedController/update" class="De-enon" onclick="refuseOrAgree2(this,'{{posi.beenrecruitedList[0].id}}',0)">录取</a>
                                        <a href="javascript:void(0);" name="{{posi.beenrecruitedList[0].version}}" data-url="/ijob/api/BeenrecruitedController/update" onclick="refuseOrAgree2(this,'{{posi.beenrecruitedList[0].id}}',1)">拒绝</a>
                                    </div>
                                </div>
                            </div>
                        {{/if}}
                        <div class="more">
                            {{if posi.beenrecruitedList[0]!=null && posi.beenrecruitedList[0].dismiss == null &&  posi.beenrecruitedList[0].state==1}}
                            <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_enroll_det?id={{posi.id}}'})" class="duty-more">
                                查看报名详情
                                <%--<i class="iconfont icon-arrow-right" style="margin-left:0;"></i>--%>
                            </a>
                            {{/if}}
                            <form id="{{posi.id}}">
                                <input type="hidden" name="id" value="{{posi.id}}">
                                <input type="hidden" name="title" value="{{posi.title}}">
                                <input type="hidden" name="dailySalary" value="{{ posi.dailySalary }}元/天">
                                <input type="hidden" name="recruitsSum" value="{{posi.personNumDay}}">
                                <input type="hidden" name="city" value="{{posi.workPlace.city |ifNull:'未知','cityName'}}">
                                <input type="hidden" name="recruitStartTime" value="{{posi.recruitStartTime | dateFormat:'MM月dd日' }} {{if posi.personNumDay!=posi.recruitsSum}} - {{posi.recruitEndTime | dateFormat:'MM月dd日' }}{{/if}}">
                                <input type="hidden" name="jobContent" value="{{posi.jobContent}}">
                            </form>
                            <a href="javascript:void(0);"  class="duty-share" data-index="{{posi.id}}">分享报名二维码</a>
                        </div>
                    </div>
                </li>
                {{/each}}
                </script>
            </ul>
        </div>
    </div>
<script>
    $("#mypositiontemplate2").loadData().then(function (result) {
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
            $('.main').append("<p style='text-align: center;margin-top: 5rem;'>没有相关职位！</p>");
            $(".nodata").remove();
        }
        /*分享报名二维码*/
        $(function () {
            var slide = null;
            $(".duty-share").click(function () {
                var scan = {position:$("#"+$(this).data("index")).serializeObjectJson(),type:0};
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

    function refuseOrAgree2 (arg,beenrecruitedID,state){
        var params = {
            "id" : beenrecruitedID,
            "version" : $(arg).attr("name")
        }

        if (state == 0){
            var btnArray = ['是', '否'];
            mui.confirm('确定录取该求职人员？', null, btnArray, function(e) {
                if (e.index == 0) {//点击是
                    var recruitsSumTemp = parseInt($(arg).attr('recruitsSum'));
                    var beenRecruitedSumTemp = parseInt($(arg).attr('beenRecruitedSum'));
                    if(recruitsSumTemp >= (beenRecruitedSumTemp + 1)){
                        params.state = 4;
                        $(arg).btPost(params,function (data) {
                            if(data.code == 200){
                                var position = {
                                    "id":$(arg).attr('positionID'),
                                    "version":$(arg).attr('positionVersion'),
                                    "beenRecruitedSum":beenRecruitedSumTemp+1
                                }
                                $.ajax({
                                    url:"/ijob/api/PositionController/addPositionPerson",
                                    type:"POST",
                                    dataType:"json",
                                    data: JSON.stringify(position),
                                    contentType:"application/json; charset=utf-8",
                                    success: function () {
                                        $("#mypositiontemplate2").loadData().then(function (result) {
                                            var navH = $(".JobVtwo").offset().top; //定位元素距离浏览器顶部的距离
                                            $(window).scroll(function(){
                                                var scroH = $(this).scrollTop();//获取滚动条的滑动距离
                                                if(scroH >= navH){
                                                    $(".JobVtwo").css({"position":"fixed","top":0});
                                                }else if(scroH < navH){
                                                    $(".JobVtwo").css({"position":"static"});
                                                }
                                            });
                                            if(result.data.list.length == 0){
                                                $('.main').append("<p style='text-align: center;margin-top: 8rem;'>没有相关职位！</p>");
                                                $(".nodata").remove();
                                            }
                                            mui.alert("已录取")
                                        });
                                    }
                                });
                            }
                        });
                    }else{
                        mui.alert("人数已经到达上限");
                    }
                }
            });
        }else if (state == 1){
            var btnArray = ['是', '否'];
            mui.confirm('确定拒绝该求职人员？', null, btnArray, function(e) {
                if (e.index == 0) {//点击是
                    params.state = 6;
                    $(arg).btPost(params,function (data) {
                        $("#mypositiontemplate2").loadData().then(function (result) {
                            $(window).scroll(function() {
                                var win_top = $(this).scrollTop();
                                if (win_top >= 170) {
                                    $(".JobVtwo ").addClass("sfixed");
                                }else if (win_top < 170) {
                                    $(".JobVtwo ").removeClass("sfixed");
                                }
                            })
                            if(result.data.list.length == 0){
                                $('.main').append("<p style='text-align: center;margin-top: 8rem;'>没有相关职位！</p>");
                                $(".nodata").remove();
                            }
                        });
                        mui.alert("已拒绝");
                    });
                }
            });
        }else{
            var btnArray = ['是', '是'];
            mui.confirm('请不要乱改我代码！！', null, btnArray, function(e) {
            });
        }
    }
</script>
</body>
</html>

