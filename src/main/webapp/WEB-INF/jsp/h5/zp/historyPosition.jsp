
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>历史职位</title>
    <jsp:include page="../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/part/myjob.css?version=4">
</head>
<body>
<div class="page_history_content">
    <ul class="tabList">
        <li class="active"><a href="javascript:void(0);">传统结算</a></li>
        <li class=""><a href="javascript:void(0);">扫码结算</a></li>
    </ul>
    <div class="main">
        <div class="history_list_box">
            <div class="list tradition_list" >
                <ul class="list-ul">
                    <script type="text/html" id="historypositiontemplate" data-url="/ijob/api/PositionController/zp/historyPosition/0">
                        {{each list as posi index}}
                        <li class="list-li">
                            <div class="list-container">
                                <div class="list-title">
                                    <span class="title-content">{{posi.title}}</span>
                                </div>
                                <div class="list-content">
                                    <div class="content-tit">
                                        {{posi.huntingtype.name}}
                                    </div>
                                    <div class="content-msg">
                                        <div class="content-msg1">
                                            <span class="content-msg1-lf">
                                                <i class="iconfont icon-shizhong"></i>
                                                {{posi.recruitStartTime | dateFormat:'MM月dd日' }} ({{posi.recruitStartTime | dateFormat:'周W' }})
                                            </span>
                                            <span class="content-msg1-rt"><strong>{{ posi.dailySalary }}元/天</strong></span>
                                        </div>
                                        <div class="content-msg2">
                                            <span class="content-msg2-lf">
                                                {{if posi.sexRequirements == '' || posi.sexRequirements == null}}男女不限{{/if}}{{ posi.sexRequirements | enums:"SexRequirements" }}&nbsp;
                                                <span class="line"></span>
                                                &nbsp;{{posi.personNumDay}}人/天
                                            </span>
                                            <span class="content-msg2-rt">{{posi.salaryType | enums:"SettlementType"}}</span>
                                        </div>
                                        <div class="content-msg3">
                                            <span class="content-msg3-lf">{{posi.workPlace.city |ifNull:'未知','cityName'}}&nbsp;</span>
                                            <span class="content-msg3-rt">商家已缴保证金<i class="CM-trI">{{posi.liquidatedDamages}}元</i></span>
                                        </div>
                                    </div>
                                </div>
                                {{each posi.signins as sign index}}
                                <div class="pers-list">
                                    <div class="duty-man">
                                        <div class="Dman-name">
                                            <div class="Dman-qq">
                                                <img src="/ijob/upload/{{sign.user.attachment | absolutelyPath}}" onerror="this.src='{{sign.user.weixin.headimgurl}}';this.onerror=null;" />
                                            </div>
                                            <div class="Dnam-t">
                                                <div class="Dnam-tT">
                                                    <p class="DT-p1">{{sign.user.realName }}</p>
                                                </div>
                                                <div class="Dnam-tF">
                                                    <p class="Ds-p2">签到记录：<span>{{sign.num }}</span>次</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                {{/each}}
                                <div class="more">
                                    <a href="javascript:void(0);"  class="duty-more" onclick="ijob.gotoPage({path:'/h5/zp/myjob_end_details?position.id={{posi.id}}'})">查看更多</a>
                                </div>
                            </div>
                        </li>
                        {{/each}}
                    </script>
                    </ul>
                </div>
                <div class="scan_list" style="display: none">
                    <div class="accountsList">
                        <div class="account-list-ul">
                            <ul class="clearfix">
                                <script type="text/html" id="yjstemplate" data-url="/ijob/api/ApplySettlementController/getQrcodeYJSInfo" >
                                    {{each list as posi}}
                                    <li class="posi-list">
                                        <div class="head-flex">
                                            <div class="title">{{posi.title}}</div>
                                            <div class="time">{{posi.updateTime |dateFormat:'yyyy年MM月dd日'}}&nbsp;&nbsp;<span>{{posi.updateTime |dateFormat:'hh:mm'}}</span></div>
                                        </div>
                                        <div class="inform-list">
                                            {{if posi.scanSettleMemberList != null && posi.scanSettleMemberList.length != 0 &&posi.scanSettleMemberList!=[]}}
                                            <ul class="ul-list">
                                                {{each posi.scanSettleMemberList as imgObj}}
                                                <li>
                                                    <img src="/ijob/upload/{{imgObj.user.attachment |absolutelyPath}}"onerror="this.src='{{imgObj.user.weixin.headimgurl}}';this.onerror=null;" >
                                                </li>
                                                {{/each}}
                                            </ul>
                                            {{/if}}
                                        </div>
                                        <div class="edit-btns">
                                            <a href="javascript:void(0);" class="moreview" onclick="ijob.gotoPage({path:'/h5/zp/accounts_end_details?scanSettle.id={{posi.id}}'})">查看详情</a>
                                        </div>
                                    </li>
                                    {{/each}}
                                </script>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <div id="homepage"></div>
</div>
</body>

<script>
    $("#homepage").loadPage({path:"/h5/homepage"});
    $(".tabList>li").on("click", function () {
        var index = $(this).index();
        $(this).addClass("active").siblings().removeClass("active");
        $(".main .history_list_box>div").eq(index).show().siblings().hide();
        if(index == 0){
            initDjs();
        }else {
            initYjs();
        }
    })
    function initDjs() {
        $("#historypositiontemplate").loadData().then(function (result) {
            //result 服务器响应过来的数据
            ijob.storage.set("position", result.data);
        });
    }
    var menu = ijob.storage.get("tab");
    if(menu && menu.indexOf("yjs")!=-1 && menu.indexOf(":")!=-1){
        $(".tabList>li").eq(menu.split(":")[1]).click();
        if(menu.split(":")[1]==1){
            document.title="已结算"
        }
    }else{
        $(".tabList>li").eq(0).click();
    }

    // 待结算是否有数据存在
    function extent() {
        var len = $(".wait-list .posi-list").length;
        // console.log(len);
        if (len == 0 ){
            $(".nullContent").show();
            $(".foot_flex").hide();
        }
    }
    // 判断求职者头像的长度
    function length() {
        var num  = 9;
        $(".inform-list").each(function(i,item){
            if($(this).find(".ul-list li").length>num){
                $(this).find(".ul-list li").eq(num-1).nextAll().remove();
                $(this).find(".ul-list li:last").after("<li  class='ellipsis'>…</li>");
            }else if($(this).find(".ul-list li").length == 0){
                $(this).hide();
                $(".head-flex").css("margin-bottom","0.267rem")
            }
        });
    }
    function initYjs(obj){
        obj = obj||{};
        $("#yjstemplate").loadData(obj).then(function (result) {
            if(!obj.hasOwnProperty("condition")){

                $("#yjstemplate").parent().append("<li onclick='showAll()' style='text-align: center;' ><a >查看更多历史</a></li>");
            }
        });
    }
    function showAll(){
        $("#yjstemplate").nextAll().remove();
        var t = setTimeout(function(){
            clearTimeout(t);
            initYjs({condition:{all:1}});
        },100);
    }
</script>
</html>
