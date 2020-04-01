<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/22
  Time: 16:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>

<html>
<head>

    <!-- Your Basic Site Informations -->
    <title>湖南一生科技</title>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="author" content="">

    <!-- Mobile Specific Meta -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <!-- Stylesheets -->
    <link rel="stylesheet" href="/ijob/static/website/css/bootstrap.min.css">
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/static/website/css/slick.css">
    <link rel="stylesheet" href="/ijob/static/website/css/slick-theme.css">
    <link rel="stylesheet" href="/ijob/static/website/css/jquery.fancybox.css">
    <link rel="stylesheet" href="/ijob/static/website/css/animate.min.css">
    <link rel="stylesheet" href="/ijob/static/website/css/index.css">

    <!-- Favicons -->
    <link rel="shortcut icon" href="/ijob/static/website/images/favicon.ico" />
    <script src="/ijob/static/js/utf.js"></script>
    <script src="/ijob/static/js/qrcode.min.js"></script>
    <script src="/ijob/static/js/html2canvas.min.js"></script>
    <script src="/ijob/static/js/ijobbase.js"></script>
    <script src="/ijob/static/js/dict.js"></script>
</head>
<body>
<!-- #header -->
<header id="header">

    <input value='<shiro:principal property="nickName"/>' id="loginFlag" type="hidden"/>
    <!-- #navigation -->
    <nav id="navigation" class="navbar scrollspy">

        <!-- .container -->
        <div class="container">

            <div class="navbar-brand">
                <a href="index.html"><img src="/ijob/static/website/images/logo.png" alt="Logo"></a> <!-- site logo -->
            </div>

            <ul class="nav navbar-nav">
                <li><a href="index.jsp" class="link">首页</a></li>
                <li><a href="/ijob/loginMain?page=enterprise" class="link">区域招商</a></li>
                <li><a href="/ijob/loginMain?page=campus" class="link">校园招商</a></li>
                <li><a  href="javaScript:void(0);" class="link" id="loginBtn" >会员登录</a></li>
                <li><a  href="/ins" class="link" >随意保</a></li>
                <li><a  href="/smms" class="link" >招聘管理系统</a></li>
            </ul>

        </div>
        <!-- .container end  /loginMain?page=member -->

    </nav>
    <!-- #navigation end -->

    <!--会员登录-->
    <div class="dialog-mask">
        <div class="dialog-mask-main">
            <a href="#" class="dialog-close"><i class="iconfont icon-guanbi"></i></a>
            <ul class="login-tab">
                <li class="current" id="loginstatus">微信扫码登录</li>
            </ul>
            <div class="login-wrap" id="qrcodeimg">
                <img src="/ijob/static/images/loading.gif" style="width: auto;height: auto;position: absolute;top: 40%;left: 44%;">
            </div>
            <p class="login-desc">微信扫一扫登录，安全、快捷</p>
            <p  id="codemsg" style="margin-top: -20px;color: #666;text-align: center;font-size: 12px;" >60</p>
        </div>
    </div>
    <!--会员登录 end-->


    <div  id="browse" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">友情提示</h4>
                </div>
                <div class="modal-body">
                    <p>您的浏览器为IE浏览器，为了您更好的使用体验，建议使用谷歌浏览器、360浏览器极速模式</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal">不需要，我已有谷歌浏览器</button>
                    <button type="button" class="btn btn-primary" onclick="window.open('http://pc6.down.gsxzq.com/download/%E8%B0%B7%E6%AD%8C%E6%B5%8F%E8%A7%88%E5%99%A8_30@24670.exe')">去下载</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <!-- .header-content -->
    <div class="header-content">

        <!-- .container -->
        <div class="container">

            <!-- .row -->
            <div class="row header-row">

                <div class="col-sm-7 col-md-8 col-lg-7">
                    <div class="header-txt">
                        <h1>I Job兼职平台<br>企业的招聘助手 求职的掌上宝典</h1>
                        <p>《I Job兼职》是集＂兼职＋就业＋社交＋支付＂为一体的智能线上交易管理平台，让任何人在任何时间、任何地点都能找到适合自己的兼职工作，发挥自己的价值，赚取报酬，让企业方便、快捷、高效的招聘到合适的用工人员，提高效率，降低企业运作成本。</p>
                    </div>
                    <div class="header-btn">
                        <a href="#more" class="btn-custom smooth-scroll">了解更多</a>
                        <a href="#download" class="btn-custom btn-border btn-icon smooth-scroll"> 关注公众号</a>
                    </div>
                </div>

                <div class="col-sm-5 col-md-4 col-lg-offset-1 header-img">
                    <div class="carousel-slider header-slider animation" data-animation="animation-fade-in-down">
                        <div><img src="/ijob/static/website/images/content/sliders/banner01.jpg" alt="Image 1"></div>
                        <div><img src="/ijob/static/website/images/content/sliders/banner02.jpg" alt="Image 2"></div>
                        <div><img src="/ijob/static/website/images/content/sliders/banner03.jpg" alt="Image 3"></div>
                        <div><img src="/ijob/static/website/images/content/sliders/banner04.jpg" alt="Image 4"></div>
                    </div>
                </div>

            </div>
            <!-- .row end -->

        </div>
        <!-- .container end -->

    </div>
    <!-- .header-content end -->

    <div class="header-bg" style="background-image:url(/ijob/static/website/images/content/bg/1.jpg);">
        <div class="header-bg-overlay"></div>
    </div>

</header>
<!-- #header end -->

<!-- #features -->
<div id="features" class="section-wrap padding-top100">

    <!-- .container-wrap -->
    <div class="container-wrap container-padding100">

        <div class="container">
            <div class="row">
                <div class="col-md-6 col-lg-5 col-txt text-center-sm text-center-xs margin-bottom40-sm margin-bottom40-xs">
                    <div class="post-heading-left">
                        <h2><strong>公司简介</strong> <br/>COMPANY  PROFILE</h2>
                    </div>
                    <p>湖南一生科技有限公司成立于2017年,是一家从传统人力资源行业向移动互联网转型的创业型公司，致力于引进最新前沿科技技术（移动互联网），对传统人力资源行业做产业化升级，为智能化人力资源灌注新鲜血液，开创新的模式。</p>
                    <p>公司积极响应国家号召，走在“互联网+”行动计划、“大众创业，万众创新”的征程中，将传统人力资源行业与互联网技术进行深度融合，开发并运营集“兼职+就业+社交+支付+管理”为一体的智能线上平台《I Job兼职》手机APP。</p>
                    <p>《I Job兼职》致力于打造标准的线上兼职交易流程，建立诚信系统，树立行业标杆，成为全国人力资源行业最大的真实兼职信息发布、交易、管理平台。平台通过大数据处理，为所有求职者与企业招聘方搭建沟通桥梁，实现智能化交易。为加速实现人力资源行业+互联网应用进程而努力。</p>
                </div>
            </div>
        </div>

        <div class="col-pull-right">
            <figure class="img-layers3 img-pull-left">
                <div class="img-layer-lg">
                    <img src="/ijob/static/website/images/content/landing/feature-1.png" class="animation" data-animation="animation-fade-in-right">
                </div>
                <div class="img-layer-md">
                    <img src="/ijob/static/website/images/content/landing/feature-2.png" class="animation"
                         data-animation="animation-fade-in-left" data-delay="300">
                </div>
            </figure>
        </div>

    </div>
    <!-- .container-wrap end -->

    <!-- .container-padding -->
    <div class="container-padding10060 bg-color" id="more">

        <!-- .container -->
        <div class="container">

            <!-- .row -->
            <div class="row">

                <div class="col-sm-8 col-md-5 col-sm-offset-2 col-md-offset-0 margin-bottom20">
                    <figure class="img-layers img-layer-right-front">
                        <div class="img-layer-left">
                            <img src="/ijob/static/website/images/content/landing/feature-4.png" alt="Image Left" class="animation" data-animation="animation-fade-in-left">
                        </div>
                        <div class="img-layer-right">
                            <img src="/ijob/static/website/images/content/landing/feature-5.png" alt="Image Right" class="animation" data-animation="animation-fade-in-right" data-delay="400">
                        </div>
                    </figure>
                </div>

                <div class="col-sm-10 col-md-7 col-lg-6 col-sm-offset-1 col-md-offset-0 col-lg-offset-1">
                    <div class="text-wrap40 text-center-sm text-center-xs">
                        <!-- .row -->
                        <div class="row">

                            <div class="text-wrap100">
                                <div class="post-heading-left text-center-xs">
                                    <h2>功能介绍<br/>Functional introduction</h2>
                                </div>
                                <p style="padding: 0 20px">I Job
                                    兼职平台是一款从兼职信息发布、人员招聘录取、鸽子户筛选、现场签到、工作排班、薪资发放、保险购买、即时沟通为一体的兼职全流程管理工具。</p>
                                <div class="list-icon margin-bottom0">
                                    <ul>
                                        <li><i class="ion ion-android-done"></i> 职位招聘——发布、录取流程简单</li>
                                        <li><i class="ion ion-android-done"></i> 求职者人员管理——考勤签到、工作排班操作方便</li>
                                        <li><i class="ion ion-android-done"></i> 工资发放——单人发放、多笔发放、扫码发放总有一个合适</li>
                                        <li><i class="ion ion-android-done"></i> 保险保障——兼职意外险购买，安全有保障</li>
                                        <li><i class="ion ion-android-done"></i> 工作号聚粉——兼职意外险购买，安全有保障</li>
                                    </ul>
                                </div>
                            </div>

                        </div>
                        <!-- .row end -->
                    </div>
                </div>

            </div>
            <!-- .row end -->

        </div>
        <!-- .container end -->

    </div>
    <!-- .container-padding end -->
    <!-- #works -->
    <div id="works" class="container-padding10080">

        <!-- .container -->
        <div class="container">

            <div class="post-heading-center no-border margin-bottom40">
                <h2>使用教程</h2>
            </div>

            <!-- .row -->
            <div class="row">

                <div class="col-sm-4"> <!-- 1 -->
                    <div class="affa-video-img">
                        <a href="#scan-box" class="box-media" title="扫码发工资" id="scan">
                            <figure>
                                <img src="/ijob/static/website/images/content/works/1.jpg" alt="Image">
                                <div class="video-img-masked"></div>
                            </figure>
                        </a>
                        <div class="video-img-txt">
                            <h4>扫码发工资</h4>
                            <p>01:52</p>
                        </div>
                    </div>
                </div>

                <div class="col-sm-4"> <!-- 2 -->
                    <div class="affa-video-img">
                        <a href="#partners-box" class="box-media" title="校园合伙人" id="partners">
                            <figure>
                                <img src="/ijob/static/website/images/content/works/2.jpg" alt="Image">
                                <div class="video-img-masked"></div>
                            </figure>
                        </a>
                        <div class="video-img-txt">
                            <h4>校园合伙人</h4>
                            <p>01:17</p>
                        </div>
                    </div>
                </div>

                <div class="col-sm-4"> <!-- 3 -->
                    <div class="affa-video-img">
                        <a href="#postjob-box" class="box-media" title="职位发布及报名全流程" id="postjob">
                            <figure>
                                <img src="/ijob/static/website/images/content/works/3.jpg" alt="Image">
                                <div class="video-img-masked"></div>
                            </figure>
                        </a>
                        <div class="video-img-txt">
                            <h4>职位发布及报名全流程</h4>
                            <p>06:02</p>
                        </div>
                    </div>
                </div>

            </div>
            <!-- .row end -->

            <div class="row">
                <!--扫码发工资-->
                <div class="col-sm-8 scan-box box-backdrop" style="display: none;" id="scan-box">
                    <div class="box-content">
                        <embed src="https://imgcache.qq.com/tencentvideo_v1/playerv3/TPout.swf?max_age=86400&v=20161117&vid=t0793uwd7yc&auto=0" allowFullScreen="true" quality="high" width="480" height="400" align="middle" allowScriptAccess="always" type="application/x-shockwave-flash"></embed>
                        <a href="javascript:void(0);" class="retractbtns fancybox-item fancybox-close"></a>
                    </div>
                </div>
                <!--校园合伙人-->
                <div class="col-sm-8 partners-box box-backdrop" style="display: none;" id="partners-box">
                    <div class="box-content">
                        <embed src="https://imgcache.qq.com/tencentvideo_v1/playerv3/TPout.swf?max_age=86400&v=20161117&vid=k0794gg2723&auto=0" allowFullScreen="true" quality="high" width="480" height="400" align="middle" allowScriptAccess="always" type="application/x-shockwave-flash"></embed>
                        <a href="javascript:void(0);" class="retractbtns fancybox-item fancybox-close"></a>
                    </div>
                </div>
                <!--校园合伙人-->
                <div class="col-sm-8 postjob-box box-backdrop" style="display: none;" id="postjob-box">
                    <div class="box-content">
                        <embed src="https://imgcache.qq.com/tencentvideo_v1/playerv3/TPout.swf?max_age=86400&v=20161117&vid=r0798295lne&auto=0" allowFullScreen="true" quality="high" width="480" height="400" align="middle" allowScriptAccess="always" type="application/x-shockwave-flash"></embed>
                        <a href="javascript:void(0);" class="retractbtns fancybox-item fancybox-close"></a>
                    </div>
                </div>
            </div>

        </div>
        <!-- .container end -->

    </div>
    <!-- #works end -->
    <!-- .container-padding -->
    <div class="container-padding10060 bg-grey">

        <!-- .container -->
        <div class="container">

            <!-- .row -->
            <div class="row">

                <div class="col-sm-6 col-md-7 col-lg-6 margin-bottom40">
                    <div class="text-wrap100">
                        <div class="post-heading-left text-center-xs">
                            <h2>公司文化<br>Corporate culture</h2>
                        </div>
                        <p>我们是一群怀揣梦想的90后，我们向往自由、高效、自我价值的实现，我们敢想敢做敢拼。我们追求诚信、畅想未来、我们就是我们。</p>
                        <div class="list-icon margin-bottom0">
                            <ul>
                                <li><i class="ion ion-android-done"></i> 我们的广告语：真实兼职，就在《I Job兼职》</li>
                                <li><i class="ion ion-android-done"></i> 我们的价值观：帮助他人，成就自我</li>
                                <li><i class="ion ion-android-done"></i> 我们的口号：一次选择，信赖一生</li>
                                <li><i class="ion ion-android-done"></i> 我们的理念：诚融天下，实守未来！</li>
                                <li><i class="ion ion-android-done"></i> 我们的愿景：打造国内最具价值的人力资源数据库！</li>
                                <li><i class="ion ion-android-done"></i> 我们的使命：让天下没有难找的工作！</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="col-sm-6 col-lg-6 margin-bottom40">
                    <figure class="img-layers2 img-layer-left-front text-wrap210">
                        <div class="img-layer-left" style="padding-right:0;">
                            <img src="/ijob/static/website/images/content/landing/feature-6.png" alt="Image Left" class="animation" data-animation="animation-fade-in-left" data-delay="400">
                        </div>
                    </figure>
                </div>

            </div>
            <!-- .row end -->

        </div>
        <!-- .container end -->

    </div>
    <!-- .container-padding end -->

</div>
<!-- #features end -->

<!-- #testimonials -->
<div id="testimonials" class="bg-color bg-dark container-padding100" style="background-image:url(/ijob/static/website/images/bg-testimonials-carousel.png);">

    <!-- .container -->
    <div class="container">

        <div class="post-heading-center no-border">
            <p>Core team</p>
            <h2>核心团队</h2>
        </div>

        <!-- .affa-testimonials-carousel -->
        <div class="affa-testimonials-carousel">
            <div class="carousel-slider">

                <div class="slick-slide"> <!-- 1 -->
                    <div class="affa-testimonial">
                        <div class="testimonial-name">
                            <div class="photos">
                                <img src="/ijob/static/website/images/content/avatars/xiaozunhai.jpg" alt="肖尊海">
                            </div>
                            <h4>肖尊海</h4>
                            <p>CEO</p>
                        </div>
                        <div class="testimonial-txt">
                            <p>
                                2014年：创建《湖南海信人力资源服务有限公司》，任总经理<br/>
                                2015年：成为《微兼职》APP湖南总代理<br/>
                                2016年：创建《湖南红树林信息科技有限公司》，任CEO<br/>
                                2017年：创建《湖南一生科技有限公司》，任CEO，研发《I Job兼职》APP
                            </p>
                        </div>
                    </div>
                </div>

                <div class="slick-slide"> <!-- 2 -->
                    <div class="affa-testimonial">
                        <div class="testimonial-name">
                            <div class="photos">
                                <img src="/ijob/static/website/images/content/avatars/liumenglong.jpg" alt="刘梦龙">
                            </div>
                            <h4>刘梦龙</h4>
                            <p>合伙人</p>
                        </div>
                        <div class="testimonial-txt">
                            <p>
                                IT领域出身，两年公司管理任职经验<br/>
                                2年创业经验，现《I Job兼职》合伙人<br/>
                                IT field origin, two years experience in company management<br/>
                                2 years of entrepreneurial experience, now IJob partner
                            </p>
                        </div>
                    </div>
                </div>

                <div class="slick-slide"> <!-- 3 -->
                    <div class="affa-testimonial">
                        <div class="testimonial-name">
                            <div class="photos">
                                <img src="/ijob/static/website/images/content/avatars/zhoutao.jpg" alt="陈涛">
                            </div>
                            <h4>陈涛</h4>
                            <p>合伙人</p>
                        </div>
                        <div class="testimonial-txt">
                            <p>
                                2012 年，在校期间，合伙创立《涉外兼职吧》<br/>
                                2014-2015年，湖南百度竞网有限公司任职，成为业务骨干<br/>
                                2015年-2016年，就职湖南龙润集团创业赢管理有限公司，管理业务团队<br/>
                                2017年，重返创业，《I Job兼职》合伙人<br/>
                            </p>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <!-- .affa-testimonials-carousel end -->

    </div>
    <!-- .container end -->

</div>
<!-- #testimonials end -->

<!-- #screenshots -->
<div id="screenshots" class="container-padding100">

    <!-- .container -->
    <div class="container">

        <div class="post-heading-center">
            <p>Campus partners</p>
            <h2>合伙人展示</h2>
        </div>

        <div class="carousel-slider gallery-slider">
            <div class="slick-slide"> <!-- 1 -->
                <div class="img-hover">
                    <a href="/ijob/static/website/images/content/screenshots/1.jpg" class="fancybox" data-fancybox-group="images_gallery"
                       title="湖南电子科技职业技术学院">
                        <figure>
                            <img src="/ijob/static/website/images/content/screenshots/1.jpg" alt="湖南电子科技职业技术学院">
                            <div class="hover-masked"></div>
                        </figure>
                    </a>
                    <h4>湖南电子科技职业技术学院</h4>
                </div>
            </div>

            <div class="slick-slide"> <!-- 2 -->
                <div class="img-hover">
                    <a href="/ijob/static/website/images/content/screenshots/2.jpg" class="fancybox" data-fancybox-group="images_gallery" title="湖南电子科技职业学院">
                        <figure>
                            <img src="/ijob/static/website/images/content/screenshots/2.jpg" alt="湖南电子科技职业学院">
                            <div class="hover-masked"></div>
                        </figure>
                    </a>
                    <h4>湖南电子科技职业学院</h4>
                </div>
            </div>

            <div class="slick-slide"> <!-- 3 -->
                <div class="img-hover">
                    <a href="/ijob/static/website/images/content/screenshots/3.jpg" class="fancybox" data-fancybox-group="images_gallery" title="湖南工业职业技术学院">
                        <figure>
                            <img src="/ijob/static/website/images/content/screenshots/3.jpg" alt="湖南工业职业技术学院">
                            <div class="hover-masked"></div>
                        </figure>
                    </a>
                    <h4>湖南工业职业技术学院</h4>
                </div>
            </div>

            <div class="slick-slide"> <!-- 4 -->
                <div class="img-hover">
                    <a href="/ijob/static/website/images/content/screenshots/4.jpg" class="fancybox" data-fancybox-group="images_gallery" title="湖南涉外经济学院">
                        <figure>
                            <img src="/ijob/static/website/images/content/screenshots/4.jpg" alt="湖南涉外经济学院">
                            <div class="hover-masked"></div>
                        </figure>
                    </a>
                    <h4>湖南涉外经济学院</h4>
                </div>
            </div>

            <div class="slick-slide"> <!-- 5 -->
                <div class="img-hover">
                    <a href="/ijob/static/website/images/content/screenshots/5.jpg" class="fancybox" data-fancybox-group="images_gallery" title="湖南外贸职业技术学院">
                        <figure>
                            <img src="/ijob/static/website/images/content/screenshots/5.jpg" alt="湖南外贸职业技术学院">
                            <div class="hover-masked"></div>
                        </figure>
                    </a>
                    <h4>湖南外贸职业技术学院</h4>
                </div>
            </div>

            <div class="slick-slide"> <!-- 6 -->
                <div class="img-hover">
                    <a href="/ijob/static/website/images/content/screenshots/6.jpg" class="fancybox" data-fancybox-group="images_gallery" title="长沙学院">
                        <figure>
                            <img src="/ijob/static/website/images/content/screenshots/6.jpg" alt="长沙学院">
                            <div class="hover-masked"></div>
                        </figure>
                    </a>
                    <h4>长沙学院</h4>
                </div>
            </div>

            <div class="slick-slide"> <!-- 7 -->
                <div class="img-hover">
                    <a href="/ijob/static/website/images/content/screenshots/7.jpg" class="fancybox" data-fancybox-group="images_gallery"
                       title="长沙医学院">
                        <figure>
                            <img src="/ijob/static/website/images/content/screenshots/7.jpg" alt="长沙医学院">
                            <div class="hover-masked"></div>
                        </figure>
                    </a>
                    <h4>长沙医学院</h4>
                </div>
            </div>

            <div class="slick-slide"> <!-- 8 -->
                <div class="img-hover">
                    <a href="/ijob/static/website/images/content/screenshots/8.jpg" class="fancybox" data-fancybox-group="images_gallery"
                       title="中南林业科技大学涉外学院">
                        <figure>
                            <img src="/ijob/static/website/images/content/screenshots/8.jpg" alt="中南林业科技大学涉外学院">
                            <div class="hover-masked"></div>
                        </figure>
                    </a>
                    <h4>中南林业科技大学涉外学院</h4>
                </div>
            </div>

            <div class="slick-slide"> <!-- 9 -->
                <div class="img-hover">
                    <a href="/ijob/static/website/images/content/screenshots/9.jpg" class="fancybox" data-fancybox-group="images_gallery"
                       title="湖南大众传媒职业技术学院">
                        <figure>
                            <img src="/ijob/static/website/images/content/screenshots/9.jpg" alt="湖南大众传媒职业技术学院">
                            <div class="hover-masked"></div>
                        </figure>
                    </a>
                    <h4>中南林业科技大学涉外学院</h4>
                </div>
            </div>

            <div class="slick-slide"> <!-- 10 -->
                <div class="img-hover">
                    <a href="/ijob/static/website/images/content/screenshots/10.jpg" class="fancybox" data-fancybox-group="images_gallery"
                       title="湖南商务职业技术学院">
                        <figure>
                            <img src="/ijob/static/website/images/content/screenshots/10.jpg" alt="湖南商务职业技术学院">
                            <div class="hover-masked"></div>
                        </figure>
                    </a>
                    <h4>湖南商务职业技术学院</h4>
                </div>
            </div>

            <div class="slick-slide"> <!-- 11 -->
                <div class="img-hover">
                    <a href="/ijob/static/website/images/content/screenshots/11.jpg" class="fancybox" data-fancybox-group="images_gallery"
                       title="长沙职业技术学院">
                        <figure>
                            <img src="/ijob/static/website/images/content/screenshots/11.jpg" alt="长沙职业技术学院">
                            <div class="hover-masked"></div>
                        </figure>
                    </a>
                    <h4>长沙职业技术学院</h4>
                </div>
            </div>

        </div>

    </div>
    <!-- .container end -->

</div>
<!-- #screenshots end -->

<div class="container">
    <div class="sep-border"></div> <!-- separator -->
</div>

<!-- #download -->
<div  class="bg-color bg-parallax">

    <!-- .bg-overlay -->
    <div  id="download" class="bg-overlay bg-overlay80 container-padding120 text-center" >

        <!-- .container -->
        <div class="container">

            <div class="row">
                <div class="col-sm-4 margin-auto floatnone widthauto">
                    <div class="code">
                        <img src="/ijob/static/website/images/code.png">
                    </div>
                    <div class="tips">微信扫码关注I Job兼职</div>
                </div>
                <div class="col-sm-4 margin-auto floatnone widthauto">
                    <div class="code" style="padding: 20px;background-color: white;">
                        <img src="/ijob/static/image/1565660710.png">
                    </div>
                    <div class="tips">扫描下载随意宝APP</div>
                </div>
            </div>

        </div>
        <!-- .container end -->

    </div>
    <!-- .bg-overlay end -->

</div>
<!-- #download end -->

<div class="container">
    <div class="sep-border"></div> <!-- separator -->
</div>

<!-- #footer -->
<footer id="footer">

    <!-- #contact -->
    <div id="contact" class="container-padding10080">

        <!-- .container -->
        <div class="container">

            <div class="post-heading-center">
                <p>Contact us</p>
                <h2>联系我们</h2>
            </div>

            <!-- .row -->
            <div class="row padding-bottom20">

                <div class="col-sm-6"> <!-- 1 -->
                    <div class="affa-contact-info">
                        <div class="contact-info-heading">
                            <p>0731-89566256</p>
                            <p>185 2005 8312</p>
                        </div>
                        <h4>联系电话</h4>
                    </div>
                </div>

                <div class="col-sm-6"> <!-- 3 -->
                    <div class="affa-contact-info">
                        <div class="contact-info-heading">
                            <p>湖南省长沙市天心区<br/>蓝湾国际广场B栋15楼（整层）</p>
                        </div>
                        <h4>公司地址</h4>
                    </div>
                </div>

            </div>
            <!-- .row end -->

            <div class="row">
                <div class="col-md-10 col-lg-8 col-md-offset-1 col-lg-offset-2">
                    <form action="#" method="post" class="affa-form-contact">
                        <div class="submit-status"></div> <!-- submit status -->
                        <input type="text" name="name" placeholder="请输入您的姓名">
                        <input type="text" name="email" placeholder="请输入您的邮箱 *">
                        <textarea name="message" placeholder="说点什么吧！"></textarea>
                        <div class="form-contact-submit">
                            <input type="submit" name="submit" value="发送" class="btn-border">
                        </div>
                    </form>
                </div>
            </div>

        </div>
        <!-- .container end -->

    </div>
    <!-- #contact end -->

    <!-- .footer-txt -->
    <div class="footer-txt">

        <!-- .container -->
        <div class="container">

            <div class="footer-copyright">
                <p class="copyright-txt">©2018湖南一生技术有限公司 湘ICP 备 18002534号-1</p>
            </div>

        </div>
        <!-- .container end -->

    </div>
    <!-- .footer-txt end -->

    <a href="#" class="scrollup" title="Back to Top!"><i class="iconfont icon-arrow-up"></i></a>

</footer>
<!-- #footer end -->
</body>
</html>
<!-- JavaScripts -->
<script type="text/javascript" src="/ijob/static/website/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/ijob/static/website/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ijob/static/website/js/Home/index.js"></script>
<script type="text/javascript" src="/ijob/static/website/js/Home/jquery.easing.min.js"></script>
<script type="text/javascript" src="/ijob/static/website/js/Home/smoothscroll.js"></script>
<script type="text/javascript" src="/ijob/static/website/js/Home/response.min.js"></script>
<script type="text/javascript" src="/ijob/static/website/js/Home/jquery.placeholder.min.js"></script>
<script type="text/javascript" src="/ijob/static/website/js/Home/jquery.fitvids.js"></script>
<script type="text/javascript" src="/ijob/static/website/js/Home/jquery.imgpreload.min.js"></script>
<script type="text/javascript" src="/ijob/static/website/js/Home/waypoints.min.js"></script>
<script type="text/javascript" src="/ijob/static/website/js/Home/slick.min.js"></script>
<script type="text/javascript" src="/ijob/static/website/js/Home/jquery.fancybox.pack.js"></script>
<script type="text/javascript" src="/ijob/static/website/js/Home/jquery.counterup.min.js"></script>
<script type="text/javascript" src="/ijob/static/website/js/Home/script.js"></script>
<script>
    var userAgent = navigator.userAgent;
    var isIE = userAgent.indexOf("compatible") >-1&&userAgent.indexOf("MSIE")>-1  || (userAgent.indexOf("Windows NT 6.1;") > -1 && userAgent.indexOf("Trident/7.0;") > -1);
    if(isIE){
        $("#browse").modal("show");
    }
    var site = "${site}";
    /*会员登录*/
    var times =0;
    $("#loginBtn").click(function () {

        if($("#loginFlag").val()){
            window.location.href = "/loginMain?page=member";
        }else{
            $(".dialog-mask").show();
            $("#qrcodeimg").empty();
            $("#codemsg").text(60);
            var pw =  $(".login-wrap").height();
            var width = pw;
            var height = width;
            var code = ijobbase.randomString(16);
            var urlQrcode = "http://"+site+"/share/login/"+code;
            var qrcode = new QRCode(document.getElementById("qrcodeimg"), {
                text:  urlQrcode,
                width: width, //生成的二维码的宽度
                height: height, //生成的二维码的高度
                colorDark : "#000000", // 生成的二维码的深色部分
                colorLight : "#ffffff", //生成二维码的浅色部分
                correctLevel : QRCode.CorrectLevel.H
            });
            var count =0;
            times = setInterval(function(){
                if(++count>=60){
                    $("#codemsg").text(dict.SalaryExcel.Expire);
                    $("#qrcodeimg").html("<img src=\"/ijob/static/images/loading.gif\" style=\"width: auto;height: auto;position: absolute;top: 40%;left: 44%;\">");
                    clearInterval(times);
                }
                $("#codemsg").text(60-count);
                $.getJSON("/getAuthCodeStatus/"+code,function(result){
                    if(result.code==200){
                        $("#loginstatus").text(dict.SalaryExcel.LoginOK);
                        clearInterval(times);
                        setTimeout(function(){
                            window.location.href = "/loginMain?page=member";
                        },1000);
                    }
                });

            },1000);
        }

    });
    // 关闭
    $(".dialog-close").click(function () {
        $(".dialog-mask").hide();
        clearInterval( times);
    });


    $(function () {


        var divList = $(".slick-active");
        for (var i = 0; i < divList.length; i++) {
            if(i>2){
                var obj = divList[i];
                if($(obj).data("slick-index")==-2){
                    $(obj).addClass("current");
                }
                if($(obj).data("slick-index")==2){
                    $(obj).addClass("current");
                }
            }

        }
        $(".slick-arrow").bind('click',function () {
            var divList = $(".slick-active");
            $(".current").removeClass("current");
            $(divList[3]).addClass("current");
            $(divList[divList.length - 1]).addClass("current");
        });


    })
</script>