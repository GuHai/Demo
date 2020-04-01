<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>预览简历</title>
    <jsp:include page="../zp/base/resource.jsp"/>

    <link rel="stylesheet" href="/ijob/static/css/mine/add_preview.css">
</head>
<body>

<style>
.wrap .summary{border-bottom:1px solid #d7d7d7;width: 96%;margin: 0 auto;padding: 0.4rem 0.266rem 0.266rem 0.266rem;height: auto;}
.wrap .summary .contentBox > p:last-child > span{margin-left:0.746rem;}
.wrap .details p{color:#666;}
.wrap .details > dd .school .discipline > p{margin:0;}
.wrap .details > dd .work .post > p{margin:0;}
.wrap .details > dd .certificate > p:last-child{margin:0;}
.wrap .details > dd .certificate > p:first-child{margin:0;}
.wrap .details > dd .school{border-bottom:1px solid #d7d7d7;}
.wrap .details > dd{padding-left:0.32rem;text-indent:0px;}
</style>

<div class="wrap">
    <div class="summary">
        <img class="headerImg" src="../../images/touxian.jpg" alt="">
        <div class="contentBox">
            <p>
                张三 <span>女<span class="ver-line"></span>26岁</span>
            </p>
            <p>
                未婚
                <span>长沙市天心区坡子街</span>
            </p>
        </div>
    </div>
    <dl class="details" style="padding-bottom:0.267rem;">
        <dt>
        <h1>联系方式</h1></dt>
        <dd>
            <p>18623442355</p>
            <p>18623442355@163.com</p>
        </dd>
        <dt>
        <h1>自我评价</h1>
        </dt>
        <dd>
            今年16岁，身高1.73，体重50公斤。执着于做自己喜欢做的事
            情，凡是只求做到更好，我相信不管过程是怎么样的，结果才
            重要。
        </dd>
        <dt>
        <h1>教育背景</h1>
        </dt>
        <dd>
            <div class="school">
                <h2>湖南涉外经济学院</h2>
                <div class="discipline">
                    <p>计算机与科技<span class="line"></span>本科</p>
                    <p>2015-至今</p>
                </div>
                <p class="specialty">本人在大学期间一直在从事兼职行业，对兼职行业有比较深入的了解。
                </p>
            </div>
            <div class="school">
                <h2>筒口县第一中学</h2>
                <div class="discipline">
                    <p>高中</p>
                    <p>2013-2015</p>
                </div>
            </div>
        </dd>
        <dt>工作经历</dt>
        <dd>
            <div class="work">
                <h2>一生科技</h2>
                <div class="post">
                    <p>销售</p>
                    <p>2017.3-2017.6</p>
                </div>
                <p class="work_msg">
                    本人在大学期间一直在从事兼职行业，对兼职行业有比较深入
                    的了解。
                </p>
            </div>
        </dd>
        <dt>证件</dt>
        <dd>
            <div class="certificate">
                <p>健康证</p>
                <p>2017.3-2017.6</p>
            </div>
            <div class="imgBox">
                <img src="../../images/banner1@2x.png" alt="">
            </div>
        </dd>
    </dl>

</div>
</body>
</html>