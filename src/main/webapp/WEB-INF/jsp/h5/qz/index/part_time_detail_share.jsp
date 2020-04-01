<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/19
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>兼职详情</title>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/index/Part-timeDetails.css?version=4">
    <script src="/ijob/static/js/ijobbase.js?version=1"></script>

    <style>
        .details>div{
            word-break:break-all;
        }
    </style>
</head>
<body>
<div class="wrap">
    <div >
        <script id="todayJob"   type="text/html"  data-url="/ijob/api/PositionController/detail/">
            {{each list as map}}
            <%--返回去首页--%>
            <header class="h_share">
                <div class="linkbox">
                    <a href="/indexMain">返回首页</a>
                    <div class="logo">
                        <img src="/ijob/static/images/yslogo.png"/>
                    </div>
                </div>
                <div style="clear: both;content: '';height: 1.15rem;visibility: hidden;"></div>
            </header>
            <div class="head">
                <div class="list-li">
                    <div class="list-container">
                        <div class="list-title">
                            <span class="title-content">{{map.position.title}}</span>
                        </div>
                        <div class="list-content ">
                            <div class="content-tit" style="background:{{map.position.huntingtype.codeGrade |getTypeColor}}!important;">
                                {{map.position.huntingtype | ifNull:'其他','name'}}
                            </div>
                            <div class="content-msg">
                                <div class="content-msg1">
                                            <span class="content-msg1-lf"><i
                                                    class="iconfont icon-shizhong"></i>{{map.position.recruitStartTime | dateFormat:'MM月dd日'}}</span>
                                    <span class="content-msg1-rt">{{map.position.dailySalary}}元/天</span>
                                </div>
                                <div class="content-msg2">
                                            <span class="content-msg2-lf">{{map.position.sexRequirements  | enums:'SexRequirements'}}&nbsp;<span
                                                    class="line"></span>&nbsp;{{map.position.workPlace | ifNull:'未知城市','cityName'}}</span>
                                    <span class="content-msg2-rt">{{map.position.settlement  | enums:'SettlementType' }}</span>
                                </div>
                                <div class="content-msg3">
                                    <span class="content-msg3-lf"><%--已录取<span style="color: #ff3b30">{{map.position.beenRecruitedSum | ifNull:'0'}}</span>人/--%>招聘<span style="color: #ff3b30">{{map.position.personNumDay | ifNull:'0'}}</span>人/天</span>
                                    <span class="content-msg3-rt">商家已缴纳保证金 <span style="color: #15bc83">{{map.position.liquidatedDamages*map.position.personNumDay | money}}元</span></span>
                                </div>
                            </div>
                        </div>
                        <div class="details-address" id="gotomap">
                            <em>工作地址</em><span >{{map.position.workPlace | ifNull:'未知地址','detailedAddress'}}</span><i class="iconfont icon-fujin"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="main">
                <!--招聘详情-->
                <div class="details">
                    <%--标签内容--%>
                    <div class="details-tag">
                        <ul class="taglist">
                            {{if map.position.includeBoard == null || map.position.includeBoard == ''}}
                            <li>不管饭</li>
                            {{else}}
                            <li>管饭：{{map.position.includeBoard |formatBoard}}</li>
                            {{/if}}
                            {{if map.labelList.length != 0}}
                            {{each map.labelList as label i}}
                            {{if i < 3}}
                            <li>{{label.name}}</li>
                            {{/if}}
                            {{/each}}
                            {{/if}}
                        </ul>
                    </div>
                    <div class="details-calendar">
                        <div class="box">
                            <section class="date"  data-editable="true">
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
                                <ul >
                                </ul>
                            </section>
                        </div>
                    </div>
                    <div class="details-hours">工作时间<span>{{map.position.startTime | dateFormatByMinute}} - {{map.position.endTime | dateFormatByMinute}}</span></div>
                </div>
                <div class="details margintop">
                    <div class="details-desc">
                        <h3>职位描述</h3>
                        <div class="txt" id="positiondesc">
                            {{map.position.jobContent |ifNull:'无职位描述'}}
                        </div>
                    </div>
                    <div class="details-setTime">集合时间<span>{{map.position.setDate |  dateFormat:'yyyy年MM月dd日 hh:mm'}}</span></div>
                    <div class="details-place" id="goviewmap"><em>集合地址</em><span>{{map.position.gather | ifNull:'未知地址','detailedAddress'}}</span><i class="iconfont icon-fujin"></i></div>
                </div>
                <!--发布对象与注意事项-->
                <div class="point">
                    <div class="company">
                        <div class="company-title">发布对象</div>
                        <div class="company-content clearfix">
                            <div class="company-content-img ">
                                <a href="javascript:void(0)"><img src="{{map.position.positionUser.imgPath}}" alt=""></a>
                            </div>
                            <div class="company-content-msg ">
                                <p>{{map.position.publish | ifNull:'无工作号','workNumber'}}</p>
                                <p>正在招聘：<em>{{map.count}}</em>个职位</p>
                            </div>
                            <div class="visit_home">
                                <%-- isEdit 是否可编辑 --%>
                                <a href="javascript:void(0);" id="gotoWorkNumber" style="padding-left: 10px;padding-right: 10px;" data-id="{{map.position.userID}}">访问工作号</a>
<%--
                                <a href="javascript:void(0);" style="padding-left: 10px;padding-right: 10px;" onclick="ijob.storage.set('isEdit',false);ijob.gotoPage({url:'/ijob/api/InformationController/h5/mine/examineUserInfo/{{map.position.userID}}'+'/'+ijob.location.get().lng+'/'+ijob.location.get().lat });">访问工作号</a>
--%>
                            </div>
                        </div>
                    </div>
                    <div class="warn">
                        <div class="warn-title">注意事项</div>
                        <div class="warn-content">
                            <div class="warn-content-msg">
                                工作期间请注意人身和财产安全，对于商家
                                提出的任何收费一律拒绝，并向平台举报。
                            </div>
                            <div class="warn-content-report" onclick="ijob.gotoPage({path:'/h5/qz/mine/SubmitFeedback?data.positionID={{map.position.id}}'})">举报</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="foot_margin"></div>
            <footer class="foot-fixed">
                <a href="javascript:void(0)" onclick="ijobbase.toChat({positionName:'{{map.position.title}}',toUserID:'{{map.position.userID}}',positionID:'{{map.position.id}}'})"  name="tel:{{map.position.contactNumber}}">
                    <div class="advisory">
                        <i class="iconfont icon-zixun"></i>
                        <p>咨询</p>
                    </div>
                </a>
                <div class="attention"  id="isAttention" class="un-company-content-collection" onclick="changeAttentionState('{{map.position.userID}}')" data-url="/ijob/api/AttentionController/update">
                    <i class="iconfont icon-guanzhu"></i>
                    <p>关注</p>
                </div>
                <form id="form" style="display: none;">
                    <input type="hidden" value="<shiro:principal property="id"/>" id="userID">
                </form>
                <div class="apply" id="signUpBnt" data-url="/ijob/api/PersonalauthenController/one"  >
                    <a href="javascript:void(0)">我要报名</a>
                </div>  <%--data-url="/ijob/api/BeenrecruitedController/add"--%>
            </footer>
            <div class="sign_up_content" style="display: none;">
                <div class="sign_up_box">
                    <div class="sign_head">
                        <span class="money">
                            <span class="msg">保证金&yen</span>
                            <span class="num">{{map.position.liquidatedDamages | ifNull:'0'}}</span>
                        </span>
                        <a href="#contentid" class="tipbtn" id="showtext" onClick="showdetails('contentid','showtext')">保证金是什么？</a>
                    </div>
                    <div class="txt">
                        *温馨提示：选择报名前请看清楚职位详情的工作时间、职位描述等相关信息，以免和商家产生纠纷
                    </div>
                    <div class="tips-content"  id="contentid" style="display: none;">
                        <div class="main-content">
                            <h1>保证金相关问答</h1>
                            <h2>一.要交多少保证金？</h2>
                            <h4>
                                招聘方需要按照自己所选的保证金金额*招聘人数交保证金，方可发布职位，以确保职位的真实有效；
                                求职者需要按照招聘者所选的保证金金额缴纳保证金。
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
                            <%--<input type="button" value="确认" class="closebtn" >--%>
                        </div>
                    </div>
                    <div class="mui-input-row mui-checkbox">
                        <label style="text-indent: 30px;font-size: 0.4rem;color: #666;">违约后补交（VIP特权）</label>
                        <input id="boa" style="left: 15px;text-align: center;top: 20%;" type="checkbox" checked="" >
                    </div>
                    <div style="clear: both;content: '';height: 1.7rem;"></div>
                </div>
                <%--底部--%>
                <div class="sign_btn">
                    <a href="javascript:void(0);"   data-url="/ijob/api/BeenrecruitedController/add"  class="gobtns" id="gobtns" >确认</a>
                </div>
            </div>
            {{/each}}
        </script>

    </div>

</div>
</body>
<%--<script src="http://webapi.amap.com/maps?v=1.4.6&key=dfd42cc657511c1daf483e8a46865a16"></script>
<script src="/ijob/static/js/map2.js"></script>--%>
<script src="https://res.wx.qq.com/open/js/jweixin-1.2.0.js" type="text/javascript"></script>
<script src="/ijob/static/js/wxlocation.js"></script>
<script>



    $(function () {
        var isPageHide = false;
        window.addEventListener('pageshow', function () {
            if (isPageHide) {
                window.location.reload();
            }
        });
        window.addEventListener('pagehide', function () {
            isPageHide = true;
        });
    });

    ijob.callbackfunc.call();


    ijobbase.checkSubscribe();
    var id = null ,shareUser = "noShareUser",positionID=ijob.storage.get("position.id"),otherUser=ijob.storage.get("position.userID");
    function checkRedPacket(forwardId){
        var query = {
            condition:{
                'forwardId':forwardId
            }
        }
        $.ajax({
            url: '/ijob/api/PositionController/h5/qz/checkRedPacket',
            contentType: 'application/json',
            type: 'POST',
            data: JSON.stringify(query),
            dataType: 'json',
            success: function (data) {
                shareUser = data.data.shareUser;
                if(data.data.Forward!=null){
                    id = data.data.Forward.id +"-";
                }
                positionID = data.data.Forward.positionId;
                init();
            }
        })
    }
    var resumeID ;
    if(positionID.indexOf("-")>-1){
        checkRedPacket(positionID.replace("-",""))
    }else{
        init();
    }
    function init(){
        $("#todayJob").data("url",$("#todayJob").data("url")+positionID);
        $("#todayJob").loadData("该职位已经关闭或删除").then(function(result){
            if(result.data==null){
               $(".wrap").css("text-align","center");
            }
            wxlocation.location().then(function(local){
                $("#gotoWorkNumber").click(function(){
                    ijob.storage.set('isEdit',false);
                    ijob.gotoPage({url:'/ijob/api/InformationController/h5/mine/examineUserInfo/'+local.lng+'/'+local.lat+'/'+$(this).data('id')})
                });
            })
            if(id==null){
                id=positionID;
            }
            var content = (result.data.list[0].position.jobContent||"无职位描述").replace(/\n/g,"<br/>");
            $("#positiondesc").html(content);
            var posi = result.data.list[0].position;
            var title= "【I Job兼职】"+posi.title+posi.dailySalary+"元/天";
            var desc="招聘人数："+result.data.list[0].position.personNumDay+"人/天"+"\n"+"地点："+posi.workPlace.cityName+"\n时间："+template.dateFormat(posi.recruitStartTime,'MM/dd')+"-"+template.dateFormat(posi.recruitEndTime,'MM/dd');
            // var link="http://www.jianzhipt.cn";
            var link="${site}/share/PD/"+id + "/"+shareUser;
            var tempType = result.data.list[0].position.huntingtype.codeGrade;
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
            //判断是招聘者预览还是求职者查看
            if(ijob.storage.get("data.position.isPreview") && ijob.storage.get("data.position.isPreview").toString() === "true"){
                //如果是预览就不要这几个 Dom 数据
                $(".point,.foot-fixed").remove();
            }

            //工作地址
            if(result.data.list[0].position.workPlace.latitude&&result.data.list[0].position.workPlace.longitude){
                $("#gotomap").click(function(){
                    var center = result.data.list[0].position.workPlace.latitude+","+result.data.list[0].position.workPlace.longitude;
                    var addr = result.data.list[0].position.workPlace.detailedAddress;
                    window.location.href='http://apis.map.qq.com/tools/poimarker?type=0&marker=coord:'+center+';title:工作地址;addr:'+addr+'&key=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77&referer=myapp';
                })

            }
            //集合地址
            if(result.data.list[0].position.gather.latitude&&result.data.list[0].position.gather.longitude){
                $("#goviewmap").click(function(){
                    var center = result.data.list[0].position.gather.latitude+","+result.data.list[0].position.gather.longitude;
                    var addr = result.data.list[0].position.gather.detailedAddress;
                    window.location.href='http://apis.map.qq.com/tools/poimarker?type=0&marker=coord:'+center+';title:集合地址;addr:'+addr+'&key=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77&referer=myapp';
                })

            }
            if(result.data.list[0].isAattention.toString()==="true"){
                $("#isAttention p").text("已关注");
                //$("#isAttention").data("url","/ijob/api/AttentionController/delete");
                $("#isAttention").removeClass("un-company-content-collection").addClass("company-content-collection");
                $("#isAttention i").removeClass("icon-guanzhu").addClass("icon-weibiaoti105");
            }else{
                $("#isAttention p").text("关注");
                //$("#isAttention").data("url","/ijob/api/AttentionController/update");
                $("#isAttention").removeClass("company-content-collection").addClass("un-company-content-collection");
            }

            var datetime = result.data.list[0].position.workDate;
            var mydatetime = result.data.list[0].defaultResume&&result.data.list[0].defaultResume.workDate||'';
            var arr = ijob.getDateList(datetime);
            var arrnum = ijob.getDatePersonList(datetime);
            var myarrtemp = ijob.getDateList(mydatetime);
            var myarr = [];
            var validarr = [];
            for(var i in myarrtemp){
                var d = myarrtemp[i];
                if(ijob.abledDate(d)){
                    myarr.push(d);
                }
            }
            $('.date').on('completionEvent', function() {
                $(".date").containDate(arr,myarr);
                $(".date").remainder(arrnum);
            });

            $(".date").on('dateClickEvent',function(event,state,dr){
                if(state){
                    myarr.push(dr);
                }else{
                    myarr.splice($.inArray(dr,myarr),1);
                }
            });

            dateRenderInit(arr);

            $("#gobtns").click(function(){
                if(checkSignUp()) {
                    var obj = {"positionID": result.data.list[0].position.id, "resumeID": resumeID};
                    obj.workDate = JSON.stringify(ijob.getStrFromList(myarr));
                    var mapObj = {"beenrecruited":obj}
                    if(id.indexOf("-")>-1){
                        mapObj.forwardID = id;
                    }
                    if(otherUser!="noShareUser"){
                        mapObj.shareUser = otherUser;
                    }
                    $(this).btPost(JSON.stringify(mapObj), function (data) {
                        if (data.success) {
                            /* ijob.storage.set("menu","myjob");
                             ijob.delayGotoPage({url:'/indexMain'},data.msg);*/
                            //跳转到保证金页面
                            payBond(result);
                        } else {
                            //跳转到补交保证金页面
                            if (data.code == "403") {
                                payBond(result);
                            }else{
                                mui.toast(data.msg);
                            }
                        }
                    })
                }
            });

            function checkSignUp(){
                var str = "";
                validarr= [];
                for(var i in myarr){
                    var d = myarr[i];
                    if(ijob.abledDate(d)){
                        validarr.push(d);
                    }
                }
                if(validarr.length==0)str += "请选择有效的工作日期<br>";
                if(str){
                    mui.toast(str);
                    return false;
                }
                var indemnity = ijobbase.checkIndemnity();
                if(indemnity){
                    ijobbase.confirmPay(indemnity,"forward?path=/h5/qz/index/part_time_detail");
                    return false;
                }else{
                    return true;
                }
            }


            $("#signUpBnt").click(function(){
                /*$(this).btPost(JSON.stringify({condition:{"userID":$("#userID").val()}}),function(data){
                    if(data.data != null){
                        checkResume();
                    }else{
                        var btnArray = ['否','是'];
                        mui.confirm('请进行个人实名认证！', '', btnArray, function(e) {
                            if (e.index == 1) {
                                ijob.gotoPage({path:"/h5/qz/mine/realName"});
                            }
                        });
                    }
                });*/

                //初始化不选择违约后补交
                $("#boa").attr("checked", false);


                var slide = null;
                $(".sign_up_content").show();
                slide = new Slide($(".wrap"),$(".sign_up_content"),".sign_up_box");
                slide.disTouch();

                $(".gobtns").click(function(){
                    $(".sign_up_content").hide();
                    slide.ableTouch();
                });
                // 点击空白处隐藏选项
                $("body>*").on('click', function (e) {
                    if ($(e.target).hasClass('sign_up_content')) {
                        $(".sign_up_content").hide();
                        slide.ableTouch();
                    }
                });
                resumeID = result.data.id ;
            });

            function checkResume(){
                $.getJSON("/ijob/api/ResumeController/one",function(result){
                    if(result.data){

                        var slide = null;
                        $(".sign_up_content").show();
                        slide = new Slide($(".wrap"),$(".sign_up_content"),".sign_up_box");
                        slide.disTouch();

                        $(".gobtns").click(function(){
                            $(".sign_up_content").hide();
                            slide.ableTouch();
                        });
                        // 点击空白处隐藏选项
                        $("body>*").on('click', function (e) {
                            if ($(e.target).hasClass('sign_up_content')) {
                                $(".sign_up_content").hide();
                                slide.ableTouch();
                            }
                        });
                        resumeID = result.data.id ;
                    }else{
                        var btnArray = ['取消','确认'];
                        mui.confirm('您还没有简历哦，是否去新增简历？', '提示', btnArray, function(e) {
                            if (e.index == 1) {
                                ijob.gotoPage({path:"/h5/qz/mine/chooseResume_add"});
                            }
                        });
                    }
                });
            }

            function payBond(result){

                if($("#boa").prop("checked")==true){
                    ijob.gotoPage({url:'/ijob/api/PositionController/signUpCallbackNoPay/'+result.data.list[0].position.id});
                }else{
                    // window.history.replaceState('','', "/ijob/forward?path=/h5/qz/myjob/my_part_time_job");
                    ijob.url.next.set("/ijob/api/PositionController/signUpCallbackJson","json",paycallback);
                    ijob.gotoPage({url:'/ijob/api/WeixinController/order',data:{order:{refID:result.data.list[0].position.id,fee:result.data.list[0].position.liquidatedDamages*100,description:'求职人员保证金'+(result.data.list[0].position.liquidatedDamages)+'元',type:enums.WxOrderType.Bond}}});
                }
            }
        });
    }

    function paycallback(data){
        if(data.code==201){
            window.location.href = "/ijob/forward?path=/h5/qz/myjob/my_part_time_job";
        }else if(data.code==202){
            ijob.storage.set("personal.tomyjob",true);
            ijob.gotoPage({path:"/h5/qz/index/personalInform"});
        }else if(data.code==203){
            sessionStorage.setItem("error",data.msg);
            window.location.href = "/ijob/forward?path=/h5/error";
        }else{
            window.location.href = "/ijob/forward?path=/h5/qz/myjob/my_part_time_job";
        }
    }

    function showdetails(targetid,objN){
        var target=document.getElementById(targetid);
        var clicktext=document.getElementById(objN)
        if (target.style.display=="block"){
            target.style.display="none";
            clicktext.innerText="保证金是什么？";
        } else {
            target.style.display="block";
            clicktext.innerText='关闭保证金相关问答';
        }
    }


    /**
     * 用户的取消关注动作以及用户再次关注的动作。
     * @param arg document 节点对象
     * @param id 关注对象ID
     */
    function changeAttentionState(userID){
        var text = $.trim($("#isAttention p").text());
        if (text == "已关注"){
            var btnArray = ['是', '否'];
            mui.confirm('确认取消关注？', '提示', btnArray, function(e) {
                if (e.index == 0) {
                    var params = {
                        // "version":$(arg).attr("name"),
                        "userID":userID,
                        // "deleted":false
                    };
                    $("#isAttention").btPost(params,function(){
                        // $(arg).attr("name",parseInt($(arg).attr("name")) + 1);
                        $("#isAttention p").text("关注");
                        $("#isAttention").data("url","/ijob/api/AttentionController/update");
                        $("#isAttention").removeClass("company-content-collection").addClass("un-company-content-collection");
                        $("#isAttention i").removeClass("icon-weibiaoti105").addClass("icon-guanzhu");
                    });
                }
            });
        }else {
            var params = {
                // "version":$(arg).attr("name"),
                "userID":userID,
                // "deleted":true
            };
            $("#isAttention").btPost(params,function(){
                // $(arg).attr("name",parseInt($(arg).attr("name")) + 1);
                $("#isAttention p").text("已关注");
                //$("#isAttention").data("url","/ijob/api/AttentionController/delete");
                $("#isAttention").removeClass("un-company-content-collection").addClass("company-content-collection");
                $("#isAttention i").removeClass("icon-guanzhu").addClass("icon-weibiaoti105");
            });
        }
    }

</script>
</html>
