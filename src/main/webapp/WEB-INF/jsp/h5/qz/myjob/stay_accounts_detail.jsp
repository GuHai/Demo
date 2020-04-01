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
    <title>我的兼职</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <script src="/ijob/static/js/ijobbase.js?version=5"></script>
    <link rel="stylesheet" href="/ijob/static/css/My_part-time/My_part-time_job.css">
</head>
<body>

    <div class="wrap">

        <div class="main">

            <div class="partTime" style="display: block;">

                <div class="partTime_content">

                    <div class="allJob">

                        <div class="allJob_workList" style="margin-top: 0;margin-bottom: 0.267rem">
                            <script id="scanTemplate" type="text/html" data-url="/ijob/api/ApplySettlementController/findWaitRushList" data-type="POST">
                                {{each list as posi}}
                                    <div class="list-container">

                                        <div class="list-title">

                                            <span class="title-content">{{posi.title}}</span>

                                        </div>

                                        <div class="btnBox">

                                            <a href="tel:{{posi.phoneNumber}}"><input type="button" value="联系商家" class="btn_contact"></a>

                                            <input type="button" value="咨询" class="btn_advisory" onclick="ijobbase.toChat({toUserID:'{{posi.createBy}}'})">

                                            <input type="button" value="催结算" class="btn_status" data-id="{{posi.id}}" data-version="{{posi.version}}" data-url="/ijob/api/ApplySettlementController/rushSettlement">

                                        </div>

                                    </div>
                                {{/each}}
                            </script>

                        </div>

                    </div>

                </div>

            </div>

        </div>
        <div id="homepage"></div>
    </div>

</body>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});
    $("#scanTemplate").loadData().then(function (result) {
        $(".btn_status").on("click",function () {
            var obj = {
                id:$(this).data("id"),
                version:$(this).data("version"),
                isRush:true
            }
            $(this).btPost(obj,function (result) {
                if(result.code==200){
                    mui.alert("已催结算！");
                }else {
                    mui.alert(result.msg);
                }
            });
        });
    });
</script>

</html>
