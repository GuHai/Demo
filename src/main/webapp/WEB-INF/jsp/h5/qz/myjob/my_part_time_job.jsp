<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/31
  Time: 18:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.yskj.utils.DateUtils,com.yskj.utils.IJobUtils" %>
<html>
<head>
    <title>我的兼职</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/My_part-time/My_part-time_job.css">
    <script src="/ijob/static/js/ijobbase.js?version=1"></script>

</head>
<body>
<div class="wrap">

    <div class="main">

        <div class="partTime" style="display: block;">
            <ul class="partTimeNav">
                <li>待录取</li>
                <li>待签到</li>
                <li>已签到</li>
                <li>待结算</li>
                <li>已结算</li>
            </ul>
            <div class="sign_posi" id="topmsg"  style="display: none">
                <div class="tips" >
                    <p class="exist" ></p>
                </div>
            </div>
            <div class="code_posi" style="display: none" id="tipDiv" onclick="ijob.gotoPage({path:'/h5/qz/myjob/stay_accounts_detail'})">
                <span class="txt">您有<span id="number">2</span>个扫码待结算的职位...</span>
                <span class="iconfont icon-arrow-right"></span>
            </div>
            <div class="scan_posi" style="display: none" onclick="ijob.gotoPage({path:'/h5/qz/myjob/already_accounts_detail'})">
                <span class="txt"><span class="iconfont icon-erweima codeImg"></span>&nbsp;扫码已结算</span>
                <span class="iconfont icon-arrow-right"></span>
            </div>
            <div class="partTime_content">
                <div class="allJob">
                    <script id="myJob"   type="text/html"  data-url="/ijob/api/BeenrecruitedController/findMyJobPage">
                        {{each list as job index}}
                            <div class="allJob_workList">
                                <div class="list-container">
                                    <div class="list-title">
                                        <span class="title-content">{{job.position.title}}</span>
                                        <span class="titel-note"><i>{{job.workDate | nextDate }}  {{job | signStatus }}</i></span>
                                    </div>
                                    <div class="list-content">
                                        <div class="content-tit" style="background-color: {{job.position.huntingtype.codeGrade |getTypeColor}}!important">{{job.position.huntingtype | ifNull:'未找到类型','name'}}</div>
                                        <div class="content-msg"  onclick="ijob.gotoPage({path:'/h5/qz/myjob/job_status?been.state={{job.state}}&been.id={{job.id}}&been.distance={{job.position.workPlace.distance}}' })">
                                            <div class="content-msg1">
                                                <span class="content-msg1-lf"><i class="iconfont icon-shizhong"></i>{{job.position.recruitStartTime | dateFormat:'MM月dd日'}}-{{job.position.recruitEndTime | dateFormat:'MM月dd日'}}</span>
                                                <span class="content-msg1-rt">{{job.position.dailySalary}}元/天</span>
                                            </div>
                                            <div class="content-msg2">
                                                <span class="content-msg2-lf">{{if job.position.sexRequirements == '' || job.position.sexRequirements == null}}男女不限{{/if}}{{job.position.sexRequirements  | enums:'SexRequirements'}}&nbsp;<span
                                                class="line"></span>&nbsp;{{job.position.personNumDay}}人/天</span>
                                                <span class="content-msg2-rt">{{job.position.settlement | enums:'SettlementType'}}</span>
                                            </div>
                                            <div class="content-msg3">
                                                <span class="content-msg3-lf">{{job.position.workPlace.city.cityName}}&nbsp; {{job.position.workPlace.distance | distance}}</span>
                                                <span class="content-msg3-rt">商家已缴纳保证金<i>{{job.position.liquidatedDamages}}元</i></span>
                                            </div>
                                            <%--待结算--%>
                                            <div class="content-msg4">
                                                <span>{{ job.signState==2?'待':'已' }}结算天数：<i class="date1">{{job.signnum}}天</i></span>
                                                <%--<span>共签到：<i class="date1">5天</i>，共<em>6次</em>；未结算天数：<i class="date2">1天</i></span>--%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="btnBox"  id="myjobbtn{{index}}">
                                        <a href="tel:{{job.position.contactNumber}}"><input type="button" value="联系商家" class="btn_contact"></a>
                                        <input type="button" value="修改兼职日期" class="btn_edit" onclick="ijob.gotoPage({path:'/h5/qz/myjob/edit_data?been.id={{job.id}}&been.version={{job.version}}&been.positionID={{job.position.id}}'})">
                                        <input type="button" value="咨询" class="btn_advisory"  onclick="ijobbase.toChat({positionName:'{{job.position.title}}',toUserID:'{{job.position.userID}}',positionID:'{{job.position.id}}'})">
                                        <input type="button" value="完善个人信息" class="btn_inform" onclick="ijob.gotoPage({path:'/h5/qz/index/personalInform?personal.tomyjob=true'});">
                                        <input type="button" value="取消应聘" class="btn_cancel"  data-id="{{job.id}}" data-version="{{job.version}}">
                                        <input type="button" value="催结算" class="btn_status"  data-url="/ijob/api/ApplySettlementController/urgeSettle/{{job.position.id}}" > <%--onclick="window.location.href='/ijob/api/SettlementpersonController/applySettle/{{job.position.id}}/{{job.position.workDate}}'"--%>
                                        <input type="button" value="辞职" class="resignation" data-url="/ijob/api/BeenrecruitedController/leaveWork/{{job.id}}" >
                                        <input type="button" value="签到" class="btn_sign"  onclick="ijob.gotoPage({path:'/h5/qz/myjob/sign_in?sign.id={{job.id}}&sign.title=签到'})">
                                        <input type="button" value="签退" class="btn_signback"  onclick="ijob.gotoPage({path:'/h5/qz/myjob/sign_in?sign.id={{job.id}}&sign.title=签退'})">
                                        <input type="button" value="评价" class="btn_think"    onclick="ijob.gotoPage({path:'/h5/qz/myjob/evaluate?evaluate.positionID={{job.position.id}}&evaluate.title={{job.position.title}}'})">
                                        <input type="button" value="删除" class="btn_del" data-id="{{job.id}}" data-version="{{job.version}}" data-url="/ijob/api/BeenrecruitedController/delete" >
                                    </div>
                                </div>
                            </div>
                        {{/each}}
                    </script>
                </div>
            </div>
        </div>
    </div>
    <div id="homepage"></div>
</div>
</body>
<script src="/ijob/static/js/wxlocation.js"></script>
<script src="/ijob/static/js/mobile_data.js"></script>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});
    var smenu = ijob.storage.pop("menu");
    if(smenu){
         var pmenu = ijob.persistence.get("menu");
         if(pmenu==null){
             ijob.persistence.set("menu",{main:'',map:{}});
         }
         ijob.menu.set(smenu);
    }
    var menu =  ijob.menu.get("personal");
    var showstate=1;
    var localtion  = ijob.location.get();
    var param = {};
    function loadJobData(){
        var page  = {"pageSize": "10", "currentPage": "1"};
        var ijobRefresh = new IJobRefresh({
            container: '.allJob',
            up: function() {
                var obj = $.extend(page,param);
                $("#myJob").appendData(obj,ijobRefresh).then(function(result){
                    $("#topmsg").hide();
                    $("#tipDiv").hide();
                    $(".scan_posi").hide();
                    $.post("/ijob/api/ApplySettlementController/findWaitRushListCount",null,function(result){
                        if(result.data > 0 && showstate == 4){
                            $(".code_posi").show();
                            $("#number").text(result.data);
                        }else {
                            $(".code_posi").hide();
                        }
                    });
                    if(showstate == 5){
                        $.post("/ijob/api/ApplySettlementController/findScanYJSListCount",null,function(result){
                            if(result.data > 0&&showstate == 5)
                                $(".scan_posi").show();
                            else
                                $(".scan_posi").hide();
                        });
                    }else if(showstate == 2){ //待签到
                        var count = 0;
                        for(var i in result.data.list){
                            var obj = result.data.list[i];
                            if(ijob.isToday(obj.workDate) && obj.dismiss==null){
                                count ++;
                            }
                        }
                        $("#topmsg").show().find("p:first").text(count>0?'您今天有'+count+'个工作':'今天没有职位需要签到哦~');

                    }else {
                        $(".scan_posi").hide();
                    }
                    page.currentPage =  result.nextPage;
                    for(var i in  result.data.list){
                        var btnobj ;
                        if(result.data.list[i].dismiss || result.data.list[i].dismiss==false ){
                            btnobj = enums.workStatus.btn[6];
                        }else{
                            btnobj = enums.workStatus.btn[showstate];
                        }
                        var id = "myjobbtn"+i;

                        $(".allJob").find("div[id='"+id+"']").find("input").each(function(j,item){
                            if($.inArray($(this).prop("className"),btnobj)==-1){
                                $(this).remove();
                            }else{
                                if($(this).prop("className")=='btn_inform' && result.data.list[i].state==1){
                                    $(this).remove();
                                }
                                if($(this).prop("className")=='btn_edit' && result.data.list[i].state==2){
                                    $(this).remove();
                                }

                            }

                        });
                    }
                    //判断待结算和已结算和其它状态下不同的显示内容
                    if(showstate == 1){
                        $(".content-msg4").hide();
                    }else if(showstate == 2){
                        $(".content-msg4").hide();
                    }else if(showstate == 3){
                        $(".content-msg4").hide();
                    }else if(showstate == 4){
                        $(".content-msg3").hide();
                    }else if(showstate == 5){
                        $(".content-msg3").hide();
                    }
                });
            }
        });
    }
    $(".partTimeNav>li").on("click", function () {
        $(this).addClass("active").siblings().removeClass("active");
        if($(this).text()=="待录取"){
            showstate = 1;
            param.condition = {"state":1,lng:localtion.lng,lat:localtion.lat};
            menu = "personal:part:0"
        }else if($(this).text()=="待签到"){
            showstate = 2;
            param.condition = {"signState":-1,"state":4,lng:localtion.lng,lat:localtion.lat};
            menu = "personal:part:1"
        }else if($(this).text()=="已签到"){
            showstate = 3;
            param.condition = {"signState":0,"state":4,"date":"today",lng:localtion.lng,lat:localtion.lat};
            menu = "personal:part:2"
        }else if($(this).text()=="待结算"){
            showstate = 4;
            param.condition = {"signState":2,"state":4,lng:localtion.lng,lat:localtion.lat};
            menu = "personal:part:3";
        }else if($(this).text()=="已结算"){
            showstate = 5;
            param.condition = {"signState":4,"state":4,lng:localtion.lng,lat:localtion.lat};
            menu = "personal:part:4"
        }
        ijob.menu.set(menu);
        ijob.storage.set("showstate",showstate);

        loadJobData();
    });

    $(".allJob").on('click','.resignation',function(){
        $(this).btPost({},function(data){
            mui.alert(data.msg);
        })
    })

    $(".allJob").on('click','.btn_status',function(){
        $(this).btPost({},function(data){
            mui.toast(data.msg);
        })
    });

    $(".main").on('click','.btn_cancel',function(){
        addCancelhandler($(this).data("id"),$(this).data("version"));
    });

    $(".main").on('click','.btn_del',function(){
        var _this = $(this);
        var btnArray = ['是', '否'];
        mui.confirm('确定删除？', null, btnArray, function(e) {
            if (e.index == 0) {//点击是
                _this.btPost({
                    id:_this.data("id"),
                    version:_this.data("version"),
                    state:9
                });
            }
        });
    });


    //取消面试弹出框
    function addCancelhandler(id,version){
        var btnArray = ['确定', '取消'];
        mui.prompt('请输入退出的理由，退出后保证金退回到余额', '退出理由', 'I Job', btnArray, function (e) {
            if (e.index == 0) {
                $.getJSON("/ijob/api/BeenrecruitedController/cancelInterview/"+id+"/"+version+"/"+ e.value,function(data){
                    ijob.delayGotoPage({path:'/h5/qz/myjob/my_part_time_job'},data.msg);
                });
            }
        });
    }

    function clickHandler() {
        document.title = "我的兼职";
        if(menu  && menu.split(":").length==3){
            $(".partTimeNav>li").eq(menu.split(":")[2]).click();
        }else{
            $(".partTimeNav>li").eq(0).click();
        }
    }



    $(document).ready(function(){
        document.title = "获取地理位置中...";
        if(localtion==null){
            wxlocation.location().then(function(local){
                localtion  = local;
                clickHandler();
                //查看是不是关注
                ijobbase.checkSubscribe();
            });
        }else{
            clickHandler();
        }
    });



</script>
</html>
