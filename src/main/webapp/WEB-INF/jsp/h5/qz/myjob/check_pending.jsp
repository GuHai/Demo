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
    <title>待审核</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/part/partstyle.css?version=4">
    <link rel="stylesheet" href="/ijob/static/css/index/homepage_firm.css?version=4">

</head>
<body>
<div class="wrap">
    <div class="page_check_pending">
        <div class="allJob_workList">
            <script type="text/html" id="shtemplate" data-url="/ijob/api/PositionController/getSHPosition/" data-type="POST">
                {{each list as position}}
                    <div class="list-container">
                        <a href="javascript:void(0);"  class="link" onclick="ijob.gotoPage({path:'/h5/qz/myjob/check_pending_details?id={{position.id}}'})">
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
                                        <span class="content-msg3-lf">{{position.positionSH.workPlace |ifNull:'未知','city.cityName'}}&nbsp; {{position.positionSH.workPlace.distance | distance}}</span>
                                        <span class="content-msg3-rt">{{position.positionSH.contacts}}</span>
                                    </div>
                                </div>
                            </div>
                        </a>
                        <div class="btnBox">
                            <input type="button" value="不通过" data-url="/ijob/api/PositionController/audit/3/{{position.id}}" class="btn_fail aaa">
                            <input type="button" value="通过审核" data-url="/ijob/api/PositionController/audit/2/{{position.id}}"class="btn_adopt aaa">
                        </div>
                    </div>
                {{/each}}
            </script>
        </div>
    </div>
</div>
</body>

<script>

    function initPage(){
        $("#shtemplate").data("url",$("#shtemplate").data("url")+ijob.location.get().lng + "/" + ijob.location.get().lat);
        $("#shtemplate").loadData({condition:{workID:ijob.storage.get("workID"),open:"'2'",status:1}}).then(function (result) {
            console.log(result);
            $(".aaa").click(function(){
                $(this).btPost(null,function(result){
                    if(result.code == 200){
                        mui.alert("操作成功",function () {
                            location.reload();
                        });
                        $(".foot-fixed").hide();
                    }else {
                        mui.alert("请重新加载页面！");
                    }
                })
            });
        })
    }

    initPage();

</script>
</html>
