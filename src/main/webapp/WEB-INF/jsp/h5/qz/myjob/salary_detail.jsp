<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/5
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>薪资详情</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/My_part-time/salaryRecord_detail.css">
</head>
<body>
<div class="wrap">
    <script id="todayJob"   type="text/html"  data-url="/ijob/api/SettlementpersonController/getSalaryDetail/${id}"   data-type="GET" >
        {{each list as settle}}
            <div class="headBox">
                <div class="headBox_top">
                    <span class="headBox_topSpan">薪资</span>
                    <div class="headBox_topDiv">
                        <input type="button" value="联系商家" class="btn_contact">
                        <input type="button" value="咨询" class="btn_advisory" >
                    </div>
                </div>
                <div class="headBox_btm">
                    <p class="nubP">{{settle.settlementMoney}}</p>
                    <p class="msgP">{{settle.state | enums:'confirmationStatus'}}</p>
                </div>
            </div>
            <div class="main">
                <div class="orderNumber">
                    <span>订单号</span>
                    <span>{{settle.settlement | ifNull:'无订单号','thirdOrderNumber'}}</span>
                </div>
                <div class="jsTime">
                    <span>结算时间</span>
                    <span>{{settle.createTime | dateFormat:'yyyy年MM月dd日'}}<em>{{settle.createTime | dateFormat:'hh-mm-ss'}}</em></span>
                </div>
                <div class="jsDate">
                    结算日期
                    <p id="settleDate">2017年12月24日、2017年12月25日、2017年12月26日
                        2017年12月27日、2017年12月27日</p>
                </div>
                <div class="remarks">
                    备注
                    <p>{{settle.settlement | ifNull:'无备注','remarks'}}</p>
                </div>
            </div>
            <div class="btnBox">
                <input type="button" class="btn_end" value="结束工作">
                <input type="button" class="btn_confirm" value="确认薪资" data-url="/ijob/api/SettlementpersonController/confirm">
            </div>
        {{/each}}
    </script>
</div>
</body>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>
    $("#todayJob").loadData().then(
        function(result){
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


            var  timestr = result.data.list[0].settlementDate;
            var  timearr =  ijob.getDateList(timestr);
            $("#settleDate").html(timearr.toString());

            $(".btn_confirm").click(function(){
                $(this).btPost(JSON.stringify({
                    'id':result.data.list[0].id,
                    'state':true,
                    'version':result.data.list[0].version
                }));
            });
        }
    );


</script>
</html>
