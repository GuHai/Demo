<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>提交成功</title>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/fullTime/fullTime.css?version=4">
</head>
<body>
<div class="wrap">
    <div class="page_success">
        <div class="hd_result">
            <div class="icon">
                <span class="iconfont icon-gou1"></span>
            </div>
            <p class="state">提示</p>
            <p  class="tips">职位发布成功</p>
        </div>
        <div class="btnbox">
            <a href="javascript:void(0)" class="postbtns" onclick="ijob.storage.clear();ijob.gotoPage({path:'/h5/zp/fullTime/postJob?full.id=0'})">继续发布</a>
            <a href="javascript:void(0)" class="back" onclick="ijob.storage.clear();ijob.gotoPage({path:'/h5/zp/fullTime/fullRecruiting'})">返回</a>
        </div>
    </div>
</div>
</body>
</html>
