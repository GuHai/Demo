<%@ page contentType="text/html;charset=UTF-8" language="java"   import="com.yskj.service.base.DictCacheService" %><!DOCTYPE html>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>基础信息</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/basicInfo.css">
</head>
<body>
<script>

</script>
<script type="text/html" id="baseInfo" data-url="/ijob/api/InformationController/h5/mine/getBasicInfo" data-type="POST">
    {{each list as base}}
    <div class="wrap">
        <div class="main">
            <ul class="selectList">
                <li class="info_avatar">
                    <a href="/ijob/UserController/h5/myHead">
                        <span class="">头像</span>
                        <span class="info_avatar_img">
                            <img  src="<shiro:principal property="imgPath"/>"  alt=""
                                 onerror="this.src='/ijob/static/images/default.jpg';this.onerror=null">
                            <i class="iconfont icon-arrow-right"></i>
                        </span>
                    </a>
                </li>
                <li class="info_nick">
                    <a href="/ijob/api/InformationController/h5/mine/basicInfo_nickname">
                        <span class="">昵称</span>
                        <span class="info_nick_modify">
                            {{base.user.nickName | ifNull: '无'}}
                            <i class="iconfont icon-arrow-right"></i>
                        </span>
                    </a>
                </li>
                <li class="info_code">
                    <a href="/ijob/api/InformationController/h5/mine/toQrcode">
                        <span class="">二维码</span>
                        <span class="info_code_modify">
                            <i class="iconfont icon-erweima code-erweima"></i>
                            <i class="iconfont icon-arrow-right code-right"></i>
                        </span>
                    </a>
                </li>
                <li class="info_JobNumber">
                    <a href="/ijob/api/InformationController/h5/mine/basicInfo_JobNumber">
                        <span class="">工作号</span>
                        <span class="info_JobNumber_sel">
                            {{base.Information.workNumber | ifNull:'无工作号'}}
                            <i class="iconfont icon-arrow-right code-right"></i>
                        </span>
                    </a>
                </li>
                <li class="info_name">
                    <a href="javascript:void(0);">
                        <span class="">姓名</span>
                        <span class="info_name_modify">
                            {{base.user.realName | ifNull: '无'}}</span>
                    </a>
                </li>
                <li class="info_card">
                    <a href="javascript:void(0);" onclick=" ijob.gotoPage({path:'/h5/qz/mine/realName'})">
                       <%-- <span class="">身份证号</span>
                        <span class="info_card_modify">{{base.user.idcard | ifNull: '无'}}</span>--%>
                           <span class="">实名认证</span>
                           <span class="info_JobNumber_sel" style="color: #b4b4b4;">
                            <i class="iconfont icon-arrow-right code-right"></i>
                        </span>
                    </a>
                </li>
                <li class="info_phone">
                    {{if base.user.phoneNumber}}
                     <a href="/ijob/api/InformationController/h5/mine/basicInfo_modifyPhone">
                     {{else}}
                     <a href="/ijob/forward?path=/h5/qz/mine/realName">
                    {{/if}}
                        <span class="">手机号</span>
                        <span class="info_tel">{{base.user.phoneNumber | ifNull: '无'}}
                            <i class="iconfont icon-arrow-right"></i></span>

                    </a>
                </li>
                <%--<li class="info_hobbies">
                    <a href="/ijob/api/InformationController/h5/mine/basicInfo_EditProfile">
                        <span class="">简介</span>
                        <span class="hobbies_infoBox">
                            <span id="about"  class="hobbies_info">{{base.Information.brief | ifNull: '无'}}</span>
                            <i class="iconfont icon-arrow-right"></i>
                        </span>
                    </a>
                </li>--%>
            </ul>
        </div>
    </div>
    {{/each}}
</script>

</body>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>
    (function ($) {
        window.addEventListener('pageshow', function (e) {
            // 通过persisted属性判断是否存在 BF Cache
            if (e.persisted) {
                location.reload();
            }
        });
    })(mui);
    $("#baseInfo").loadData().then(function (result) {
        var about=$("#about").text().trim();
        $("#about").text(about.length > 15 ? about.substring(0,15)+"..." : about);
    })
</script>
</html>