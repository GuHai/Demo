
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <!DOCTYPE html>
<html lang="en">
<head>
<body>
<div class="main">
    <div class="head-list-colse">
        <div class="notes">
            <a href="javascript:void(0);" class="link" onclick="ijob.gotoPage({path:'/h5/zp/newAccount'})">
                <div class="txt-left-code" >
                    <span class="iconfont icon-erweima codeImg"></span>
                    <span class="txt">工资二维码（批量发工资）</span>
                </div>
                <div class="view-right-code">
                    <span class="iconfont icon-arrow-right"></span>
                </div>
            </a>
        </div>
        <div class="notes" style="display:none">
            <a href="javascript:void(0);" class="link" onclick="ijob.gotoPage({path:'/h5/zp/mine/salaryList?signtype=false'})">
                <div class="txt-left" >
                    您有<span id="num">1</span>笔工资正在结算中...
                </div>
                <div class="view-right">
                    <span class="iconfont icon-arrow-right"></span>
                </div>
            </a>
        </div>
    </div>
    <div class="list" >
        <ul class="list-ul">
            <script type="text/html" id="mypositiontemplate4" data-url="/ijob/api/PositionController/zp/getUserPositionWaitApplySettlementInfo/2">
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
                                <span class="content-msg1-lf"><i
                                        class="iconfont icon-shizhong"></i>{{posi.recruitStartTime | dateFormat:'MM月dd日' }} ({{posi.recruitStartTime | dateFormat:'周W' }})</span>
                                    <span class="content-msg1-rt"><span>{{ posi.dailySalary }}元/天</span></span>
                                </div>
                                <div class="content-msg2">
                                <span class="content-msg2-lf">{{if posi.sexRequirements == '' || posi.sexRequirements == null}}男女不限{{/if}}{{ posi.sexRequirements | enums:"SexRequirements" }}&nbsp;<span
                                        class="line"></span>&nbsp;{{posi.personNumDay}}人/天</span>
                                    <span class="content-msg2-rt">{{posi.salaryType | enums:"SettlementType"}}</span>
                                </div>
                                <div class="content-msg3">
                                    <span class="content-msg3-lf">{{posi.workPlace.city |ifNull:'保密','cityName'}}&nbsp; {{posi.workPlace | getDistance }}</span>
                                    <span class="content-msg3-rt">商家已缴保证金<i class="CM-trI">{{posi.liquidatedDamages*posi.personNumDay | money}}元</i></span>
                                </div>
                            </div>
                        </div>
                        {{if posi.signins[0].id!=null}}
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
                                                    <%--<p class="DT-p2">待结算</p>--%>
                                                    <p class="Ds-p2">签到记录：<span>{{sign.num }}</span>次</p>
                                                </div>
                                                    <%--<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_close3?applySettlement.positionID={{posi.id}}&applySettlement.state=0&applySettlement.title={{posi.title}}'})" class="Dnam-m">去结算</a>--%>
                                            </div>
                                        </div>
                                        <%--<div class="Dman-state">--%>
                                            <%--<a href="javascript:viod(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_close3?applySettlement.positionID={{posi.id}}&applySettlement.state=0&applySettlement.title={{posi.title}}'})">--%>
                                                <%--<p class="Ds-p1">申请结算: </p>--%>
                                                <%--<p class="Ds-p2">{{posi.applySettlementList[0].user.applySettlementSum |ifNull:'0'}}次，未处理:{{posi.applySettlementList[0].user.applySettlementNoHandle |ifNull:'0'}}次，拒绝:{{posi.applySettlementList[0].user.applySettlementRefuse |ifNull:'0'}}次</p>--%>
                                                <%--<i class="iconfont icon-arrow-right" style="float:right;"></i>--%>
                                            <%--</a>--%>
                                        <%--</div>--%>
                                        <%--<div class="Dman-state">--%>
                                            <%--<p class="Ds-p1">共 签 到 : </p>--%>
                                            <%--<p class="Ds-p2">{{posi.applySettlementList[0].user.signinCount |ifNull:'0'}}天,预计薪资--%>
                                                <%--{{if posi.applySettlementList[0].user.signinCount == null}}--%>
                                                <%--0--%>
                                                <%--{{else}}--%>
                                                <%--{{posi.applySettlementList[0].user.signinCount * posi.dailySalary}}--%>
                                                <%--{{/if}}--%>
                                                <%--元</p>--%>
                                            <%--<i class="iconfont icon-arrow-right" style="float:right;"></i>--%>
                                        <%--</div>--%>
                                        <%--<div class="Dman-state">
                                            <a href="myjob_close2_record.html">
                                                <p class="Ds-p1">结算总额: </p>
                                                <p class="Ds-p2"><span>380元</span>，总笔数1笔，已确认1笔</p>
                                                <i class="iconfont icon-arrow-right" style="float:right;"></i>
                                            </a>
                                        </div>--%>
                                    </div>
                                    {{if sign.hasUrge==true}}
                                    <div class="press">催款中</div>
                                    {{/if}}

                                </div>
                            {{/each}}
                        {{/if}}
                      <%--  onclick="ijob.gotoPage({path:'/h5/zp/myjob_close_apply?position.index={{index}}'})" class="duty-more"--%>
                        <div class="more moreview">
                            {{if posi.signins[0].id!=null}}
                            <a href="javascript:void(0);"  class="duty-more" onclick="ijob.gotoPage({path:'/h5/zp/myjob_close3?applySettlement.positionID={{posi.id}}&applySettlement.state=0&applySettlement.title={{posi.title}}'})">查看更多</a>
                            {{/if}}
                            <%--<form id="{{posi.id}}">
                                <input type="hidden" name="id" value="{{posi.id}}">
                                <input type="hidden" name="title" value="{{posi.title}}">
                                <input type="hidden" name="dailySalary" value="{{ posi.dailySalary }}元/天">
                                <input type="hidden" name="recruitsSum" value="{{posi.recruitsSum}}">
                                <input type="hidden" name="city" value="{{posi.workPlace.city |ifNull:'未知','cityName'}}">
                                <input type="hidden" name="recruitStartTime" value="{{posi.recruitStartTime | dateFormat:'MM月dd日' }} ({{posi.recruitStartTime | dateFormat:'周W' }})">
                                <input type="hidden" name="jobContent" value="{{posi.jobContent}}">
                            </form>
                            <a href="javascript:void(0);"  class="duty-share" data-index="{{posi.id}}">分享工资二维码</a>--%>
                        </div>
                    </div>
                </li>
                {{/each}}
                </script>
            </ul>
        </div>
    </div>
<script>


    $.getJSON("/ijob/api/SettlementpersonController/getUnsettled",function(data){
        if(data.success&&data.data>0){
            $("#num").text(data.data);
           $(".notes").show();
        }
    });

    $("#mypositiontemplate4").loadData().then(function (result) {
        console.log(result)
        var navH = $(".JobVtwo").offset().top; //定位元素距离浏览器顶部的距离
        $(window).scroll(function(){
            var scroH = $(this).scrollTop();//获取滚动条的滑动距离
            if(scroH >= navH){
                $(".JobVtwo").css({"position":"fixed","top":"0"});
            }else if(scroH < navH){
                $(".JobVtwo").css({"position":"static"});
            }
        });
        //result 服务器响应过来的数据
        ijob.storage.set("position",result.data);
        if(result.data.list.length == 0){
            $(".nodata").remove();
            $('.main').append("<p style='text-align: center;margin-top: 5rem;'>没有相关职位！</p>");
        }
        /*分享工资二维码*/
        $(function () {
            var slide = null;
            $(".duty-share").click(function () {
                initQrcode($("#"+$(this).data("index")).serializeObjectJson(),2);
                $(".share_code_code").show();
                slide = new Slide($(".rx_wrap"),$(".share_code_code"),".mainlist");
                slide.disTouch();
            });
            // 点击空白处隐藏选项
            $("body>*").on('click', function (e) {
                if ($(e.target).hasClass('share_code_code')) {
                    $(".share_code_code").hide();
                    slide.ableTouch();
                }
            });
        })
    });
</script>
</body>
</html>
