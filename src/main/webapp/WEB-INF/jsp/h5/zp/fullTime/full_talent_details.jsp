<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/8
  Time: 10:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>人才详情</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/fullTime/fullTime.css?version=4">
</head>
<body>
<div class="full-talent-details">
    <%--个人信息--%>
    <script id="resumeLoad" type="text/html" data-url="/ijob/api/FullTimeController/loadResume/{prb.id}">
        {{each list as resume}}
            <div class="inform-box">
                <div class="hd-main">
                    <div class="txt-box">
                        <div class="name">{{resume.resume.resumeName}}</div>
                        <div class="workname">{{resume.post.title}}</div>
                        <div class="companyname">{{resume.post.company.company}}</div>
                    </div>
                    <div class="photo">
                        <img src="/ijob/upload/{{resume.resume.attachment.absolutelyPath}}" onerror="this.src='{{resume.resume.imgPath}}';this.onerror=null"/>
                    </div>
                </div>
                <div class="content-main">
                    <div class="flex">
                        <span>{{resume.resume.sex |enums:'SexType'}}{{if resume.resume.sex!=null}}·{{if resume.resume.age!=null}}{{resume.resume.age}}岁{{/if}}{{/if}}{{if resume.resume.schoolLevel!=null}}·{{resume.resume.schoolLevel |enums:'EduLevel'}}{{/if}}</span>
                        {{if resume.broker!=null}}
                        <span>推荐人：{{resume.broker.name}}</span>
                        {{/if}}
                    </div>
                    <div class="tel">联系方式：{{resume.resume.phoneNumber}}</div>
                    {{if resume.resume.evaluation!=""&&resume.resume.evaluation!='null'&&resume.resume.evaluation!=null&&resume.resume.evaluation!='nullnull'}}
                    <div class="remark" id="remark">{{resume.resume.evaluation}}</div>
                    {{/if}}
                </div>
            </div>
            <%--工作经历--%>
            {{if resume.resume.workexperienceList != null}}
                <div  class="experience-box">
                    <div class="work-list">
                        <div class="title">工作经历</div>
                        <ul>
                            {{each resume.resume.workexperienceList as workexperience}}
                            <li class="ul-li">
                                <div class="name">{{workexperience.companyName}}</div>
                                <div class="flex">
                                    <span class="txt">{{workexperience.jobName}}</span>
                                    <%--<span class="time">2017.3-2017.6</span>--%>
                                </div>
                                <div class="content">{{workexperience.jobContent}}</div>
                            </li>
                            {{/each}}
                        </ul>
                    </div>
                </div>
            {{/if}}
            <div class="clearfix" style="clear: both;height: 2rem;overflow: hidden;content: '';"></div>
            <%--工作经历 end--%>
            <%--个人信息 end--%>
            <footer class="footbox">
                <a href="tel:{{resume.resume.phoneNumber}}" class="tel">打电话</a>
            </footer>
        {{/each}}
    </script>
</div>
</body>
</html>
<script>
    $(function () {

        $("#resumeLoad").loadData().then(function (result) {
            console.log(result);
            if(result.data.list[0].resume.workexperienceList.length==0){
                $(".experience-box").hide();
            }

            // 判断备注或者自我评价是否为空
            if ($("#remark").text() == '' || $("#remark").text() == null){
                $("#remark").remove();
            }
        });

    })
</script>
