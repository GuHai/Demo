<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/11
  Time: 10:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

        <link rel="stylesheet" href="/ijob/static/css/index/index.css">

</head>
<body>
<div class="wrap">
    <!--搜索框-->
    <header class="head">
        <div class="head-fixe">
            <div class="positioning" id="prompt"></div>
            <div class="mui-input-row mui-search head-find">
                <a href="/ijob/api/SearchlogController">
                    <%--<input type="search" placeholder="职位/工作号">--%>
                    <i class="iconfont icon-sousuo h-sousuo"></i>
                    <span>搜索</span>
                </a>
            </div>
            <div class="tab_head">
                <ul>
                    <li class="head-li all active"><a href='javascript:void(0);'>全部</a></li>
                    <li class="head-li news"><a href='javascript:void(0);'>关注</a></li>
                </ul>
            </div>
        </div>
    </header>

    <div class="main">
        <%--全部--%>
        <div class="all_content" style="display: block">
            <!--轮播图-->
            <div class="banner">
                <div class="mui-slider">
                    <div class="mui-slider-group mui-slider-loop">
                        <!--支持循环，需要重复图片节点-->
                        <div class="mui-slider-item mui-slider-item-duplicate"><a href="javascript:void(0);"><img
                                src="/ijob/static/images/banner1.png"/></a>
                        </div>
                        <div class="mui-slider-item ban-slider"><a href="javascript:void(0);"><img src="/ijob/static/images/banner1.png"/></a></div>
                        <div class="mui-slider-item ban-slider"><a href="javascript:void(0);"><img src="/ijob/static/images/banner.png"/></a></div>
                        <div class="mui-slider-item ban-slider"><a href="javascript:void(0);"><img src="/ijob/static/images/banner03.jpg"/></a></div>
                        <!--支持循环，需要重复图片节点-->
                        <div class="mui-slider-item mui-slider-item-duplicate"><a href="javascript:void(0);"><img
                                src="/ijob/static/images/banner1.png"/></a>
                        </div>
                    </div>
                    <div class="mui-slider-indicator">
                        <div class="mui-indicator mui-active"></div>
                        <div class="mui-indicator"></div>
                        <div class="mui-indicator"></div>
                    </div>
                </div>
            </div>
            <!--选取-->
            <div class="select_nav">
                <ul class="nav">
                    <li class="nav-li li_1">
                        <div class="nav-box" id="place">
                            <a data-value="地点"  id="point" class="place nav-select" href="javascript:void(0);">地点</a>
                            <i class="iconfont icon-arrow-down1"></i>
                        </div>
                        <div class="mui-backdrop nav-content" >
                            <div class="nav-selected grade-eject" id="workType2">
                                <ul class="grade-w" id="gradew" style="width: 33.3%;">
                                    <li style="background: rgb(242, 245, 247); color: rgb(16, 142, 233);" >附近</li>
                                    <li >区域</li>
                                    <li >地铁</li>
                                </ul>
                                <ul class="grade-t" id="gradet2" style="left: 33.33%;">
                                    <li  style="background: rgb(242, 245, 247); color: rgb(16, 142, 233);"  data-dist="10">不限</li>
                                    <li  data-dist="1">1000m内</li>
                                    <li  data-dist="3">3000m内</li>
                                    <li  data-dist="5">5000m内</li>
                                </ul>
                                <ul class="grade-s" id="gradets">
                                    <%--<li onclick="grades(this)" data-value="全秦皇岛">全秦皇岛</li>
                                    <li onclick="grades(this)" data-value="海港区">海港区</li>
                                    <li onclick="grades(this)" data-value="山海关区">山海关区</li>
                                    <li onclick="grades(this)" data-value="北戴河区">北戴河区</li>
                                    <li onclick="grades(this)" data-value="青龙满族自治区">青龙满族自治区</li>
                                    <li onclick="grades(this)" data-value="昌黎县">昌黎县</li>
                                    <li onclick="grades(this)" data-value="抚宁县">抚宁县</li>--%>
                                </ul>
                            </div>
                        </div>
                    </li>
                    <li class="nav-li line"></li>
                    <li class=" nav-li li_2">
                        <div class="nav-box" id="release">
                            <a data-value="类型" class="release nav-select" href="javascript:void(0);">类型</a>
                            <i class="iconfont icon-arrow-down1"></i>
                        </div>
                        <div class="mui-backdrop nav-content">

                            <%--<li>销售</li>
                            <li>家教</li>
                            <li>模特</li>
                            <li>主持人</li>--%>
                            <ul class="nav-selected" id="publishType">
                                <script  type="text/html" id="typetemplate"  data-url="/ijob/api/HuntingtypeController/findAllType">
                                    {{each list as type }}
                                    <li data-value="{{type.name}}" data-id="{{type.id}}">{{type.name}}</li>
                                    {{/each}}
                                </script>
                            </ul>

                        </div>
                    </li>
                    <li class="nav-li line"></li>
                    <li class="nav-li li_3">
                        <div class="nav-box" id="all-sort">
                            <a data-value="排序" class="all-sort nav-select" href="javascript:void(0);">排序</a>
                            <i class="iconfont icon-arrow-down1"></i>
                        </div>
                        <div class="mui-backdrop nav-content">
                            <ul class="nav-selected" id="orderType">
                                <li data-value="发布时间">发布时间</li>
                                <li data-value="人气优先">人气优先</li>
                                <li data-value="距离优先">距离优先</li>
                                <li data-value="价格优先">价格优先</li>
                            </ul>
                        </div>
                    </li>
                    <li class="nav-li line"></li>
                    <li class="nav-li li_4">
                        <div class="nav-box" id="filter">
                            <a class="filter nav-select" href="javascript:void(0);">筛选</a>
                            <i class="iconfont icon-shaixuan" id="icon-shaixuan"></i>
                        </div>
                        <div class="mui-backdrop nav-content">
                            <ul class="nav-selected "  id="filterPanel">
                                <li class="filter-price">
                                    <div class="mui-input-row mui-input-range">
                                        <h1 class="pri-title">价格</h1>
                                        <div class="scale" id="salary">
                                            <input type="number" placeholder="开始价格" class="text_start"><span>元</span>
                                            <em>——</em>
                                            <input type="number" placeholder="结束价格" class="text_end"><span>元</span>
                                        </div>
                                    </div>
                                </li>
                                <li class="filter-js">
                                    <h1 class="pri-title">结算方式</h1>
                                    <ul class="filter-js-msg">
                                        <li data-id="1">日结</li>
                                        <li data-id="2">周结</li>
                                        <li data-id="3">月结</li>
                                        <li data-id="4">完工结算</li>
                                    </ul>
                                </li>
                                <li class="filter-gender">
                                    <h1 class="pri-title">性别要求</h1>
                                    <ul class="filter-gender-msg">
                                        <li data-id="2">男女不限</li>
                                        <li data-id="1">仅限男性</li>
                                        <li data-id="3">仅限女性</li>
                                    </ul>
                                </li>
                                <li class="filter-claim">
                                    <div class="filter-claim-title">面试要求</div>
                                    <div class="mui-switch mui-switch-mini">

                                        <div class="mui-switch-handle"></div>
                                    </div>
                                </li>
                                <li class="filter-weekend">
                                    <div class="filter-weekend-title">周末</div>
                                    <div class="mui-switch mui-switch-mini">
                                        <div class="mui-switch-handle"></div>
                                    </div>
                                </li>
                                <li class="filter-btn">
                                    <span id="resetBtn">重置</span>
                                    <span id="filterBtn">确定筛选</span>
                                </li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
            <!--信息-->
            <div class="list" >
                <ul class="list-ul">
                    <script  type="text/html" id="jobtemplate"  data-url="/ijob/api/PositionController/myPositionPage">
                        {{each list as posi}}
                        <li class="list-li">
                            <a href="javascript:void(0);"    onclick="ijob.gotoPage({path:'/h5/qz/index/part_time_detail?data.position.id={{posi.id}}&shareObj.title={{posi.title}}&shareObj.salary={{posi.dailySalary}}&shareObj.date={{posi.recruitStartTime | dateFormat:'MM/dd'}}-{{posi.recruitEndTime | dateFormat:'MM/dd'}}&shareObj.city={{posi.workPlace.city.cityName}}'})">
                                <div class="list-container">
                                    <div class="list-title">
                                        <span class="title-content">{{posi.title}}</span>
                                        <span class="titel-note"></span>
                                    </div>
                                    <div class="list-content">
                                        <div class="content-tit" style='background-color:{{posi.huntingtype.codeGrade |getTypeColor}}!important;'>
                                            {{posi.huntingtype | ifNull:'其他','name'}}
                                        </div>
                                        <div class="content-msg">
                                            <div class="content-msg1">
                                                <span class="content-msg1-lf">
                                                    <i class="iconfont icon-shizhong"></i>
                                                    {{posi.recruitStartTime | dateFormat:'MM月dd日'}}-{{posi.recruitEndTime | dateFormat:'MM月dd日'}}
                                                </span>
                                                <span class="content-msg1-rt">{{posi.dailySalary}}元/天</span>
                                            </div>
                                            <div class="content-msg2">
                                                <span class="content-msg2-lf">{{if posi.sexRequirements == '' || posi.sexRequirements == null}}男女不限{{/if}}{{posi.sexRequirements  | enums:'SexRequirements'}}&nbsp;<span class="line"></span>&nbsp;{{posi.beenRecruitedSum | ifNull:'0'}}/{{posi.recruitsSum | ifNull:'0'}}人</span>
                                                <span class="content-msg2-rt">{{posi.settlement | enums:'SettlementType'}}</span>
                                            </div>
                                            <div class="content-msg3">
                                                <span class="content-msg3-lf">{{posi.workPlace | ifNull:'未知','city.cityName'}}&nbsp; {{posi.workPlace.distance | distance }}</span>
                                                <span class="content-msg3-rt">{{posi.publish | ifNull : '无工作号','workNumber'}}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </a>
                            <%--<div class="list-share all">
                                <div class="title envelopes">喊上同学做兼职即可获得红包</div>&lt;%&ndash;envelopes有红包显示，没有显示内容为“喊上同学一起做兼职”&ndash;%&gt;
                                <div class="btns"><a href="javascript:void(0);" class="share" ><span class="iconfont icon-fenxiang"></span>&nbsp;分享</a></div>
                            </div>--%>
                        </li>
                        {{/each}}
                    </script>
                </ul>
            </div>
            <%--求职意向--%>
            <div class="select_filter">
                <div class="fix-block-r" style="display: none">
                    <a href="javascript:void(0);"  onClick="tofilter()"  class="gotop-btn gotop" id="goTopBtn">
                        <i class="iconfont icon-shezhi"></i>
                    </a>
                </div>
                <div class="workFilter" >
                    <script id="myIntention"   type="text/html"  data-url="/ijob/api/BeenrecruitedController/intention">
                        {{each list as map}}
                        <div class="filter_main">
                            <div class="filter_top">
                                <div class="filter-title">
                                    <h3>求职意向</h3>
                                </div>
                                <div class="filter_content">
                                    <div class="post_sort">
                                        <h3>职位类别（可多选）</h3>
                                        <ul class="sortList clearfix" id="jobType">
                                            {{each map.workTypeList as type}}
                                            <li  data-id="{{type.id}}"   class="{{type.isSelected==true ? 'active' : ''}}" data-htid="{{type.id}}"  data-refid="{{type.refId}}" >{{type.name}}</li>
                                            {{/each}}
                                        </ul>
                                    </div>
                                    <div class="region">
                                        <h3>工作区域（可多选）</h3>
                                        <ul class="regionList clearfix" id="jobCity">
                                            {{each map.cityList as city}}
                                            <li  data-id="{{city.id}}"  class="{{city.isSelected==true ? 'active' :''}}"  data-cityid="{{city.id}}"   data-refid="{{city.refId}}" >{{city.cityName}}</li>
                                            {{/each}}
                                        </ul>
                                    </div>
                                    <div class="leisure">
                                        <h3>空闲时间</h3>
                                        <div class="details-calendar">
                                            <div class="box">
                                                <section class="date"    data-editable="true">
                                                    <div class="data-head">
                                                        <div class="prev mui-icon mui-icon-back"></div>
                                                        <div class="tomon"><span class="year"></span>年 <span class="month"></span>月</div>
                                                        <div class="next mui-icon mui-icon-forward"></div>
                                                    </div>
                                                    <ol>
                                                        <li>周日</li>
                                                        <li>周一</li>
                                                        <li>周二</li>
                                                        <li>周三</li>
                                                        <li>周四</li>
                                                        <li>周五</li>
                                                        <li>周六</li>
                                                    </ol>
                                                    <ul id="jobDate">

                                                    </ul>
                                                </section>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="filter_footer">
                                <div class="filter_main_footer">
                                    <button class="cancel_btn">取消</button>
                                    <button class="save_btn"  id="saveConfigBtn" data-url="/ijob/api/BeenrecruitedController/addIntention">保存设置</button>
                                </div>
                            </div>
                        </div>
                        {{/each}}
                    </script>
                </div>
            </div>
        </div>
        <%--关注--%>
        <div class="attention_content" style="display: none">
            <div id="panel">
            <script type="text/html" id="myfriendtemplate1" data-url="/ijob/api/PositionController/myAttentionPositionPage" data-type="POST">
                {{each list as posi}}
                <div class="pay_content_main">
                    <div class="attention_head" <%--onclick="ijob.gotoPage({url:'/ijob/api/InformationController/h5/mine/examineUserInfo/{{posi.userID}}'});"--%> >
                        <div class="media">
                            <div class="mediaImg"onclick="ijob.gotoPage({url:'/ijob/api/InformationController/h5/mine/examineUserInfo/'+ijob.location.get().lng+'/'+ijob.location.get().lat+'/{{posi.userID}}'});">
                                <img class="media-img" src="{{posi.weixin.headimgurl}}"  onerror="this.src='/ijob/static/images/me.jpg';this.onerror=null" >
                            </div>
                            <div class="attention-nick"onclick="ijob.gotoPage({url:'/ijob/api/InformationController/h5/mine/examineUserInfo/'+ijob.location.get().lng+'/'+ijob.location.get().lat+'/{{posi.userID}}'});">
                                <p> {{if posi.realName!= null && posi.realName!= ''}}{{posi.realName}}{{else}}{{posi.weixin.nickname}}{{/if}}</p>
                                <p class="attention-ellipsis">{{posi.publishTime | subTime}}前发布</p>
                            </div>
                            <div class="attention-gz" data-id="{{posi.userID}}" data-url="/ijob/api/AttentionController/update">
                                <%--<span>关注</span>--%>
                                {{if posi.attention}}
                                    <i class="iconfont icon-weibiaoti105"></i>
                                    <input id="type" type="hidden" value="delete">
                                {{else}}

                                    <div class="un-company-content-collection attentionButton {{posi.userID}}" data-id="{{posi.userID}}" >
                                        <input id="type" type="hidden" value="insert">
                                        <button class="btn">未关注</button>
                                    </div>
                                    {{/if}}
                                </div>
                            </div>
                        </div>
                        <div class="attention-msg">
                            <ul>
                                <li class="list-li">
                                    <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/qz/index/part_time_detail?data.position.id={{posi.id}}&shareObj.title={{posi.title}}&shareObj.salary={{posi.dailySalary}}&shareObj.date={{posi.recruitStartTime | dateFormat:'MM/dd'}}-{{posi.recruitEndTime | dateFormat:'MM/dd'}}&shareObj.city={{posi.workPlace.city.cityName}}'})">
                                        <div class="list-container">
                                            <div class="list-title">
                                                <span class="title-content">{{posi.title}}</span>
                                                <span class="titel-note"></span>
                                            </div>
                                            <div class="list-content">
                                                <div class="content-tit"  style='background-color:{{posi.huntingtype.codeGrade |getTypeColor}}!important;'>
                                                    {{posi.huntingtype | ifNull:'其他','name'}}
                                                </div>
                                                <div class="content-msg">
                                                    <div class="content-msg1">
                                                <span class="content-msg1-lf">
                                                    <i class="iconfont icon-shizhong"></i>
                                                     {{posi.recruitStartTime | dateFormat:'MM月dd日'}}-{{posi.recruitEndTime | dateFormat:'MM月dd日'}}
                                                </span>
                                                        <span class="content-msg1-rt">{{posi.dailySalary}}元/天</span>
                                                    </div>
                                                    <div class="content-msg2">
                                                        <span class="content-msg2-lf">{{if posi.sexRequirements == '' || posi.sexRequirements == null}}男女不限{{/if}}{{posi.sexRequirements  | enums:'SexRequirements'}}&nbsp;<span class="line"></span>&nbsp;{{posi.beenRecruitedSum | ifNull:'0'}}/{{posi.recruitsSum | ifNull:'0'}}人</span>
                                                        <span class="content-msg2-rt">{{posi.settlement | enums:'SettlementType'}}</span>
                                                    </div>
                                                    <div class="content-msg3">
                                                        <span class="content-msg3-lf">{{posi.workPlace | ifNull:'未知','city.cityName'}}&nbsp; {{posi.workPlace.distance | distance }}</span>
                                                        <span class="content-msg3-rt">{{posi.publish | ifNull : '无工作号','workNumber'}}</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                    <%--<div class="list-share">
                                        <div class="title envelopes">喊上同学做兼职即可获得红包</div>&lt;%&ndash;envelopes有红包显示，没有显示内容为“喊上同学一起做兼职”&ndash;%&gt;
                                        <div class="btns"><a href="javascript:void(0);" class="share" ><span class="iconfont icon-fenxiang"></span>&nbsp;分享</a></div>
                                    </div>--%>
                                </li>
                            </ul>
                        </div>
                    </div>
                    {{/each}}
                </script>
                </div>
            </div>

        <%--分享--%>
        <div class="share-content">
            <div class="popup-backdrop">
                <div class="descript"><span class="rotate"><span class="iconfont icon-dianji1"></span></span>点击进行分享</div>
                <div class="arrowhead">
                    <img src="/ijob/static/images/arrowhead.png"/>
                </div>
            </div>
        </div>
        <%--<div class="share_content" style="display: none;">--%>
            <%--<div class="mainpopup">--%>
                <%--<ul>--%>
                    <%--<li>--%>
                        <%--<a href="javascript:void(0);">--%>
                            <%--<span class="iconfont icon-weixinhaoyou"></span>--%>
                            <%--<span class="name">微信好友</span>--%>
                        <%--</a>--%>
                    <%--</li>--%>
                    <%--<li>--%>
                        <%--<a href="javascript:void(0);">--%>
                            <%--&lt;%&ndash;<span class="iconfont icon-pengyouquan"></span>&ndash;%&gt;--%>
                            <%--<div class="circle">--%>
                                <%--<img src="/ijob/static/images/Circle.png"/>--%>
                            <%--</div>--%>
                            <%--<span class="name">朋友圈</span>--%>
                        <%--</a>--%>
                    <%--</li>--%>
                <%--</ul>--%>
                <%--<div class="cancel">--%>
                    <%--<a href="javascript:void(0);">取消</a>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
    </div>
    <%--开启红包--%>
    <%--<div class="red_packet_box">
        <div class="content">
            <div class="person">
                <div class="close_btn"><span class="iconfont icon-guanbi"></span></div>
                <div class="informBox">
                    <div class="portrait">
                        <div class="photo">
                            <img src="/ijob/static/images/default.jpg"/>
                        </div>
                        <p>Amin的红包</p>
                    </div>
                    <div class="name">
                        <p class="pro_name">公司真心诚聘传单派发学生可兼职</p>
                        <p class="type">分享奖励</p>
                    </div>
                </div>
                <div class="open"><img src="/ijob/static/images/open.png"/></div>
            </div>
        </div>
    </div>--%>
</div>
</body>

<script src="/ijob/static/js/index/part-time.js"></script>
<script src="/ijob/static/js/index/index.js"></script>
<script>


    var localtion ,menu=ijob.persistence.get("menu");

    (function () {

        var slide = null;

        $(".head-li").click(function () {
            if($(this).text() == "全部"){
                menu = "findJob:0"
            }else{
                menu = "findJob:1"
            }
            ijob.persistence.set("menu",menu);
            var nub = $(this).index();
            $(this).addClass("active").siblings('.head-li').removeClass("active");
            $(".main>div").eq(nub).show().siblings().hide();
        });
        // 拆开红包
        $(".red_packet_box .open").on("click",function(){
            $(".red_packet_box .open").addClass("animation");
        });

       /* window.addEventListener('pageshow', function(e) {
            // 通过persisted属性判断是否存在 BF Cache
            if (e.persisted) {
                location.reload();
            }
        });*/

        localtion  =  ijob.location.get();
        var positionparam ;


        document.getElementById("prompt").innerHTML =  (localtion.city||'失联中')+"<i class=\"mui-icon mui-icon-arrowdown\">";

        positionparam  = {condition:{type:0,open:2,isDeleted:false,lng:localtion.lng,lat:localtion.lat,radius:10,cityID:localtion.cityID}};
        //默认附件不限  按距离排序，十公里范围
        positionparam.condition.orderby = "createTime";
        function loadAttention(){
           /* $("#myfriendtemplate1").loadData({condition:{type:0,open:2,isDeleted:false,lng:localtion.lng,lat:localtion.lat,radius:10}}).then(function(result){
                $(".contentBox").remove();
                $(".attention_content>span").remove();
                if( result.data.list.length == 0){
                    $('#panel').before("<div class=\"contentBox\" style='margin-top:0px!important; '><p style='text-align: center;margin-top: 1px;padding: 0.5rem;background: #fff;'>您还没有关注任何人</p></div><span style='padding: 0.3rem 0.5rem;padding-bottom: 0;font-size: 0.34rem;display: block;'>您可能感兴趣的</span>");
                    $("#myfriendtemplate1").loadData({condition:{Recommend:'Recommend',type:0,open:2,isDeleted:false,lng:localtion.lng,lat:localtion.lat,radius:10}}).then(function(result){
                        $(".attentionButton").on("click",function(e){
                            e.stopPropagation();
                            var userID = $(this).data("id");
                            changeAttentionState(userID,this,loadAttention);

                        });
                    });
                }
            });*/




            var param = {condition:{type:0,open:2,isDeleted:false,lng:localtion.lng,lat:localtion.lat,radius:10}};
            var page  = {"pageSize": "10", "currentPage": "1"};
            var isRecommend = false;
            //关注界面
            function loadHandler(){
                page  = {"pageSize": "10", "currentPage": "1"};
                var ijobRefresh = new IJobRefresh({
                    container: '#panel',
                    up: function() {
                        var obj = $.extend(page,param);
                        $("#myfriendtemplate1").appendData(obj,ijobRefresh).then(function(result){
                            // 分享
                            $(".share").click(function(){

                                $(".share-content").show();
                                slide = new Slide($(".wrap"),$(".share-content"),".popup-backdrop");
                                slide.disTouch();
                            });
                            /*$(".share_content .cancel a").click(function(){
                                $(".share_content").hide();
                                slide.ableTouch();
                            });*/
                            // 点击空白处隐藏选项
                            $("body>*").on('click', function (e) {
                                if ($(e.target).hasClass('share-content')) {
                                    $(".share-content").hide();
                                    slide.ableTouch();
                                }
                            });
                            page.currentPage =  result.nextPage;
                            if(result.totalPage==0 && isRecommend==false){
                                isRecommend = true;
                                $('#panel').before("<div class=\"contentBox\" style='margin-top:0px!important; '><p style='text-align: center;margin-top: 1px;padding: 0.5rem;background: #fff;'>您还没有关注任何人或者关注的人没有发布职位</p></div><span style='padding: 0.3rem 0.5rem;padding-bottom: 0;font-size: 0.34rem;display: block;'>您可能感兴趣的</span>");
                                param = {condition:{Recommend:'Recommend',type:0,open:2,isDeleted:false,lng:localtion.lng,lat:localtion.lat,radius:10}};
                                loadHandler();
                            }

                            $(".attention-gz").click(function(){
                                var userID = $(this).data("id");
                                var _this = this;
                                if($("#type").val() == "delete"){
                                    var btnArray = ['否', '是'];
                                    mui.confirm('确认取消关注？', '', btnArray, function (e) {
                                        if (e.index == 1) {
                                            var params = {
                                                "userID": userID,
                                            };
                                            $(_this).btPost(params, function (data) {
                                                param = {condition:{Recommend:'Recommend',type:0,open:2,isDeleted:false,lng:localtion.lng,lat:localtion.lat,radius:10}};
                                                loadAttention();
                                            });
                                        }
                                    });
                                }else{
                                    var params = {
                                        "userID": userID,
                                    };
                                    $(this).btPost(params, function (data) {
                                        param = {condition:{type:0,open:2,isDeleted:false,lng:localtion.lng,lat:localtion.lat,radius:10}};
                                        $("#panel").prevAll().remove();
                                        loadAttention();
                                    });
                                }
                            });

                        });
                    }
                });
            }
            loadHandler();

        }

        var loadtimes = setTimeout(function(){
            clearTimeout(loadtimes);
            loadAttention();
        },100);

        $("#prompt").click(function(){
            var btn = ['取消', '切换'];
            var localtion  =  ijob.location.get();
            var info = '定位为'+localtion.city+'，是否切换？';
            mui.confirm( info, '提示', btn, function (e) {
                if (e.index == 0) {

                } else {
                    ijob.gotoPage({path:"/h5/qz/index/select_area"});
                }
            })
        });

        var flag  = true;
        // var positionparam  = {condition:{type:0,open:2,isDeleted:false,lng:localtion.lng,lat:localtion.lat,radius:10}};
        function loadPosition(){
            var page  = {"pageSize": "10", "currentPage": "1"};
            var ijobRefresh = new IJobRefresh({
                container: '.list-ul',
                up: function() {
                    var obj = $.extend(page,positionparam);
                    $("#jobtemplate").appendData(obj,ijobRefresh).then(function(result){
                        // 分享
                        $(".share").click(function(){

                            $(".share-content").show();
                            slide = new Slide($(".wrap"),$(".share-content"),".popup-backdrop");
                            slide.disTouch();
                        });
                        /*$(".share_content .cancel a").click(function(){
                            $(".share_content").hide();
                            slide.ableTouch();
                        });*/
                        // 点击空白处隐藏选项
                        $("body>*").on('click', function (e) {
                            if ($(e.target).hasClass('share-content')) {
                                $(".share-content").hide();
                                slide.ableTouch();
                            }
                        });
                        page.currentPage =  result.nextPage;
                        $(window).scroll(function() {
                            var win_top = $(this).scrollTop();
                            var tagArr=$('.nav-content');
                            var flag = $(tagArr[0]).css("display") == 'none' ? true : false;
                            if(flag){
                                flag = $(tagArr[1]).css("display") == 'none' ? true : false;
                            }
                            if(flag){
                                flag = $(tagArr[2]).css("display") == 'none' ? true : false;
                            }
                            if(flag){
                                flag = $(tagArr[3]).css("display") == 'none' ? true : false;
                            }
                            var topHeight = $('.banner').outerHeight()+$('.head-fixe').outerHeight();
                            if (win_top >= topHeight) {
                                $(".select_nav").addClass("sfixed");
                            }else if (win_top < topHeight && flag) {
                                $(".select_nav").removeClass("sfixed");
                            }
                        });

                        if(flag){
                            flag = false;
                            initIntention();
                        }
                    });
                }
            });
            $(".nav-content").click();

        }
        function initIntention(){

            $("#orderType li").on('click',function(){
                if ($(this).text() == "发布时间") {
                    positionparam.condition.orderby = "createTime";
                } else if ($(this).text() == "人气优先") {
                    positionparam.condition.orderby = "hot";
                } else if ($(this).text() == "距离优先") {
                    positionparam.condition.orderby = "distance";
                } else if ($(this).text() == "价格优先") {
                    positionparam.condition.orderby = "dailySalary";
                }
                selected($(this));
                loadPosition();
                $("#all-sort a").text($(this).text());
                showActive(2);
            });


            $("#typetemplate").loadData().then(function(result){
                $("#publishType li").on('click', function () {
                    positionparam.condition.workTypeID  = $(this).data("id").toString().trim();
                    loadPosition();
                    $("#release a").text($(this).text());
                    showActive(1);
                });
            });

            /**
             * 获得性别要求
             */
            var sex = null, settlementType = null;
            $(".filter-gender-msg > li").click(function(){
                var arr = $(".filter-gender-msg > li");
                for (var i = 0 ; i < arr.length ; i++){
                    if(arr[i] != this){
                        $(arr[i]).removeClass("aaa");
                        $(arr[i]).css("border-color","");
                        $(arr[i]).css("color","");
                    }
                }
                if(!$(this).hasClass("aaa")){
                    $(this).addClass("aaa")
                    $(this).css("border-color","#0d9bf2");
                    $(this).css("color","#0d9bf2");
                    sex = $(this).data("id");
                }else{
                    $(this).removeClass("aaa");
                    $(this).css("border-color","");
                    $(this).css("color","");
                    sex = null ;
                }
            });


            /**
             * 获得结算方式
             */
            $(".filter-js-msg > li").click(function(){
                var arr = $(".filter-js-msg > li");
                for (var i = 0 ; i < arr.length ; i++){
                    if(arr[i] != this){
                        $(arr[i]).removeClass("aaa");
                        $(arr[i]).css("border-color","");
                        $(arr[i]).css("color","");
                    }
                }
                if(!$(this).hasClass("aaa")){
                    $(this).addClass("aaa")
                    $(this).css("border-color","#0d9bf2");
                    $(this).css("color","#0d9bf2");
                    settlementType = $(this).data("id");
                }else{
                    $(this).removeClass("aaa");
                    $(this).css("border-color","");
                    $(this).css("color","");
                    settlementType = null ;
                }
            });


            //点击查询方法
            $("#filterBtn").on('click', function () {
                var start = $("#salary .text_start:first").val();
                var end = $("#salary .text_end:first").val();
                if (ijob.isNotNull(start) && ijob.isNotNull(end)) {
                    positionparam.condition.salaryOpen = start;
                    positionparam.condition.salaryClose = end;
                }
                positionparam.condition.settlement=settlementType;
                positionparam.condition.sexRequirements= sex;
                loadPosition();
                showActive(3);
                $(".nav-content").click();
            });


            //点击重置
            $("#resetBtn").on("click", function () {
                $(".text_start,.text_end").val("");
                $("[data-id]").attr("id", "");
                $(".mui-active").removeClass("mui-active");
                sex = null;
                settlementType = null;
                var arr = $(".filter-gender-msg > li");
                for (var i = 0 ; i < arr.length ; i++){
                    $(arr[i]).removeClass("aaa");
                    $(arr[i]).css("border-color","");
                    $(arr[i]).css("color","");
                }
                arr = $(".filter-js-msg > li");
                for (var i = 0 ; i < arr.length ; i++){
                    $(arr[i]).removeClass("aaa");
                    $(arr[i]).css("border-color","");
                    $(arr[i]).css("color","");
                }
                positionparam.condition.settlement=null;
                positionparam.condition.sexRequirements= null;
                positionparam.condition.salaryOpen = null;
                positionparam.condition.salaryClose = null;
            });



            $("#myIntention").loadData().then(function(result){
                $(".fix-block-r").show();
                var resultIntentionDate  = result.data.list[0].intentionDate;
                if(!resultIntentionDate){
                    resultIntentionDate = {myDate:"{}"};
                }
                var datetime = resultIntentionDate.myDate;
                var userID =  result.data.list[0].userID;


                var now  = new Date();
                var  year = now.getFullYear()+1900;
                var  month = now.getMonth()+1;
                $("#tomon").find(".year").text(year);
                $("#tomon").find(".month").text(month);

                //初始化我的意向里面的时间
                var arr = ijob.getDateList(datetime);
                $('.date').on('completionEvent', function() {
                    $(".date").selectDate(arr);
                });

                $(".date").on('dateClickEvent',function(event,state,dr){
                    if(state){
                        arr.push(dr);
                    }else{
                        arr.splice($.inArray(dr,arr),1);
                    }
                });

                dateRenderInit();

                $("#jobType").showSelect();
                //优化地区选框
                $("#jobCity").showSelect();

                //保存按钮
                $("#saveConfigBtn").click(function(){
                    var obj = {
                        intentionaddresses:[],
                        intentiontypes:[],
                        intentiondate:{id:resultIntentionDate.id,version:resultIntentionDate.version,userID:userID,myDate:null}
                    };
                    $("#jobType li").each(function(i,item){
                        if($(this).hasClass("active")){
                            obj.intentiontypes.push({userID:userID,id:$(this).data("refid"),"htID":$(this).data("htid")});
                        }
                    });
                    $("#jobCity li").each(function(i,item){
                        if($(this).hasClass("active")){
                            obj.intentionaddresses.push({userID:userID,id:$(this).data("refid"),cityID:$(this).data("cityid")});
                        }
                    });
                    obj.intentiondate.myDate=JSON.stringify(ijob.getStrFromList(arr));
                    $("#saveConfigBtn").btPost(obj,function(data){
                        mui.toast("保存成功");
                        $(".cancel_btn").click();
                    });
                });
            });
        }

        $(".all").one("click",function(){
            loadPosition();
        });


        var html ="";
        var pointtype = "";
        var metroHtml = "";
        $("#gradew").on('click','li',function(e){

            $("#gradets").empty();
            selected($(this));
            $(this).parent().css("width","33.3%");
            pointtype = $(this).text();
            if($(this).text()=='附近'){
                // loadPosition();
                $("#gradet2").html("<li  data-dist=\"10\">不限</li>\n" +
                    "                                <li  data-dist=\"1\">1000m内</li>\n" +
                    "                                <li  data-dist=\"3\">3000m内</li>\n" +
                    "                                <li  data-dist=\"5\">5000m内</li>");
                //selected($("#gradet2 li:first"));
            }else if($(this).text()=="区域"){
                $("#gradet2").html("");
                var dist = $(this).data("dist");
                if(html){
                    $("#gradet2").html(html);
                }else{
                    $.getJSON("/ijob/api/CityController/getMyCityRegion/"+localtion.cityID,null,function(result){
                        var list = result.data.list;
                        for(var index in list){
                            html += "<li data-id='"+list[index].id+"'>"+list[index].cityName+"</li>";
                        }
                        $("#gradet2").html(html);
                    });
                }
                selectPanel($("#gradet2"));
            }else if($(this).text()=="地铁"){
                $("#gradet2").html("");
                if(metroHtml){
                    $("#gradet2").html(metroHtml);
                }else{
                    $.getJSON("/ijob/api/MetroController/getMyCityMetro/"+localtion.cityID,null,function(result){
                        var list = result.data.list;
                        for(var index in list){
                            metroHtml += "<li data-id='"+list[index].id+"'>"+list[index].name+"</li>";
                        }
                        $("#gradet2").html(metroHtml);
                    });
                }
                selectPanel($("#gradets"));
            }
            e.stopPropagation();
        });

        $("#gradet2").on('click','li',function(e){


            $("#gradets").empty();
            selected($(this));
            $(this).parent().css("width","33.3%");

            $("#point").text($(this).text());
            if( pointtype=="附近"){
                positionparam.condition.orderby = "distance";
                positionparam.condition.radius  = $(this).data("dist") ;
                positionparam.condition.cityID = localtion.cityID;
                positionparam.condition.lng=localtion.lng;
                positionparam.condition.lat=localtion.lat;
                loadPosition();
                showActive( 0);
            }else if( pointtype=="区域"){
                positionparam.condition.orderby = "hot";
                positionparam.condition.radius  = 100;
                positionparam.condition.cityID = $(this).data("id");
                positionparam.condition.lng=localtion.lng;
                positionparam.condition.lat=localtion.lat;
                loadPosition();
                showActive(0);
            }else if(pointtype="地铁"){
                $(this).parent().next().css("left","66.6%");
                $("#gradets").html("");
                var stationHtml = "";
                $.getJSON("/ijob/api/MetroController/getMyCityStation/"+$(this).data("id"),null,function(result){
                    var list = result.data.list;
                    for(var index in list){
                        stationHtml += "<li data-lat='"+list[index].lat+"' data-lng='"+list[index].lng+"'  data-id='"+list[index].id+"'>"+list[index].name+"</li>";
                    }
                    $("#gradets").html(stationHtml);
                });
                e.stopPropagation();
            }


        });

        $("#gradets").on('click','li',function(e){
            $("#point").text($(this).text().substring(0,Math.min(3,$(this).text().length)));
            selected($(this));
            positionparam.condition.orderby = "distance";
            positionparam.condition.lng=$(this).data("lng");
            positionparam.condition.lat=$(this).data("lat");
            positionparam.condition.radius  = 2;
            positionparam.condition.cityID = null;
            loadPosition();
            showActive(0);
        });

        $("#filterPanel li").not(":last").on('click',function(e){
            e.stopPropagation();
        });


        function selected(_this){
            _this.siblings().each(function(i,item){
                $(this).css("background","");
                $(this).css("color","");
            });

            _this.css("background","#f2f5f7");
            _this.css("color","#108ee9");
        }

        function  showActive(index){
            $(".nav-box>a").each(function(i,item){
                $(this).removeClass("active");
                if(index==i){
                    $(this).addClass("active");
                }
            });
        }
    })();

    //获得slider插件对象
    var gallery = mui('.mui-slider');
    gallery.slider({
        interval:3000//自动轮播周期，若为0则不自动播放，默认为0；
    });

    if(menu && menu.indexOf(":")!=-1){
        $(".head-li").eq(menu.split(":")[1]).click();
    }else{
        $(".head-li").eq(0).click();
    }



</script>

</html>
