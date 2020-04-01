<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>工资卡</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/salaryCard.css?version=4">
</head>
<body>
<div class="wrap">
    <div class="over_blue">
        <p>可提现金额
            <%--(税后)--%>
        </p>
        <script id="todayJob"   type="text/html"  data-url="/ijob/api/AccountController/getTotalSalary"  >
            {{each list as account}}
                <div class="over-withdraw">{{account.money | money}}元</div>
                <div class="margin">
                    <span>已交信用保证金{{account.bond | money}}元</span>
                    <button onclick="ijob.gotoPage({path:'/h5/qz/mine/bond?bond.payerType=1'})">查看详情</button>
                    <%--<ul class="flex">
                        <li><span class="title">保证金</span><span class="num">58</span></li>
                        <li><span class="title">工资和奖励收入</span><span class="num">1023</span></li>
                        <li><span class="title">当月个税</span><span class="num">12.31</span></li>
                    </ul>--%>
                </div>
            {{/each}}
        </script>
    </div>
    <div class="popular">
        <ul id="hot">
        </ul>
    </div>
    <div class="withdraw">
        <a href="javascript:void(0)" onclick="isJudge()">
            <span class="withdrawspan"><i class="iconfont icon-qia"></i>提现</span>
            <span class="iconfont icon-arrow-right"></span>
        </a>
    </div>
    <%--<div class="details">
        <a href="javascript:void(0)" onclick="ijob.gotoPage({path:'/h5/qz/mine/redEnvelopes'})">
            <span class="detailsspan"><i class="iconfont icon-entireEredWrap" style="color: #FF3B30;"></i>红包</span>
            <span class="num"><em>0</em>&nbsp;<span class="iconfont icon-arrow-right"></span></span>
        </a>
    </div>--%>
    <div class="details">
         <a href="javascript:void(0)" onclick="ijob.gotoPage({path:'/h5/qz/mine/Bills'})">
            <span class="detailsspan"><i class="iconfont icon-mingxi"></i>明细</span>
            <span class="iconfont icon-arrow-right"></span>
        </a>
    </div>
</div>
</body>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>
    $("#todayJob").loadData({}).then(function(result){
        ijob.storage.set("account.money",result.data.list[0].money);
        //红包数量渲染
        $(".num em").text(result.data.list[0].redPacketCount);
    });

    function isJudge(){
        $.ajax({
            url:"/ijob/api/InformationController/h5/mine/getInfoPass",
            type:"POST",
            dataType:"json",
            data: null,
            contentType:"application/json; charset=utf-8",
            success: function (result) {
                var password=result.data.list[0].payPassword;
                if(password==null || password==""){
                    ijob.gotoPage({path:'h5/qz/mine/mySettings_changePassword1'})
                }else{
                    ijob.gotoPage({path:'/h5/qz/mine/salaryCard_withdraw'});
                }
            }
        });
    }
</script>
</html>