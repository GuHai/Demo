<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/8
  Time: 16:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>简历详情</title>
    <jsp:include page="../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/add_preview.css">
    <script src="/ijob/static/js/ijobbase.js"></script>
    <meta name="format-detection" content="telephone=no"/>
    <style>
        .wrap {
            background-color: #f2f5f7;
        }

        .contentBox {
            border-bottom: 1px solid #cccfd0;
            padding-bottom: 0.533rem;
        }

        /*.wrap .summary{background:#fff;height:auto;padding:55px 17px 10px 17px;}*/
        .wrap .summary {
            background: #fff;
            height: auto;
            padding: 0.266rem 0.453rem 0.266rem 0.453rem;
        }

        .wrap .details p {
            color: #666;
        }

        .wrap .details > dd .school .discipline > p {
            margin: 0;
        }

        .wrap .details > dd .work .post > p {
            margin: 0;
        }

        .wrap .details > dd .certificate > p:last-child {
            margin: 0;
        }

        .wrap .details > dd .certificate > p:first-child {
            margin: 0;
        }

        .wrap .details > dd .school {
            border-bottom: 1px solid #d7d7d7;
        }

        .post {
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .wrap .details > dd {
            padding-left: 0.320rem;
            text-indent: 0px;
        }

       /* .wrap .details > dd .work {
            border-bottom: 1px solid #d7d7d7;
        }*/

        .wrap .details > dd .imgBox {
            width: 100%;
        }

        .wrap .details > dd .imgBox img {
            max-width: 100%;
            height: 5.333rem;
            padding-right: 10px;
            padding-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="wrap1">
<script type="text/html" id="zppreviewresumetemplate"
        data-url="/ijob/api/ResumeController/h5/zp/index/getResumeForRecruit/${id}">
    <div class="wrap">
        {{each list as resume}}
        <div class="summary">
            <div class="headerImg">
                {{if resume.attachment != null}}
                <img style="border-radius: 50%" class="headerImg" src="/ijob/upload/{{resume.attachment.absolutelyPath}}"
                     onerror="this.src='{{resume.user.weixin.headimgurl}}';this.onerror=null;"/>
                {{else if resume.user.attachment != null }}
                <img style="border-radius: 50%" class="headerImg"
                     src="/ijob/upload/{{resume.user.attachment |ifNull:'','absolutelyPath'}}"
                     onerror="this.src='{{resume.user.weixin.headimgurl}}';this.onerror=null;"/>
                {{else}}
                <img style="border-radius: 50%" class="headerImg" src="{{resume.user.weixin.headimgurl}}"/>
                {{/if}}
            </div>
            <div class="contentBox">
                <p style="height: 0.800rem;">
                    {{resume.resumeName}}<span>{{resume.educationalList[0]}}</span>
                </p>
                <p>
                    {{each resume.intentiontypeList as intentiontype index}}
                    {{if index < 3}}
                    {{if index!=0 }}|{{/if}} {{intentiontype | ifNull:'其他','huntingtype.name'}}
                    {{/if}}
                    {{/each}}
                </p>
            </div>
            <div class="H-contP">
                <p>
                    今年{{resume.user.birthday | dateFormat:'AA'}}岁，身高{{resume.height}}，体重{{resume.weight}}公斤。
                    {{resume.evaluation}}
                </p>
            </div>
        </div>
        <dl class="details mb65">
            <dt>
                <h1 style="padding-top: 0.267rem;">教育背景</h1>
            </dt>
            {{if resume.educationalList.length != 0}}
            <dd style="margin-top:0.400rem;">
                {{each resume.educationalList as item}}
                <div class="school">
                    <div class="discipline">
                        <p>{{item.schoolName}}</p>
                        <p>{{item.education}}</p>
                    </div>
                    <p class="specialty">{{item.association}}
                    </p>
                </div>
                {{/each}}
            </dd>
            {{else}}
            无
            {{/if}}
            <dt>工作经历</dt>
            {{if resume.workexperienceList.length != 0}}
            <dd>
                {{each resume.workexperienceList as item}}
                <div class="work">
                    <h2>{{item.companyName}}</h2>
                    <div class="post">
                        <p>{{item.jobName}}</p>
                        <%--<p>{{item.startTime | dateFormat:'yyyy.MM'}}-{{item.endTime | dateFormat:'yyyy.MM'}}</p>--%>
                    </div>
                    <p class="work_msg">
                        {{item.jobContent}}
                    </p>
                </div>
                {{/each}}
            </dd>
            {{else}}
            无
            {{/if}}
            <%--<dt>证件</dt>
            {{if resume.documentList.length != 0}}
            <dd>
                {{each resume.documentList as item}}
                <div class="certificate">
                    <p>{{item.documentName}}</p>
                    <p>有效期：{{item.effective | dateFormat:'yyyy.MM.dd'}}</p>
                </div>
                {{if item.attachment}}
                {{if item.attachment.name}}
                <div class="imgBox">
                    <img width="365px" height="200px" src="/ijob/upload/{{item.attachment | absolutelyPath}}" alt="">
                </div>
                {{/if}}
                {{/if}}
                {{/each}}
            </dd>
            {{else}}
            无
            {{/if}}--%>
        </dl>
        <div class="mui-hbutton mui-hbutTwo rx_fixed">
            {{if resume.phoneNumber!=null&&resume.phoneNumber!=''}}
                <a href="tel:{{resume.phoneNumber}}">打电话</a>
            {{/if}}
            <a href="javascript:void(0);"
               onclick="ijobbase.toChat({toUserID:'${userID}'})">发消息</a>
        </div>
        {{/each}}
    </div>
</script>
</div>
<div id="homepage"></div>
</body>
</html>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});
    $("#zppreviewresumetemplate").loadData().then(function (result) {

    });
</script>