<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/5
  Time: 9:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>薪资记录</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/My_part-time/salaryRecord.css">
    <style>
        .btnBox {
            margin-top: 0px;
            margin-bottom: 0px;
        }
    </style>
</head>
<body>
<div class="wrap">
    <div class="head" id="head">
        <span class="head_span" id="selectAll">全选</span>
        <div class="head_div">
            <input type="button" value="联系商家" class="btn_contact">
            <input type="button" value="咨询" class="btn_advisory">
        </div>
    </div>
    <ul class="recordList">
        <script id="todayJob" type="text/html" data-url="/ijob/api/SettlementpersonController/findList" data-type="POST">
            {{each list as settle}}
            <li>
                <div class="checkboxs mui-input-row mui-checkbox mui-left">
                    <label></label>
                    <input name="checkbox1" data-id="{{settle.id}}"  data-state="{{settle.state}}" value="Item 1" type="checkbox">
                </div>
                <div class="list_content"
                     onclick="window.location.href='/ijob/api/SettlementpersonController/settlementpersonDetail/{{settle.id}}'">
                    <div class="divSpan">
                                <span class="content_while">
                                    <span class="content_day">{{settle.createTime | dateFormat:'yyyy年MM月dd日'}}</span>
                                    <em class="content_time">{{settle.createTime | dateFormat:'hh-mm-ss'}}</em>
                                </span>
                        <span class="content_money">{{settle.settlementMoney}}元</span>
                    </div>
                    <div class="divP">
                        <p>工作时间：{{settle | timeRange:'settlementDate' }}</p>
                        <p class="stateText">{{settle.state == true ?'已确认':'未确认'}}</p>
                    </div>
                </div>
            </li>
            {{/each}}
        </script>
    </ul>
    <div class="btnBox">
        <input type="button" class="btn_end" value="结束工作"  data-url="/ijob/api/BeenrecruitedController/overWork">
        <input type="button" class="btn_confirm" value="全部确认" data-url="/ijob/api/SettlementpersonController/confirmAll">
    </div>
</div>
</body>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>
    var positionID = "${positionID}";
    var param = {condition:{"positionID": positionID}};
    $("#todayJob").loadData(param).then(function (result) {
        //点击联系商家
        $(".btn_contact").click(function(){
            //在 session 中拿到电话号码
            window.location.href="tel:"+ijob.storage.get("position.tel");
        });
        //点击联系咨询
        $(".btn_advisory").click(function(){
            //在 session 中拿到用户id
            ijob.gotoPage({path:'/h5/information/chat?chat.toUserID='+ijob.storage.get("position.userID")});
        });

        //全选/取消全选
        $("#selectAll").click(function () {
            if ($(this).text() == "全选") {
                $(this).text('取消');
                $(":checkbox").prop("checked", true);
            } else {
                $(this).text("全选");
                $(":checkbox").prop("checked", false);
            }
        });
        $(document).on("click", ":checkbox", function () {
            if ($(":checkbox").length == $(":checkbox:checked").length) {
                $("#selectAll").text("取消");
            } else {
                $("#selectAll").text("全选");
            }
        });

        $(".btn_confirm").click(function () {
            var appeals = [];
            $(".recordList").find("input[type='checkbox']:checked").each(function(i,item){
                if($(this).parent().next().find(".stateText").text()=="未确认")
                    appeals.push({id:$(this).data("id")});
            });
            if(appeals.length==0){
                mui.toast("请至少选择一项需要确认的工资项");
            }else{
                $(this).btPost(appeals,function(data){
                    ijob.goPreAndRefresh(data.msg);
                });
            }

        });

        $(".btn_end").click(function(){
            var _this = $(this);
            var appeals = [];
            $(".recordList").find("input[type='checkbox']:checked").each(function(i,item){
                if($(this).parent().next().find(".stateText").text()=="未确认")
                    appeals.push({id:$(this).data("id")});
            });
            if(appeals.length>0){
                mui.alert("请先确认薪资");
            }else{
                var btnArray = ['否', '是'];
                mui.confirm('为了求职人员利益，请确认工资都结算完成了才结束工作，工资都已结算？', '退出提示', btnArray, function(e) {
                    if (e.index == 1) {
                        _this.btPost(_this.data("url")+"/"+positionID,function(data){
                            if(data.success){
                                // ijob.goPreAndRefresh(data.msg);
                                ijob.storage.set("been.state",5);
                                ijob.gotoPage({path:'/h5/qz/myjob/job_status'})
                            }else{
                                mui.toast(data.msg);
                            }
                        });
                    }
                })
            }

        });

        $(".wrap").attr("style", function () {
            return "margin-top:" + $("#header").height() + 'px';
        })
    });


</script>
</html>
