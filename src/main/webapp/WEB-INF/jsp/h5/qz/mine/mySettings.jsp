<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>设置</title>
    <script src="/ijob/lib//lib-flexible.js"></script>
    <script src="/ijob/lib/mui/js/mui.min.js"></script>
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/static/css/base.css">
    <link rel="stylesheet" href="/ijob/static/css/mine/mySettings.css">
</head>
<body>
<div class="wrap">
    <div>
        <a href="/ijob/api/InformationController/h5/mine/mySettings_changePassword">
            <span>修改密码</span>
            <i class="iconfont icon-arrow-right"></i>
        </a>
    </div>
    <div>
        <a href="/ijob/api/InformationController/h5/mine/mySettings_newsSettings">
            <span>推送设置</span>
            <i class="iconfont icon-arrow-right"></i>
        </a>
    </div>
    <div>
        <a href="javascript:void(0);">
            <span>检测更新</span>
            <small>当前<span class="version">${requestScope.UserSetting.gmversion}</span><i class="iconfont icon-arrow-right"></i></small>
        </a>
    </div>
    <div>
        <a href="/ijob/api/InformationController/h5/mine/mySettings_feedback">
            <span>帮助与反馈</span>
            <i class="iconfont icon-arrow-right"></i>
        </a>
    </div>
    <div>
        <a href="/ijob/api/InformationController/h5/mine/aboutUs">
            <span>关于我们</span>
            <i class="iconfont icon-arrow-right"></i>
        </a>
    </div>
</div>
</body>
</html>