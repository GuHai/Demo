<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>推送设置</title>
    <script src="/ijob/lib//lib-flexible.js"></script>
    <script src="/ijob/lib/mui/js/mui.min.js"></script>
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/static/css/base.css">
    <link rel="stylesheet" href="/ijob/static/css/mine/mySettings_newsSettings.css">
    <script>
        mui.init();
    </script>
</head>
<body>
<div class="wrap">
    <input value="${UserSetting.version}" id="version" type="hidden">
    <input value="${UserSetting.id}" id="id" type="hidden">
    <div class="systemMsg">
        <div class="systemMsg-text">
            <p>系统通知</p>
            <p>系统通知兼职中的相关信息和公告</p>
        </div>
        <div class="mui-switch mui-switch-mini <c:if test="${UserSetting.gmnotic eq true}">mui-active</c:if>" data-id="gmnotic">
            <div class="mui-switch-handle"></div>
        </div>
    </div>
    <div class="chatMsg">
        <div class="chatMsg-text">
            聊天信息
        </div>
        <div class="mui-switch mui-switch-mini <c:if test="${UserSetting.chatinfo eq true}">mui-active</c:if>" data-id="chatinfo">
            <div class="mui-switch-handle"></div>
        </div>
    </div>
</div>
</body>
<script src="/ijob/static/js/jquery-3.1.1.min.js"></script>
<script>
    $(".mui-switch").click(function(){
        var params = {
            version:$("#version").val(),
            id:$("#id").val()
        }
        if($(this).hasClass("mui-active")){
            if ($(this).data("id") == "gmnotic"){
                params.gmnotic = true;
            }else{
                params.chatinfo = true;
            }
            $.post("/ijob/api/UserSettingController/update",params,
            function(data){
                if(data.code == 200){
                    $("#version").val((parseInt($("#version").val()) + 1));
                }
            });
        }else{
            if ($(this).data("id") == "gmnotic"){
                params.gmnotic = false;
            }else{
                params.chatinfo = false;
            }
            $.post("/ijob/api/UserSettingController/update",params,
                function(data){
                    if(data.code == 200){
                        $("#version").val((parseInt($("#version").val()) + 1));
                    }
                });
        }
    });
</script>
</html>