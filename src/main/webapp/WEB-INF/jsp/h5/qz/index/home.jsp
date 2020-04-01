<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/11
  Time: 10:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<html>
<head>

        <link rel="stylesheet" href="/ijob/static/css/index/index.css?version=4">
</head>
<body>
<div class="wrap">
    <!--搜索框-->
    <header class="head">
        <div class="head-fixe">
            <div class="positioning" id="prompt"></div>
            <div class="tab_head">
                <ul>
                    <li data-index="0" class="head-li part-time active"><a href='javascript:void(0);'>兼职</a></li>
<%--                    <li data-index="1" class="head-li news"><a href='javascript:void(0);'>全职</a></li>--%>
                    <li data-index="2" class="head-li all"><a href='javascript:void(0);'>关注</a></li>
                </ul>
            </div>
            <div class="mui-input-row mui-search head-find">
                <a href="/ijob/api/SearchlogController">
                    <%--<input type="search" placeholder="职位/工作号">--%>
                    <i class="iconfont icon-sousuo h-sousuo"></i>
                    <%--<span>搜索</span>--%>
                </a>
                <a href="javascript:void(0);">
                    <i class="iconfont icon-saoyisao"></i>
                </a>
            </div>
        </div>
    </header>

    <div class="main">
        <%--兼职--%>
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
                        <div class="mui-slider-item ban-slider"><a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/qz/mine/partnerPlan'})"><img src="/ijob/static/images/partnerbanner.png"/></a></div>
                        <div class="mui-slider-item ban-slider"><a href="https://c.eqxiu.com/s/3gyhROfb"><img src="/ijob/static/images/bannner.png"/></a></div>
                        <%--<div class="mui-slider-item ban-slider"><a href="javascript:void(0);"><img src="/ijob/static/images/banner03.jpg"/></a></div>--%>

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
            <!--选取-->
            <div class="select_nav">
                <ul class="nav">
                    <li class="nav-li li_1">
                        <div class="nav-box" id="place">
                            <a data-value="地点"  id="point" class="place nav-select" href="javascript:void(0);">地点</a>
                            <i class="iconfont icon-arrow-down1"></i>
                        </div>
                        <div class="mui-backdrop nav-content" >
                            <ul class="nav-selected" id="workType2">
                                <li data-value="430103">天心区</li>
                                <li data-value="430102">芙蓉区</li>
                                <li data-value="430111">雨花区</li>
                                <li data-value="430105">开福区</li>
                                <li data-value="430104">岳麓区</li>
                                <li data-value="430112">望城区</li>
                                <li data-value="430121">长沙县</li>
                                <li data-value="430124">宁乡县</li>
                                <li data-value="430181">浏阳市</li>
                            </ul>
                            <%--<div class="nav-selected grade-eject" id="workType2">
                                <ul class="grade-w" id="gradew" style="width: 33.3%;">
                                    <li style="background: rgb(242, 245, 247); color: rgb(16, 142, 233);" id="fujin" >附近</li>
                                    <li >区域</li>
                                    <li >地铁</li>
                                </ul>
                                <ul class="grade-t" id="gradet2" style="left: 33.33%;">

                                </ul>
                                <ul class="grade-s" id="gradets">

                                </ul>
                            </div>--%>
                        </div>
                    </li>
                    <li class="nav-li line"></li>
                    <li class=" nav-li li_2">
                        <div class="nav-box" id="release">
                            <a data-value="类型" class="release nav-select" href="javascript:void(0);">类型</a>
                            <i class="iconfont icon-arrow-down1"></i>
                        </div>
                        <div class="mui-backdrop nav-content">
                            <ul class="nav-selected" id="publishType">
                                <script  type="text/html" id="typetemplate"  data-res="cache"  data-url="/ijob/api/HuntingtypeController/findAllType">
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
                                <li data-value="最新发布">最新发布</li>
                                <li data-value="薪资从高到低">薪资从高到低</li>
                                <%--<li data-value="价格优先">价格优先</li>
                                <li data-value="发布时间">发布时间</li>
                                <li data-value="人气优先">人气优先</li>
                                <li data-value="距离优先">距离优先</li>--%>
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
                               <%-- <li class="filter-price">
                                    <div class="mui-input-row mui-input-range">
                                        <h1 class="pri-title">价格</h1>
                                        <div class="scale" id="salary">
                                            <input type="number" placeholder="开始价格" class="text_start"><span>元</span>
                                            <em>——</em>
                                            <input type="number" placeholder="结束价格" class="text_end"><span>元</span>
                                        </div>
                                    </div>
                                </li>--%>
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
                                <%--<li class="filter-claim">
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
                                </li>--%>
                                <li class="filter-btn">
                                    <span id="resetBtn">重置</span>
                                    <span id="filterBtn">确定筛选</span>
                                </li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="list" >
                <ul class="list-ul">
                    <script  type="text/html" id="jobtemplate"  data-res="cache" data-url="/ijob/api/PositionController/myPositionPage">
                        {{each list as posi}}
                        <li class="list-li">
                            <a href="javascript:void(0);" id="{{posi.id}}1" onclick="remarkAnchors();ijob.gotoPage({path:'/h5/qz/index/part_time_detail?data.position.id={{posi.id}}&shareObj.title={{posi.title}}&shareObj.salary={{posi.dailySalary}}&shareObj.date={{posi.recruitStartTime | dateFormat:'MM/dd'}}-{{posi.recruitEndTime | dateFormat:'MM/dd'}}&shareObj.city={{posi.cityName}}'})">
                                <div class="list-container">
                                    <div class="list-title">
                                        <span class="title-content">{{posi.title}}</span>
                                        <span class="titel-note"></span>
                                    </div>
                                    <div class="list-content">
                                        <div class="content-tit" style='background-color:{{posi.codeGrade |getTypeColor}}!important;'>
                                            {{posi.name | ifNull:'其他'}}
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
                                                <span class="content-msg2-lf">{{if posi.sexRequirements == '' || posi.sexRequirements == null}}男女不限{{/if}}{{posi.sexRequirements  | enums:'SexRequirements'}}&nbsp;<span class="line"></span>&nbsp;{{posi.personNumDay | ifNull:'0'}}人/天</span>
                                                <span class="content-msg2-rt">{{posi.settlement | enums:'SettlementType'}}</span>
                                            </div>
                                            <div class="content-msg3">
                                                <span class="content-msg3-lf">{{posi.cityName | ifNull:'未知'}}&nbsp; {{posi.distance | distance }}</span>
                                                <span class="content-msg3-rt">{{posi.workNumber | ifNull : '无工作号'}}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </a>
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
        <%--全职--%>
        <div class="full_time_content" style="display: none">
            <!--轮播图-->
            <div class="banner">
                <div class="mui-slider">
                    <div class="mui-slider-group mui-slider-loop">
                        <!--支持循环，需要重复图片节点-->
                        <div class="mui-slider-item mui-slider-item-duplicate"><a href="javascript:void(0);"><img
                                src="/ijob/static/images/banner1.png"/></a>
                        </div>
                        <div class="mui-slider-item ban-slider"><a href="javascript:void(0);"><img src="/ijob/static/images/banner1.png"/></a></div>
                        <div class="mui-slider-item ban-slider"><a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/qz/mine/partnerPlan'})"><img src="/ijob/static/images/partnerbanner.png"/></a></div>
                        <div class="mui-slider-item ban-slider"><a href="https://c.eqxiu.com/s/3gyhROfb"><img src="/ijob/static/images/bannner.png"/></a></div>
                        <%--<div class="mui-slider-item ban-slider"><a href="javascript:void(0);"><img src="/ijob/static/images/banner03.jpg"/></a></div>--%>

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

            <%--筛选--%>
            <div class="screen-box-list" style="">
                <div class="nav-filter">
                    <ul>
                        <li class="nav-li nav_li_1">
                            <div class="a_filter">
                                <a href="javascript:void(0);" data-value="区域">
                                    <span  id="region" class="txt">区域</span><span class="iconfont icon-arrow-down1"></span>
                                </a>
                            </div>
                            <div class="filter-list mui-backdrop" style="display: none;">
                                <div class="main-list-box" id="regiondiv">
                                    <ul>
                                        <script id="fullJobCityList"  data-res="cache"  type="text/html" data-url="/ijob/api/CityController/findList">
                                            {{each list as city}}
                                                <li data-value="{{city.id}}">{{city.cityName}}</li>
                                            {{/each}}
                                        </script>
                                    </ul>
                                </div>
                            </div>
                        </li>
                        <li class="nav-li nav_li_2">
                            <div class="a_filter" id="quarters">
                                <a href="javascript:void(0);" data-value="岗位"  class="quarters">
                                   <span class="txt" id="post"> 岗位</span><span class="iconfont icon-arrow-down1"></span>
                                </a>
                            </div>
                            <div class="filter-list mui-backdrop" style="display: none">
                                <div class="main-list-box" id="publishPostdiv">
                                    <ul>
                                        <script id="fullJobTypeList"  data-res="cache"  type="text/html" data-url="/ijob/api/FullTimeController/getPostType">
                                            {{each list as type}}
                                                <li data-value="{{type.value}}">{{type.name}}</li>
                                            {{/each}}
                                        </script>
                                    </ul>
                                </div>
                            </div>
                        </li>
                        <li class="nav-li nav_li_3">
                            <div class="a_filter">
                                <a href="javascript:void(0);" data-value="排序"  >
                                    <span class="txt" id="sort">排序</span><span class="iconfont icon-arrow-down1"></span>
                                </a>
                            </div>
                            <div class="filter-list mui-backdrop" style="display: none">
                                <div class="main-list-box" id="sortdiv">
                                    <ul>
                                        <li data-value="1">最新发布</li>
                                        <li data-value="2">薪资从高到低</li>
                                    </ul>
                                </div>
                            </div>
                        </li>
                        <li class="nav-li nav_li_4">
                            <div class="a_filter">
                                <a href="javascript:void(0);" data-value="薪资" >
                                    <span class="txt" id="wages">薪资</span><span class="iconfont icon-arrow-down1"></span>
                                </a>
                            </div>
                            <div class="filter-list mui-backdrop" style="display: none">
                                <div class="main-list-box" id="wagesdiv">
                                    <ul>
                                        <li data-value="1">3000元以下</li>
                                        <li data-value="2">3000-5000元</li>
                                        <li data-value="3">5000-7000元</li>
                                        <li data-value="4">7000-9000元</li>
                                        <li data-value="5">9000元以上</li>
                                    </ul>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            <%--筛选end--%>

            <div class="full-list-box">
                <ul class="allFullList">
                    <script id="fullJobList"   data-res="cache"  type="text/html" data-url="/ijob/api/FullTimeController/getFullJobList">
                        {{each list as post}}
                            <li onclick="remarkAnchors();ijob.gotoPage({path:'/h5/qz/myjob/full_time_detail?full.id={{post.id}}'})">
                                <div class="title">
                                    <span class="txt">{{post.title}}</span>
                                    {{if post.minSalary == post.maxSalary&&post.maxSalary==0}}
                                        <span class="price">面议</span>
                                    {{else}}
                                        <span class="price">{{post.minSalary}}-{{post.maxSalary}}元/月</span>
                                    {{/if}}
                                </div>
                                <div class="name-area">
                                    <div class="name"><span>{{post.company.company}}</span>·<span>{{post.workPlace.city.cityName}}</span></div>
                                </div>
                                <div class="label-box">
                                    {{if post.benefitsLabel!=null&&post.benefitsLabel!=""}}
                                    <div class="welfaretag taglist">
                                        <span>福利</span>
                                        {{#post.benefitsLabel |toLabel}}
                                    </div>
                                    {{else}}
                                    {{#post.benefitsLabel |toLabel}}
                                    {{/if}}
                                    <div class="requiretag taglist">
                                        <span>工作</span>
                                        <span>{{post.minAge}}-{{post.maxAge}}岁</span>
                                        {{#post.workLabel |toLabel}}
                                    </div>
                                </div>
                            </li>
                        {{/each}}
                    </script>
                </ul>
            </div>
        </div>
        <%--关注--%>
        <div class="attention_content" style="display: block">
            <div id="panel">
                <script type="text/html"   data-res="cache"  id="myfriendtemplate1" data-url="/ijob/api/PositionController/myAttentionPositionPage" data-type="POST">
                    {{each list as posi index}}
                    <div class="pay_content_main">
                        <div class="attention_head" <%--onclick="ijob.gotoPage({url:'/ijob/api/InformationController/h5/mine/examineUserInfo/{{posi.userID}}'});"--%> >
                            <div class="media">
                                <div class="mediaImg"onclick="ijob.gotoPage({url:'/ijob/api/InformationController/h5/mine/examineUserInfo/'+ijob.location.get().lng+'/'+ijob.location.get().lat+'/{{posi.weixin.userID}}'});">
                                    <img class="media-img" src="{{posi.weixin.headimgurl}}"  onerror="this.src='/ijob/static/images/me.jpg';this.onerror=null" >
                                </div>
                                <div class="attention-nick"onclick="ijob.gotoPage({url:'/ijob/api/InformationController/h5/mine/examineUserInfo/'+ijob.location.get().lng+'/'+ijob.location.get().lat+'/{{posi.weixin.userID}}'});">
                                    <p> {{posi.weixin.nickname}}</p>
                                    <p class="attention-ellipsis">{{posi.publishTime | subTime}}前发布</p>
                                </div>
                                <div class="attention-gz" data-id="{{posi.weixin.userID}}" data-url="/ijob/api/AttentionController/update">
                                    {{if posi.attention}}
                                    <i class="iconfont icon-weibiaoti105"></i>
                                    <input id="type" type="hidden" value="delete">
                                    {{else}}
                                    <div class="un-company-content-collection attentionButton {{posi.weixin.userID}}" data-id="{{posi.weixin.userID}}" >
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
                                    {{if posi.userID == posi.weixin.userID}}
                                    <a href="javascript:void(0);" onclick="remarkAnchors();ijob.gotoPage({path:'/h5/qz/index/part_time_detail?data.position.id={{posi.id}}&shareObj.title={{posi.title}}&shareObj.salary={{posi.dailySalary}}&shareObj.date={{posi.recruitStartTime | dateFormat:'MM/dd'}}-{{posi.recruitEndTime | dateFormat:'MM/dd'}}&shareObj.city={{posi.workPlace.city.cityName}}'})">
                                    {{else}}
                                    <a href="javascript:void(0);" onclick="remarkAnchors();ijob.gotoPage({path:'/h5/qz/index/part_time_detail?data.forwardUser={{posi.weixin.userID}}&data.position.id={{posi.id}}&shareObj.title={{posi.title}}&shareObj.salary={{posi.dailySalary}}&shareObj.date={{posi.recruitStartTime | dateFormat:'MM/dd'}}-{{posi.recruitEndTime | dateFormat:'MM/dd'}}&shareObj.city={{posi.workPlace.city.cityName}}'})">
                                    {{/if}}
                                        <div class="list-container">
                                            <div class="list-title">
                                                <span class="title-content">
                                                    {{if posi.userID != posi.weixin.userID}}
                                                        <span class="forwardName">转</span>
                                                    {{/if}}
                                                    <span class="positit">{{posi.title}}</span>
                                                </span>
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
                                                        <span class="content-msg2-lf">{{if posi.sexRequirements == '' || posi.sexRequirements == null}}男女不限{{/if}}{{posi.sexRequirements  | enums:'SexRequirements'}}&nbsp;<span class="line"></span>&nbsp;{{posi.recruitsSum | ifNull:'0'}}人天</span>
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
                                </a>
                                <div class="list-share">
                                    <form id="{{posi.id}}" style="display: none;">
                                        <input type="hidden" name="title" value="{{posi.title}}">
                                        {{if posi.forwardID != null}}
                                        <input type="hidden" name="id" value="{{posi.forwardID}}-">
                                        {{else}}
                                        <input type="hidden" name="id" value="{{posi.id}}">
                                        {{/if}}
                                        <input type="hidden" name="salary" value="{{posi.dailySalary}}">
                                        <input type="hidden" name="date" value="{{posi.recruitStartTime | dateFormat:'MM/dd'}}-{{posi.recruitEndTime | dateFormat:'MM/dd'}}">
                                        <input type="hidden" name="city" value="{{posi.workPlace.city.cityName}}">
                                        <input type="hidden" name="shareUser" value="<shiro:principal property="id"/>">
                                        <input type="hidden" name="codeGrade" value="{{posi.huntingtype.codeGrade}}">
                                    </form>
                                    {{if posi.hasRedPacketForward != null||posi.hasRedPacket != null}}
                                    <div class="title envelopes">分享职位和同学一起瓜分红包</div><%--envelopes有红包显示，没有显示内容为“喊上同学一起做兼职”--%>
                                    {{else}}
                                    <div class="title envelopes" style="color: #999;">喊上同学一起做兼职</div><%--envelopes有红包显示，没有显示内容为“喊上同学一起做兼职”--%>
                                    {{/if}}
                                    <div class="btns"><a href="javascript:void(0);" class="share" data-index="{{posi.id}}" ><span class="iconfont icon-fenxiang"></span>&nbsp;分享</a></div>
                                </div>
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
                <%--<div class="posi">
                    <p>好友通过你的分享做此兼职</p>
                    <p>你可以获得<span>1元/小时</span>的提成</p>
                </div>--%>
            </div>
        </div>
    </div>

</div>
</body>

<script src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js" type="text/javascript"></script>
<script src="/ijob/static/js/index/part-time.js" type="text/javascript"></script>
<script src="/ijob/static/js/index/index.js" type="text/javascript"></script>
<%--<script src="/ijob/static/js/index/fullIndex.js"></script>--%>
<script>
    var localtion ,menu=ijob.menu.get();

    localtion  =  ijob.location.get();
    document.getElementById("prompt").innerHTML =  (localtion.city||'失联中')+"<i class=\"mui-icon mui-icon-arrowdown\">";
    var positionparam  = {condition:{between:null,notin:"in",type:0,open:2,isDeleted:false,lng:localtion.lng,lat:localtion.lat,radius:10,cityID:localtion.cityID}};
    // positionparam.condition.orderby = "dailySalary";
    positionparam.condition.orderby = "createTime";
    var flag  = true;
    var slide = null;


    var urlmap = {
        '0':'/ijob/api/PositionController/myPositionPage',
        '1':'/ijob/api/FullTimeController/getFullJobList',
        '2':'/ijob/api/PositionController/myAttentionPositionPage'
    };
    var url ;
    var cachedata;
    var cachepage;
    function changeCache(index){
        url = urlmap[index];
        cachedata = ijob.persistence.get("cache."+url);
        if(cachedata&&index==0){  //如果是兼职 ，记录最后一次param值
            positionparam = cachedata.param;
        }
        if(cachedata&&cachedata.param)
            cachepage = {pageSize:cachedata.param.pageSize,currentPage:(1+(cachedata.param.currentPage||1))};
    }
    function remarkAnchors(){  //记录当前位置，设置为待缓存所有
        cachepage = null;
        cachedata = ijob.persistence.get("cache."+url);
        cachedata.anchors = {stop: $(window).scrollTop()};
        cachedata.cache = true;
        ijob.persistence.set("cache."+url,cachedata);
    }



    $(".icon-saoyisao").unbind().click(function(){
        $.getJSON("/ijob/api/WeixinController/getJSAuthSignature?url="+window.location.href,function(data){
            wx.config({
                debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                appId: data.data.appId, // 必填，公众号的唯一标识
                timestamp: data.data.timestamp, // 必填，生成签名的时间戳
                nonceStr: data.data.noncestr, // 必填，生成签名的随机串
                signature: data.data.signature,// 必填，签名
                jsApiList: ["scanQRCode"] // 必填，需要使用的JS接口列表
            });
        })

        wx.ready(function () {
            wx.scanQRCode({
                needResult: 0, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                scanType: ["qrCode","barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                success: function (res) {
                    var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                }
            });
        });


    });


    $(".head-li").click(function (event) {
        if($(this).text() == "兼职"){
            $(".wrap .head").addClass("bg_hd");
        }else if($(this).text() == "全职"){
            $(".wrap .head").addClass("bg_hd");
        }else{
            $(".wrap .head").removeClass("bg_hd");
        }
        menu = "findJob:"+$(this).data("index");
        changeCache($(this).data("index"));
        ijob.menu.set(menu);
        var nub = $(this).data("index");
        $(this).addClass("active").siblings('.head-li').removeClass("active");
        $(".main>div").eq(nub).show().siblings().hide();
        // ijob.storage.set("remenber",nub);
        if(nub==0){
            allHandler();
        }else if(nub == 1){
            loadFullJob();
        }else{
            attentionHandler();
        }
    });



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

    function allHandler(){
        loadPosition();
    }
    // 分享
    $("body").on('click','.share',function(){
        $(".share-content").show();
        /*slide = new Slide($(".wrap"),$(".share-content"),".popup-backdrop");
        slide.disTouch();*/
        initShare($("#"+$(this).data("index")).serializeObjectJson());
    });
    $("body").on('click','.share_content .cancel a',function () {
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

    //加载全职工作区域，和工作类别
    $("#fullJobCityList").loadData({condition:{parentID:"430100"}}).then(function(result1){
        if(ijob.persistence.get("fullCondition")){
            var cityList = $(".nav_li_1 .filter-list .main-list-box li");
            for(var i = 0;i<cityList.length;i++){
                if($(cityList[i]).data("value")==ijob.persistence.get("fullCondition").cityType){
                    var _this = $(cityList[i]);
                    $("#region").html("<span>"+_this.text()+"</span>"+"<span class=\"iconfont icon-arrow-down1\"></span>");
                    _this.css("color", "#108ee9").siblings().css("color", "#666");
                    $("#region").addClass("active");
                }
            }
        }
        $("#fullJobTypeList").loadData().then(function(result2){
            if(ijob.persistence.get("fullCondition")){
                var postTypeList = $(".nav_li_2 .filter-list .main-list-box li");
                for(var i = 0;i<postTypeList.length;i++){
                    if($(postTypeList[i]).data("value")==ijob.persistence.get("fullCondition").fullType){
                        var _this = $(postTypeList[i]);
                        $("#quarters").html("<span>"+_this.text()+"</span>"+"<span class=\"iconfont icon-arrow-down1\"></span>");
                        _this.css("color", "#108ee9").siblings().css("color", "#666");
                        $("#quarters").addClass("active");
                    }
                }

                var orderByList = $(".nav_li_3 .filter-list .main-list-box li");
                for(var i = 0;i<orderByList.length;i++){
                    if($(orderByList[i]).data("value")==ijob.persistence.get("fullCondition").orderBy){
                        var _this = $(orderByList[i]);
                        $("#sort").html("<span class='txt'>"+_this.text()+"</span>"+"<span class=\"iconfont icon-arrow-down1\"></span>");
                        _this.css("color", "#108ee9").siblings().css("color", "#666");
                        $("#sort").addClass("active");
                    }
                }

                var salaryOrderList = $(".nav_li_4 .filter-list .main-list-box li");
                for(var i = 0;i<salaryOrderList.length;i++){
                    if($(salaryOrderList[i]).data("value")==ijob.persistence.get("fullCondition").salaryOrder){
                        var _this = $(salaryOrderList[i]);
                        $("#wages").html("<span class='txt'>"+_this.text()+"</span>"+"<span class=\"iconfont icon-arrow-down1\"></span>");
                        _this.css("color", "#108ee9").siblings().css("color", "#666");
                        $("#wages").addClass("active");
                    }
                }
            }
            loadJs("/ijob/static/js/index/fullIndex.js?version=5");
        });
    });

    function loadFullJob(){
        var page  = cachepage||{"pageSize":"10", "currentPage":"1"};
        var condition = $.extend({status:true},ijob.persistence.get("fullCondition")) ;
        page.condition = condition;
        var ijobRefresh = new IJobRefresh({
            container: '.allFullList',
            up: function () {
                $("#fullJobList").appendData(page, ijobRefresh).then(function (result) {
                    if(result.nextPage)
                        page.currentPage = result.nextPage;
                    if(cachedata&&cachedata.cache){
                        $(window).scrollTop(cachedata.anchors.stop);
                        cachedata.cache = false;  //缓存开关关闭
                        ijob.persistence.set("cache."+url,cachedata);
                    }
                    // 添加样式
                    $(".label-box .taglist span").each(function () {
                        if($(this).text() == "福利"){
                            $(this).addClass("key1")
                        }else if($(this).text() == "工作"){
                            $(this).addClass("key2");
                        }
                    });

                    $(window).scroll(function() {
                        var win_top = $(this).scrollTop();
                        var topHeight = $('.banner').outerHeight()+$('.head-fixe').outerHeight();
                        if (win_top >= topHeight) {
                            $(".screen-box-list").addClass("sfixed");
                        }else if (win_top < topHeight) {
                            $(".screen-box-list").removeClass("sfixed");
                        }
                    });
                });
            }
        });
    }

    function loadPosition(){
        var page  = cachepage||{"pageSize": "10", "currentPage": "1"};
        var ijobRefresh = new IJobRefresh({
            container: '.list-ul',
            panel:'.all_content',
            up: function() {
                var obj = $.extend(positionparam,page);
                $("#jobtemplate").appendData(obj,ijobRefresh).then(function(result){
                    if(result.nextPage)
                        page.currentPage = result.nextPage;
                    if(cachedata&&cachedata.cache){
                        $(window).scrollTop(cachedata.anchors.stop);
                        cachedata.cache = false;  //缓存开关关闭
                        ijob.persistence.set("cache."+url,cachedata);
                    }
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
                    if(positionparam.condition.notin=="in" && 10000==result.totalPage){
                        positionparam.condition.notin = "notin";
                        page.currentPage = 1;
                        ijobRefresh.up.call();
                    }else if(positionparam.condition.between==null&&positionparam.condition.notin=="notin" && 20000==result.totalPage){
                        positionparam.condition.between = "all";
                        page.currentPage = 1;
                        ijobRefresh.up.call();
                    }


                });
            }
        });
        $(".nav-content").click();

    }
    function initIntention(){

        $("#orderType li").on('click',function(){
            ijob.storage.clear("cache./ijob/api/PositionController/myPositionPage");
            if ($(this).text() == "最新发布") {
                positionparam.condition.between = null;
                positionparam.condition.orderby = "publishTime";
            } else if ($(this).text() == "人气优先") {
                positionparam.condition.orderby = "hot";
            } else if ($(this).text() == "距离优先") {
                positionparam.condition.orderby = "distance";
            } else if ($(this).text() == "价格优先") {
                positionparam.condition.orderby = "dailySalary";
            }else if($(this).text() == "薪资从高到低"){
                positionparam.condition.orderby = "dailySalary";
            }
            selected($(this));
            loadPosition();
            $("#all-sort a").text($(this).text());
            showActive(2);
        });

        $("#workType2 li").click(function(){
            ijob.storage.clear("cache./ijob/api/PositionController/myPositionPage");
            positionparam.condition.cityID = $(this).data("value");
            selected($(this));
            loadPosition();
            $("#place a").text($(this).text());
            showActive(0);
        });

        $("#typetemplate").loadData().then(function(result){
            $("#publishType li").on('click', function () {
                positionparam.condition.workTypeID  = $(this).data("id").toString().trim();
                positionparam.condition.between = null;
                positionparam.condition.notin = "in";
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



        setTimeout(function showAttention(){
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

                $("#fujin").trigger("click");

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
                        positionparam.condition.between = null;
                        positionparam.condition.notin = "in";
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

            });
        },1000);

    }

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

    function attentionHandler(){
        var param = {condition:{type:0,open:2,isDeleted:false,lng:localtion.lng,lat:localtion.lat,radius:10}};
        var page  = {"pageSize": "10", "currentPage": "1"};
        var isRecommend = false;
        //关注界面
        function loadHandler(){
            page  = {"pageSize": "10", "currentPage": "1"};
            var ijobRefresh = new IJobRefresh({
                container: '#panel',
                panel:'.attention_content',
                up: function() {
                    var obj = $.extend(page,param);
                    $("#myfriendtemplate1").appendData(obj,ijobRefresh).then(function(result){
                        // 分享
                        page.currentPage = result.nextPage;
                        if(cachedata&&cachedata.cache){
                            $(window).scrollTop(cachedata.anchors.stop);
                            cachedata.cache = false;  //缓存开关关闭
                            ijob.persistence.set("cache."+url,cachedata);
                        }
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
                            $('#panel').prevAll().remove();
                            $('#panel').before("<div class=\"contentBox\" style='margin-top:0px!important; '><p style='text-align: center;margin-top: 1px;padding: 0.5rem;background: #fff;'>您还没有关注任何人或者关注的人没有发布职位</p></div><span style='padding: 0.3rem 0.5rem;padding-bottom: 0;font-size: 0.34rem;display: block;'>您可能感兴趣的</span>");
                            param = {condition:{Recommend:'Recommend',type:0,open:2,isDeleted:false,lng:localtion.lng,lat:localtion.lat,radius:10}};
                            loadHandler();
                        }

                        $(".attention-gz").click(function(e){
                            e.preventDefault();
                            e.stopPropagation();
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
                                            attentionHandler();
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
                                    attentionHandler();
                                });
                            }
                        });

                    });
                }
            });
        }
        loadHandler();
    }

    var gallery = mui('.mui-slider');
    gallery.slider({
        interval:3000//自动轮播周期，若为0则不自动播放，默认为0；
    });


    $(document).ready(function(){
        if( menu && menu.indexOf("findJob")!=-1 && menu.indexOf(":")>-1){
            $(".head-li").eq(menu.split(":")[1]).trigger('click');
        }else{
            $(".head-li").eq(0).trigger('click');
        }
    });

    function initShare(shareObj){
        var title= "【I Job兼职】"+shareObj.title;
        var desc="待遇："+shareObj.salary+"元/天"+"\n"+"地点："+shareObj.city+"\n时间："+shareObj.date;
        // var link="http://www.jianzhipt.cn";
        var link="${site}/share/PD/"+shareObj.id + "/" + shareObj.shareUser;
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


    function loadJs(_url){
        var new_element = document.createElement("script");
        new_element.setAttribute("type", "text/javascript");
        new_element.setAttribute("charset", "UTF-8");
        new_element.setAttribute("src", _url);
        document.body.appendChild(new_element);
    }

</script>

</html>
