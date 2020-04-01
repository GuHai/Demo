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
    <title>设置奖金</title>
    <jsp:include page="../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/chooseResume.css?version=4">
</head>
<style>
    .wrap .page_offerReward .claim-row .mui-switch:before {
        content: '关闭';
        font-size: 0.266rem;
        left: 0.48rem;
        top: -0.4rem;
        right: 0;
    }
    .wrap .page_offerReward .claim-row .mui-switch.mui-active:before {
        content: '开放中';
        left: 3px;
    }
</style>
<body>
    <div class="wrap">
        <script type="text/html" id="rewardTemplate"  data-url="/ijob/api/RewardController/getNewReward/" data-type="POST">
            <div class="page_offerReward">
                <div class="tablist">
                    <ul class="list-ul">
                        <li class="list-li curr"><a href="javascript:void(0)">代理费</a></li>
                        <li class="list-li"><a href="javascript:void(0)">红包奖励</a></li>
                    </ul>
                </div>
                <div class="tabcontent">
                    <div class="agentcontent main">
                        <form class="myform" id="myform">
                            <%--代理费--%>
                            <div class="input-row">
                                <label>代理费</label>
                                <div class="input">
                                    <input type="hidden" name="positionID" value="{{list[0].positionID}}">
                                    <input type="number" class="money" name="rewardMoney" oninput="if(value.length>6)value=value.slice(0,6)" onblur="checkVal(this)"  placeholder="请填写金额" id="rewardMoney" value="{{list[0].rewardMoney}}">
                                </div>
                                <div class="unit">每人/天</div>
                            </div>
                        </form>
                        <div class="tips_content">
                            <h3>悬赏的好处</h3>
                            <div class="describe">
                                <p>设置代理费后，平台上的兼职代理可以帮助你转发邀请求职者报名。</p>
                                <p>报名成功并参加工作结束后，支付相应代理费给代理。</p>
                                <p>如果没有代理招聘成功，工作结束不需要支付代理费。</p>
                            </div>
                        </div>
                        <footer class="foot-fixed">
                            <a href="javascript:void(0)" class="cancel btns" onclick="ijob.gotoPage({path:'/h5/zp/mine/positionManage'})">取消</a>
                            <a href="javascript:void(0)" class="confirm btns" data-url="/ijob/api/RewardController/insertNewReward">确定</a>
                        </footer>
                    </div>
                    <div class="packetcontent main" style="display: none;">
                        <div class="money_input">
                            <form class="myform" id="packetform">
                                <input type="hidden" name="positionID" value="{{list[0].positionID}}">
                                <div class="input-row">
                                    <label>单个金额</label>
                                    <div class="input">
                                        <input type="number" class="money"oninput="if(value.length>6)value=value.slice(0,6)" onblur="if(value<0.1||isNaN(value))value=0.1"  name="oneOfMoney" placeholder="输入单个红包的金额" >
                                    </div>
                                    <div class="unit">元</div>
                                </div>
                                <div class="input-row">
                                    <label>红包个数</label>
                                    <div class="input">
                                        <input type="number" class="money"oninput="if(value.length>6)value=value.slice(0,6)" onblur="change(this)" name="residueCount"  placeholder="填写个数" id="singlenum">
                                    </div>
                                    <div class="unit">个</div>
                                </div>
                                <%--<input type="hidden" name="rewardType" value="{{list[0].rewardType}}" id="rewardType">--%>
                                <%--<div class="input-row">
                                    <label>时薪资</label>
                                    <div class="input">
                                        <input type="number" class="money" name="hourlyWage" oninput="if(value.length>6)value=value.slice(0,6)" onblur="checkVal(this)" id="hourlyWage" placeholder="请输入时薪资" value="{{list[0].hourlyWage}}">
                                    </div>
                                    <div class="unit">元</div>
                                </div>
                                <div class="input-row">
                                    <label>赏金金额</label>
                                    <div class="input">
                                        <input type="number" class="money" name="rewardMoney" oninput="if(value.length>6)value=value.slice(0,6)" onblur="checkVal(this)"  placeholder="请填写金额" id="rewardMoney" value="{{list[0].rewardMoney}}">
                                    </div>
                                    <div class="unit">每人/小时</div>
                                </div>--%>
                                <%--<div class="claim-row">
                                    <div class="claim-title">悬赏状态</div>
                                    <div class="mui-switch mui-switch-blue {{list[0].rewardType |rewardType}}" id="mySwitch">
                                        <div class="mui-switch-handle"></div>
                                    </div>
                                </div>--%>
                            </form>
                        </div>
                        <div class="tips_content">
                            <div class="describe">
                                <p>1.入职一人，分享者和求职者瓜分一个红包，如有10个人入职则需消耗10个红包。</p>
                                <p>2.求职者未到岗，红包瓜分失败，剩余金额自动返回到I Job工资卡余额。</p>
                                <p>3.单个红包金额不得少于0.1元。</p>
                            </div>
                        </div>
                        <footer class="foot-fixed">
                            <a href="javascript:void(0)" class="cancel btns" onclick="ijob.gotoPage({path:'/h5/zp/mine/positionManage'})">取消</a>
                            <a href="javascript:void(0)" class="packetbtn btns" data-url="/ijob/api/RedPacketController/addNewRedPacket">确定</a>
                        </footer>
                    </div>
                </div>
            </div>
        </script>
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
    var positionID = ijob.storage.get("position.id");
    $("#rewardTemplate").data("url",$("#rewardTemplate").data("url") + positionID);
    $("#rewardTemplate").loadData().then(function (result) {
        /*$("#rewardType").val(result.data.list[0].rewardType);*/
        var value = $("input[name='rewardMoney']");
        if (value !='undefined'|| value !=''){
            $(".claim-row").show();
        }
        /*$("#mySwitch").click(function () {
            if($(this).hasClass("mui-active")){
                $(this).removeClass("mui-active");
                $("#rewardType").val(false);
            }else{
                $(this).addClass("mui-active");
                $("#rewardType").val(true);
            }
        });*/
        $(".list-ul .list-li").click(function () {
            var nub = $(this).index();
            $(this).addClass("curr").siblings('.list-ul .list-li').removeClass("curr");
            $(".tabcontent>div").eq(nub).show().siblings().hide();
        })
        $(".confirm").click(function () {
            var reward = $("#myform").serializeObjectJson();
            if (reward.rewardMoney == null|| reward.rewardMoney == "" || reward.rewardMoney == undefined  ){
                mui.alert("请输入悬赏金额！");
            }else {
                $(this).btPost(reward,function (data) {
                    if(data.code == 200)
                        mui.alert("操作成功",function () {
                            ijob.gotoPage({path:'/h5/zp/mine/positionManage'});
                        });
                    else
                        mui.alert("服务器繁忙");
                })
            }
        });
        $(".packetbtn").click(function () {
            var redpacket = $("#packetform").serializeObjectJson();
            redpacket.allOfMoney = redpacket.oneOfMoney * redpacket.residueCount;
            redpacket.allOfMoney = Math.round(redpacket.allOfMoney*100)/100
            redpacket.state = false
            /*alert(redpacket.oneOfMoney);*/
            if(redpacket.residueCount==null||redpacket.residueCount==undefined||redpacket.residueCount<1){
                mui.alert("请填写红包数量！")
            }else if(redpacket.oneOfMoney==null||redpacket.oneOfMoney==undefined||redpacket.oneOfMoney<0||redpacket.oneOfMoney.toString()==''){
                mui.alert("请填写红包金额！")
            }else{
                $(this).btPost(redpacket,function (data) {
                    if (data.code==200){
                        //跳转到支付页面支付
                        var order = {order:{refID:data.data.id,fee:data.data.allOfMoney*100,description:('红包金额'+redpacket.allOfMoney+"元"),type:enums.WxOrderType.RedPacket}};
                        payBond(order);
                    }else if(data.code==501){
                        mui.alert("该职位已经设置过红包！")
                    }else{
                        mui.alert("网络错误！")
                    }
                })
            }
        });
    })

    function checkVal(arg){
        if(arg.value<0){
            arg.value = -arg.value;
        }else if(arg.value==0){
            arg.value = 1
        }
        if(arg.value.indexOf(".")>-1){
            var temp = arg.value+""
            var arr = temp.split(".")
            if(arr[1].length>2){
                arr[1] = arr[1].slice(0,2);
            }
            arg.value = parseFloat(arr[0]+"."+arr[1])
        }
    }

    function payBond(order){
        window.history.replaceState('','', "forward?path=/h5/zp/index");
        ijob.url.next.set("/ijob/api/ForwardController/redPacketCallback");
        ijob.gotoPage({url:'/ijob/api/WeixinController/order',data:order});
    }
</script>