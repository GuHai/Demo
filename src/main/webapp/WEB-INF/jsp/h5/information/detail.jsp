<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>我的动态信息</title>
    <script src="/ijob/static/js/jquery-3.1.1.min.js"></script>
    <script src="/ijob/lib//lib-flexible.js"></script>
    <link rel="stylesheet" href="/ijob/lib/mui/fonts/mui.ttf">
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <script src="/ijob/lib/mui/js/mui.min.js"></script>
    <script src="/ijob/static/js/ijob.js"></script>
    <script src="/ijob/lib/template.js"></script>
    <script src="/ijob/static/js/attachment.js"></script>
    <script src="/ijob/static/js/templateUtils.js"></script>
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/static/css/base.css">
    <link rel="stylesheet" href="/ijob/static/css/infprmation/added.css">
</head>
<body>
<div class="wrap">
    <script id="todayJob"   type="text/html"  data-url="/ijob/api/ParttimeinformationController/one"  >
        {{each list as part}}
        <div class="">
            <textarea name="releaseContent" value="{{part.releaseContent}}" cols="30" rows="10"></textarea>
        </div>
        <div class="img-box">
            <section class=" img-section">
                <div class="z_photo upimg-div clearfix" id="photes">
                    {{each part.attachmentList as atta}}
                    <section  class="z_file fl">
                        <img  data-editable="true" class="attachment up-img" data-name="attachmentList0" data-type="Photos"
                              style="height: 100%;width: 100%"
                              src="/ijob/upload/{{atta | absolutelyPath }}" alt=""
                              onerror="this.src='/ijob/static/images/a11.png';this.onerror=null">
                    </section>
                    {{/each}}
                </div>
            </section>
        </div>
        {{/each}}
    </script>
</div>
</body>
<script>
    $("#todayJob").loadData({
        condition:{
            "id":"${id}"
        }
    });
</script>
</html>
