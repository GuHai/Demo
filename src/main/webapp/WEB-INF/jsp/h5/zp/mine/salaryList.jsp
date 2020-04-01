<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>交易记录</title>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/salaryList.css">
</head>
<body>
<div class="wrap">
    <nav class="nav" style="display: none">
        <ul class="navList clearfix">
          <%--  <li class="">保证金</li>
            <li class="">赔付金</li>--%>
            <li id="salaryPay" class="">工资支付</li>
        </ul>
    </nav>
    <div class="main">
       <%-- <ul class="allList" id="bondPanel">
            <script id="bondList"   type="text/html"  data-url="/ijob/api/BondtransactionController/findPage"  >
                {{each list as bond}}
                    <li>
                        <a href="javascript:void(0);" data-title="{{bond.title}}" data-bid="{{bond.id}}"  data-id="{{bond.positionID}}" onclick="gotoBill(this);">
                            <i class="iconfont icon-weixin"></i>
                            <div class="contenBox">
                                <p class="list-title"  style="width: 300px">{{bond.title}}</p>
                                <p class="list-time" style="width: 200px" >{{bond.updateTime | dateFormat:'yyyy-MM-dd hh:mm:ss'}}</p>
                            </div>
                            <div class="fr money">
                                <p>{{bond.premiumMoney | money}}元</p>
                                <p>{{bond.isReturn==0?'平台托管':'已退回'}}</p>
                            </div>
                        </a>
                    </li>
                {{/each}}
            </script>
        </ul>

        <ul class="allList" id="bondPanel2">
            <script id="bondList2"   type="text/html"  data-url="/ijob/api/BondtransactionController/find2Page"  >
                {{each list as bond}}
                <li>
                    <a href="javascript:void(0);" data-title="{{bond.title}}" data-bid="{{bond.id}}"  data-id="{{bond.positionID}}" onclick="gotoBill2(this);">
                        <i class="iconfont icon-weixin"></i>
                        <div class="contenBox">
                            <p class="list-title"  style="width: 300px">{{bond.title}}</p>
                            <p class="list-time" style="width: 200px" >{{bond.updateTime | dateFormat:'yyyy-MM-dd hh:mm:ss'}}</p>
                        </div>
                        <div class="fr money">
                            <p>{{bond.premiumMoney | money}}元</p>
                            <p>{{bond.isReturn==0?'平台托管':'已赔付'}}</p>
                        </div>
                    </a>
                </li>
                {{/each}}
            </script>
        </ul>
--%>
        <ul class="allList"  id="salaryPanel">
           <script id="salaryList"   type="text/html"  data-url="/ijob/api/SettlementpersonController/zp/settlementList"  >
               {{each list as settle}}
               <li>
                   <a href="javascript:void(0);"  onclick="ijob.gotoPage({path:'/h5/zp/mine/orderDetails?settlePersonGroup.id={{settle.id}}'})">
                       <div class="contenBox">
                           <p class="list-title"  style="width: 300px">发放薪资</p>
                           <p class="list-time" style="width: 200px" >{{settle.createTime | dateFormat:'MM-dd hh:mm:ss'}}</p>
                       </div>
                       <div class="fr money">
                           <p>{{settle.totalMoney | money }}元</p>
                           <p>{{settle.isPay==true?'已付款':'等待付款'}}</p>
                       </div>
                   </a>
               </li>
               {{/each}}
           </script>
       </ul>
        <%--结算记录--%>
        <%--<ul class="withdrawList" style="display: none;">
            <li>
                <a href="javascript:void(0);" onclick="">
                    <div class="pers-list">
                        <div class="duty-man">
                            <div class="Dman-name">
                                <div class="pers-img">
                                    <img src="" title="头像">
                                </div>
                                <div class="pers-name">
                                    <div class="Dnam-tT">
                                        <p class="DT-p1">梁超</p>
                                    </div>
                                    <div class="Dnam-tF">
                                        <p class="Ds-p2">工作完成</p>
                                    </div>
                                </div>
                                <div class="statu">已结算</div>
                            </div>
                        </div>
                    </div>
                    <div class="record">
                        <span class="txt"><i>签到记录：</i><span>5</span>天，共<span>10</span>次</span>
                        <span class="iconfont icon-arrow-right"></span>
                    </div>
                    <div class="accounts">
                        <span class="txt"><i>结算总额：</i><span class="yen">380元</span>，总笔数<span>10</span>笔，已确定<span>10</span>笔</span>
                        <span class="iconfont icon-arrow-right"></span>
                    </div>
                </a>
            </li>
            <li>
                <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/qz/mine/Bills_partyA?id={{SettlementPerson.id}}'})">
                    <div class="pers-list">
                        <div class="duty-man">
                            <div class="Dman-name">
                                <div class="pers-img">
                                    <img src="" title="头像">
                                </div>
                                <div class="pers-name">
                                    <div class="Dnam-tT">
                                        <p class="DT-p1">梁超</p>
                                    </div>
                                    <div class="Dnam-tF">
                                        <p class="Ds-p2">工作完成</p>
                                    </div>
                                </div>
                                <div class="statu">已结算</div>
                            </div>
                        </div>
                    </div>
                    <div class="record">
                        <span class="txt"><i>签到记录：</i><span>5</span>天，共<span>10</span>次</span>
                        <span class="iconfont icon-arrow-right"></span>
                    </div>
                    <div class="accounts">
                        <span class="txt"><i>结算总额：</i><span class="yen">380元</span>，总笔数<span>10</span>笔，已确定<span>10</span>笔</span>
                        <span class="iconfont icon-arrow-right"></span>
                    </div>
                </a>
            </li>
        </ul>--%>
    </div>
    <div id="homepage"></div>
</div>
</body>
</html>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});
    (function ($) {
        window.addEventListener('pageshow', function (e) {
            // 通过persisted属性判断是否存在 BF Cache
            if (e.persisted) {
                location.reload();
            }
        });
    })(mui);

    var menu = ijob.menu.get();
    //先获取条件，然后查询
    var signtype = ijob.storage.get("signtype")||"all";
    /*$("#todayJob").loadData({condition:{signtype:signtype,payerType:2}}).then(function(result){
        if (result.data.list == 0){
            $(".main").html("<p style='text-align: center;margin-top:5rem;'>您还没有交易记录哦！ </p>");
        }
    });
*/

    $(".nav>.navList>li").on("click", function () {
        var i = $(this).index();
        $(this).addClass("active").siblings().removeClass("active")
        $(".main>ul").eq(i).show().siblings().hide();
        menu = "personal:account:"+i;
        ijob.menu.set(menu);
        var title = $(".navList li[class='active']").text();
        if(title=="保证金"){
            loadBondList();
        }else if(title=="赔付金"){
            loadBond2List();
        }else {
            loadSalaryList();
        }

    });

    function clickHandler(){
        if(menu.indexOf(":")!=-1){
            $(".nav>.navList>li").eq(menu.split(":")[2]).click();
        }else{
            $(".nav>.navList>li").eq(0).click();
        }
    }


    function loadBondList(){

        var page  = {"pageSize": "15", "currentPage": "1"};
        var ijobRefresh = new IJobRefresh({
            container: '#bondPanel',
            up: function() {
                var obj = $.extend(page,{condition:{
                        payerType:2
                    }});

                $("#bondList").appendData(obj,ijobRefresh).then(function(result){
                    page.currentPage =  result.nextPage;
                });
            }
        });


       /* $("#bondList").loadData({condition:{payerType:2}}).then(function(result){
            if (result.data.list == 0){
                $(".main").html("<p style='text-align: center;margin-top:5rem;'>您还没有交易记录哦！ </p>");
            }
        });*/
    }

    function loadBond2List(){

        var page  = {"pageSize": "15", "currentPage": "1"};
        var ijobRefresh = new IJobRefresh({
            container: '#bondPanel2',
            up: function() {
                var obj = $.extend(page,{condition:{
                        payerType:1
                    }});

                $("#bondList2").appendData(obj,ijobRefresh).then(function(result){
                    page.currentPage =  result.nextPage;
                });
            }
        });
    }


    function loadSalaryList(){
      /*  var page  = {"pageSize": "15", "currentPage": "1"};
        var ijobRefresh = new IJobRefresh({
            container: '#salaryPanel',
            up: function() {
                var obj = $.extend(page,{condition:{
                        signtype:signtype
                    }});

                _this.appendData(obj,ijobRefresh).then(function(result){
                    page.currentPage =  result.nextPage;
                });
            }
        });*/


        $("#salaryList").loadData({condition:{signtype:signtype}}).then(function(result){
            if (result.data.list == 0){
                $("#salaryList").after("<p style='text-align: center;margin-top:5rem;'>您还没有交易记录哦！ </p>");
                $(".nodata").remove();
            }
        });
    }

    if(signtype == 'false'){
        $(".nav>.navList").children("li:last-child").click();
    }else{
        clickHandler();
    }

    function gotoBill(item){
        ijob.storage.set("bill",{bondtype:1,title:$(item).data("title"),positionID:$(item).data("id"),id:$(item).data("bid")});
        ijob.gotoPage({path:'/h5/qz/mine/bill_detail'});
    }

    function gotoBill2(item){
        ijob.storage.set("bill",{bondtype:2,title:$(item).data("title"),positionID:$(item).data("id"),id:$(item).data("bid")});
        ijob.gotoPage({path:'/h5/qz/mine/bill_detail'});
    }



</script>