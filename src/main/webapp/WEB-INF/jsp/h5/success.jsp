<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>提交成功</title>
    <jsp:include page="qz/base/resource.jsp"/>
    <jsp:include page="qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/recharge.css?version=4">
</head>
<body>
<div class="wrap">
    <div class="page_success">
        <div class="hd_result">
            <div class="icon">
                <span class="iconfont icon-gou1"></span>
            </div>
            <p class="state">提交成功</p>
            <p  class="tips">预计7天之内送达</p>
        </div>
        <div class="btnbox">
            <a href="javascript:void(0)" class="back">返回</a>
        </div>
    </div>
</div>
</body>
</html>

<script>
    if(ijob.storage.get("data.type")==1){
        $(".hd_result .tips").text("等待管理员审核");
    }else if(ijob.storage.get("data.type")==3){
        $(".hd_result .tips").text("等待招聘者为您购买保险");
    }
    $(".back").click(function () {
        if(ijob.storage.get("data.type")==1){
            ijob.gotoPage({url:"/h5/invoiceIndex"})
        }else if(ijob.storage.get("data.type")==3){
            ijob.gotoPage({url:"/indexMain"})
        }
    });
</script>


<script type="text/javascript">
    $(function() {
        if (window.history && window.history.pushState) {
            $(window).on('popstate', function () {
                if(ijob.storage.get("data.type")==3){
                    window.history.pushState('forward', null, '#');
                    window.history.forward(1);
                    ijob.gotoPage({url:"/indexMain"})
                }else{
                    ijob.reback();
                }

            });
        }
        window.history.pushState('forward', null, '#');
        window.history.forward(1);
    })
</script>