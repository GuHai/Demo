<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/8
  Time: 17:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>职位管理</title>
    <jsp:include page="../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/chooseResume.css">
</head>
<body>
<style>
    #chooseResume .main .resumeList > li .list-title>span{float:right;font-size:0.346rem;color:#666;}
    #chooseResume .head > a .head-lf_span{font-size:0.4rem !important;}
    .mui-switch{top:0.266rem;}
    .mui-switch.mui-active:before{content: '开放中';font-size:0.266rem;left:3px;}
    .mui-switch:before{content: '已关闭';font-size:0.266rem;right:4px;}

    .mui-switch{width:1.6rem;height:0.533rem;}
    .mui-switch .mui-switch-handle{width:0.48rem;height:0.48rem;}
    .mui-switch:before{top:-0.08rem;}
    #chooseResume .main .resumeList > li .list-title>p{font-size:0.4rem;color:#333;}
    .mui-switch{background-color:#d7d7d7;border:2px solid #d7d7d7;}
    .mui-switch-blue.mui-active{background-color:#108ee9;border:2px solid #108ee9;}
</style>

<div id="chooseResume" class="wrap">
    <header class="head">
        <a href="postJob2.html">
            <span class="head-lf_span"><i class="iconfont icon-jia" style="font-size:0.480rem;margin-right:0.213rem;"></i>发布职位</span>
            <span class="head-rt_span iconfont icon-arrow-right"></span>
        </a>
    </header>
    <div class="main">
        <ul class="resumeList">
            <li>
                <div class="list-title">
                    <p>车展模特急招</p>
                    <span>已关闭</span>
                </div>
                <div class="list-content">
                    <div class="list-cz">
                        <a href="javascript:void(0);" class="edit"><i class="iconfont icon-edit-fill"></i>编辑</a>
                        <a href="javascript:void(0);" class="delete"><i class="iconfont icon-shanchu2"></i>删除</a>
                    </div>
                    <div class="mui-switch mui-switch-blue">
                        <div class="mui-switch-handle"></div>
                    </div>
                </div>
            </li>
            <li>
                <div class="list-title">
                    <p>车展模特急招</p>
                    <span>开放中</span>
                </div>
                <div class="list-content">
                    <div class="list-cz">
                        <a href="javascript:void(0);" class="edit"><i class="iconfont icon-edit-fill"></i>编辑</a>
                        <a href="javascript:void(0);" class="delete"><i class="iconfont icon-shanchu2"></i>删除</a>
                    </div>
                    <div class="mui-switch mui-switch-blue mui-active">
                        <div class="mui-switch-handle"></div>
                    </div>
                </div>
            </li>
            <li>
                <div class="list-title">
                    <p>车展模特急招车展模特急招车展模特急招车展模特急招车展模特急招</p>
                    <span>未支付</span>
                </div>
                <div class="list-content">
                    <div class="list-cz">
                        <a href="javascript:void(0);" class="edit"><i class="iconfont icon-edit-fill"></i>编辑</a>
                        <a href="javascript:void(0);" class="delete"><i class="iconfont icon-shanchu2"></i>删除</a>
                    </div>
                    <div class="default">去支付</div>
                </div>
            </li>
        </ul>
    </div>
</div>
</body>
</html>
