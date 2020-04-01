<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/30
  Time: 10:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.yskj.service.base.DictCacheService" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>我的</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/mine.css?version=4">
</head>
<body>
<script type="text/html" id="mine" data-url="/ijob/api/InformationController/h5/qz/getMine" data-type="POST">
    {{each list as mine}}
    <div class=wrap>
        <header class="head">
            <div class="head_topBox">
                <a href="/ijob/api/InformationController/h5/mine/basicInfo">
                    <div class="imgBox">
                        <img class="photoImg" src="{{mine.imagePath}}" alt=""
                             onerror="this.src='/ijob/static/images/default.jpg';this.onerror=null">
                    </div>
                    <div class="infoBox">
                        <p class="nameP"><shiro:principal property="nickName"/></p>
                        <p class="noteP"><i class="iconfont icon-xiugai1" style="font-size: 12px;"></i>&nbsp;&nbsp;工作号：
                            {{mine.Information.workNumber |ifNull:'无工作号' }}
                        </p>
                    </div>
                </a>
                <div class="codeBox">
                    <a href="/ijob/api/InformationController/h5/mine/toQrcode"><i class="iconfont icon-erweima codeImg"></i></a>
                </div>
            </div>
            <%--我的工作号--%>
            <div class="head_bottomBox">
                <div class="hd-box">
                    <div class="workNumber">
                        <a href="/ijob/api/InformationController/h5/mine/examineUserInfo/" id="workNumber" class="flex">
                            <span class="mine_edit"><i class="iconfont icon-zhuye1"></i>我的工作号</span>
                            {{if mine.dshPosition!=null && mine.dshPosition!=0}}
                            <span class="t_tips">待审核<i class="num">{{mine.dshPosition}}</i>
                            {{/if}}
                                <span class="iconfont icon-arrow-right"></span></span>
                        </a>
                    </div>
                    <ul class="mui-row ">
                        <li class="fans mui-col-xs-6 mui-col-sm-6">
                            <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/qz/mine/myFans'})">
                                <p class="fans-data">{{mine.fansCount}}</p>
                                <p>粉丝</p>
                            </a>
                        </li>
                        <li class="attention mui-col-xs-6 mui-col-sm-6">
                            <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/qz/mine/myFocus'})">
                                <p class="attention-data">{{mine.followCount}}</p>
                                <p>关注</p>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <%--我的工作号 end--%>
        </header>
        <div class="main">
            <ul class="selectList">
                {{if mine.Information.identityType == 1}}
                <li class="mine_jianzhi" id="jobRecord">
                    <a href="javascript:void(0);" class="qzText">
                        <span class="mine_jianzhi_span">
                            <i class="iconfont icon-jianzhi1"></i>
                            <em>求职记录</em>
                        </span>
                    </a>
                    <div class="mui-popup-backdrop" style="display:none;">
                        <div class="record-box">
                            <ul>
                                <li class="part-time">兼职</li>
                                <li class="full-time">全职</li>
                                <li class="cancel" id="cancel">取消</li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li class="mine_resume">
                    <a href="javascript:void(0);"
                       onclick="ijob.gotoPage({path:'/h5/qz/mine/chooseResume_add'})">
                        <span class="mine_resume_span">
                            <i class="icon1 iconfont icon-wodejianli"></i>
                            <em>我的简历</em>
                        </span>
                    </a>
                </li>
                <li class="mine_bank">
                    <a href="javascript:void(0)" onclick="ijob.gotoPage({path:'/h5/salaryCard'})">
                        <span class="mine_bank_span">
                            <i class="iconfont icon-qia"></i>
                            <em>工资卡</em>
                        </span>
                    </a>
                </li>
                <li class="mine_join">
                    <a href="/ins" >
                        <span class="mine_set_span">
                            <i class="iconfont icon-baoxian"></i>
                            <em>保险</em>
                        </span>
                    </a>
                </li>
                {{/if}}
                {{if mine.Information.identityType == 2}}
                <li class="mine_resume">
                    <a href="/ijob/api/PositionController/h5/mine/positionManage">
                        <span class="mine_resume_span">
                            <i class="iconfont icon-guanlikehu"></i>
                            <em>兼职管理</em>
                        </span>
                    </a>
                </li>
                <li class="mine_resume">
                    <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/newAccount'})">
                        <span class="mine_resume_span">
                            <i class="iconfont icon-erweima"></i>
                            <em>批量发工资</em>
                        </span>
                    </a>
                </li>
                <li class="mine_bank">
                    <a href="javascript:void(0)" onclick="ijob.gotoPage({path:'/h5/salaryCard'})">
                        <span class="mine_bank_span">
                            <i class="iconfont icon-qia"></i>
                            <em>工资卡</em>
                        </span>
                    </a>
                </li>
                {{if  mine.Information.fullType == 1}}
                <li class="mine_resume">
                    <a href="javascript:void(0);" id="fullJob">
                        <span class="full_time_span">
                            <i class="iconfont icon-guanlikehu"></i>
                            <em>全职管理</em>
                        </span>
                    </a>
                </li>
                {{/if}}
                <li class="mine_resume">
                    <a href="javascript:void(0)" id="broker" data-url="/ijob/api/FullTimeController/becomeBroker">
                        <span class="mine_resume_span">
                            <i class="iconfont icon-jingjiren"></i>
                            <em>经纪人</em>
                        </span>
                    </a>
                    <form id="form" style="display: none;">
                        <input type="hidden" value="<shiro:principal property="id"/>" id="userID">
                    </form>
                </li>
                <li class="mine_attest">
                    <a href="/ijob/forward?path=/h5/qz/mine/realName">
                        <span class="mine_attest_span">
                            <i class="iconfont icon-shimingrenzheng"></i>
                            <em>实名认证</em>
                        </span>
                    </a>
                </li>
                <li class="mine_join">
                    <a href="/ins">
                        <span class="mine_set_span">
                            <i class="iconfont icon-baoxian"></i>
                            <em>保险</em>
                        </span>
                    </a>
                </li>
                {{/if}}
                <li class="mine_join">
                    <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/qz/mine/partnerPlan'})">
                        <span class="mine_join_span">
                            <i class="iconfont icon-zhaoshanghezuo"></i>
                            <em>合伙人计划</em>
                        </span>
                    </a>
                </li>
                <li class="mine_set">
                    <a href="/ijob/api/InformationController/h5/mine/mySettings">
                        <span class="mine_set_span">
                            <i class="iconfont icon-guanli"></i>
                            <em>设置</em>
                        </span>
                    </a>
                </li>
                <li class="mine_switch">
                    <a href="/ijob/api/InformationController/h5/mine/switchIdentity">
                        <span class="mine_switch_span">
                            <i class="iconfont icon-qiehuan"></i>
                            <em>切换身份</em>
                        </span>
                    </a>
                </li>
                <li class="mine_switch">
                    <a href="/ijob/api/ApiPromotionController/coupon">
                        <span class="mine_bank_span">
                            <i class="iconfont icon-qia"></i>
                            <em>卡券</em>
                        </span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
    <a href="/ijob/api/ResumeController/toGaodeMap"></a>
    {{/each}}
</script>
</body>
</html>
<script type='text/javascript' src='/ijob/static/js/slide.js'  charset="UTF-8"></script>
<script>

    ijob.storage.set("billobj","");

    location_2 = ijob.location.get();




    $("#mine").loadData().then(function (result) {
        var id = result.data.list[0].Information.userID ;
        if(result.data.list[0].Information.lastWorkNumber!= null){
            id = result.data.list[0].Information.lastWorkNumber;
        }
        ijob.storage.set("partner",result.data.list[0].partner);
        $("#workNumber").attr("href",$("#workNumber").attr("href")+location_2.lng +"/"+location_2.lat+'/'+id);
        $("#fullJob").click(function(){
            $.getJSON("/ijob/api/PersonalauthenController/qz/checkFinalVerification",function(result){//校验是否实名
                if(result.code == 200){
                    ijob.gotoPage({path:'/h5/zp/fullTime/fullTime'});
                }else{
                    /*实名认证*/
                    var btnArray = ['否','是'];
                    mui.confirm('根据相关部门规定，必须实名认证，才能进行下一步操作。', '提示', btnArray, function(e) {
                        if (e.index == 1) {
                            ijob.gotoPage({path:"/h5/qz/mine/realName"});
                        }
                    });
                }
            });
        });
        /*经纪人*/
        $("#broker").click(function(){
            $.getJSON("/ijob/api/FullTimeController/checkBroker",function(result){
                if(result.code == 200){
                    ijob.gotoPage({path:"/h5/zp/broker/broker?broker.code="+result.data.list[0].code});
                }else if(result.code==401){
                    mui.toast(result.msg);
                }else{
                    $.getJSON("/ijob/api/PersonalauthenController/qz/checkFinalVerification",function(result){//校验是否实名
                        if(result.code == 200){
                            /*申请成为经纪人*/
                            var btnArray = ['否','是'];
                            mui.confirm('您还不是经纪人，是否申请成为经纪人？', '提示', btnArray, function(e) {
                                if (e.index == 1) {
                                    /*ijob.gotoPage({path:"/h5/zp/broker/broker"});*/
                                    $.getJSON("/ijob/api/FullTimeController/becomeBroker",function(result){
                                        if(result.code == 200){
                                            mui.toast(result.msg);
                                        }else {
                                            mui.toast("网络异常...");
                                        }
                                    })
                                }
                            });

                        }else{
                            /*实名认证*/
                            var btnArray = ['否','是'];
                            mui.confirm('根据相关部门规定，必须实名认证，才能进行下一步操作。', '提示', btnArray, function(e) {
                                if (e.index == 1) {
                                    ijob.gotoPage({path:"/h5/qz/mine/realName?data.becomeBroker=1"});
                                }
                            });
                        }
                    });
                }
            });
        });
        var slide = null;
        /*求职记录*/
        $(".qzText").click(function () {
            $(".mui-popup-backdrop").show();
            slide = new Slide($(".wrap"),$(".mui-popup-backdrop"),".record-box");
            slide.disTouch();
        })
        $("#cancel").click(function () {
            $(".mui-popup-backdrop").hide();
            slide.ableTouch();
        })
        $(".part-time").click(function(){
            ijob.menu.set("personal:part");
            ijob.gotoPage({path:'/h5/qz/myjob/my_part_time_job'});
        });
        $(".full-time").click(function(){
            ijob.menu.set("personal:full");
            ijob.gotoPage({path:'/h5/qz/myjob/full_time_job'})
        });
    });
    $(".selectList>li").on("click", function () {
        $(".wrap").hide();
        $("#chooseResume").show();
    })
</script>