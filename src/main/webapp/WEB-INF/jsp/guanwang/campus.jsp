<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/22
  Time: 17:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <title>湖南一生科技-服务商</title>
    <link rel="stylesheet" href="/ijob/static/website/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/static/website/css/common.css">
    <link rel="stylesheet" href="/ijob/static/website/css/enterprise.css" />
    <link rel="stylesheet" href="/ijob/static/website/css/campus.css" />
    <!-- Favicons -->
    <link rel="shortcut icon" href="/ijob/static/website/images/favicon.ico" />
</head>
<body>
<div class="wrap">
    <!-- 头部区域 -->
    <header class="head">
        <div class="header">
            <div class="container">
                <div class="logo">
                    <a href="#"><img src="/ijob/static/website/images/area/logo.png" /></a>
                    <span></span>
                </div>
                <nav class="navbar navbar-default">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false" id="upNav">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                        </div>
                        <div class="nav_back collapse navbar-collapse collapseContent" id="bs-example-navbar-collapse-1">
                            <ul class=" nav-content navbar-nav navbar-right navDropdown">
                                <li><a href="index.jsp">首页</a></li>
                                <li><a href="/ijob/loginMain?page=enterprise">区域招商</a></li>
                                <li><a href="/ijob/loginMain?page=campus">校园招商</a></li>
                                <li><a href="JavaScript:void(0);"  id="login">会员登录</a></li>
                            </ul>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
        <div class="banner">
            <img src="/ijob/static/website/images/area/banner.png" alt="">
            <button class="apply-link" id="btn">立即关注</button>
        </div>
    </header>
    <!--遮罩层-->
    <div class="mask">
        <div class="fixe_codeBox1">
            <img src="/ijob/static/website/images/area/code2.png" alt="">
            <div>扫描二维码</div>
            <div>关注I Job兼职公众号</div>
        </div>
    </div>
    <!--会员登录-->
    <div class="dialog-mask">
        <div class="dialog-mask-main">
            <a href="javascript:;" class="dialog-close"><i class="iconfont icon-guanbi"></i></a>
            <ul class="login-tab">
                <li class="current">微信扫码登录</li>
            </ul>
            <div class="login-wrap">
                <img src="/ijob/static/website/images/wechat.png"/>
            </div>
            <p class="login-desc">微信扫一扫登录，安全、快捷</p>
        </div>
    </div>
    <!--会员登录 end-->
    <!-- 主体内容区域 -->
    <div class="container-fluid content">
        <div class="container">
            <!-- 项目介绍区域 -->
            <div class="region-card">
                <div class="sub-title">
                    <h3>PROJECT INTRODUCTION</h3>
                    <div class="title">
                        <h2>
                            <span class="line"></span>
                            <span>项目介绍</span>
                            <span class="line"></span>
                        </h2>
                    </div>
                </div>
                <div class="introduction">I Job兼职是湖南一生科技有限公司开发并运营的兼职交易管理平台 打造标准的线上兼职交易流程、建立诚信系统、树立行业标杆 大数据处理智能化交易。
                </div>
                <div class="row">
                    <div class="col-md-4 col-sm-6 card-list">
                        <img src="/ijob/static/website/images/area/img1.png" />
                        <h4>平台性质</h4>
                        <p>人力资源+互联网</p>
                        <p>产业化升级领导者</p>
                    </div>
                    <div class="col-md-4 col-sm-6 card-list">
                        <img src="/ijob/static/website/images/area/img2.png" />
                        <h4>团队构成</h4>
                        <p>8年市场、技术团队</p>
                        <p>8年行业专业人士</p>
                    </div>
                    <div class="col-md-4 col-sm-6 card-list">
                        <img src="/ijob/static/website/images/area/img3.png" />
                        <h4>发展目标</h4>
                        <p>成为全国最大的</p>
                        <p> 兼职交易管理平台</p>
                    </div>
                </div>
            </div>
            <!-- 项目发展区域 -->
            <div class="region-card">
                <div class="sub-title">
                    <h3>PROJECT DEVELOPMENT</h3>
                    <div class="title">
                        <h2>
                            <span class="line"></span>
                            <span>项目发展计划</span>
                            <span class="line"></span>
                        </h2>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4 development">
                        <div class="development-text dev1">
                            <h4>2018年6月</h4>
                            <p class="txt1">平台真实上线</p>
                        </div>
                    </div>
                    <div class="col-md-4 development">
                        <div class="development-text dev2">
                            <h4>2018长沙——起步</h4>
                            <p class="txt1">样板城市打造</p>
                            <p class="txt2">产品与商业模式磨合</p>
                        </div>
                    </div>
                    <div class="col-md-4 development">
                        <div class="development-text dev3">
                            <h4>2019全国——展望</h4>
                            <p class="txt1">招商加盟</p>
                            <p class="txt2">快速复制</p>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 development develop-two">
                        <div class="development-text dev4">
                            <h4>2020深耕——未来</h4>
                            <p class="txt1">建立壁垒</p>
                            <p class="txt2">成为霸主</p>
                        </div>
                    </div>
                    <div class="col-md-6 development develop-two">
                        <div class="development-text dev5">
                            <h4>百城千校计划</h4>
                            <p class="txt1">数百座城市</p>
                            <p class="txt2">数千所学校</p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 模式案例区域 -->
            <div class="row region-card">
                <div class="col-md-6 half-module module-case">
                    <div class="sub-title">
                        <h3>MODEL CASE</h3>
                        <div class="title">
                            <p>
                                模式案例
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="model_case_content">
                            菜鸟驿站：在各个学校设立运营站点，通过整合资源，统一快递业务，达到自运营生存状态良好，与《I JOB兼职》“百城千校”市场战略
                        </div>
                    </div>
                </div>
                <!-- 合伙人优势 -->
                <div class="col-md-6 half-module module-goods">
                    <div class="sub-title">
                        <h3>JION THE ADVANTAGE</h3>
                        <h2>合伙人优势</h2>
                    </div>
                    <div class="goodness">
                        <img class="imgPng" src="/ijob/static/website/images/area/goodness.png" alt="">
                    </div>
                </div>
            </div>
            <!-- 加盟利润区域 -->
            <div class="row region-card">
                <div class="col-md-6 half-module">
                    <img src="/ijob/static/website/images/area/images1.png" alt="" />
                </div>
                <div class="col-md-6 half-module">
                    <div class="sub-title">
                        <h3>APPLICATION FORM</h3>
                        <h2>加盟利润</h2>
                    </div>
                    <ul>
                        <li><span>增值业务</span>——个人、企业VIP增值服务</li>
                        <li><span>保险分佣</span>——独家兼职保险</li>
                        <li><span>估值增长</span>——区域增值、股份收益</li>
                        <li><span>平台业务</span>——网络兼职、线下兼职</li>
                        <li><span>广告分红</span>——浏览、点击收费</li>
                    </ul>
                </div>
            </div>
            <!-- 竞品分析区域 -->
            <div class="region-card">
                <table>
                    <tr>
                        <th><span>平台</span></th>
                        <th><span>I JOB</span></th>
                        <th><span>x米</span></th>
                        <th><span>x猫</span></th>
                    </tr>
                    <tr>
                        <td><span>运营模式</span></td>
                        <td><span>加盟合伙</span></td>
                        <td><span>直营</span></td>
                        <td><span>直营</span></td>
                    </tr>
                    <tr>
                        <td><span>现状</span></td>
                        <td><span>合伙人制</span></td>
                        <td><span>线下直营团队、自主承接业务</span></td>
                        <td><span>线下无团队线上运营</span></td>
                    </tr>
                    <tr>
                        <td><span>平台发展</span></td>
                        <td><span>线上兼职交易管理平台</span></td>
                        <td><span>线上线下结合的信息发布平台</span></td>
                        <td><span>线上兼职信息发布平台</span></td>
                    </tr>
                    <tr>
                        <td><span>关系</span></td>
                        <td><span>联合运营、数据共享、合作共赢</span></td>
                        <td><span>发布招聘</span></td>
                        <td><span>发布招聘</span></td>
                    </tr>
                </table>
            </div>
            <!-- 痛点分析区域 -->
            <div class="row region-card">
                <div class="col-md-6 half-module">
                    <div class="sub-title">
                        <h3>ANALYSIS OF PAIN POINT</h3>
                        <h2>痛点分析</h2>
                    </div>
                    <ul class="analysis">
                        <li>招聘难</li>
                        <li>鸽子多</li>
                        <li>操作繁琐</li>
                        <li>用工风险大</li>
                        <li>再次联系</li>
                        <li>质量低</li>
                    </ul>
                </div>
                <div class="col-md-6 half-module">
                    <img src="/ijob/static/website/images/area/images2.png" alt="" />
                </div>
            </div>
            <!-- 功能介绍区域 -->
            <div class="region-card">
                <div class="sub-title">
                    <h3>FUNCTIONAL INTRODUCTION</h3>
                    <div class="title">
                        <h2>
                            <span class="line"></span>
                            <span>功能介绍</span>
                            <span class="line"></span>
                        </h2>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4 col-sm-6 card-list">
                        <img src="/ijob/static/website/images/area/img7.png" />
                        <h4>职位招聘</h4>
                        <p>发布、面试、培训、录取</p>
                    </div>
                    <div class="col-md-4 col-sm-6 card-list">
                        <img src="/ijob/static/website/images/area/img8.png" />
                        <h4>岗位管理</h4>
                        <p>考勤、排班</p>
                    </div>
                    <div class="col-md-4 col-sm-6 card-list">
                        <img src="/ijob/static/website/images/area/img9.png" />
                        <h4>工资发放</h4>
                        <p>单笔发放、多笔发放</p>
                    </div>
                    <div class="col-md-4 col-sm-6 card-list">
                        <img src="/ijob/static/website/images/area/img10.png" />
                        <h4>信用互评</h4>
                        <p>保证金+互评机制</p>
                        <p>确保信息真实</p>
                    </div>
                    <div class="col-md-4 col-sm-6 card-list">
                        <img src="/ijob/static/website/images/area/img11.png" />
                        <h4>保险保障</h4>
                        <p>兼职意外险购买</p>
                    </div>
                    <div class="col-md-4 col-sm-6 card-list">
                        <img src="/ijob/static/website/images/area/img12.png" />
                        <h4>再次联系</h4>
                        <p>工作号聚粉</p>
                    </div>
                </div>
            </div>
            <!-- 服务商加盟申请表  -->
            <div class="form-content">
                <div class="sub-title">
                    <h3>APPLICATION FORM</h3>
                    <h2>服务商加盟申请表</h2>
                </div>
                <form action="">
                    <div class="form-group">
                        <label for="">公司名称：</label>
                        <input type="text" />
                    </div>
                    <div class="form-group">
                        <label for="">公司地址：</label>
                        <input type="text" />
                    </div>
                    <div class="form-group">
                        <label for="">联系方式：</label>
                        <input type="text" />
                    </div>
                    <div class="form-group">
                        <label for="">法人代表：</label>
                        <input type="text" />
                    </div>
                    <div class="form-group">
                        <label for="">主营项目：</label>
                        <textarea name="" cols="30" rows="10"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="">加盟区域：</label>
                        <textarea name="" cols="30" rows="10"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="">加盟目的：</label>
                        <textarea name="" cols="30" rows="10"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="">加盟规划：</label>
                        <textarea name="" cols="30" rows="10"></textarea>
                    </div>
                    <input type="button" class="submit" value="提交申请" id="submit" />
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script type="text/javascript" src="/ijob/static/website/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/ijob/static/website/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ijob/static/website/js/Home/campus_enterprise.js"></script>
