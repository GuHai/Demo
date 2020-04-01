<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>红包</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/salaryCard.css?version=4">
</head>
<body>
    <div class="wrap">
        <script id="packetTemplate" type="text/html"  data-url="/ijob/api/AccountController/getRedPacketInfo" >
            <div class="page_packet">
                <div class="informBox informlist">
                    <div class="header">
                        <div class="head">
                            <a href="javascript:void(0);" onclick="history.go(-1)">返回</a>
                            <a href="javascript:void(0);" id="hidenSpan" style="display: none" ><span id="backMoneySpan">56.02</span>元已退还</a>
                        </div>
                    </div>
                    <div class="person qz_person">
                        <div class="portrait">
                            <div class="photo">
                                {{if list[0].forward!=null}}
                                <img src="/ijob/upload/{{list[0].forward.payRedPacketUser.attachment | absolutelyPath}}" onerror="this.src='{{list[0].forward.payRedPacketUser.weixin.headimgurl}}';this.onerror=null;" />
                                {{else}}
                                <img src="/ijob/upload/{{list[0].position.positionUser.attachment | absolutelyPath}}" onerror="this.src='{{list[0].position.positionUser.weixin.headimgurl}}';this.onerror=null;" />
                                {{/if}}
                            </div>
                            <p>
                                {{if list[0].forward!=null}}
                                    {{list[0].forward.payRedPacketUser.realName}}
                                    {{if list[0].forward.payRedPacketUser.realName == null || list[0].forward.payRedPacketUser.realName == '' }}
                                        {{list[0].forward.payRedPacketUser.weixin.nickname}}
                                    {{/if}}
                                {{else}}
                                    {{list[0].position.positionUser.realName}}
                                    {{if list[0].position.positionUser.realName == null || list[0].position.positionUser.realName == '' }}
                                        {{list[0].position.positionUser.weixin.nickname}}
                                    {{/if}}
                                {{/if}}
                                的红包</p>
                        </div>
                        <div class="name">
                            <p class="pro_name">
                                {{if list[0].forward!=null}}
                                    {{list[0].forward.position.title}}
                                {{else}}
                                    {{list[0].position.title}}
                                {{/if}}</p>
                            <p class="type">分享奖励单个红包金额</p>
                        </div>
                        <%--退还时不显示--%>
                        <div class="num" id="showMoney">
                            <p><span>{{list[0].oneOfMoney}}</span><em>元</em></p>
                            <p class="tips">该红包已存入工资卡余额</p>
                        </div>
                    </div>
                </div>
                <div class="receive_box_list">
                    <div class="num" id="num">领取<span>{{(list[0].allOfMoney/list[0].oneOfMoney-list[0].residueCount)}}/{{(list[0].allOfMoney/list[0].oneOfMoney)}}</span>个</div>
                    <ul>
                        {{each list[0].redPacketReceiveList as redPacketReceive index}}
                            <li>
                                <div class="portrait">
                                    <img src="/ijob/upload/{{redPacketReceive.getRedPacketUser.attachment | absolutelyPath}}" onerror="this.src='{{redPacketReceive.getRedPacketUser.weixin.headimgurl}}';this.onerror=null;" />
                                </div>
                                <div class="contenBox">
                                    <p class="list-title" style="width: 300px">{{redPacketReceive.getRedPacketUser.realName}}
                                        {{if redPacketReceive.getRedPacketUser.realName == null || redPacketReceive.getRedPacketUser.realName == '' }}
                                            {{redPacketReceive.getRedPacketUser.weixin.nickname}}
                                        {{/if}}
                                    </p>
                                    <p class="list-time" style="width: 200px">{{redPacketReceive.updateTime | dateFormat:'yyyy年MM月dd日 hh:mm:ss'}}</p>
                                </div>
                                <div class="fr money">
                                    <p>{{redPacketReceive.money}}元</p>
                                </div>
                            </li>
                        {{/each}}
                    </ul>
                </div>
            </div>
        </script>
    </div>
    <div id="homepage"></div>
</body>
</html>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});
    var params = {
        condition:{
            settlementOrderNumber:ijob.storage.get("orderNo"),
            type:ijob.storage.get("type")
        }
    }
    $("#packetTemplate").loadData(params).then(function (result) {
        console.log(result)
        if(ijob.storage.get("type")==="04"){
            $(".tips").text("红包总金额"+result.data.list[0].allOfMoney+"元");
        }
        if(ijob.storage.get("type")==12){
            $("#backMoneySpan").text(result.data.list[0].backMoney);
            $(".tips").text("该红包已退还至工资卡余额");
            $("#hidenSpan").show();
        }
    });
</script>