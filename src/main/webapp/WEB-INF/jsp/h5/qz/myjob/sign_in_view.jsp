<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/5
  Time: 19:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>签到详情</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/My_part-time/signIn.css?version=4">
    <style>


    </style>
</head>
<body>
<div class="wrap">
    <div class="page_sign_in_view">
        <div class="sign_list_box">
            <ul class="sign-box">
                <script id="todayJob"   type="text/html"    data-type="GET" >
                    {{each list as sign}}
                    <%--有签到内容--%>
                    <li>
                        <div class="sign-hd">
                        <span class="left">
                            <span class="iconfont icon-fujin"></span>
                            <span class="addr">{{sign.address.detailedAddress}}</span>
                        </span>
                            <span class="right">
                            <span class="time">{{sign.signTime | dateFormat:'hh:mm'}}</span>
                        </span>
                        </div>

                        <div class="img-box">
                            <section class=" img-section">
                                <div class="z_photo upimg-div clearfix" >
                                    {{each sign.attachmentList as atta}}
                                    <section class="z_file fl">
                                        <img class="up-img" src="/ijob/upload/{{atta.absolutelyPath}}" />
                                    </section>
                                    {{/each}}
                                </div>
                            </section>
                        </div>
                    </li>

                    <%--无签到内容--%>
                    {{if sign.signBack}}
                    <li>
                        <div class="sign-hd">
                        <span class="left">
                            <span class="iconfont icon-fujin"></span>
                            <span class="addr">{{sign.backAddress.detailedAddress}}</span>
                        </span>
                            <span class="right">
                            <span class="time">{{sign.signBack | dateFormat:'hh:mm'}}</span>
                        </span>
                        </div>

                        <div class="img-box">
                            <section class=" img-section">
                                <div class="z_photo upimg-div clearfix" >
                                    {{each sign.backAttachmentList as atta}}
                                    <section class="z_file fl">
                                        <img class="up-img" src="/ijob/upload/{{atta.absolutelyPath}}" />
                                    </section>
                                    {{/each}}
                                </div>
                            </section>
                        </div>
                    </li>
                    <div class="content">
                        备注：{{sign.mark}}
                    </div>
                    {{/if}}

                    {{/each}}
                </script>
            </ul>
        </div>
    </div>
</div>
<div id="homepage"></div>
</body>
<jsp:include page="../../qz/base/resource.jsp"/>
<script src="/ijob/static/js/slidePhoto.js"></script>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});
    $("#todayJob").data("url","/ijob/api/SigninController/getSignInfo/"+ijob.storage.get("sign.id"));
    $("#todayJob").loadData({}).then(function(result){
        new SlidePhoto(".up-img");
    });

</script>
</html>
