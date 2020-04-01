<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/17
  Time: 11:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>提现</title>
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/static/css/part/myjob.css">
    <link rel="stylesheet" href="/ijob/static/css/mine/Bills.css">
    <jsp:include page="qz/base/resource.jsp"/>
    <style>
        li, ul {
            list-style: none;
            margin-bottom: 0;
        }
        body{background-color: #f2f5f7;}
        #detail {
            width: 90%;
            background-color: #108ee9;
            color: #fff;
            border-radius: 1rem;
            border: 0;
            height: 1.067rem;
            font-size: 0.4rem;
            margin: 0 0.453rem;
            margin-top:10px;
        }
    </style>
</head>
<body>
<div class="wrap">
    <div class="main page_withdraw">
        <div class="wd_list">
            <label>校&nbsp;&nbsp;验&nbsp;&nbsp;码：</label>
            <span>${txTask.code}</span>
        </div>
        <div class="wd_list">
            <label>金　　额：</label>
            <span>${txTask.money}元</span>
        </div>
        <div class="wd_list">
            <label>手机号码：</label>
            <span>${txTask.phone}</span>
        </div>
        <div class="wd_list">
            <label>昵　　称：</label>
            <span>${txTask.name}</span>
        </div>
        <div class="wd_list password">
            <label>密　　码：</label>
            <input  type="password"  id="password" placeholder="请输入密码" >
        </div>
        <div class="btns">
            <button id="ratification" data-url="/ijob/api/AccountController/ratification"  >确定</button>
            <button id="detail" onclick="loadData()">查看收支详情</button>
        </div>
    </div>



    <main class="main" style="display: none">
        <div class="main page_withdraw" >
            <div class="wd_list">
                <label>收入</label>
                <span id="in" style="color:  #119824;">0元</span>
                <label>支出</label>
                <span id="out" style="color:  #ff3b30;">0元</span>
            </div>
        </div>
        <ul class="allList" style="margin-top: 10px">
            <script id="MyBills"   type="text/html"  data-url="/ijob/api/AccountController/findPageById"  >
                {{each list as account }}
                <li>
                    <a href="javascript:void(0);" data-type="{{account.btype}}" data-order="{{account.orderNo}}" onclick="gotoBill(this);">
                        <i class="iconfont icon-weixin"></i>
                        <div class="contenBox">
                            <p class="list-title"  style="width: 300px;font-weight: bold">{{account.btype | enums:'AccountType' }}</p>
                            <p class="list-time" style="width: 200px" >{{account.time | dateFormat:'yyyy-MM-dd hh:mm:ss'}}</p>
                        </div>
                        <div class="fr money">
                            <p>{{account.isin==0?(account.btype=='9'?'-':''):(account.isin==-1?'-':'+')}}{{account.money | money}}</p>
                            <p>{{account | billStatus}}</p>
                        </div>
                    </a>
                </li>
                {{/each}}
            </script>
        </ul>
    </main>
</div>
<script>

    var billobj = {condition:{txTaskId:'${txTask.id}'}};
    function loadData(){
        $(".main").css("display","block");
        $("#detail").css("display","none");
        $("#MyBills").loadData(billobj).then(function (result) {
            var income  =0;
            var expenditure = 0;
            $.each(result.data.list,function (i,item){
                if(item.isin==1){
                    income+= item.money;
                }else{
                    if(item.status==1){
                        expenditure += item.money;
                    }
                }
            });
            income  = Math.round(income*100)/100;
            expenditure = Math.round(expenditure*100)/100;
            $("#in").text(income+"元");
            $("#out").text(expenditure+"元");
        });

    }



    var obj={
        code:'${txTask.code}',
        id:'${txTask.id}',
        version:'${txTask.version}'
    }
    $("#ratification").click(function(){
        if($("#password").val()){
            obj.password=$("#password").val();
            $(this).btPost(obj,function(result){
                if(result.success==true){

                }else{
                    mui.alert(result.msg);
                }
            });
        }else{
            mui.alert("请输入提现密码");
        }
    });

</script>
</body>
</html>
