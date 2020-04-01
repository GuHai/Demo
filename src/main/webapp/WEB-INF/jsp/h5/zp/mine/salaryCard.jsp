<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>工资卡</title>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/salaryCard.css">
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
                <button onclick="ijob.gotoPage({path:'/h5/qz/mine/bond?bond.payerType=2'})">查看详情</button>
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
        <a href="javascript:void(0)" onclick="isJudge()" id="signUpBnt" data-url="/ijob/api/PersonalauthenController/one">
            <span class="withdrawspan"><i class="iconfont icon-qia"></i>提现</span>
            <span class="iconfont icon-arrow-right"></span>
        </a>
    </div>
    <div class="details">
        <a href="javascript:void(0)" onclick="ijob.gotoPage({path:'/h5/qz/mine/Bills'})">
            <span class="detailsspan"><i class="iconfont icon-mingxi"></i>交易记录</span>
            <span class="iconfont icon-arrow-right"></span>
        </a>
    </div>
</div>
<script>
    $("#todayJob").loadData({}).then(function(result){
        ijob.storage.set("account.money",result.data.list[0].money);
    });

    function isJudge(){
        $("#signUpBnt").btPost(JSON.stringify({condition:{"userID":$("#userID").val()}}),function(data){
            if(data.data != null){
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
            }else{
                var btnArray = ['去认证'];
                mui.confirm('根据相关部门规定，必须实名认证，才能进行下一步操作。', '', btnArray, function(e) {
                    if (e.index == 1) {
                        ijob.gotoPage({path:"/h5/qz/mine/realName"});
                    }
                });
            }
        });

    }
</script>
</body>
</html>
