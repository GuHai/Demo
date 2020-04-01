<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>工资卡</title>
    <jsp:include page="qz/base/resource.jsp"/>
    <jsp:include page="qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/salaryCard.css?version=4">
</head>
<body>
<div class="wrap">
    <div class="over_blue">

        <script id="todayJob"   type="text/html"  data-url="/ijob/api/AccountController/getTotalSalary"  >
            {{each list as account}}
            <p class="txt">
                <em>余额(税后)</em>
                <%--没有充值数据链接--%>
                <%--<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/pay_code'})"><span class="iconfont icon-query"></span></a>--%>
                <%--有充值数据链接--%>
                <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/qz/mine/Bills?data.billobj.btntype=tax'})"><span class="iconfont icon-query"></span></a>
            </p>
            <div class="over-withdraw">{{account.money | money}}元</div>
            <div class="margin "><%--改成当月个税删除paststyle类名--%>
               <%-- <span>已交信用保证金{{account.bond | money}}元</span>
                <button onclick="ijob.gotoPage({path:'/h5/qz/mine/bond?bond.payerType=2'})">查看详情</button>--%>
                <ul class="flex">
                    <li><span class="title" onclick="ijob.gotoPage({path:'/h5/qz/mine/Bills?data.billobj.btntype=bond'})">待退保证金</span><span class="num">{{account.bond | money}}</span></li>
                    <li><span class="title" onclick="ijob.gotoPage({path:'/h5/qz/mine/Bills?data.billobj.btntype=salary'})">工资和奖励收入</span><span class="num">{{account.salary | money}}</span></li>
                    <li><span class="title" id="recharge">充值金额</span><span class="num">{{account.recharge | money}}</span></li>
                </ul>
            </div>
            {{/each}}
        </script>
    </div>
    <div class="popular">
        <ul id="hot">
        </ul>
    </div>
   <div class="withdraw b-border">
        <a href="javascript:void(0)" onclick="ijob.gotoPage({path:'/h5/qz/mine/recharge'})">
            <span class="withdrawspan"><i class="iconfont icon-chongzhi"></i>充值</span>
            <span class="iconfont icon-arrow-right"></span>
        </a>
    </div>
    <div class="withdraw">
        <a href="javascript:void(0)" onclick="isJudge()" id="signUpBnt" data-url="/ijob/api/PersonalauthenController/qz/checkFinalVerification">
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
   <%-- <div class="details">
        <a href="javascript:void(0)" onclick="ijob.gotoPage({path:'/h5/invoiceIndex'})">
            <span class="detailsspan"><i class="iconfont icon-fapiao1"></i>开具发票</span>
            <span class="iconfont icon-arrow-right"></span>
        </a>
    </div>
    <div class="details b-border">
        <a href="javascript:void(0)" onclick="ijob.gotoPage({path:'/h5/qz/mine/Bills'})">
            <span class="detailsspan"><i class="iconfont icon-fapiao"></i>开票历史</span>
            <span class="iconfont icon-arrow-right"></span>
        </a>
    </div>--%>
</div>
<script>
    ijob.storage.remove("billobj");
    var isPageHide = false;
    window.addEventListener('pageshow', function () {
        if (isPageHide) {
            window.location.reload();
        }
    });
    window.addEventListener('pagehide', function () {
        isPageHide = true;
    });

    $("#todayJob").loadData({}).then(function(result){
        var account  =result.data.list[0];
        ijob.storage.set("account.money",Math.floor(100*(account.money-account.recharge+0.0001))/100);
        ijob.storage.set("account.recharge",account.recharge);
        $("#recharge").click(function () {
            if(account.recharge==null||account.recharge==0){
                ijob.gotoPage({path:'/h5/pay_code_transfer?zhuanzhang.type=1'});
            }else{
                ijob.gotoPage({path:'/h5/rechargeSalary'});
            }

        });


        $.getJSON("/ijob/api/PersonalauthenController/qz/checkFinalVerification",function(result){//校验是否实名
            if(result.code!=200){
                var btnArray = ['去认证'];
                mui.confirm('根据相关部门规定，必须实名认证，才能进行下一步操作。', '', btnArray, function(e) {
                    if (e.index == 0) {
                        ijob.storage.set("personal.toreal",true);
                        ijob.gotoPage({path:"/h5/qz/index/personalInform"});
                    }
                });
            }
        });


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
</body>
</html>
