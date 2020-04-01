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
    <title>我的全职</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/My_part-time/my_full_time_job.css?version=4">

</head>
<body>
<div class="wrap">
    <div class="full-time-job">
        <div class="hd-list-box">
            <div class="box-list">
                <ul>
                    <li class="head-li current">已投递</li>
                    <li class="head-li">待面试</li>
                    <li class="head-li">感兴趣</li>
                </ul>
            </div>
        </div>
        <div class="full-job-list">
            <%--已投递--%>
            <div class="mainbox delivered">
                <ul id="allList">
                    <script id="jobtemplate" type="text/html" data-url="/ijob/api/FullTimeController/deliveredResumePage">
                        {{each list as post}}
                            <li class="ul-li" onclick="ijob.gotoPage({path:'/h5/qz/myjob/full_time_detail?full.id={{post.post.id}}'})">
                                <div class="title">
                                    <span class="txt">{{post.post.title}}</span>
                                    {{if post.post.status==false && post.status == 1}}
                                    <span class="money">停止招聘</span>
                                    {{else}}
                                    <span class="money">{{post.status |enums:'FullWorkType'}}</span>
                                    {{/if}}
                                </div>
                                <div class="name">{{post.post.company.company}}·{{post.post.workPlace.city.cityName}}</div>
                                <div class="tag-list">
                                    <div class="welfaretag taglist">
                                        {{if post.post.benefitsLabel!=null&&post.post.benefitsLabel!=""}}
                                            <span>福利</span>
                                            {{#post.post.benefitsLabel |toLabel}}
                                        {{/if}}
                                    </div>
                                    <div class="requiretag taglist">
                                        <span>工作</span>
                                        <span>{{post.post.minAge}}-{{post.post.maxAge}}岁</span>
                                        {{#post.post.workLabel |toLabel}}
                                    </div>
                                </div>
                                <div class="time">投递于：{{post.createTime |dateFormat:'yyyy-MM-dd hh:mm'}}</div>
                            </li>
                        {{/each}}
                    </script>
                </ul>
            </div>
            <%--已投递 end--%>
        </div>
    </div>
</div>
</body>
<script>
    $(function () {
        // tab切换
        $(".box-list .head-li").click(function () {
            var nub = $(this).index();
            ijob.menu.set("personal:full:"+nub);
            $(this).addClass("current").siblings('.head-li').removeClass("current");
            loadFullPostJob(nub);
            $(".full-job-list>div").eq(nub).show().siblings().hide();
        });
        var menu = ijob.menu.get("personal");
        if(menu && menu.split(":").length==3){
            $(".box-list .head-li").eq(menu.split(":")[2]).click();
        }else{
            $(".box-list .head-li").eq(0).click();
        }
    });

    function loadFullPostJob(index){
        var page  = {"pageSize": "10", "currentPage": "1"};
        if(index==0){
            page.condition={
                status:null
            }
        }else if(index==1){
            page.condition={
                status:2
            }
        }else if(index==2){
            page.condition={
                isLike:true
            }
        }
        var ijobRefresh = new IJobRefresh({
            container: '#allList',
            up: function () {
                $("#jobtemplate").appendData(page, ijobRefresh).then(function (result) {
                    console.log(result)
                    /*if(result.code==501){
                        /!*实名认证*!/
                        var btnArray = ['否','是'];
                        mui.confirm('根据相关部门规定，必须实名认证，才能进行下一步操作。', '提示', btnArray, function(e) {
                            if (e.index == 1) {
                                ijob.gotoPage({path:"/h5/qz/mine/realName"});
                            }
                        });
                    }else*/
                    if(index==2){
                        $(".time").hide();
                        var arr = $(".money");
                        for(var a = 0 ; a < result.data.list.length ;a++){
                            $(arr[a]).text(result.data.list[a].post.minSalary+"-"+result.data.list[a].post.maxSalary+"元/月");
                            if(result.data.list[a].post.minSalary==result.data.list[a].post.maxSalary&&result.data.list[a].post.maxSalary==0){
                                $(arr[a]).text("面议");
                            }
                        }

                    }
                    page.currentPage = result.nextPage;
                    if(result.code==502){
                        mui.toast(result.msg);
                    }
                    $(".tag-list span").each(function () {
                        if ($(this).text() == '福利'){
                            $(this).addClass("curr1");
                        }else if ($(this).text() == '工作'){
                            $(this).addClass("curr2");
                        }else if ($(this).text().length >= 4){
                            $(this).css("width","1.653rem")
                        }
                    });

                    $(".noMore").parent().css("padding-top","25%");

                });
            }
        });

        $("#loadimg").parent().css("padding-top","25%");
    }
</script>
</html>
