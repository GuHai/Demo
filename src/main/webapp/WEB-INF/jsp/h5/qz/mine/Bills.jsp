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
    <nav class="nav">
        <a href="javascript:void(0);" class="filterbtns">筛选<span class="iconfont icon-arrow-down1"></span></a>
        <div class="filterList">
            <div class="popup-backdrop">
                <h3>快捷筛选</h3>
                <ul class="list filter-list-msg">
                    <li data-type="2,4,02,14,05" id="salary">工资</li>
                    <li data-type="1,3,6,7,01"  id="bond">保证金</li>
                    <li data-type="06" id="weiyue">违约金</li>
                    <li data-type="04,11,12" id="redPacket">红包</li>
                    <li data-type="5,9">提现</li>
                    <li data-type="8,03" id="partner">合伙人</li>
                    <li data-type="10" id="forward">提成</li>
                    <li data-type="13"  id="tax">个税</li>
                    <li data-type="29">充值</li>
                    <li data-type="17,18">结算给自己</li>
                    <li data-type="19,30">转账</li>
                </ul>
                <div class="btns">
                    <a  href="javascript:void(0);" class="reset" id="reset">重置</a>
                    <a  href="javascript:void(0);" class="confirm">确认</a>
                </div>
            </div>
        </div>
    </nav>

    <main class="main marTop">
        <ul class="allList">
            <script id="MyBills"   type="text/html"  data-url="/ijob/api/AccountController/findPage"  >
                {{each list as account }}
                <li>
                    <a href="javascript:void(0);" data-virtual="{{account.virtual}}" data-type="{{account.btype}}" data-money="{{account.money}}" data-datetime="{{account.time}}" data-mark="{{account.mark}}" data-order="{{account.orderNo}}" onclick="gotoBill(this);">
                        <%--邮费--%>
                        <%--<i class="iconfont icon-shunfeng1"></i>--%>
                        <%--充值--%>
                        <%--<i class="iconfont icon-chongzhi1"></i>--%>
                        <%--扫描二维码的工资--%>
                        <%--<i class="iconfont icon-gongzi2"></i>--%>
                        <%--提成--%>
                        <%--<i class="iconfont icon-ticheng"></i>--%>
                        <%--保证金--%>
                        <%--<i class="iconfont icon-baozhengjin"></i>--%>
                        <%--红包--%>
                        <%--<i class="iconfont icon-hongbao"></i>--%>
                        <%--工资--%>
                        <%--<i class="iconfont icon-gongzi"></i>--%>
                        <%--合伙人 {{if account.btype==16}}（{{account.orderNo | getTypeByCode }}）--%>
                        <%--<i class="iconfont icon-zhaoshanghezuo"></i>--%>
                        <%--提现--%>
                        <i class="iconfont  {{account.btype | enums:'BillIconType'}}"></i>
                        <div class="contenBox">
                            <p class="list-title"  style="width: 300px;font-weight: bold">{{account.btype | enums:'AccountType' }}</p>
                            <p class="list-time" style="width: 200px" >{{account.time | dateFormat:'yyyy-MM-dd hh:mm:ss'}}</p>
                        </div>
                        <div class="fr money">
                            <p>{{account.isin}}{{account.money | money}}</p>
                            <p>{{account | billStatus}}</p>
                        </div>
                    </a>
                </li>
                {{/each}}
            </script>
        </ul>
    </main>
    <div id="homepage"></div>
</div>
</body>
</html>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});
    var slide;
    var menu = ijob.menu.get();
    var billobj = ijob.storage.get("billobj")|| {condition:{}};
    $(".filter-list-msg").removeClass("curr");
    if('redpacket'===billobj.btntype){
        $("#redPacket").addClass("curr");
    }
    else if('bond'==billobj.btntype){
        $("#bond").addClass("curr");
        billobj={
            condition:{
                btype:"'01'",
                status:4
            }
        };
    }
    else if('tax'==billobj.btntype){
        $("#tax").addClass("curr");
        billobj={
            condition:{
                btype:"'13'"
            }
        };
    }else if('salary'==billobj.btntype){
        billobj={
            condition:{
                btype:"'2','8','10','11','14'"
            }
        };
    }

    function loadData(){
        var page = {"pageSize": "15", "currentPage": "1"};
        var ijobRefresh = new IJobRefresh({
            container: '.allList',
            up: function () {
                var obj = $.extend(page, billobj);
                $("#MyBills").appendData(obj, ijobRefresh).then(function (result) {
                    page.currentPage = result.nextPage;
                });
            }
        });
    }
    loadData();
    // 筛选
    $(".filterbtns").on("click",function () {
        $(".nav .filterbtns").toggleClass("current");
        $(".nav .filterbtns>span").toggleClass("icon-arrow-down1");
        $(".nav .filterbtns>span").toggleClass("icon-arrow-up");
        $(this).parent().siblings().find(".filterList").hide();
        $(".filterList").toggle();
        slide = new Slide($(".wrap"),$(".filterList"),".popup-backdrop");
        slide.disTouch();

    });
    // 选择筛选选项
    $(".filter-list-msg > li").click(function(){
        var arr = $(".filter-list-msg > li");
        for (var i = 0 ; i < arr.length ; i++){
            if(arr[i] != this){
                $(arr[i]).removeClass("curr");
            }
        }
        if(!$(this).hasClass("curr")){
            $(this).addClass("curr")
        }else{
            $(this).removeClass("curr");
        }
    });
    // 点击空白处隐藏选项
    $("body>*").on('click', function (e) {
        if ($(e.target).hasClass('filterList')) {
            $(".filterList").hide();
            slide.ableTouch();
            $(".nav .filterbtns").removeClass("current");
            $(".nav .filterbtns>span").removeClass("icon-arrow-up");
            $(".nav .filterbtns>span").addClass("icon-arrow-down1");
        }
    });
    // 重置
    $("#reset").on("click",function () {
        $(".filter-list-msg > li").removeClass("curr");
    })

    $(".confirm").on("click",function(){
        var type  = $(".filter-list-msg li[class='curr']").data("type")+"";
        billobj.condition.virtual = null;
        billobj.condition.status = null;
        if(type && type!=undefined &&type.trim(" ")!=''&&type!='undefined')
            billobj.condition.btype="'"+type.replace(/,/g,"','")+"'";
        else
            billobj.condition = {};
        /*if($(".filter-list-msg li[class='curr']").attr("id")==="bond" || $(".filter-list-msg li[class='curr']").attr("id")==="salary" || $(".filter-list-msg li[class='curr']").attr("id")==="weiyue"|| $(".filter-list-msg li[class='curr']").attr("id")==="redPacket"|| $(".filter-list-msg li[class='curr']").attr("id")==="forward"||$(".filter-list-msg li[class='curr']").attr("id")==="partner"){
            billobj.condition.virtual = true;
        }*/
        if(billobj.condition.btype=="'16'"){
            billobj.condition.btype = null;
            billobj.condition.virtual = true;
        }
        ijob.storage.set("billobj",billobj);
        $(".filterList").click();
        loadData();
    });

    function gotoBill(item){
        ijob.storage.set("data.virtual", $(item).data("virtual"));
        var type = $(item).data("type");
        var orderNo  = $(item).data("order");
        if( type==="02" || type==="03" || type==="05" || type==="06" || type==='07'){
            ijob.gotoPage({path:'/h5/qz/mine/wxorder_detail',data:{orderNo:orderNo,type:type}});
        }else if(type===14){
            ijob.gotoPage({path:'/h5/qz/mine/account_detail',data:{orderNo:orderNo,type:type}});
        }else if(type==="01" ){ //保证金支付
            ijob.gotoPage({path:'/h5/qz/mine/bond_detail',data:{orderNo:orderNo}});
        }else if(type===1 ||type===3 ){ //保证金退回
            ijob.gotoPage({path:'/h5/qz/mine/bill_detail',data:{billtype:1,btype:type,orderNo:orderNo}});
        }else if(type===6 || type===7){
            ijob.gotoPage({path:'/h5/qz/mine/bill_detail',data:{billtype:2,orderNo:orderNo}});
        }else if(type===2){
            ijob.gotoPage({path:'/h5/qz/mine/Bills_partyA?code='+orderNo});
        }else if(type===5){ //提现
            ijob.gotoPage({path:'/h5/qz/mine/Bills_withdrawCash?code='+orderNo})
        }else if(type===9){ //提现手续费
            ijob.gotoPage({path:'/h5/qz/mine/Bills_withdrawCash_sxf?code='+orderNo})
        }else if(type===16){ //余额付款
            if(orderNo.indexOf("R")==0){//红包
                ijob.gotoPage({path:'/h5/qz/index/packet',data:{orderNo:orderNo,type:"04"}});
            }else{
                ijob.gotoPage({path:'/h5/qz/mine/account_detail',data:{orderNo:orderNo,type:type}});
            }
        }else if(type===8){
            ijob.gotoPage({path:'/h5/qz/mine/partner_detail',data:{orderNo:orderNo}})
        }else if(type===10){
            var obj = {
                mark:$(item).data("mark"),
                datetime:$(item).data("datetime"),
                money:$(item).data("money"),
                orderNo:orderNo
            }
            ijob.gotoPage({path:'/h5/qz/mine/Bills_cash',data:{orderNo:orderNo,result:obj}});
        }else if(type===12 || type === 11 || type==="04"){
            ijob.gotoPage({path:'/h5/qz/index/packet',data:{orderNo:orderNo,type:type}});
        }else if(type===13){

        }else if(type===29){
            ijob.gotoPage({path:'/h5/qz/mine/recharge_bills',data:{orderNo:orderNo,type:type}});
        }else if(type===17||type===18||type===19||type===30){
            ijob.gotoPage({path:'/h5/qz/mine/jsMine_tran',data:{orderNo:orderNo,type:type}});
        }
    }
</script>