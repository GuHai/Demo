<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/1/9
  Time: 10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>提示</title>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/insurance/insurance.css?version=4">
</head>
<body>
<div class="page_prompt">
    <div class="icon-box">
        <span class="iconfont icon-shijian"></span>
        <p class="success">上传成功</p>
        <p class="tips">客服正在努力为您购保中</p>
    </div>
    <div class="foot-flex">
        <p class="note">注：如购买当月的保险，购买次日的0点开始生效</p>
        <a href="javascript:void(0);" class="reback" onclick="ijob.gotoPage({path:'/h5/zp/insurance/insured_record'})">返回</a>
    </div>
</div>
</body>
<script>
    ijob.storage.clear();
    $(function(){
        if (window.history && window.history.pushState) {
            $(window).on('popstate', function () {
                window.history.pushState('forward', null, '#');
                window.history.forward(1);
                ijob.gotoPage({path:'/h5/zp/insurance/insured_record'});
            });
        }
        window.history.pushState('forward', null, '#');
        window.history.forward(1);
    });
</script>
</html>
