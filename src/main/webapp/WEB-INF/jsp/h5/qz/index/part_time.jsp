<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/30
  Time: 14:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>搜索结果</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/index/part-time.css">
    <jsp:include page="../../qz/base/resource.jsp"/>
</head>
<body>
<div class="wrap">
    <header class="hader-fixed">
        <div class="head_input">
            <i class="iconfont icon-sousuo"></i>
            <input type="text" id="position" placeholder="职位/公司/工作号" class="text_search" maxlength="10" value="${search}">
            <span class="btn_cancel" id="searchBnt">搜索</span>
        </div>
        <ul class="nav">
            <li class="nav-li li_1">
                <div class="nav-box" id="place">
                    <a data-value="地点" class="place nav-select" href="javascript:void(0);" id="point">地点</a>
                    <i class="iconfont icon-arrow-down1"></i>
                </div>
                <div class="mui-backdrop nav-content" >
                    <ul class="nav-selected" id="workType2">
                        <li data-value="天心区">天心区</li>
                        <li data-value="芙蓉区">芙蓉区</li>
                        <li data-value="雨花区">雨花区</li>
                        <li data-value="开福区">开福区</li>
                        <li data-value="岳麓区">岳麓区</li>
                        <li data-value="望城区">望城区</li>
                        <li data-value="长沙县">长沙县</li>
                        <li data-value="宁乡县">宁乡县</li>
                        <li data-value="浏阳市">浏阳市</li>
                    </ul>
                    <%--<div class="nav-selected grade-eject" id="workType">
                        <ul class="grade-w" id="gradew1">
                            <li >附近</li>
                            <li >区域</li>
                            <li >地铁</li>
                        </ul>
                        <ul class="grade-t" id="gradet1">

                        </ul>
                        <ul class="grade-s" id="grades1">

                        </ul>
                    </div>--%>
                </div>
            </li>
            <li class="nav-li line"></li>
            <li class=" nav-li li_2">
                <div class="nav-box" id="release">
                    <a data-value="类型" class="release nav-select" href="javascript:void(0);" id="worktypename">类型</a>
                    <i class="iconfont icon-arrow-down1"></i>
                </div>
                <div class="mui-backdrop nav-content">
                    <ul class="nav-selected" id="workTypeList">
                        <c:forEach items="${workTypeList}" var="type">
                            <li data-value="${type.name}" data-id="${type.id}">${type.name}</li>
                        </c:forEach>
                    </ul>
                </div>
            </li>
            <li class="nav-li line"></li>
            <li class="nav-li li_3">
                <div class="nav-box" id="all-sort">
                    <a data-value="排序" class="all-sort nav-select" href="javascript:void(0);" id="sortname">排序</a>
                    <i class="iconfont icon-arrow-down1"></i>
                </div>
                <div class="mui-backdrop nav-content">
                    <ul class="nav-selected" id="publishType">
                        <li data-value="最新发布">最新发布</li>
                        <li data-value="薪资从高到低">薪资从高到低</li>
                        <%--<li data-value="发布时间">发布时间</li>
                        <li data-value="人气优先">人气优先</li>
                        <li data-value="距离优先">距离优先</li>
                        <li data-value="价格优先">价格优先</li>--%>
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
                    <ul class="nav-selected " id="filterPanel">
                        <%--<li class="filter-price">
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
                                <li data-id="3">仅限女生</li>
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
    </header>
    <div class="main">
        <div class="list">
            <ul class="list-ul" id="jobList">
                <script type="textml" id="jobtemplate" data-url="/ijob/api/PositionController/myPositionPage">
                    {{each list as posi}}
                    <li class="list-li"   onclick="ijob.gotoPage({path:'/h5/qz/index/part_time_detail?data.position.id={{posi.id}}'})">
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
                                        <span class="content-msg1-rt">{{posi.dailySalary}}/天</span>
                                    </div>
                                    <div class="content-msg2">
                                        <span class="content-msg2-lf">{{posi.sexRequirements  | enums:'SexRequirements'}}&nbsp;<span class="line"></span>&nbsp;{{posi.beenRecruitedSum | ifNull:'0'}}/{{posi.recruitsSum | ifNull:'0'}}人</span>
                                        <span class="content-msg2-rt">{{posi.settlement | enums:'SettlementType'}}</span>
                                    </div>
                                    <div class="content-msg3">
                                        <span class="content-msg3-lf">{{posi.workPlace | ifNull:'未知','city.cityName'}}&nbsp; {{posi.workPlace.distance | distance }}</span>
                                        <span class="content-msg3-rt">{{posi.publish | ifNull : '无工作号','workNumber'}}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    {{/each}}
                </script>

            </ul>

        </div>
    </div>
</div>
</body>
<%--<script src="/ijob/static/js/index/part-time.js"></script>--%>
<script src="/ijob/static/js/index/new_part_time.js"></script>
<script>
    $("#filterPanel li").not(":last").on('click',function(e){
        e.stopPropagation();
    });
    /**
     * 获得性别要求
     */
    var sex = null, settlementType = null;
    $(".filter-gender-msg > li").click(function(e){
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
        e.stopPropagation();
    });

    /**
     * 获得结算方式
     */
    $(".filter-js-msg > li").click(function(e){
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
        e.stopPropagation();
    });
</script>
<script>

   /* var workTypeID   ;
    var search  = {};
    search.condition = {
        "isDeleted": false,
        "workTypeID": $("#workType li:first").data("id") == "" ? null : $(this).data("id"),
        "settlement": settlementType,
        "sexRequirements": sex,
        "interview": null,
        "salaryOpen": null,
        "salaryClose": null,
        "orderby":"${orderBy}",
        type:0,
        open:2
    };
    search.condition.orderby = "createTime";
    search.orderByClause = " order by p.createTime desc ";

    function searchData(param) {
       /!* $("#jobtemplate").loadData(param).then(function(){

        });*!/
        var page  = {"pageSize": "10", "currentPage": "1"};
        var ijobRefresh = new IJobRefresh({
            container: '#jobList',
            up: function() {
                var obj = $.extend(page,param);
                $("#jobtemplate").appendData(obj,ijobRefresh).then(function(result){
                    page.currentPage =  result.nextPage;
                });
            }
        });
    }

    function searchHandler() {
        searchData({
            "condition":search.condition ,
            "orderByClause": search.orderByClause
        });
    }

    function initSearchParam() {
        search.condition = {
            "isDeleted": false,
            "workTypeID": workTypeID,
            "settlement": settlementType,
            "sexRequirements": sex,
            "interview": null,
            "salaryOpen": null,
            "salaryClose": null
        };
        search.condition.orderby = null;
        search.orderByClause = null;
    }

    $("#workType li").on('click', function () {
        initSearchParam();
        search.condition = {"workTypeID": $(this).data("id") == "" ? null : $(this).data("id")};
        workTypeID = $(this).data("id");
        searchHandler();

    });

    $("#publishType li").on('click', function () {
        initSearchParam();
        if(workTypeID==null || workTypeID==""){
            search.condition = {"workTypeID": $(this).data("id") == "" ? null : $(this).data("id")};
        }
        search.condition.orderby = null;
        search.orderByClause = null;
        if ($(this).text() == "发布时间") {
            search.condition.orderby = "createTime";
            search.orderByClause = " order by p.createTime desc ";
        } else if ($(this).text() == "人气优先") {
            search.condition.orderby = "hot";
        } else if ($(this).text() == "距离优先") {

        } else if ($(this).text() == "价格优先") {
            search.condition.orderby = "dailySalary";
            search.orderByClause = " order by p.dailySalary desc ";
        }
        searchHandler();
    });

    //点击查询方法
    $("#filterBtn").on('click', function () {
        initSearchParam();
        var start = $("#salary .text_start:first").val();
        var end = $("#salary .text_end:first").val();
        if (ijob.isNotNull(start) && ijob.isNotNull(end)) {
            search.condition.salaryOpen = start;
            search.condition.salaryClose = end;
        }
        searchHandler();
        $(".nav-content").click();
    });

    $(".filter-js").on('click', 'li', function () {
        $('.filter-js li').removeClass('active');
        $(this).addClass('active');
        search.condition.settlement = $(this).data("id");
    });

    $(".filter-gender").on('click', 'li', function () {
        $('.filter-gender li').removeClass('active');
        $(this).addClass('active');
        search.condition.sexRequirements = $(this).data("id");
    });

    $(".filter-claim>div:last").on('click', function () {
        search.condition.settlement = $(this).hasClass("mui-active");
    });
    //点击重置
    $("#resetBtn").on("click", function () {
        $(".text_start,.text_end").val("");
        $("[data-id]").attr("id", "");
        $(".mui-switch-handle").prop("style", "transition-duration: 0.2s; transform: translate(0px, 0px);");
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
    });



    //由于选择器优先级问题只能用 id 选择器
    $("[data-id]").on("click", function () {
        $(this).attr("id", function () {
            return $(this).attr("id") == 'data-id' ? "" : "data-id"
        });
    });

    $("#searchBnt").on('click',function(event){
        if(ijob.isNotNull($("#position").val())){
            window.location.href = "/ijob/api/SearchlogController/result?search="+$("#position").val();
        }else{
            mui.toast("搜索内容不能为空");
        }
    });

    $('#position').bind('input propertychange', function() {
        if(ijob.isNotNull($("#position").val())){
            $('#searchBnt').html("搜索");
        }else {
            $('#searchBnt').html("取消");
        }
    });*/

    var localtion = ijob.location.get();
    var  positionparam  = {condition:{searchkey:"${search}",type:0,open:2,isDeleted:false,lng:localtion.lng,lat:localtion.lat,radius:10}};
    function loadPosition(){
       var page  = {"pageSize": "10", "currentPage": "1"};
       var ijobRefresh = new IJobRefresh({
           container: '.list-ul',
           up: function() {
               var obj = $.extend(page,positionparam);
               $("#jobtemplate").appendData(obj,ijobRefresh).then(function(result){
                   page.currentPage =  result.nextPage;
               });
           }
       });
    }

    function  gradetHandler(_this){
        $("#point").text(_this.text());
        if( pointtype=="附近"){
             positionparam.condition.orderby = "distance";
             positionparam.condition.radius  =_this.data("dist") ;
             positionparam.condition.cityID = null;
             positionparam.condition.lng=localtion.lng;
             positionparam.condition.lat=localtion.lat;
             loadPosition();
        }else if( pointtype=="区域"){
             positionparam.condition.orderby = "hot";
             positionparam.condition.radius  = 10;
             positionparam.condition.cityID = _this.data("id");
             positionparam.condition.lng=localtion.lng;
             positionparam.condition.lat=localtion.lat;
             loadPosition();
        }else {
            $("#grades1").html("");
            var stationHtml = "";
            $.getJSON("/ijob/api/MetroController/getMyCityStation/"+_this.data("id"),null,function(result){
                var list = result.data.list;
                for(var index in list){
                    stationHtml += "<li data-lat='"+list[index].lat+"' data-lng='"+list[index].lng+"'  data-id='"+list[index].id+"'>"+list[index].name+"</li>";
                }
                $("#grades1").html(stationHtml);
            });
        }
    }

    function gradesHandler(_this){
        $("#point").text(_this.text().substring(0,Math.min(3,_this.text().length)));
        positionparam.condition.orderby = "distance";
        positionparam.condition.lng=_this.data("lng");
        positionparam.condition.lat=_this.data("lat");
        positionparam.condition.radius  = 2;
        positionparam.condition.cityID = null;
        loadPosition();
    }
    
    function publishTypeHandler(_this) {
        $("#sortname").text(_this.text());
        if (_this.text() == "发布时间") {
            positionparam.condition.orderby = "createTime";
        } else if (_this.text() == "人气优先") {
            positionparam.condition.orderby = "hot";
        } else if (_this.text() == "距离优先") {
            positionparam.condition.orderby = "distance";
        } else if (_this.text() == "价格优先") {
            positionparam.condition.orderby = "dailySalary";
        }
        loadPosition();
    }



    function filterHandler() {
        var start = $("#salary .text_start:first").val();
        var end = $("#salary .text_end:first").val();
        if (ijob.isNotNull(start) && ijob.isNotNull(end)) {
            positionparam.condition.salaryOpen = start;
            positionparam.condition.salaryClose = end;
        }
        positionparam.condition.settlement=settlementType;
        positionparam.condition.sexRequirements= sex;
        loadPosition();
    }

    function workTypeHandler(_this){
        $("#worktypename").text(_this.text());
        positionparam.condition.workTypeID  = _this.data("id").trim();
        loadPosition();
    }

    function resetBtnHandler() {
        positionparam.condition.settlement=null;
        positionparam.condition.sexRequirements= null;
        positionparam.condition.salaryOpen = null;
        positionparam.condition.salaryClose = null;
    }

   $('#position').bind('input propertychange', function() {
       if(ijob.isNotNull($("#position").val())){
           $('#searchBnt').html("搜索");
       }else {
           //$('#searchBnt').html("取消");
           positionparam.condition.searchkey = null;
           loadPosition();
       }
   });


   $("#searchBnt").on('click',function(event){
       if(ijob.isNotNull($("#position").val())){
           positionparam.condition.searchkey = $("#position").val();
           loadPosition();
       }else{
           mui.toast("搜索内容不能为空");
       }
   });


   loadPosition();

</script>
</html>
