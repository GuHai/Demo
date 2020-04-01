<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/8
  Time: 17:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>转发</title>
    <jsp:include page="../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/index/index.css?version=4">
</head>
<body>
<div class="wrap">
    <div class="page_post_forward">
        <header class="head">他人通过你的转发做此兼职，你可以获得<span id="rewardMoney">1</span>元/天的提成</header>
        <div class="main">
            <%--<div class="title">给好友奖励</div>--%>
            <div class="money_input">
                <form class="myform">
                    <input type="hidden" name="positionID" id="positionID">
                    <input type="hidden" name="rewardID" id="rewardID">
                    <input type="hidden" name="allOfMoney" id="allOfMoney">
                    <input type="hidden" name="isDeleted" value="true">
                    <div class="input-row">
                        <label>单个金额</label>
                        <div class="input">
                            <input id="oneOfMoney" type="number" name="oneOfMoney" oninput="if(value.length>7)value=value.slice(0,7)" onblur="if(value<0.1||isNaN(value))value=0.1" placeholder="输入单个红包的金额">
                        </div>
                        <div class="unit">元</div>
                    </div>
                    <div class="input-row">
                        <label>红包个数</label>
                        <div class="input">
                            <input id="count" type="number" name="residueCount" oninput="if(value.length>3)value=value.slice(0,3)" onblur="change(this)"  placeholder="填写个数">
                        </div>
                        <div class="unit">个</div>
                    </div>
                </form>
            </div>
            <div class="tips_content">
                <p>1.入职一人，分享者和求职者瓜分一个红包，如有10个人入职则需消耗10个红包。</p>
                <p>2.求职者未到岗，红包瓜分失败，剩余金额自动返回到I Job工资卡余额。</p>
                <p>3.单个红包金额不得少于0.1元。</p>
            </div>
        </div>
        <footer class="foot-fixed">
            <div class="cancel btns">取消</div>
            <div class="confirm btns">
                <a href="javascript:void(0)" data-url="/ijob/api/ForwardController/forwardPosition/" class="link"><i>&yen;</i><em>0</em>转发到工作号</a>
            </div>
        </footer>
        <%--分享--%>
        <div class="cancel_content">
            <div class="mainpopup">
                <ul>
                    <li class="editbtns">
                        <a href="javascript:void(0);">继续编辑</a>
                    </li>
                    <li class="cancelbtns" onclick="ijob.gotoPage({path:'/h5/zp/index'})">
                        <a href="javascript:void(0);">放弃</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script>
    function change(arg){
        if(arg.value<1||isNaN(arg.value)||arg.value==null)
            arg.value=1
        else
            arg.value=parseInt(arg.value);
    }
    var money ;
    function jisuan(){
        $("#oneOfMoney").val($("#oneOfMoney").val().trim(" "));
        $("#count").val($("#count").val().trim(" "));
        money = $("#oneOfMoney").val() * $("#count").val();
        $(".confirm em").text(money);
    }
    $(function () {
        var positionID = ijob.storage.get("reward.positionID"),rewardID = ijob.storage.get("reward.id");
        $("#rewardMoney").text(ijob.storage.get("reward.rewardMoney"));
        $("#positionID").val(positionID);
        $("#rewardID").val(rewardID);

        $(".link").data("url",$(".link").data("url") + positionID +"/" +rewardID);
        // 取消
        $(".foot-fixed .cancel").click(function () {
            $(".cancel_content").show();
            slide = new Slide($(".wrap"), $(".cancel_content"), ".mainpopup");
            slide.disTouch();
        });
        //继续编辑
        $(".cancel_content .editbtns").click(function () {
            $(".cancel_content").hide();
            slide.ableTouch();
        });
        // 点击空白处隐藏选项
        $("body>*").on('click', function (e) {
            if ($(e.target).hasClass('cancel_content')) {
                $(".cancel_content").hide();
                slide.ableTouch();
            }
        });
        $("#count").blur(function () {
            $(this).val(parseInt($(this).val()));
            jisuan()
        })
        $("#oneOfMoney").blur(function () {
            var temp = this.value + "";
            var tempArr = temp.split(".");
            if(tempArr.length > 2){
                if(tempArr[1].length>2){
                    this.value = tempArr[0] + '.' + tempArr[1].slice(0,2);
                }
            }
            jisuan()
        })
        //计算需要的金额
        $("#oneOfMoney,#count").on("input propertychange", function () {
            jisuan();
        });

        //点击转发按钮
        $('.link').click(function () {
            $("#allOfMoney").val(money);
            var params = $(".myform").serializeObjectJson();
            if (money > 0) {//有奖励
                $(".link").data("url","/ijob/api/ForwardController/forwardPositionByRed");
                $(".link").btPost(params,function (data) {
                    if (data.code == 200){
                        //跳转到支付页面支付
                        var order = {order:{refID:data.data.redPacket.id,fee:data.data.redPacket.allOfMoney*100,description:('红包金额'+Math.round(data.data.redPacket.allOfMoney*100)/100+"元"),type:enums.WxOrderType.RedPacket}};
                        payBond(order);
                    }else if(data.code == 501){
                        mui.alert(data.msg);
                    }else{
                        mui.alert("服务器繁忙！");
                    }
                })

            } else {
                //没有奖励
                //职位转发到工作号
                var btn = ['取消', '确定'];
                mui.confirm('确定不设置分享红包直接转发吗？', '提示', btn, function (e) {
                    if (e.index == 1) {
                        $(".link").btPost(null,function (data) {
                            if(data.code == 200){
                                mui.alert("转发成功！",function () {
                                    ijob.gotoPage({url:"/indexMain"});
                                })
                            }else if(data.code == 501){
                                mui.alert(data.msg);
                            }else{
                                mui.alert("服务器繁忙！");
                            }
                        });
                    }
                });
            }
        });
    });
    function payBond(order){
        window.history.replaceState('','', "forward?path=/h5/zp/index");
        ijob.url.next.set("/ijob/api/ForwardController/redPacketCallback");
        ijob.gotoPage({url:'/ijob/api/WeixinController/order',data:order});
    }
</script>