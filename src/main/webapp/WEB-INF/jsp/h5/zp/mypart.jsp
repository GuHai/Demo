

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>我的</title>
    <jsp:include page="../zp/base/resource.jsp"/>
</head>
<body>


<div class=wrap style="margin-top:1.173rem;">
    <header class="head">
        <div class="head_topBox">
            <a href="javascript:void(0);">
                <div class="imgBox">
                    <img class="photoImg" src="../../images/toux.png" alt="">
                </div>
                <div class="infoBox">
                    <p class="nameP">Anne</p>
                    <p class="noteP">工作号：中南大学兼职负责人</p>
                </div>
            </a>
            <div class="codeBox">
                <a href="javascript:void(0);"><i class="iconfont icon-erweima codeImg"></i></a>
            </div>
        </div>
        <div class="head_bottomBox">
            <ul class="mui-row ">
                <li class="fans mui-col-xs-4 mui-col-sm-4">
                    <a href="javascript:void(0);">
                        <p class="fans-data">125</p>
                        <p>粉丝</p>
                    </a>
                </li>
                <li class="attention mui-col-xs-4 mui-col-sm-4">
                    <a href="javascript:void(0);">
                        <p class="attention-data">78</p>
                        <p>关注</p>
                    </a>
                </li>
                <li class="credit mui-col-xs-4 mui-col-sm-4">
                    <a href="javascript:void(0);">
                        <p class="credit-data">1000</p>
                        <p>信用值</p>
                    </a>
                </li>
            </ul>
        </div>
    </header>
    <div class="main">
        <ul class="selectList">
			<li class="mine_resume">
                <a href="javascript:void(0);">
                    <span class="mine_resume_span"><i class="iconfont icon-guanlikehu"></i>职位管理</span>
                    <span class="iconfont icon-arrow-right"></span>
                </a>
            </li>
            <li class="mine_bank">
                <a href="javascript:void(0);">
                    <span class="mine_bank_span"><i class="iconfont icon-shimingrenzheng"></i>企业认证</span>
                    <span class="iconfont icon-arrow-right"></span>
                </a>
            </li>
            <li class="mine_join">
                <a href="javascript:void(0);">
                    <span class="mine_join_span"><i class="iconfont icon-zhaoshanghezuo"></i>招商加盟</span>
                    <span class="iconfont icon-arrow-right"></span>
                </a>
            </li>
            <li class="mine_switch">
                <a href="javascript:void(0);">
                    <span class="mine_switch_span"><i class="iconfont icon-qiehuan"></i>切换身份</span>
                    <span class="iconfont icon-arrow-right"></span>
                </a>
            </li>
            <li class="mine_set">
                <a href="javascript:void(0);">
                    <span class="mine_set_span"><i class="iconfont icon-guanli"></i>设置</span>
                    <span class="iconfont icon-arrow-right"></span>
                </a>
            </li>
        </ul>
    </div>
   <jsp:include page="../zp/base/foot.jsp"/>
</div>

</body>
</html>
<script src="../../../ijob/lib/jquery-2.2.3.js"></script>
