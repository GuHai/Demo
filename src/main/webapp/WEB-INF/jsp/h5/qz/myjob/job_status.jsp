<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/4
  Time: 11:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>工作状态</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/My_part-time/TransactionRecord_Unsettlement.css">
    <script src="/ijob/static/js/ijobbase.js?version=1"></script>
</head>
<body>
<div>

<div class="wrap">
    <script id="todayJob"   type="text/html"  data-url="/ijob/api/PositionController/jobDetailPathId/{been.distance}/{been.id}"  data-type="GET" >
        {{each list as posi}}
            <div class="head_title">
                <div class="head_title_lf">
                    {{posi.beenrecruited | signStatus }}
                </div>
                <div class="head_title_rt">
                    <img src="/ijob/static/images/{{posi.beenrecruited.state | enums:'BeenPicName'}}" alt="">
                </div>
            </div>
            <div class="main">
                <div class="list-container">
                    <div class="list-title">
                        <span class="title-content">{{posi.title}}</span>

                    </div>
                    <div class="list-content">
                        <div class="content-tit" style="background-color: {{posi.huntingtype.codeGrade |getTypeColor}}!important">{{posi.huntingtype.name}}</div>
                        <div class="content-msg">
                            <div class="content-msg1">
                                            <span class="content-msg1-lf"><i
                                                    class="iconfont icon-shizhong"></i>{{posi.recruitStartTime | dateFormat:'MM月dd日'}}</span>
                                <span class="content-msg1-rt">{{posi.dailySalary}}元/天</span>
                            </div>
                            <div class="content-msg2">
                                            <span class="content-msg2-lf">{{if posi.sexRequirements == '' || posi.sexRequirements == null}}男女不限{{/if}}{{posi.sexRequirements  | enums:'SexRequirements'}}&nbsp;<span
                                                    class="line"></span>&nbsp;{{posi.beenRecruitedSum |ifNull:'0'}}/{{posi.recruitsSum}}人</span>
                                <span class="content-msg2-rt">{{posi.settlement | enums:'SettlementType'}}</span>
                            </div>
                            <div class="content-msg3">
                                <span class="content-msg3-lf">{{posi.workPlace.cityName}}&nbsp;{{posi.workPlace.distance | distance}}</span>
                                <span class="content-msg3-rt">信用保证金<span style="color: #15bc83">{{posi.liquidatedDamages}}元</span></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="ulBox" >
                    <ul class="conterList">
                        <li class="identical title" id="tit">{{posi.title}}</li>
                        <li class="identical sum" id="sum">
                            <span id="signinDay"></span>
                            <span><i class="iconfont icon-arrow-right"></i></span>
                        </li>
                        <li class="time" id="dat">
                            <div class="details-calendar">
                                <div class="box">
                                    <section class="date"  data-editable="false">
                                        <div class="data-head">
                                            <div class="prev mui-icon mui-icon-back"></div>
                                            <div class="tomon"><span class="year"></span>年 <span class="month"></span><span style="padding-left: 15px;">月</span></div>
                                            <div class="next mui-icon mui-icon-forward"></div>
                                        </div>
                                        <ol>
                                            <li>日</li>
                                            <li>一</li>
                                            <li>二</li>
                                            <li>三</li>
                                            <li>四</li>
                                            <li>五</li>
                                            <li>六</li>
                                        </ol>
                                        <ul >
                                        </ul>
                                    </section>
                                </div>
                            </div>
                            <div class="select-content">
                                <div class="txt">
                                    未结算天数：<span id="unsettleDay"></span>
                                </div>
                                <div class="tipsmain">
                                    <span class="selectbtn selectable" >
                                        <span class="round"></span>
                                        <span>未结算</span>
                                    </span>
                                    <span class="selectbtn selected">
                                        <span class="round"></span>
                                        <span>已结算</span>
                                    </span>
                                </div>
                            </div>
                        </li>

                        <li class="layout" id="wdqdjl"  onclick="window.location.href='/ijob/api/SigninController/list/{{posi.id}}'">
                            <span>我的签到</span>
                            <span>{{if posi.signin!=null}}
                                    {{posi.signin | dateFormat:'MM月dd日hh-mm-ss','signTime'}}
                                    {{posi.signin.state==9?'（未到岗被辞退）':''}}
                                {{else}}
                                    无
                                {{/if}}
                                <i class="iconfont icon-arrow-right"></i></span>
                        </li>

                        <li class="layout" id="bzj" onclick="gotoBill(this);" data-id="{{posi.id}}" data-title="{{posi.title}}">
                            <span>保证金</span>
                            <span>{{posi.bondStatus}}<i class="iconfont icon-arrow-right"></i></span>
                        </li>
                    </ul>
                    <ul class="dataList">
                        {{each posi.beenrecruited.statusList as status}}
                        <li>
                            <span>{{status.name}}</span>
                            <span>{{status.date | dateFormat:'yyyy年MM月dd日  hh:mm:ss'}}</span>
                        </li>
                        {{/each}}
                    </ul>
                </div>
            </div>
            <div class="foot_fixed">
                <input onclick="calltel(this);" data-tel="{{posi | ifNull:'无手机号','contactNumber'}}" type="button" value="联系商家" class="btn_contact">
                <input type="button" value="修改兼职日期" class="btn_edit"  onclick="ijob.gotoPage({path:'/h5/qz/myjob/edit_data?been.id={{posi.beenrecruited.id}}&been.positionID={{posi.id}}'})">
                <input type="button" value="咨询" class="btn_advisory" onclick="ijobbase.toChat({positionName:'{{posi.title}}',toUserID:'{{posi.userID}}',positionID:'{{posi.id}}'})"  >
                <input type="button" value="取消应聘" class="btn_cancel" onclick="cancelInterview('{{posi.beenrecruited.id}}','{{posi.beenrecruited.version}}')"  > <%--onclick="window.location.href = '/ijob/api/SigninController/cancelInterview/{{posi.beenrecruited.id}}'"--%>
                <%--<input type="button" value="辞职" class="resignation">--%>
                <input type="button" value="签到" class="btn_sign"  onclick="ijob.gotoPage({path:'/h5/qz/myjob/sign_in?sign.id={{posi.beenrecruited.id}}&sign.title=签到'})">
                <input type="button" value="签退" class="btn_signback"  onclick="ijob.gotoPage({path:'/h5/qz/myjob/sign_in?sign.id={{posi.beenrecruited.id}}&sign.title=签退'})">
                <input type="button" value="催结算" class="btn_status"  data-url="/ijob/api/ApplySettlementController/urgeSettle/{{posi.id}}">
                <input type="button" value="评价" class="btn_think"  onclick="ijob.gotoPage({path:'/h5/qz/myjob/evaluate?evaluate.positionID={{posi.id}}&evaluate.title={{posi.title}}'})">
            </div>
        {{/each}}
    </script>
</div>
    <div class="home-block-r">
        <a href="javascript:void(0);" class="homepage" id="homepage">
            <span class="iconfont icon-zhuye"></span>
            <%--<p>返回</p>--%>
        </a>
    </div>
</div>
</body>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>
    document.getElementById("homepage").onclick = function(){
        window.location.href = "/indexMain";
    }
    var showstate =  ijob.storage.get("showstate");
    $("#todayJob").data("url",$("#todayJob").data("url")+"/"+showstate);
    $("#todayJob").loadData(function(){
        var _this = $(this);
        var state = ijob.storage.get("been.state");
        var liobj = enums.workStatus.li[showstate];


        _this.find(".conterList>li").each(function(i,item){
            if($.inArray($(this).prop("id"),liobj)==-1){
                $(this).remove();
            }
        });
        if (showstate == 4) {
            _this.find(".head_title,.list-container,.dataList").remove();
        }
        if (showstate == 5) {
            _this.find(".head_title,.list-container,.dataList").remove();
        }
    }).then(function(result){
        var btnobj = enums.workStatus.btn[showstate];
        if(result.data.list[0].beenrecruited && (result.data.list[0].beenrecruited.dismiss || result.data.list[0].beenrecruited.dismiss==false) ){
            btnobj = enums.workStatus.btn[6];
        }else{
            btnobj = enums.workStatus.btn[showstate];
        }
        $(".foot_fixed>input").each(function(i,item){
            if($.inArray($(this).prop("className"),btnobj)==-1){
                $(this).remove();
            }
        });
        var unsettlearr = [];
        var settlearr  = [];
        var signins = result.data.list[0].signins;
        if(signins&&signins.length>0){
            var unsettle = 0;
            $.each(signins,function(i,item){
                if(item.state<4  && item.state>0){
                    unsettle ++;
                    unsettlearr.push(ijob.getDateByTime(item.signTime));
                }else if(item.state==4){
                    settlearr.push(ijob.getDateByTime(item.signTime));
                }
            });
            $("#unsettleDay").text(unsettle+"天");
            $("#signinDay").text("共签到"+signins.length+"天");
        }

        $('.date').on('completionEvent', function() {
            $(".date").containDate(unsettlearr,settlearr);
        });
        dateRenderInit();


    });

    function calltel(item){
        var tel  = $(item).data("tel");
        if(tel=='无手机号'){
            mui.toast('无商家电话号码');
        }else{
            window.location.href = "tel:"+tel;
        }
    }

    function gotoBill(item){
        ijob.storage.set("bill",{title:$(item).data("title"),positionID:$(item).data("id")});
        ijob.gotoPage({path:'/h5/qz/mine/bill_detail'});
    }


    function cancelInterview (id,version){
        var btnArray = ['取消','确定'];
        mui.prompt('请填写退出原由', '退出理由', 'I Job', btnArray, function (e) {
            if (e.index == 1) {
                $.getJSON("/ijob/api/BeenrecruitedController/cancelInterview/"+ id+"/"+version+"/"+ e.value,function(data){
                    // ijob.reback(data.msg);
                    ijob.delayGotoPage({url:'/indexMain'},data.msg);
                });
            }
        });
    }

    $(".wrap").on('click','.btn_status',function(){
        $(this).btPost({},function(data){
            mui.toast(data.msg);
        })
    });
</script>
</html>
