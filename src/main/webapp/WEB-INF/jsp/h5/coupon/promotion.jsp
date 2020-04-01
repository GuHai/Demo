<%@ page import="com.yskj.service.base.DictCacheService" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/7/29
  Time: 17:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<%--
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, viewport-fit=cover">
--%>
    <title>求职者</title>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <jsp:include page="../../h5/qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/coupon.css?version=4">
    <script src="/ijob/static/js/ijobbase.js?version=<%=DictCacheService.Version%>"></script>
    <style>
        .bottomtext{padding: 0 10px;height: 30px;background-color: #fff;display: flex;justify-content: space-between;align-items: center;width: 100%;bottom:0px;position: absolute}
    </style>
</head>
<body>
<div class="wrap" id="wrap">
<%--    <div id="mainPage">--%>
<%--        欢迎来的推广大使活动页面，这个页面需要等前端来完善。--%>
<%--    </div>--%>
    <header class="hd-notice">
        <div class="img">
            <img src="/ijob/static/images/notice.png">
        </div>
        <div class="text">
            新人礼只能二选一
        </div>
    </header>
    <section class="promotion-page">
        <h2 class="title tit3" style="height: 30px;"></h2>
        <ul class="ul-li">
            <script id="cardlist"   type="text/html"  data-url="/ijob/api/ApiPromotionController/cardList"  >
                {{each list as pro}}
                    <li>
                        <a href="javascript:void(0)">
                            <img src="/ijob/static/images/{{pro.imgpath}}.png">
                            <div class="clearfix text" style="height: 50px;">
                                <div style="display:block;width:70%">
                                    <p >{{pro.name}}   {{pro.price}}元</p>
                                    <p >有效期{{pro.expiryDate}}天</p>
                                </div>
                                <span class="btns {{pro.id}}btns" data-url="/ijob/api/ApiPromotionController/receivingCards" data-id="{{pro.id}}">立即领取</span>
                            </div>
                        </a>
                    </li>
                {{/each}}
            </script>
        </ul>
    </section>
    <div class="bottomtext">
        领取的卡券位置：进入IJob公众号>我的>卡券
    </div>
    <div id="homepage"></div>
</div>

<jsp:include page="../../h5/qz/base/resource.jsp"/>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});

    $("#cardlist").loadData().then(function (result) {
        result.data.list.forEach(item=>{
            if(item.used && item.used==1){
                $("."+item.id+"btns").hideCard();
            }
        });
        ijobbase.checkSubscribe();
    });

    $.fn.hideCard = function(){
        $(this).css('background-color','#ddd').text('已领取');
        $(this).closest('li').siblings().addClass('removebg');
        $(this).closest('li').siblings().find('.btns').remove();
    }
    $(".promotion-page").on('click','.btns',function(){
        /*$(this).css('background-color','#ddd').text('已领取');
        $(this).closest('li').siblings().addClass('removebg');
        $(this).closest('li').siblings().find('.btns').remove();*/

        $(this).btPost({id:$(this).data("id")},(result)=>{
            if(result.code=='200'){
                $(this).hideCard();
            }
            mui.toast(result.msg);
        });
    });
</script>
</body>
</html>
