<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/1
  Time: 10:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>我要报名</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/index/signUp.css">
</head>
<body>

<div class="wrap">

    <header class="head">
        <script  type="text/html" id="jobtemplate"  data-url="/ijob/api/PositionController/detailPathId/{position.id}" data-type="GET">
            {{each list as posi}}
                <div class="list-li">
                    <div class="list-container">
                        <div class="list-title">
                            <span class="title-content">{{posi.title}}</span>
                        </div>
                        <div class="list-content ">
                            <div class="content-tit">
                                {{posi.huntingtype | ifNull:'其他','name'}}
                            </div>
                            <div class="content-msg">
                                <div class="content-msg1">
                                            <span class="content-msg1-lf"><i
                                                    class="iconfont icon-shizhong" style="font-size: 12px"></i>{{posi.recruitStartTime | dateFormat:'MM月dd日'}}-{{posi.recruitEndTime | dateFormat:'MM月dd日'}}</span>
                                    <span class="content-msg1-rt">{{posi.dailySalary}}元/天</span>
                                </div>
                                <div class="content-msg2">
                                            <span class="content-msg2-lf">{{posi.sexRequirements  | enums:'SexRequirements'}}&nbsp;<span
                                                    class="line"></span>&nbsp;{{posi.workPlace | ifNull:'未知地址','cityName'}}</span>
                                    <span class="content-msg2-rt">{{posi.settlement | enums:'SettlementType'}}</span>
                                </div>
                                <div class="content-msg3">
                                    <span class="content-msg3-lf">已录取<strong>{{posi.beenRecruitedSum | ifNull:'0'}}</strong>人/招聘<strong>{{posi.recruitsSum | ifNull:'0'}}</strong>人</span>
                                    <span class="content-msg3-rt">商家已缴纳保证金<strong>{{posi.liquidatedDamages}}元</strong></span>
                                </div>
                            </div>
                        </div>
                        <div class="details-address">
                        <em>工作地址</em><span id="workplace"></span><i class="iconfont icon-fujin" ></i>
                        </div>
                    </div>
                </div>
            {{/each}}
        </script>
    </header>


    <div class="main">
        <!--招聘详情-->
        <div class="details">
            <%--<div class="details-address">--%>
                <%--工作地址<span id="workplace"></span><i class="iconfont icon-fujin" ></i>--%>
            <%--</div>--%>
            <a id="resume" class="details-resume">简历
                <span class="span_1"><span id="chooseResume"></span><i class="iconfont icon-arrow-right" id="selectResume"></i></span>
            </a>
            <div class="details-workDate">工作日期<span class="right">默认为招聘者发布的所有工作日期</span></div>
            <div class="details-calendar">
                <div class="box">
                    <section class="date"    data-editable="false" >
                        <div class="data-head">
                            <div class="prev mui-icon mui-icon-back"></div>
                            <div class="tomon"><span class="year">2018</span>年 <span class="month">1</span>月</div>
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
                        <ul>

                        </ul>
                    </section>
                </div>
            </div>
            <div class="select-content" style="display: none;">
                <div class="tipsmain">
                    <span class="selectbtn selectable" >
                        <span class="round"></span>
                        <span>可选</span>
                    </span>
                    <span class="selectbtn selected">
                        <span class="round"></span>
                        <span>已选</span>
                    </span>
                </div>
            </div>
            <%--<a id="resume" class="details-resume">简历--%>
                <%--<span class="span_1"><span id="chooseResume"></span><i class="iconfont icon-arrow-right" id="selectResume"></i></span>--%>
             <%--</a>--%>
            <%--<div class="details-margin" id="topay">保证金<span><i id="liquidatedDamages" class="money"></i><i class="iconfont icon-arrow-right" id="bondStatus"></i></span>--%>
                <%--<span></span>--%>
            <%--</div>--%>
        </div>
        <div style="content: '';clear: both;height: 1.2rem;"></div>
        <div class="btnBox">
            <div class="btnsave tips">
                <a href="javascript:void(0);" class="tipbtn">保证金是什么？</a>
                <div class="tips-content">
                    <div class="main-content">
                        <h1>保证金相关问答</h1>
                        <h2>一.要交多少保证金？</h2>
                        <h4>
                            1.招聘方需要按照所发布的职位日薪资的25%*招聘人数交保证金，方可发布职位，
                            以确保职位的真实有效；
                        </h4>
                        <h4>
                            求职者需按照所报名工作日薪资的25%，缴纳保证金。
                        </h4>
                        <h2>
                            二.我是招聘者，我的保证金怎么退回？
                        </h2>
                        <h4>
                            招聘者发布职位到期后，保证金会退还到您的工资表余额中。
                        </h4>
                        <h2>
                            三.我是求职者，我的保证金怎么退回？
                        </h2>
                        <h4>
                            1.如果求职者被录取，到岗后，保证金退还到您的工资卡余额中；
                        </h4>
                        <h4>
                            2.如果求职者被拒绝，保证金退还到您的工资卡余额中；
                        </h4>
                        <h4>
                            3.如果求职者没有被录取也没有被拒绝，岗位到期后，保证金退还到您的工资卡余额中。
                        </h4>
                        <h2>
                            四.什么情况下不退回保证金？
                        </h2>
                        <h4>
                            1.招聘者发布虚假职位信息，被投诉经核实后，所交保证金补偿给报名的求职者。
                        </h4>
                        <h4>
                            2.求职者被录取后没有到岗（放鸽子的），所交保证金补偿给招聘者。
                        </h4>
                        <input type="button" value="确认" class="closebtn" >
                    </div>
                </div>
            </div>
            <div class="btnsave money">
                <span>保证金：&yen</span>
                <span class="num">{{posi.liquidatedDamages}}</span>
            </div>
            <div class="btnsave enroll-btns" id="saveConfigBtn" data-url="/ijob/api/BeenrecruitedController/add">
                <a href="javascript:void(0);"  class="btn">确认报名</a>
                <%--<input type="button" value="确认" class="btn" style="display: block"  id="saveConfigBtn" data-url="/ijob/api/BeenrecruitedController/add">--%>
            </div>
        </div>
    </div>
</div>
</body>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>
    $(function(){
        // 保证金
        var slide = null;
        $(".tipbtn").click(function(){
            $(".tips-content").show();
            slide = new Slide($(".wrap"),$(".tips-content"),".main-content");
            slide.disTouch();
        })
        $(".closebtn").click(function(){
            $(".tips-content").hide();
            slide.ableTouch();
        });
    });
    var now  = new Date();
    $(".date").find("span[class='year']").html(now.getYear()+1900);
    $(".date").find("span[class='month']").html(now.getMonth()+1);
    $("#jobtemplate").loadData().then(function(result){
        $(".num").text(result.data.list[0].liquidatedDamages);
        //保存positionID到全局
        var haveBond = (result.data.list[0].wxorder!=null);
        var resumeId = ijob.storage.get("data.resumeId");
        var resumeName = ijob.storage.get("data.resumeName");
        var bondstr = "（去缴纳）";
        if(haveBond){
            bondstr = "（已缴纳）";
        }else{
            if(result.data.list[0].liquidatedDamages==null || result.data.list[0].liquidatedDamages==0){
                haveBond = true;
                bondstr = "（无需缴纳）";
                $("#topay").hide();
            }else{
                bondstr = "（去缴纳）";
                $("#topay").click(function(){
                    ijob.url.next.set("/ijob/api/PositionController/signUpCallback");
                    ijob.gotoPage({url:'/ijob/api/WeixinController/order',data:{order:{refID:result.data.list[0].id,fee:result.data.list[0].liquidatedDamages*100,description:'求职人员保证金'+(result.data.list[0].liquidatedDamages*100)+'元',type:enums.WxOrderType.Bond}}});
                });
            }
        }
        $("#liquidatedDamages").html((result.data.list[0].liquidatedDamages||'0')+"元"+bondstr);

        $("#workplace").html(result.data.list[0].workPlace && (result.data.list[0].workPlace.cityName + "·"+result.data.list[0].workPlace.detailedAddress  ));
        $("#chooseResume").html(resumeName || (result.data.list[0].defaultResume && result.data.list[0].defaultResume.resumeTitle)||"请选择简历");
        var haveResume = ($("#chooseResume").text()!="请选择简历");
        var datetime = result.data.list[0].workDate;
        var mydatetime = result.data.list[0].defaultResume&&result.data.list[0].defaultResume.workDate||'';
        var arr = ijob.getDateList(datetime);
        var myarrtemp = ijob.getDateList(datetime);
        var myarr = [];
        for(var i in myarrtemp){
            var d = myarrtemp[i];
            if(ijob.abledDate(d)){
                myarr.push(d);
            }
        }
        //if(mydatetime!=undefined)myarr = ijob.getDateList(mydatetime);
        $('.date').on('completionEvent', function() {
            $(".date").containDate(arr,myarr);
        });

      /*  $(".date").on('dateClickEvent',function(event,state,dr){
            if(state){
                myarr.push(dr);
            }else{
                myarr.splice($.inArray(dr,myarr),1);
            }
        });*/
        dateRenderInit(arr);
        $("#saveConfigBtn").click(function(){
            if(checkSignUp()){
                var obj = {"positionID":result.data.list[0].id,"resumeID":resumeId || (result.data.list[0].defaultResume && result.data.list[0].defaultResume.id)};
                obj.workDate = JSON.stringify(ijob.getStrFromList(myarr));
                $("#saveConfigBtn").btPost(JSON.stringify(obj),function(data){
                    if(data.success){
                       /* ijob.storage.set("menu","myjob");
                        ijob.delayGotoPage({url:'/indexMain'},data.msg);*/
                       //跳转到保证金页面
                        payBond(result);
                    }else{
                        //跳转到补交保证金页面
                        if(data.code=="403"){
                            payBond(result);
                        }
                        mui.toast(data.msg);
                    }
                })

            }
        });

        $("#workplace").parent().click(function(){
            //var center = result.data.list[0].workPlace.latitude+","+result.data.list[0].workPlace.longitude;
            //ijob.gotoPage({url:"http://apis.map.qq.com/tools/poimarker?type=1&center="+center+"&radius=1000&key=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77&referer=myapp"})
            ijob.showPoint(result.data.list[0].workPlace);
            // ijob.gotoPage({url:"/ijob/api/WeixinController/map",data:{localtion:{lng:result.data.list[0].workPlace.longitude,lat:result.data.list[0].workPlace.latitude}}});
        });
        function checkSignUp(){
            var str = "";
            if(myarr.length==0)str += "工作已经结束<br>";
            if(!haveResume)str += "简历未选择<br>";
            // if(!haveBond)str += "保证金未缴纳";
            if(str){
                mui.toast(str);
                return false;
            }
            return true;
        }
        //重置清空，避免点击默认选择后还是用 session 里旧的值
        ijob.storage.set("data.resumeId",null);
        ijob.storage.set("data.resumeName",null);
    });

    $("#resume").click(function(){
        //为了后续判断是否是由这个页面进入的
        ijob.storage.set("isByEnroll",true);
        ijob.gotoPage({url:"/ijob/api/ResumeController/h5/mine/chooseResume"});
    });

    function payBond(result){
        window.history.replaceState('','', "/ijob/forward?path=/h5/qz/myjob/my_part_time_job");
        ijob.url.next.set("/ijob/api/PositionController/signUpCallback");
        ijob.gotoPage({url:'/ijob/api/WeixinController/order',data:{order:{refID:result.data.list[0].id,fee:result.data.list[0].liquidatedDamages*100,description:'求职人员保证金'+(result.data.list[0].liquidatedDamages)+'元',type:enums.WxOrderType.Bond}}});
    }
</script>
</html>
