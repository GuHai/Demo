<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/21
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>企业工作号</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/index/business.css?version=4">
</head>
<body>
<div class="wrap">
    <div class="business-index">
        <header class="hd-switch-list">
            <%--切换图片--%>
            <div class="hd-box">
                <div class="img">
                    <img src="/ijob/static/images/workslide.png"/>
                </div>
                <div class="linear-gradient">
                    <a onclick="ijob.gotoPage({url:'/ijob/api/InformationController/h5/mine/toQrcode'})"><span class="iconfont icon-erweima"></span></a>
                </div>
                <div class="switch-content-box">
                    <a href="javascript:void(0);" class="switch-btns" onclick="toswitch()">切换工作号
                        <span class="icon"><em></em><i></i></span>
                    </a>
                </div>
            </div>
            <%--个人信息--%>
            <div class="perInform">
                <div class="box-area">
                    <div class="photo">
                        <img class="pic_toux" src="/ijob/static/images/default.jpg"  alt="头像">
                    </div>
                    <div class="list-item">
                        <div class="name">巴拉巴拉 </div>
                        <div class="count">
                            <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/qz/mine/myFans'})"><span>粉丝 <i>7</i></span></a>
                            <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/qz/myjob/history_job'})"><span>历史职位 <i>8</i></span></a>
                        </div>
                    </div>

                </div>
            </div>
            <%--个人信息 end--%>
        </header>

        <%--工作号简介--%>
        <div class="synopsis-box">
            <div class="abstract" onclick="ijob.gotoPage({path:'/h5/qz/index/SubmitIntroduction'})">
                这个地方是工作号的简介，这个地方是工作号的简介，这个地方是工作号的简介
            </div>
        </div>
        <%--工作号简介end--%>
        <%--职位列表 end--%>
        <div class="tabContent mainbox">
            <ul>
                <li class="ul-li" onclick="ijob.gotoPage({path:'/h5/qz/myjob/full_time_detail'})">
                    <div class="title">
                        <span class="txt">长沙德邦聘搬运工十二个字</span>
                        <span class="money">3000-5000元/月</span>
                    </div>
                    <div class="name">长沙人力资源公司·岳麓区</div>
                    <div class="tag-list">
                        <div class="welfaretag taglist">
                            <span>福利</span>
                            <span>包吃</span>
                            <span>包住</span>
                            <span>月休4天</span>
                            <span>交通补助</span>
                        </div>
                        <div class="requiretag taglist">
                            <span>工作</span>
                            <span>20-55岁</span>
                            <span>三班倒</span>
                        </div>
                    </div>
                </li>
                <li class="ul-li">
                    <div class="title">
                        <span class="txt">长沙德邦聘搬运工十二个字</span>
                        <span class="money">3000-5000元/月</span>
                    </div>
                    <div class="name">长沙人力资源公司·岳麓区</div>
                    <div class="tag-list">
                        <div class="welfaretag taglist">
                            <span>福利</span>
                            <span>包吃</span>
                            <span>包住</span>
                            <span>月休4天</span>
                            <span>交通补助</span>
                        </div>
                        <div class="requiretag taglist">
                            <span>工作</span>
                            <span>20-55岁</span>
                            <span>三班倒</span>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <%--职位列表 end--%>
        <%--切换工作号--%>
        <div class="switch-popup-backdrop">
            <div class="switch-content-box">
                <a href="javascript:void(0);" class="switch-btns">
                    切换工作号
                    <span class="icon"><em></em><i></i></span>
                </a>
            </div>
            <div class="switch-box">
                <div class="work-list">
                    <p class="txt">当前</p>
                    <div class="name curr">长沙大学</div><%--curr当前选择的工作号--%>
                </div>
                <div class="work-list">
                    <p class="txt">我的工作号</p>
                    <div class="name">刘方敏的工作号哦刘方敏的工作号哦</div>
                </div>
                <div class="work-list">
                    <p class="txt">我管理的工作号</p>
                    <div class="name border-bottom curr">长沙大学</div><%--border-bottom 管理多个公众号--%>
                    <div class="name">涉外经济学院</div>
                </div>
                <div class="tips">没有更多工作号了哦~</div>
            </div>
        </div>
        <%--切换工作号 end--%>

    </div>
</div>
</body>
</html>
<script>
    $(function () {
        $(".tag-list span").each(function () {
            if ($(this).text() == '福利'){
                $(this).addClass("curr1");
            }else if ($(this).text() == '工作'){
                $(this).addClass("curr2");
            }else if ($(this).text().length >= 4){
                $(this).css("width","1.653rem")
            }
        })
    })
    /*切换工作号*/
    $("body>*").on('click', function (e) {
        if ($(e.target).hasClass('switch-popup-backdrop')) {
            $(".switch-popup-backdrop").removeClass("modal-active");
            $(".switchbg").remove();
        }
    });
    function toswitch(){
        $(".switch-popup-backdrop").addClass("modal-active");
        if($(".switchbg").length>0){
            $(".switchbg").addClass("switchbg-active");
        }else{
            $("body").append('<div class="switchbg"></div>');
            $(".switchbg").addClass("switchbg-active");
        }
        $(".switch_btn").click(function(){
            $(".switch-popup-backdrop").removeClass("modal-active");
            setTimeout(function(){
                $(".switchbg-active").removeClass("switchbg-active");
                $(".switchbg").remove();
            },300);
        })
    }
</script>
