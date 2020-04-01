<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/23
  Time: 11:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8"   import="com.yskj.service.base.DictCacheService"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>

<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>会员中心</title>
    <!-- plugins:css -->
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <!-- endinject -->
    <!-- inject:css -->
    <link rel="stylesheet" href="/ijob/static/website/css/member.css">
    <link rel="stylesheet" href="/ijob/static/website/css/bill.css">

    <!-- endinject -->
    <link rel="shortcut icon" href="/ijob/static/website/images/favicon.ico" />
</head>
<body>

<!--会员登录-->
<div class="dialog-mask"  style="display: none">
    <div class="dialog-mask-main contentmain">
        <a href="#" class="dialog-close"><i class="iconfont icon-guanbi"></i></a>
        <ul class="login-tab">
            <li class="current" id="loginstatus">微信扫码支付</li>
        </ul>
        <div class="login-wrap" id="qrcodeimg">
            <img src="/ijob/static/images/loading.gif" style="/*width: 100%;height: 100%*/ position: absolute;top: 40%;left: 40%">
        </div>
        <p class="login-desc" >微信扫一扫登录，安全、快捷</p>
        <p  id="codemsg" style="margin-top: -20px;color: #666;text-align: center;font-size: 12px;" >600</p>
    </div>
</div>


<div class="container-scroller">
    <!-- partial:partials/_navbar.html -->
    <nav class="navbar default-layout-navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
        <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
            <a class="navbar-brand brand-logo" href="/ijob/loginMain?page=member">
                <img src="/ijob/static/website/images/m_logo.png" alt="logo" />
                <span>I Job兼职会员中心</span>
            </a>
        </div>
        <div class="navbar-menu-wrapper d-flex align-items-stretch">
            <ul class="navbar-nav navbar-nav-right">
                <li class="nav-item nav-profile dropdown">
                    <a class="nav-link dropdown-toggle" id="profileDropdown" href="javascript:void(0);">
                        <div class="nav-profile-img">
                            <img src="<shiro:principal property="imgPath"/>" alt="image">
                            <span class="availability-status online"></span>
                        </div>
                        <div class="nav-profile-text">
                            <p class="mb-1 text-black"><shiro:principal property="nickName"/></p>
                        </div>
                    </a>
                    <div class="dropdown-menu navbar-dropdown profileDropdown">
                        <a class="dropdown-item" href="/ijob/logout">
                             退出
                        </a>
                    </div>
                </li>
                <%--<li class="nav-item dropdown">
                    <a class="nav-link count-indicator dropdown-toggle" id="notificationDropdown" href="#">
                        <i class="iconfont icon-gwtixing"></i>
                        <span class="count-symbol bg-danger"></span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list notificationDropdown">
                        <h6 class="p-3 mb-0">系统通知</h6>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item preview-item">
                            <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
                                <h6 class="preview-subject font-weight-normal mb-1">催款</h6>
                                <p class="text-gray ellipsis mb-0">
                                    某某催款
                                </p>
                            </div>
                        </a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item preview-item">
                            <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
                                <h6 class="preview-subject font-weight-normal mb-1">催款</h6>
                                <p class="text-gray ellipsis mb-0">
                                    某某催款
                                </p>
                            </div>
                        </a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item preview-item">
                            <div class="preview-item-content d-flex align-items-start flex-column justify-content-center">
                                <h6 class="preview-subject font-weight-normal mb-1">催款</h6>
                                <p class="text-gray ellipsis mb-0">
                                    某某催款
                                </p>
                            </div>
                        </a>
                        <div class="dropdown-divider"></div>
                        <h6 class="p-3 mb-0 text-center">查看所有通知</h6>
                    </div>
                </li>--%>
            </ul>
            <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
                <span class="iconfont icon-gwhanbao"></span>
            </button>
        </div>
    </nav>
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
        <!-- partial:partials/_sidebar.html -->
        <nav class="sidebar sidebar-offcanvas" id="sidebar">
            <ul class="nav">
                <li class="nav-item nav-profile">
                    <a href="#" class="nav-link">
                        <div class="nav-profile-image">
                            <img src="<shiro:principal property="imgPath"/>" alt="profile">
                            <span class="login-status online"></span>
                            <!--change to offline or busy as needed-->
                        </div>
                        <div class="nav-profile-text d-flex flex-column">
                            <span class="font-weight-bold mb-2"><shiro:principal property="nickName"/></span>
                            <span class="text-secondary text-small"><shiro:principal property="workNumber"/></span>
                        </div>
                    </a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="javascript:void(0);" onclick="loadPageByUrl('guanwang/welcome');">
                        <span class="menu-title">首页</span>
                        <i class="iconfont icon-zhuye1"></i>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
                        <span class="menu-title">批量发工资</span>
                        <%--<i class="menu-arrow"></i>--%>
                    </a>
                    <div class="collapse show in" id="ui-basic">
                        <ul class="nav flex-column sub-menu">
                            <li class="nav-item"> <a class="nav-link" href="javascript:void(0);" onclick="loadPageByUrl('guanwang/salary?data.againID=all');">批量发工资</a></li>
                            <li class="nav-item"> <a class="nav-link" href="javascript:void(0);" onclick="loadPageByUrl('guanwang/history');">支付记录</a></li>
                        </ul>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="javascript:void(0);">
                        <span class="menu-title">保险</span>
                        <%--<i class="menu-arrow"></i>--%>
                    </a>

                    <div class="collapse show in" id="ui-basics">
                        <ul class="nav flex-column sub-menu">
                            <li class="nav-item"> <a class="nav-link" href="javascript:void(0);" onclick="loadPageByUrl('guanwang/insuranceList?insupload.id=');">保险上传</a></li>
                            <li class="nav-item"> <a class="nav-link" href="javascript:void(0);" onclick="loadPageByUrl('guanwang/insurancehistory');">保险历史记录</a></li>
                        </ul>
                    </div>
                </li>
            </ul>
        </nav>
        <!-- partial -->
        <div class="main-panel">
            <div class="content-wrapper">



            </div>
            <!-- content-wrapper ends -->
            <!--footer-->
            <footer class="footer">
                <div class="d-sm-flex justify-content-center justify-content-sm-between">
                    <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Copyright &copy; 2018湖南一生技术有限公司 湘ICP 备 18002534号-1</span>
                </div>
            </footer>
            <!--footer end-->
        </div>
        <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
</div>
<!-- container-scroller -->

</body>
</html>
<!-- plugins:js -->
<script type="text/javascript" src="/ijob/static/website/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/ijob/static/website/js/Admin/member.js"></script>
<script src='/ijob/lib/template.js?version=<%=DictCacheService.Version%>' ></script>
<script charset="UTF-8" src='/ijob/static/js/ijob.js?version=<%=DictCacheService.Version%>'></script>
<script charset="UTF-8"  src='/ijob/static/js/templateUtils.js?version=<%=DictCacheService.Version%>'></script>
<script src='/ijob/static/js/enums.js?version=<%=DictCacheService.Version%>'></script>
<script src='/ijob/static/js/dict.js?version=<%=DictCacheService.Version%>'></script>
<script src="/ijob/static/js/utf.js"></script>
<script src="/ijob/static/js/qrcode.min.js"></script>
<script src="/ijob/static/js/html2canvas.min.js"></script>
<script src="/ijob/static/js/ijobbase.js"></script>
<!-- endinject -->
<script>
    $(document).ready(function(e) {
        if (window.history && window.history.pushState) {
            $(window).on('popstate', function () {
                window.history.pushState('forward', null, '#');
                window.history.forward(1);
                ijob.url.history.back($(".content-wrapper"));
            });
        }
        window.history.pushState('forward', null, '#'); //在IE中必须得有这两行
        window.history.forward(1);
    });



    var site = "${site}";

    function loadPageByUrl(url){
        $(".content-wrapper").loadPage({path:url},function(response,status,xhr){
            if(xhr.status!=200){
                window.location.href = "/loginMain";
            }
        });
    }

    loadPageByUrl("/guanwang/welcome");

    // 登录退出
    $("#profileDropdown").click(function () {
        $(".profileDropdown").toggle();
        $(".notificationDropdown").hide();
    })
    $("#notificationDropdown").click(function (e) {
        $(".notificationDropdown").toggle();
        $(".profileDropdown").hide();
    });

    $('[data-toggle="offcanvas"]').on("click", function() {
        $('.sidebar-offcanvas').toggleClass('active')
    });

    $(".nav").on("click","li",function(){
        $(this).addClass("active").siblings().removeClass("active");
        if ($(".nav li").hasClass("active")){
            $(this).siblings().children(".collapse").find("li").removeClass("active");
        }
    });
    $(".flex-column").on("click","li",function(){
        $(this).addClass("active").siblings().removeClass("active");

    });
</script>