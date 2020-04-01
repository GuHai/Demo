<%--
  Created by IntelliJ IDEA.
  User: liuli
  Date: 2019/8/1
  Time: 17:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的优惠券</title>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
   <%-- <link rel="stylesheet" href="/ijob/static/css/coupon.css?version=4">
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">--%>
    <jsp:include page="../../h5/qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/coupon.css?version=4">
</head>
<body>
    <header class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
        <h1 class="mui-title">我的优惠券</h1>
    </header>
    <div class="mui-content new-min-quan">
        <ul>
            <script id="myCardlist"   type="text/html"  data-url="/ijob/api/ApiPromotionController/myCardList"  >
                {{each list as pro}}
                    <li>
                        <div class="left">
                            <div class="rtdian"></div>
                            <div class="rbdian"></div>
                            <div class="padding">
                                <div class="sign">
                                    <img src="/ijob/static/images/{{pro.imgpath}}.png">
                                </div>
                                <div class="tit" style="font-size:14px;">{{pro.name}}
                                    <p style="line-height: 1.0;font-size:12px;">{{pro.start | dateFormat:'yyyy.MM.dd'}}-{{pro.end | dateFormat:'yyyy.MM.dd'}}</p>
                                    <p style="line-height: 1.0;font-size:12px;">序列号：{{pro.code}}</p>
                                </div>
                            </div>
                        </div>
                        <div class="right {{pro.flag==1?'bg1':'bg2'}}">
                            <div class="ltdian"></div>
                            <div class="lbdian"></div>
                            <div class="padding">
                                <div class="price">￥<i>{{pro.price}}</i></div>
                                <div class="btn"><button class="{{pro.flag==1?'used':'use'}}">{{pro.flag==1?'已使用':'未使用'}}</button></div>
                            </div>
                        </div>
                    </li>
                {{/each}}
            </script>
            <%--<li>
                <div class="left">
                    <div class="rtdian"></div>
                    <div class="rbdian"></div>
                    <div class="padding">
                        <div class="sign">
                            <img src="images/logo.jpg">
                        </div>
                        <div class="tit">好评券券自营店<p>2018.07.16-2018.08.16</p></div>
                    </div>
                </div>
                <div class="right bg1">
                    <div class="ltdian"></div>
                    <div class="lbdian"></div>
                    <div class="padding">
                        <div class="price">￥<i>30</i></div>
                        <div class="btn"><button class="used">已使用</button></div>
                    </div>
                </div>
            </li>
            <li>
                <div class="left">
                    <div class="rtdian"></div>
                    <div class="rbdian"></div>
                    <div class="padding">
                        <div class="sign">
                            <img src="images/logo.jpg">
                        </div>
                        <div class="tit">好评券券自营店<p>2018.07.16-2018.08.16</p></div>
                    </div>
                </div>
                <div class="right bg2">
                    <div class="ltdian"></div>
                    <div class="lbdian"></div>
                    <div class="padding">
                        <div class="price">￥<i>30</i></div>
                        <div class="btn"><button class="use">去使用</button></div>
                    </div>
                </div>
            </li>--%>
        </ul>
    </div>
    <jsp:include page="../../h5/qz/base/resource.jsp"/>
<script>
    $("#myCardlist").loadData().then(function (result) {
    });
</script>
</body>
</html>
