<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/9
  Time: 15:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>账单</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/Bills.css">
</head>
<body>
<div class="wrap">
    <main class="main">
        <ul class="allList">
            <script id="mybond"   type="text/html"  data-url="/ijob/api/BondtransactionController/findPage">
                {{each list as bond}}
                <li>
                    <a href="javascript:void(0);" data-title="{{bond.title}}" data-id="{{bond.positionID}}" onclick="gotoBill(this);">
                        <%--<i class="iconfont icon-weixin"></i>--%>
                        <i class="iconfont  icon-baozhengjin"></i>
                        <div class="contenBox">
                            <p class="list-title"  style="width: 300px">{{bond.title}}</p>
                            <p class="list-time" style="width: 200px" >{{bond.createTime | dateFormat:'yyyy-MM-dd hh:mm:ss'}}</p>
                        </div>
                        <div class="fr money">
                            <p>{{bond.premiumMoney | money}}元</p>
                            <p>{{bond.isReturn==0?'平台托管':(bond.type==6?'已赔付':'已退回')}}</p>
                        </div>
                    </a>
                </li>
                {{/each}}
            </script>
        </ul>
    </main>
</div>
</body>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>
    /*$("#mybond").loadData({condition:{
            payerType:ijob.storage.get("bond.payerType")
        }}).then(function(result){

    });*/
    var _this  = $("#mybond");
    var page  = {"pageSize": "15", "currentPage": "1"};
    var ijobRefresh = new IJobRefresh({
        container: '.allList',
        up: function() {
            var obj = $.extend(page,{condition:{
                    payerType:ijob.storage.get("bond.payerType")
                }});

            _this.appendData(obj,ijobRefresh).then(function(result){
                page.currentPage =  result.nextPage;
            });
        }
    });


    function gotoBill(item){
        ijob.storage.set("bill",{title:$(item).data("title"),positionID:$(item).data("id")});
        ijob.gotoPage({path:'/h5/qz/mine/bill_detail'});
    }
</script>
</html>
