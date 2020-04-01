<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>帮助与反馈</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/base.css?version=4">
    <link rel="stylesheet" href="/ijob/static/css/mine/mySettings_feedback.css?version=4">
</head>
<body>

<div class="wrap">
    <%--<div class="heep-zpgl">
        <h1>招聘攻略</h1>
        <p>招聘必看教程</p>
        <p>招聘必看教程</p>
    </div>
    <div class="heep-shlc">
        <h1>审核流程</h1>
        <p>为什么职位审核失败</p>
        <p>审核一般需要多久</p>
    </div>
    <div class="heep-shlc">
        <h1>违约金的算法</h1>
        <p>违约金　 &gt;=　 招聘人数　 * 　日薪资　 *　 25% </p>
    </div>--%>
    <%--<div class="btn_fixed">
        <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/qz/mine/SubmitFeedback'})" class="btn">我要反馈</a>
    </div>--%>
    <div class="page_feedback">
        <div class="list">
            <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/qz/mine/SubmitFeedback'})"  class="link">
                <span class="txt">举报与投诉</span>
                <span class="iconfont icon-arrow-right"></span>
            </a>
        </div>
        <div class="list">
            <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/qz/mine/SubmitAdvise'})" class="link">
                <span class="txt">产品功能建议</span>
                <span class="iconfont icon-arrow-right"></span>
            </a>
        </div>
        <div class="list">
            <a href="javascript:void(0);" class="link"  onclick="ijob.gotoPage({path:'/h5/qz/mine/using_help'})" >
                <span class="txt">使用帮助</span>
                <span class="iconfont icon-arrow-right"></span>
            </a>
        </div>
    </div>
</div>
</body>
</html>