<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/8
  Time: 16:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>评价详情</title>
    <jsp:include page="../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/myFans.css">
</head>
<body>
<style>
    .mui-table-view:before{background-color:#fff;}
    .mui-table-view-cell:after{background-color:#fff;}
    .mui-table-view:after{background-color:#fff;}
    .wrap .mui-table-view-cell{border-bottom:0;}
    .wrap .mui-table-view-cell{padding:0.266rem 0px;}
    .mui-table-view-cell>a:not(.mui-btn){padding:0.266rem 0.8rem;}
    .evaluatelist{
        padding: 5px;
        margin: 5px;
    }
</style>

<script type="text/html" id="mypositiontemplate" data-url="/ijob/api/EvaluateController/h5/zp/getEvaluateInfo/{evaluate.id}">
    {{each list as eva }}
        <div class="wrap">
            <ul id="refresh" class="mui-table-view">
                <li class="mui-table-view-cell mui-media">
                    <div class="evaluatelist">
                        <a href="javascript:void(0);">
                            <img class="mui-media-object mui-pull-left" src="/ijob/upload/{{eva.user.attachment | absolutelyPath}}" onerror="this.src='{{eva.user.weixin.headimgurl}}';this.onerror=null">
                            <div class="mui-media-body">
                                {{eva.user.realName}}
                                <p class="mui-ellipsis">{{eva.evaluateTime | dateFormat:'yyyy年MM月dd日 hh:mm:ss'}}</p>
                            </div>
                        </a>
                        <div class="hev-com">
                            <div class="hev-comTbox">
                                <div class="hev-comT">
                                    <p>{{eva.evaluateContent}}</p>
                                    <p style="margin-top:5px;">
                                        {{if eva.attachmentList != null }}
                                            {{each eva.attachmentList as atta }}
                                                <img style="height: 2.933rem" src="/ijob/upload/{{atta | absolutelyPath}}" alt="" />
                                            {{/each}}
                                        {{else}}
                                            无图片
                                        {{/if}}
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="evaluatelist">
                        <a href="javascript:void(0);">
                            <img class="mui-media-object mui-pull-left" src="/ijob/upload/{{eva.replyUser.attachment | absolutelyPath}}" onerror="this.src='{{eva.replyUser.weixin.headimgurl}}';this.onerror=null">
                            <div class="mui-media-body">
                                {{eva.replyUser.realName}}
                                <p class="mui-ellipsis">{{eva.updateTime | dateFormat:'yyyy年MM月dd日 hh:mm:ss'}}</p>
                            </div>
                        </a>
                        <div class="hev-com">
                            <div class="hev-comTbox" style="border-bottom: 0px ">
                                <div class="hev-comT" >
                                    <p>{{eva.reply}}</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%--<div class="hev-com">
                        <div class="hev-comTbox">
                            <div class="hev-comT">
                                <p>{{eva.position.evaluateContent}}</p>
                                <p style="margin-top:5px;">
                                    {{if eva.position.attachmentEvaluate != null}}
                                        <img style="width: 100%;height: 50%;" src="/ijob/upload/{{eva.position.attachmentEvaluate | absolutelyPath}}" alt="" />
                                    {{else}}
                                    无图片
                                    {{/if}}
                                </p>
                            </div>
                        </div>
                    </div>--%>
                </li>
            </ul>
        </div>
    {{/each}}
</script>
</body>
</html>
<script>
    $("#mypositiontemplate").loadData().then(function (result) {
        //result 服务器响应过来的数据
    });

    function jumpPage(){
        var state = ijob.storage.get("data.positionID");
        ijob.gotoPage({path:'/h5/zp/evaluate_yes?id='+state});
    }
</script>
