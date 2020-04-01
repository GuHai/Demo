<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/22
  Time: 19:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<html>
<head>
    <title>主页</title>
    <link rel="stylesheet" href="/ijob/static/css/index/index.css?version=4">
    <style>
        .personbox>.name{
            display: inline-block;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            width: 85%;
        }
    </style>
</head>
<body>

<!--搜索框-->
<header class="head bg_hd">
    <div class="head-fixe" style="height: 1.200rem">
        <div class="positioning" id="prompt">定位中</div>
        <div class="tab_head">
            <ul id="group">
                <li class="head-li personnel active" data-index="0"><a href='javascript:void(0);'>人才</a></li>
                <li class="head-li position"data-index="1"><a href='javascript:void(0);'>职位</a></li>
            </ul>
        </div>
        <%--<b style="color: white;font-size: 0.4rem;font-family:Microsoft yahei;">人才</b>--%>
        <div class="mui-input-row mui-search head-find">
            <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/man_list'})">
                <%--<input type="search" disabled="disabled" style="font-size:0.373rem;color:#fff;text-align:left;text-indent:0.400rem;" value="搜索人才">--%>
                <%--<i class="iconfont icon-sousuo h-sousuo" style="top: -0.26rem;"></i>--%>
                <i class="iconfont icon-sousuo"></i>
                <span>搜索</span>
            </a>
        </div>
    </div>

</header>

<div class="main">
    <div class="personnel_content_box mui-content-box">
        <!--轮播图-->
        <div class="banner">
            <div class="mui-slider">
                <div class="mui-slider-group mui-slider-loop">
                    <!--支持循环，需要重复图片节点-->
                    <div class="mui-slider-item mui-slider-item-duplicate"><a href="javascript:void(0);"><img
                            src="/ijob/static/images/banner1.png"/></a>
                    </div>
                    <div class="mui-slider-item ban-slider"><a href="javascript:void(0);"><img src="/ijob/static/images/banner1.png"/></a></div>
                    <div class="mui-slider-item ban-slider"><a href="https://c.eqxiu.com/s/3gyhROfb"><img src="/ijob/static/images/bannner.png"/></a></div>
                    <%--<div class="mui-slider-item ban-slider"><a href="javascript:void(0);"><img src="/ijob/static/images/banner03.jpg"/></a></div>--%>
                    <div class="mui-slider-item ban-slider"><a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/qz/mine/partnerPlan'})"><img src="/ijob/static/images/partnerbanner.png"/></a></div>
                    <!--支持循环，需要重复图片节点-->
                    <div class="mui-slider-item mui-slider-item-duplicate"><a href="javascript:void(0);"><img
                            src="/ijob/static/images/banner1.png"/></a>
                    </div>
                </div>
                <div class="mui-slider-indicator">
                    <div class="mui-indicator mui-active"></div>
                    <div class="mui-indicator"></div>
                    <div class="mui-indicator"></div>
                    <%--<div class="mui-indicator"></div>--%>
                </div>
            </div>
        </div>
        <!--导航-->
        <div class="wrapper wrapper02" id="wrapper02">
            <div class="scroller">
                <ul class="clearfix">
                    <script type="text/html" id="qznav" data-url="/ijob/api/PositionController/h5/index/zp/myReleasePosition"
                            data-type="POST">
                        {{each list as posi index}}
                        <li class="worktype"  data-wtid="{{posi.workTypeID}}" data-index="{{index}}"><a href="javascript:void(0);">{{posi.title}}</a>
                        </li>
                        {{/each}}
                    </script>
                </ul>
            </div>
        </div>
        <!-- 信息 -->
        <div class="JobInfo">
            <ul class="list-box">
                <script type="text/html" id="qzjobtemplate" data-url="/ijob/api/PositionController/h5/index/zp/mySeekerPage/0">
                    {{each list as resume}}
                    <li class="JImans" onclick="ijob.gotoPage({url:'/ijob/api/ResumeController/h5/zp/index/previewOtherUserResume/{{resume.id}}'})" >
                        <a href="javascript:void(0);">
                            <div class="manName">
                               <%-- {{if resume.attachment != null}}
                                <img src="/ijob/upload/{{resume.attachment |absolutelyPath}}"
                                     onerror="this.src='{{resume.user.weixin.headimgurl}}';this.onerror=null;"/>
                                {{else}}
                                <img src="/ijob/upload/{{resume.user.attachment |absolutelyPath}}"
                                     onerror="this.src='{{resume.user.weixin.headimgurl}}';this.onerror=null;"/>
                                {{/if}}--%>

                                   <img src="/ijob/upload/{{resume.localimg}}"
                                        onerror="this.src='{{resume.headimg}}';this.onerror=null;"/>
                            </div>
                            <div class="inform">
                                <div class="personbox">
                                    <span class="name" id="nametxt">{{resume.name |ifNull:''}}</span>
                                    <span class="sex"><%--{{resume.sex==1?'男':'女'}}--%>
                                        {{if resume.sex == 1}}
                                        <span class="iconfont icon-nan1"></span>
                                         {{else}}
                                        <span class="iconfont icon-nv1"></span>
                                        {{/if}}
                                    </span>
                                </div>
                                <div class="posi_list">
                                    <span>{{resume.inte!=null?resume.inte:'暂未设置求职意向'}}</span>
                                </div>
                            </div>
                        </a>
                    </li>
                    {{/each}}
                </script>
            </ul>
        </div>
        <div class="fix-block-r">
            <a href="javascript:void(0);" class="gotop-btn gotop"
               onclick="ijob.gotoPage({path:'/h5/zp/postJob2?positionTemp.id=0'})">
                <i class="iconfont icon-fabu1"></i>
            </a>
        </div>
    </div>
    <div class="position_content_box mui-content-box" style="display: none;">
        <div class="positionList">
            <div class="mainBox">
                <ul class="ulList">
                    <script type="text/html" id="positionTemp" data-url="/ijob/api/RewardController/findPositionByRewardPage"data-type="POST">
                        {{each list as position index}}
                            <li class="list_li">
                                <div class="list-container" onclick="ijob.gotoPage({path:'/h5/qz/index/part_time_detail?data.position.id={{position.position.id}}&shareObj.title={{position.position.title}}&shareObj.salary={{position.position.dailySalary}}&shareObj.date={{position.position.recruitStartTime | dateFormat:'MM/dd'}}-{{position.position.recruitEndTime | dateFormat:'MM/dd'}}&shareObj.city={{position.position.workPlace.city.cityName}}'})">
                                    <div class="list-title">
                                        <span class="title-content">{{position.position.title}}</span>
                                    </div>
                                    <div class="list-content">
                                        <div class="content-tit" style='background-color:{{position.position.huntingtype.codeGrade |getTypeColor}}!important;'>{{position.position.huntingtype.name}}</div>
                                        <div class="content-msg">
                                            <div class="content-msg1">
                                            <span class="content-msg1-lf">
                                                <i class="iconfont icon-shizhong"></i>
                                                 {{position.position.publishTime |dateFormat:'MM-dd'}} ({{position.position.publishTime |dateFormat:'周W'}})
                                            </span>
                                                <span class="content-msg1-rt">{{position.position.dailySalary}}元/天</span>
                                            </div>
                                            <div class="content-msg2">
                                            <span class="content-msg2-lf">{{if position.position.sexRequirements == null || position.position.sexRequirements == ''}}男女不限{{else}}{{position.position.sexRequirements |enums:'SexRequirements'}}{{/if}}&nbsp;<span
                                                    class="line"></span>&nbsp;<%--{{position.position.beenRecruitedSum |ifNull:'0'}}/--%>{{position.position.personNumDay}}人/天</span>
                                                <span class="content-msg2-rt"></span>
                                            </div>
                                            <div class="content-msg3">
                                                <span class="content-msg3-lf">{{position.position.workPlace | ifNull:'未知','city.cityName'}}&nbsp; {{position.position.workPlace.distance | distance }}</span>
                                                <span class="content-msg3-rt">{{position.position.publish | ifNull : '无工作号','workNumber'}}</span>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div class="bottomBox">
                                    <div class="left"><em><%--{{position.position.beenRecruitedSum |ifNull:'0'}}/--%>{{position.position.recruitsSum}}人</em><span>提成:每人<i>{{position.rewardMoney}}</i>元/天</span></div>
                                    <div class="right">
                                        <form id="{{position.position.id}}">
                                            <input type="hidden" name="title" value="{{position.position.title}}">
                                            <input type="hidden" name="id" value="{{position.position.id}}">
                                            <input type="hidden" name="salary" value="{{position.position.dailySalary}}">
                                            <input type="hidden" name="date" value="{{position.position.recruitStartTime | dateFormat:'MM/dd'}}-{{position.position.recruitEndTime | dateFormat:'MM/dd'}}">
                                            <input type="hidden" name="city" value="{{position.position.workPlace.city.cityName}}">
                                            <input type="hidden" name="codeGrade" value="{{position.position.huntingtype.codeGrade}}">
                                            <input type="hidden" name="shareUser" value="<shiro:principal property="id"/>">
                                        </form>
                                        <a href="javascript:void(0);" class="share" data-index="{{position.position.id}}"><span class="iconfont icon-fenxiang"></span>分享</a>
                                        <a href="javascript:void(0);" class="forward"
                                           onclick="ijob.gotoPage({path:'/h5/zp/postForward?reward.positionID={{position.positionID}}&reward.rewardMoney={{position.rewardMoney}}&reward.id={{position.id}}'})"><span
                                                class="iconfont icon-zhuanfa"></span>转发</a>
                                    </div>
                                </div>
                            </li>
                        {{/each}}
                    </script>

                </ul>
                <%--分享--%>
                <div class="share-content">
                    <div class="popup-backdrop">
                        <div class="descript"><span class="rotate"><span class="iconfont icon-dianji1"></span></span>点击进行分享</div>
                        <div class="arrowhead">
                            <img src="/ijob/static/images/arrowhead.png"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
<script src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js" type="text/javascript"></script>
<script>

    function loadHandler(_this,workTypeID){
        if($(".contentBox").length>1){
            for (var i =0; i<$(".contentBox").length;i++){
                $($(".contentBox")[i]).remove();
            }
        }
        ijob.menu.set("findJob:0:"+_this.data("index"));
        //判断是否是第一次进入该页面
        if (oldWorkTypeID == null){
            oldWorkTypeID = _this.data("index");
        }
        //判断是否需要重新加载其他工作类型下面的求职者。
        if(oldWorkTypeID!=_this.data("index")){
            oldWorkTypeID=_this.data("index");
        }
        $(".clearfix li").attr("class", "");
        _this.attr("class", "cur");
        $("#qzjobtemplate").data("url", "/ijob/api/PositionController/h5/index/zp/mySeekerPage/" + workTypeID);
        var page = {"pageSize": "10", "currentPage": "1"};
        var ijobRefresh = new IJobRefresh({
            container: '.JobInfo',
            clear:false,
            up: function () {
                var obj = $.extend(page, {});
                $("#qzjobtemplate").appendData(obj, ijobRefresh).then(function (result) {
                    page.currentPage = result.nextPage;
                    if(result.totalPage < result.nextPage && loadOther == true){
                        loadOther = false;
                        if($(".JImans").length%2==1){
                            $('.JImans:last').after("<li class='rem-tit'>暂无更多，已为您推送其他人才：</li>")
                        }else{
                            $('.JImans:last').after("<li class='rem-tit'>暂无更多，已为您推送其他人才：</li>\n" +
                                "            <li style='display: none'></li>");
                        }
                        $("#qzjobtemplate").data("url","/ijob/api/PositionController/h5/index/zp/mySeekerPage" );
                        loadHandler(_this,"ALL");
                    }
                    //appendText();
                    $(".personbox").each(function () {
                        if($(this).children(".name").text().length < 4){
                            $(this).children(".name").css("width","auto")
                        }
                    })

                });
            }
        });
    }
    $("#wrapper02").on('click','li',function(){
        var workTypeID = $(this).data("wtid");
        var _this = $(this);
        $(".list-box li").remove();
        $(".JobInfo").find(".noMore").parent().remove();
        $(".JobInfo").find("#loadimg").parent().remove();
        loadOther = true;
        loadHandler(_this,workTypeID);
    });

    function getRewardPosition(){
        var page = {"pageSize": "10", "currentPage": "1",condition:{lng:ijob.location.get().lng,lat:ijob.location.get().lat}};
        var ijobRefresh = new IJobRefresh({
            container: '.ulList',
            up: function () {
                var obj = $.extend(page, {});
                $("#positionTemp").appendData(obj, ijobRefresh).then(function (result) {
                    console.log(result);
                    page.currentPage = result.nextPage;
                    var slide = null;
                    // 分享
                    $(".share").click(function () {
                        $(".share-content").show();
                        slide = new Slide($(".wrap"), $(".share-content"), ".popup-backdrop");
                        slide.disTouch();
                        initShare($("#"+$(this).data("index")).serializeObjectJson());
                    });
                    $(".share_content .cancel a").click(function () {
                        $(".share_content").hide();
                        slide.ableTouch();
                    });
                    // 点击空白处隐藏选项
                    $("body>*").on('click', function (e) {
                        if ($(e.target).hasClass('share-content')) {
                            $(".share-content").hide();
                            slide.ableTouch();
                        }
                    });
                });
            }
        });
    }
    function appendText() {
        $(".posiType").each(function(){
            if($(this).text().trim(" ")==""||$(this).text()==null||$(this).text()==undefined)
                $(this).text("暂未设置求职意向")
        });
    }

    $(function () {
        // 人才、职位切换
        $(".head-li").click(function () {
            $(this).addClass("active").siblings().removeClass("active");
            $(".main .mui-content-box").eq($(this).index()).show().siblings().hide();
            if($(this).text() == "职位"){
                $(".wrap .head").removeClass("bg_hd");
                ijob.menu.set("findJob:1");
            }else {
                $(".wrap .head").addClass("bg_hd");
                ijob.menu.set("findJob:0");
            }
            if($(this).index() == 1){
                getRewardPosition();
            }
        });
    })
    var localtion = ijob.location.get();
    document.getElementById("prompt").innerHTML = (localtion.city || '失联中') + "<i class=\"mui-icon mui-icon-arrowdown\">";


    $("#prompt").click(function () {
        var btn = ['取消', '切换'];
        var localtion = ijob.location.get();
        var info = '定位为' + localtion.city + '，是否切换？';
        mui.confirm(info, '提示', btn, function (e) {
            if (e.index == 0) {

            } else {
                ijob.gotoPage({path: "/h5/qz/index/select_area"});
            }
        })
    });

    // 切换地址过长
    function conceal() {
        var len = $("#prompt").text().length;
        var str = $("#prompt").text().substring(0,3);
        if(len > 3){
            $("#prompt").html(str+"…"+"<i class=\"mui-icon mui-icon-arrowdown\">");
        }else {
            $("#prompt").css("width","16%");
            $("#prompt").siblings(".tab_head").css("width","68%");
        }
    }
    conceal();

    setTimeout(function () {
        $("#qznav").loadData().then(function (result) {
            if (result && result.data && result.data.list.length > 0) {
                $('.wrapper').navbarscroll();
                $(".scroller").width(30000);
                menu = ijob.menu.get();
                if(menu && menu.split(":").length==3){
                    $(".clearfix li").eq(menu.split(":")[2]).click();
                }else{
                    $(".clearfix li:first").click();
                }
            } else {
                $('.wrapper02').html("<div style='height: 1.3rem;line-height: 1.3rem;text-align: center;font-size: 0.35rem;'><a href=\"javascript:void(0)\" style='color: #999;'>发布职位后，系统会推荐相关人才</a></div>");
                $('.JobInfo').append("<p style='text-align: center;margin-top: 2rem;font-size: 0.373rem'>没有发布任何职位！&nbsp;&nbsp;<a href='javascript:void(0);' onclick=\"ijob.gotoPage({path:'/h5/zp/postJob2?positionTemp.id=0'})\" style='text-decoration: underline;color: #108ee9'>立即发布</a></p>");
            }
        });

    }, 100);

    //用户判断是否加载对当前职位类型有意向的求职者
    var loadOther = true ;
    var oldWorkTypeID = null;
    //用于判断是否重新加载，还是将数据添加到已有数据后面
    //获得slider插件对象
    var gallery = mui('.mui-slider');
    gallery.slider({
        interval: 3000//自动轮播周期，若为0则不自动播放，默认为0；
    });

    function initShare(shareObj){
        var title= "【I Job兼职】"+shareObj.title;
        var desc="待遇："+shareObj.salary+"元/天"+"\n"+"地点："+shareObj.city+"\n时间："+shareObj.date;
        // var link="http://www.jianzhipt.cn";
        var link="${site}/share/PD/"+shareObj.id + "/" + shareObj.shareUser;
        console.log(shareObj.codeGrade);
        var tempType = shareObj.codeGrade;
        var imgUrl="";
        if(tempType=="0016"||tempType=="007"||tempType=="0020"||tempType=="0024"){
            imgUrl="${site}/static/images/shareLogo1.png";
        }else if(tempType=="006"||tempType=="005"||tempType=="0026"){
            imgUrl="${site}/static/images/shareLogo2.png";
        }else if(tempType=="0014"||tempType=="004"){
            imgUrl="${site}/static/images/shareLogo3.png";
        }else if(tempType=="0012"||tempType=="0015"){
            imgUrl="${site}/static/images/shareLogo4.png";
        }else if(tempType=="0010"){
            imgUrl="${site}/static/images/shareLogo5.png";
        }else if(tempType=="008"||tempType=="009"||tempType=="0013"||tempType=="0018"){
            imgUrl="${site}/static/images/shareLogo6.png";
        }else if(tempType=="0025"||tempType=="0021"||tempType=="001"){
            imgUrl="${site}/static/images/shareLogo7.png";
        }else if(tempType=="0017"||tempType=="003"||tempType=="002"||tempType=="0019"){
            imgUrl="${site}/static/images/shareLogo8.png";
        }else if(tempType=="0011"||tempType=="0023"||tempType=="0022"){
            imgUrl="${site}/static/images/shareLogo9.png";
        }else{
            imgUrl="${site}/static/images/sharelogo.png";
        }
        $.getJSON("/ijob/api/WeixinController/getJSAuthSignature?url="+window.location.href,function(data){
            wx.config({
                debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                appId: data.data.appId, // 必填，公众号的唯一标识
                timestamp: data.data.timestamp, // 必填，生成签名的时间戳
                nonceStr: data.data.noncestr, // 必填，生成签名的随机串
                signature: data.data.signature,// 必填，签名
                jsApiList: ["onMenuShareAppMessage","onMenuShareTimeline","onMenuShareQQ","onMenuShareQZone","onMenuShareWeibo"] // 必填，需要使用的JS接口列表
            });
        })

        wx.ready(function () {

            var params = {
                title: title, // 分享标题
                desc: desc, // 分享描述
                link: link, // 分享链接
                imgUrl: imgUrl, // 分享图标
                success: function () {
                    // 用户确认分享后执行的回调函数
                },
                cancel: function () {
                    // 用户取消分享后执行的回调函数
                }
            };

            //获取“分享给朋友”按钮点击状态及自定义分享内容接口
            wx.onMenuShareAppMessage(params);
            //获取“分享到朋友圈”按钮点击状态及自定义分享内容接口
            wx.onMenuShareTimeline(params);
            //分享到QQ
            wx.onMenuShareQQ(params);
            //分享到QQ空间
            wx.onMenuShareQZone(params);
            //分享到腾讯微博
            wx.onMenuShareWeibo(params);
        });
        wx.error(function(res){
            mui.alert("错误信息"+JSON.stringify(res));
        });
    }

    var menu  = ijob.menu.get();
    if(menu&&menu.indexOf(":")>-1){
        $("#group li").eq(menu.split(":")[1]).click();
    }else{
        $("#group li").eq(0).click();
    }


</script>
</html>
