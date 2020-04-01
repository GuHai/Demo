<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.yskj.service.base.DictCacheService" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>预览简历</title>
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/static/css/base.css">
    <link rel="stylesheet" href="/ijob/static/css/mine/add_preview.css">
    <script src="/ijob/lib/template.js"></script>
    <script src="/ijob/static/js/templateUtils.js"></script>
    <script src="/ijob/lib//lib-flexible.js"></script>
    <script src="/ijob/lib/mui/js/mui.min.js"></script>
    <script src="/ijob/lib/jquery-2.2.3.js"></script>
    <script src="/ijob/static/js/ijob.js"></script>
</head>
<body>

<div class="wrap">
    <script type="text/html" id="findForPreview" data-url="/ijob/api/ResumeController/findForPreview/{resumeID}"
            data-type="GET">
        {{each list as map}}
        <div class="summary">
            <img class="headerImg" alt=""
                 src="/ijob/upload/{{map.Resume.imgPath}}"
                 onerror="this.src='/ijob/static/images/default.jpg';this.onerror=null">
            <div class="contentBox">
                <p>
                    {{map.Resume.resumeName}}
                </p>
                <p>
                    <span class="mar-left">
                    {{if map.Resume.sex == 1}}
                        男
                    {{else if map.Resume.sex == 2}}
                        女
                    {{else}}
                        保密
                    {{/if}}
                    <span class="ver-line"></span>{{map.Resume.age}}岁</span>
                </p>
                <%--<p>
                    {{if map.Resume.marriage == 1}}
                    未婚
                    {{else if map.Resume.marriage == 2}}
                    已婚未育
                    {{else if map.Resume.marriage == 3}}
                    已婚已育
                    {{else}}
                    保密
                    {{/if}}
                    <span>{{map.Resume.residence}}</span>
                </p>--%>
            </div>
        </div>
        <dl class="details">
            <dt>
                <h1>联系方式</h1>
            </dt>
            <dd>
                <p><span>手机号：</span>{{map.Resume.phoneNumber}}</p>
                {{if map.Resume.email}}
                <p><span>邮　箱：</span>{{map.Resume.email}}</p>
                {{/if}}
            </dd>
            {{if map.Resume.evaluation}}
            <dt>
                <h1>自我评价</h1>
            </dt>
            <dd>
                <p>{{map.Resume.evaluation || '无'}}</p>
            </dd>
            {{/if}}
            <dt>
                <h1>教育背景</h1>
            </dt>
            {{if map.Resume.educationalList.length != 0}}
            <dd>
                {{each map.Resume.educationalList as item}}
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
            <dd><p class="null">无</p></dd>
            {{/if}}

            <dt><h1>工作经历</h1></dt>
            {{if map.Resume.workexperienceList.length != 0}}
            <dd>
                {{each map.Resume.workexperienceList as item}}
                <div class="work">
                    <h2>{{item.companyName}}</h2>
                    <div class="post">
                        <p>{{item.jobName}}</p>
                        <%--{{item.startTime | dateFormat:'yyyy.MM'}}-{{item.endTime | dateFormat:'yyyy.MM'}}--%>
                    </div>
                    <p class="work_msg">
                        {{item.jobContent}}
                    </p>
                </div>
                {{/each}}
            </dd>
            {{else}}
            <dd><p class="null">无</p></dd>
            {{/if}}

           <%-- <dt><h1>证件</h1></dt>
            {{if map.Resume.documentList.length != 0}}
            <dd>
                {{each map.Resume.documentList as item}}
                <div class="certificate">
                    <p>{{item.documentName}}</p>
                    <p>有效期：{{item.effective | dateFormat:'yyyy-MM-dd'}}</p>
                </div>
                {{if item.attachment}}
                {{if item.attachment.name}}
                <div class="imgBox">
                    <img src="/ijob/upload/{{item.attachment.path}}/{{item.attachment.datestr}}/{{item.attachment.name}}"
                         alt="">
                </div>
                {{/if}}
                {{/if}}
                {{/each}}
            </dd>
            {{else}}
            无
            {{/if}}--%>
        </dl>
        </div>
<%--        <div class="btnBox">
            <botton class="btn_back"
                    onclick="javascript:history.go(-1);">
                返回
            </botton>
        </div>--%>
        {{/each}}
    </script>
</div>
<div id="homepage"></div>
</body>
</html>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});
    $(function () {
        $("#findForPreview").loadData().then(function(result){
            if(!result.data.list[0].Resume.imgPath){
                $('.headerImg').prop("src",ijob.storage.get('userHeadImg'));//默认用微信的
            }
        });
    });
</script>