<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>我的招聘</title>
    <%--<jsp:include page="../zp/base/resource.jsp"/>--%>
    <link rel="stylesheet" href="/ijob/static/css/index/index.css">
    <style>
        .list-ul{
            margin-top:0;
        }
    </style>
</head>
<body>
       <div class="main">
            <div class="list">
                <ul class="list-ul">
                    <script type="text/html" id="mypositiontemplate1" data-url="/ijob/api/PositionController/zp/getMyPositionForMeOfZP">
                        {{ each list as posi }}
                            <li class="list-li">
                                <div class="list-container">
                                    <div class="list-title">
                                        <span class="title-content">{{posi.title}}</span>
                                    </div>
                                    <div class="list-content">
                                        {{if posi.huntingtype.codeGrade < 6}}
                                        <div class="content-tit" style="background:#ff943e;">
                                            {{else if posi.huntingtype.codeGrade > 5 && posi.huntingtype.codeGrade < 10}}
                                            <div class="content-tit" style="background:#108ee9;">
                                                {{else if posi.huntingtype.codeGrade > 10 && posi.huntingtype.codeGrade < 16}}
                                                <div class="content-tit" style="background:#e8541e;">
                                                    {{else}}
                                                    <div class="content-tit" style="background:#4ccca0;">
                                                        {{/if}}
                                                        {{posi.huntingtype | ifNull:'其他','name'}}
                                                    </div>
                                                    <div class="content-msg">
                                                        <div class="content-msg1">
                                                            <span class="content-msg1-lf"><i class="iconfont icon-shizhong"></i>{{posi.setDate | dateFormat:'MM月dd日' }} ({{posi.setDate | dateFormat:'周W' }})</span>
                                                            <span class="content-msg1-rt">{{ posi.dailySalary }}元/天</span>
                                                        </div>
                                                        <div class="content-msg2">
                                                            <span class="content-msg2-lf">{{ posi.sexRequirements | enums:"SexRequirements" }}&nbsp;
                                                                <span class="line"></span>&nbsp;{{posi.beenRecruitedSum | ifNull:'0'}}/{{posi.recruitsSum | ifNull:'0'}}人
                                                            </span>
                                                            <span class="content-msg2-rt">{{posi.salaryType | enums:"SettlementType"}}</span>
                                                        </div>
                                                        <div class="content-msg3">
                                                            <span class="content-msg3-lf">{{posi.workPlace |ifNull:'保密','city.cityName'}}&nbsp; 0.37km</span>
                                                            <span class="content-msg3-rt">信用保证金<i class="CM-trI">{{posi.liquidatedDamages}}元</i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="list-ul">
                                                    <p class="list-ulp1"><a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_enroll_det?id={{posi.id}}&state=1'})" class="">待确认<span>{{posi.noSure}}</span></a></p>
                                                    <p class="list-ulp2"><a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_enroll_det2?id={{posi.id}}'})">等待面试 <span>{{posi.waitInterview}}</span></a></p>
                                                    <p class="list-ulp5">
                                                        <a href="javascript:void(0);"  onclick="ijob.gotoPage({path:'/h5/zp/myjob_sign?position.id={{posi.id}}'})">待到岗
                                                            <span>
                                                                {{posi.waitToPosition>0 ? posi.waitToPosition:'0'}}
                                                            </span>
                                                        </a>
                                                    </p>
                                                    <p class="list-ulp7"><a href="#" onclick="ijob.gotoPage({path:'/h5/zp/myjob_work?id={{posi.id}}'})">工作中 <span>{{if posi.working != 0}}{{posi.working}}{{/if}}</span></a></p>
                                                    <p class="list-ulp8"><a href="#" onclick="/*ijob.gotoPage({path:'/h5/zp/myjob_close2_record2?id={{posi.id}}&state=0'})*/">待结算 <span>{{posi.waitSettlement}}</span></a></p>
                                                    <p class="list-ulp8"><a href="#" onclick="/*ijob.gotoPage({path:'/h5/zp/myjob_close2_record2?id={{posi.id}}&state=1'})*/">已结算 <span>{{posi.settlementCount}}</span></a></p>
                                                    <p class="list-ulp10"><a href="#" onclick="ijob.gotoPage({path:'/h5/zp/evaluate_no?id={{posi.id}}&state=5'})">待评价 <span>{{posi.waitEvaluate}}</span></a></p>
                                                    <p class="list-ulp11"><a href="#" onclick="ijob.gotoPage({path:'/h5/zp/evaluate_yes?id={{posi.id}}'})">已评价 <span>{{posi.evaluateed}}</span></a></p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        {{ /each }}
                    </script>
                </ul>
            </div>
       </div>
</body>
<script>
   /* $("#mypositiontemplate1").loadData().then(function (result) {
        //result 服务器响应过来的数据
        if(result.data.list.length == 0){
            $('.main').append("<p style='text-align: center;margin-top: 8rem;'>没有相关职位！</p>");
        }
    });*/

    var page  = {"pageSize": "10", "currentPage": "1"};
    var ijobRefresh = new IJobRefresh({
        container: '.list-ul',
        up: function() {
            $("#mypositiontemplate1").appendData(page,ijobRefresh).then(function (result) {
                page.currentPage =  result.nextPage;
                $(window).scroll(function() {
                    var win_top = $(this).scrollTop();
                    if (win_top >= 170) {
                        $(".JobVtwo ").addClass("sfixed");
                    }else if (win_top < 170) {
                        $(".JobVtwo ").removeClass("sfixed");
                    }
                })
            });
        }
    });
</script>
