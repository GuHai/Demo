<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/8
  Time: 10:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>已报名</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/fullTime/fullTime.css?version=4">
</head>
<body>
<div class="full-enlist">
    <div class="list-main-box">
        <div class="info-box">
            <ul>
                <script id="getFullInfo" type="text/html" data-url="/ijob/api/FullTimeController/getFullJobInfoByStatus/{full.jobType}">
                    {{each list as info}}
                        <li class="ul-li">
                            <div class="hd-txt">
                                <div class="name" onclick="ijob.gotoPage({path:'/h5/zp/fullTime/full_talent_details?prb.id={{info.id}}'})">
                                    <span class="call">{{info.recommend.name}}</span>
                                    <span class="sex">{{info.recommend.sex |enums:'SexType'}}</span>
                                    {{if info.recommend.age != null && info.recommend.age !='' && info.recommend.age != 0}}
                                    <span class="age">{{info.recommend.age}}岁</span>
                                    {{/if}}
                                </div>
                                <div class="tel">
                                    <span class="iconfont icon-dianhua"></span>
                                    <a href="tel:{{info.recommend.phoneNumber}}" class="number">{{info.recommend.phoneNumber}}</a>
                                </div>
                            </div>
                            <div class="data-list">
                                <div class="type">{{info.post.title}}</div>
                                <div class="flex">
                                    <span class="name">{{info.post.company.company}}</span>
                                    {{if info.broker!=null}}
                                    <div class="broker">经纪人：{{info.broker.name}}</div>
                                    {{/if}}
                                </div>
                            </div>
                            <form id="{{info.id}}" style="display: none;">
                                <input type="hidden" name="id" value="{{info.id}}">
                                <input type="hidden" name="version" value="{{info.version}}">
                                <input type="hidden" name="recommendID" value="{{info.recommendID}}">
                            </form>
                            <div class="footbox">
                                <a href="javascript:void(0)" class="btns improper" data-url="/ijob/api/FullTimeController/changeWorkerStatus" data-id="{{info.id}}" data-status="9">不合适</a>
                                <a href="javascript:void(0)" class="btns interview" data-url="/ijob/api/FullTimeController/changeWorkerStatus" data-id="{{info.id}}"data-status="2">约面试</a>
                                <a href="javascript:void(0)" class="btns wait" data-url="/ijob/api/FullTimeController/changeWorkerStatus" data-id="{{info.id}}"data-status="3">待入职</a>
                                <a href="javascript:void(0)" class="entry entryTime" id="entry1" data-options='{"type":"date"}'data-url="/ijob/api/FullTimeController/changeWorkerStatus" onclick="entry(this)" data-status="4"data-id="{{info.id}}">已入职</a>
                            </div>
                            <div class="timebox">
                                <span class="entry">入职时间：{{info.entry | dateFormat:'yyyy-MM-dd'}}</span>
                                <span class="quit">离职时间：{{info.quit | dateFormat:'yyyy-MM-dd'}}</span>
                                <input type="hidden" value="{{info.entry | dateFormat:'yyyy-MM-dd'}}">
                                <a href="javascript:void(0)" class="quitbtns" id="quitbtns1" data-options='{"type":"date"}'data-url="/ijob/api/FullTimeController/changeWorkerStatus" onclick="quitJob(this)" data-status="5" data-id="{{info.id}}">已离职</a>
                            </div>
                        </li>
                    {{/each}}
                </script>
            </ul>
        </div>
    </div>
</div>
</body>
</html>
<script>
    $("#getFullInfo").loadData().then(function (result) {
        if(ijob.storage.get("full.jobType")==1){
            document.title = "已报名";
            $(".timebox").remove();
            entry()
        }else if(ijob.storage.get("full.jobType")==2){
            document.title = "待面试";
            $(".footbox .interview").remove();
            $(".timebox").remove();
            entry()
        }else if(ijob.storage.get("full.jobType")==3){
            document.title = "待入职";
            entry()
            $(".footbox .interview,.footbox .wait").remove();
            $(".timebox").remove();
        }else if(ijob.storage.get("full.jobType")==4){
            document.title = "已入职";
            $(".footbox").remove();
            $(".timebox .quit").remove();
        }else if(ijob.storage.get("full.jobType")==5){
            document.title = "已离职";
            $(".footbox").remove();
            $(".timebox .quitbtns").remove();
        }

        $(".btns").click(function () {
            var postRecommendBroker = $("#"+$(this).data("id")).serializeObjectJson();
            postRecommendBroker.status = $(this).data('status');
            changeStatus($(this),postRecommendBroker)
        });
    });

    function changeStatus(arg,postRecommendBroker){
        $(arg).btPost(postRecommendBroker,function (result) {
            if(result.code==501){
                mui.toast(result.msg);
            }else if(result.code==200){
                mui.toast("操作成功,重新载入中...");
                setTimeout(function(){
                    window.location.reload();
                },1000);
            }else{
                mui.toast("网络异常,请刷新重试!");
            }
        })
    }
    function entry(){
        $(".entryTime").each(function (i,item) {
            var jihe = item;
            jihe.addEventListener('tap', function () {
                $(item).unbind("click");
                var optionsJson = this.getAttribute('data-options') || '{}';
                var options = JSON.parse(optionsJson);
                var picker = new mui.DtPicker(options);
                if($(".mui-active").length>0){
                    var aa = $(".mui-active").length;
                    $($(".mui-active")[aa-1]).remove();
                    $($(".mui-backdrop")[aa-1]).remove();
                }
                picker.show(function (rs) {
                    item.value = rs.text;
                    picker.dispose();
                    var postRecommendBroker = $("#"+$(item).data("id")).serializeObjectJson();
                    postRecommendBroker.status = $(item).data('status');
                    postRecommendBroker.entry = rs.text;
                    changeStatus(item,postRecommendBroker);
                });
            }, false);
        })
    }
    function quitJob(){
        $(".quitbtns").each(function (i, item) {
            //已离职
            var jihe = item;
            jihe.addEventListener('tap', function () {
                var optionsJson = this.getAttribute('data-options') || '{}';
                var options = JSON.parse(optionsJson);
                var picker = new mui.DtPicker(options);
                //防止重复弹出时间控件，暂时没想到好办法， 只能用死办法。
                if($(".mui-active").length>0){
                    var aa = $(".mui-active").length;
                    $($(".mui-active")[aa-1]).remove();
                    $($(".mui-backdrop")[aa-1]).remove();
                }
                picker.show(function (rs) {
                    item.value = rs.text;
                    picker.dispose();
                    if(!checkEndTime($(item).siblings("input").val(),rs.text)){
                        return ;
                    }
                    var postRecommendBroker = $("#"+$(item).data("id")).serializeObjectJson();
                    postRecommendBroker.status = $(item).data('status');
                    postRecommendBroker.quit = rs.text;
                    changeStatus($(item),postRecommendBroker);
                });
            }, false);
        })
    }

    /**
     * 判断开始时间是否大于结束时间
     * @param startTime
     * @param endTime
     */
    function checkEndTime(startTime,endTime){
        var startArr = startTime.split("-");
        var endArr = endTime.split("-");
        if(parseInt(startArr[0])>parseInt(endArr[0])){
            mui.alert("入职时间在离职时间之后");
            return false ;
        }else if(parseInt(startArr[0])==parseInt(endArr[0])&&parseInt(startArr[1])>parseInt(endArr[1])){
            mui.alert("入职时间在离职时间之后");
            return false ;
        }else if(parseInt(startArr[0])==parseInt(endArr[0])&&parseInt(startArr[1])==parseInt(endArr[1])&&parseInt(startArr[2])>parseInt(endArr[2])){
            mui.alert("入职时间在离职时间之后");
            return false ;
        }else{
            return true ;
        }
    }


</script>
