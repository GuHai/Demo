<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/2/13
  Time: 10:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>首页</title>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <style>
        .wrap {
            min-width: 8.533rem;
            max-width: 20.48rem;
            margin: 0 auto;
            overflow: hidden;
            position: relative;
        }
        .top{
            width: 9.1rem;
            height: 4.2rem;
            margin: 0.45rem 0.4rem;
            background-color: #f2f2f2;
            background: -webkit-linear-gradient(left,#f7a219,#ef5523);
            border-radius:10px
        }
        .infoAndRealName{
            width: 100%;
            height: 0.93rem;
        }
        .info{
            margin-left: 10px;
            margin-top: 10px;
        }
        .imgBox{
            float: left;
            width: 0.66rem;
            height: 0.66rem;
            border-radius: 100%;
            margin-top: 10px;
        }
        .headImage{
            width: 100%;
            height: 100%;
            border-radius: 50%;
        }
        .name{
            font-size: 0.37rem;
            font-weight: 500;
            color: #fff;
            margin-left: 5px;
        }
        .iconfont {
             font-family: "iconfont" !important;
             font-size: 15px;
             font-style: normal;
             -webkit-font-smoothing: antialiased;
             -moz-osx-font-smoothing: grayscale;
            color: white;
         }
        .typeDiv{
            margin-right: 0px;
            display:inline;
            float: right;
            margin-right: 5px;
        }
        .typeFont{
            font-size: 15px;
            font-weight: 500;
            color: #fff;
            margin-left: 5px;
        }
        .txt {
            font-size: 0.32rem;
            font-weight: normal;
            font-stretch: normal;
            letter-spacing: 0px;
            padding-top: 0.267rem;
            color: #ffffff;
            line-height: 1;
        }
        .over-withdraw {
            font-size: 0.53rem;
            font-weight: normal;
            font-stretch: normal;
            text-align: center;
            letter-spacing: 0px;
            color: #ffffff;
            margin-top: 0.26rem;
        }
        .money{
            text-align: center;
            margin-top: 0.6rem;
        }
        .updatePay{
            float: right;
            padding-right: 10px;
            margin-top: 0.53rem;
        }
        .updatePayFont{
            font-size: 14px;
            color: white;
        }
        .content{
            width: 100%;
            height: 3.66rem;
            background-color: white;
        }
        .left{
            float:left;
            text-align: center;
            width: 50%;
            height: 100%;
            padding-top: 1.466rem;
            font-size: 13px;
            border-right:solid 1px #EFEFF4 ;
        }
        .right{
            float: right;
            text-align: center;
            width: 50%;
            padding-top: 1.466rem;
            height: 100%;
            font-size: 13px;
        }
    </style>
</head>
<body>
<div class="wrap">
    <div class="top">
        <div class="infoAndRealName">
            <div class="info">
                <div class="imgBox">
                    <img src="/ijob/static/images/default.jpg" class="headImage"/>
                </div>
                <div style="padding-top: 10px">
                    <span class="name" id="username"></span>
                    <div class="typeDiv">
                        <i class="iconfont icon-renzheng"></i><span class="typeFont" id="usermsg"></span>
                    </div>
                </div>
            </div>
            <div>
            </div>
        </div>
        <div class="money" onclick="ijob.gotoPage({path:'/h5/salaryCard'})">
            <p class="txt">
                <em>工资卡余额</em>
            </p>
            <div class="over-withdraw"><b>￥</b>
                <script id="mymoney"   type="text/html"  data-url="/ijob/api/AccountController/getTotalSalary"  >
                    {{each list as account}}
                    {{account.money | money}}
                    {{/each}}
                </script>
            </div>
        </div>
        <div class="updatePay">
            <span class="updatePayFont" onclick="ijob.gotoPage({url:'/ijob/api/InformationController/h5/mine/mySettings_changePassword'})">修改支付密码</span><i class="iconfont icon-arrow-right"></i>
        </div>
    </div>
    <div class="content" style="height: 7.32rem;">
        <div class="left" style="height: 50%!important; border-bottom: solid 1px #EFEFF4;" onclick="ijob.gotoPage({path:'/h5/zp/paysalary/getSalaryInfo'})">
            <div style="margin-bottom: 5px">
                <i class="iconfont icon-gongzi2" style="color: #15bc83;font-size: 1.173rem"></i>
            </div>
            <span>领工资</span>
        </div>
        <div class="right"  style="height: 50%!important; border-bottom: solid 1px #EFEFF4;" onclick="ijob.gotoPage({path:'/h5/zp/paysalary/paySalaryInfo'})">
            <div style="margin-bottom: 5px">
                <i class="iconfont icon-gongzi2" style="color: #f87f26;font-size: 1.173rem"></i>
            </div>
            <span>发工资</span>
        </div>
        <div class="left" style="height: 50%!important;" onclick="ijob.gotoPage({path:'/h5/zp/paysalary/guanyu'})">
            <div style="margin-bottom: 5px">
                <i class="iconfont icon-guanyu" style="color: #108ee9;font-size: 1.173rem"></i>
            </div>
            <span>关于</span>
        </div>
        <div class="right"  style="height: 50%!important;" onclick="window.location.href='http://www.jianzhipt.com/ins'">
            <div style="margin-bottom: 5px">
                <i class="iconfont icon-baoxian1" style="color: #f87f26;font-size: 1.173rem"></i>
            </div>
            <span>保险</span>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $.getJSON("/ijob/api/PersonalauthenController/getPersonInfo",function (result) {
            $("#username").text(result.data.realName);
            $(".imgBox").html("<img src=\'/upload/"+result.data.userimg+"\'  onerror=\"this.src='"+result.data.weixinimg+"';this.onerror=null\" class=\'headImage\'/>");
            $("#usermsg").text(result.msg);
        })
        $("#mymoney").loadData({});
        ijob.storage.set("homepageType",1);
    });

</script>
</body>
</html>
