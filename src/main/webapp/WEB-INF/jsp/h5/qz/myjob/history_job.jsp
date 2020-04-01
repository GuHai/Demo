<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/31
  Time: 18:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.yskj.utils.DateUtils,com.yskj.utils.IJobUtils" %>
<html>
<head>
    <title>历史职位</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/part/partstyle.css?version=4">
    <link rel="stylesheet" href="/ijob/static/css/index/homepage_firm.css?version=4">

</head>
<body>
<div class="wrap">
    <div class="page_check_pending historyJob ">
        <div class="Jobtips">
            这里只显示最近一年已经关闭的职位哦~
        </div>
        <div class="allJob_workList"id="workNumber" >
            <%--公司真心诚聘传单派发学生可兼职--%>
            <script type="text/html" id="shtemplate" data-url="/ijob/api/PositionController/getSHPosition/" data-type="POST">
                {{each list as position}}
                <div class="list-container">
                    <a href="javascript:void(0);"  class="link">
                        <div class="list-title">
                            <span class="title-content">{{position.positionSH.title}}</span>
                            <%--<span class="titel-note"><i>已招满</i></span>--%>
                        </div>
                        <div class="list-content">
                            <div class="content-tit" style="background:{{position.positionSH.huntingtype.codeGrade |getTypeColor}}!important;">{{position.positionSH.huntingtype | ifNull:'其他','name'}}</div>
                            <div class="content-msg">
                                <div class="content-msg1">
                                    <span class="content-msg1-lf"><i class="iconfont icon-shizhong"></i>{{position.positionSH.recruitStartTime | dateFormat:'MM月dd日' }} ({{position.positionSH.recruitStartTime | dateFormat:'周W' }})</span>
                                    <span class="content-msg1-rt">{{position.positionSH.dailySalary}}元/天</span>
                                </div>
                                <div class="content-msg2">
                                    <span class="content-msg2-lf">{{position.positionSH.sexRequirements | enums:'SexRequirements'}}&nbsp;<span class="line"></span>&nbsp;{{position.positionSH.personNumDay}}人/天</span>
                                    <span class="content-msg2-rt">{{position.positionSH.salaryType | enums:"SettlementType"}}</span>
                                </div>
                                <div class="content-msg3">
                                    <span class="content-msg3-lf">{{position.positionSH.workPlace |ifNull:'未知','city.cityName'}}&nbsp;<%-- {{position.positionSH.workPlace.distance | distance}}--%></span>
                                    <span class="content-msg3-rt">{{position.positionSH.contacts}}</span>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                {{/each }}
            </script>
        </div>
        <div class="allJob_workList" id="user" style="display: none;">
            <%--公司真心诚聘传单派发学生可兼职--%>
            <script type="text/html" id="historypositiontemplate" data-url="/ijob/api/PositionController/zp/historyPosition" data-type="POST">
                {{each list as posi index}}
                <div class="list-container">
                    <a href="javascript:void(0);"  class="link">
                        <div class="list-title">
                            <span class="title-content">{{posi.title}}</span>
                            <%--<span class="titel-note"><i>已招满</i></span>--%>
                        </div>
                        <div class="list-content">
                            <div class="content-tit" style="background:{{posi.huntingtype.codeGrade |getTypeColor}}!important;">{{posi.huntingtype.name}}</div>
                            <div class="content-msg">
                                <div class="content-msg1">
                                    <span class="content-msg1-lf"><i class="iconfont icon-shizhong"></i>{{posi.recruitStartTime | dateFormat:'MM月dd日' }} ({{posi.recruitStartTime | dateFormat:'周W' }})</span>
                                    <span class="content-msg1-rt">{{posi.dailySalary}}元/天</span>
                                </div>
                                <div class="content-msg2">
                                    <span class="content-msg2-lf">{{posi.sexRequirements | enums:'SexRequirements'}}&nbsp;<span class="line"></span>&nbsp;{{posi.personNumDay}}人/天</span>
                                    <span class="content-msg2-rt">{{posi.salaryType | enums:"SettlementType"}}</span>
                                </div>
                                <div class="content-msg3">
                                    <span class="content-msg3-lf">{{posi.workPlace |ifNull:'未知','city.cityName'}}&nbsp;<%-- {{position.positionSH.workPlace.distance | distance}}--%></span>
                                    <span class="content-msg3-rt">{{posi.contacts}}</span>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                {{/each }}
            </script>
        </div>
    </div>
</div>
</body>

<script>
    function initPage(){
        console.log();
        if(ijob.storage.get("workID")!=null){
            $("#shtemplate").data("url",$("#shtemplate").data("url")+ijob.location.get().lng + "/" + ijob.location.get().lat);
            $("#shtemplate").loadData({condition:{workID:ijob.storage.get("workID"),open:"'3','4'",status:2}}).then(function (result) {
            })
        }else{
            $("#user").show();
            $(".workNumber").hide();
            $("#historypositiontemplate").data("url",$("#historypositiontemplate").data("url")+"/"+ijob.storage.get("userID"))
            $("#historypositiontemplate").loadData().then(function (result) {
                //result 服务器响应过来的数据
                if (result.data.list.length == 0) {
                    $(".nodata").remove();
                    $('.main').append("<p style='text-align: center;margin-top: 5rem;'>没有相关职位！</p>");
                }
            });
        }
    }

    initPage();

</script>
</html>
