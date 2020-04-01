<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>结算</title>
    <jsp:include page="../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/part/newAccount.css?version=4">
    <script>
        (function ($) {
            window.addEventListener('pageshow', function (e) {
                // 通过persisted属性判断是否存在 BF Cache
                if (e.persisted) {
                    location.reload();
                }
            });
        })(mui);
    </script>
</head>
<body>

<div class="wrap">
    <%--<header class="headtips">
        请仔细核对名单，支付后此订单不能再次结算
    </header>--%>
    <div class="evList" style="margin-top: 0;">
        <script type="text/html" id="djsinfotemplate" data-url="/ijob/api/ApplySettlementController/getQrcodeDJSInfo" >
            <input type="hidden" name="version" id="allVersion" value="{{list[0].version}}">
            {{each list[0].scanSettleMemberList as user}}
                <a href="javascript:void(0);" class="evLbox">
                    <div class="mui-input-row mui-checkbox mui-left inputCheck">
                        <%--<label></label>--%>
                        {{if user.createBy != null && user.id != null}}
                        <input name="checkbox1" value="Item 1" data-id="{{user.id}}" type="checkbox" class="goods-check GoodsCheck">
                        {{/if}}
                    </div>
                    <div class="evLb-man">
                        <div class="evLb-mT">
                            <div class="evLb-qq"><div class="qqbox">
                                {{if user.createBy == null}}
                                <img src="/ijob/static/images/default.jpg" >
                                {{else}}
                                <img src="/ijob/upload/{{user.user.attachment |absolutelyPath}}"onerror="this.src='{{user.user.weixin.headimgurl}}';this.onerror=null;" >
                                {{/if}}
                            </div>
                                <div class="tbox">
                                    <p class="tboxS">{{if user.createBy != null}}{{user.user.mainName}}{{else}}{{user.salaryImport.realName}}{{/if}} <%--<span>|</span>--%>
                                        {{if user.createBy != null}}
                                            {{if user.user.sex == 1}}
                                            <span class="iconfont icon-nan1"></span>
                                            {{else}}
                                            <span class="iconfont icon-nv1"></span>
                                            {{/if}}
                                        {{/if}}
                                    </p>
                                    <p class="tsala">{{if user.createBy != null}}{{user.user.phoneNumber}}{{else}}{{user.salaryImport.personPhoneNumber}}{{/if}}</p>
                                </div>
                            </div>
                            {{if user.isRush != null}}
                                <div class="press">催款中</div>
                            {{/if}}

                            <div class="h-settle">
                                <input type="number"id="{{user.id}}"
                                                         class="set_put" maxlength="7" value="{{(user.salary-(user.sxf==null?0:user.sxf)) | money2}}"
                                                         data-id="{{user.id}}" data-version="{{user.version}}" />
                                <span  class="yuan">元</span>
                            </div>
                        </div>
                    </div>
                </a>
            {{/each}}
        </script>
    </div>
    <div class="clearfix" style="height: 1.5rem;clear: both;content: '';"></div>
    <div class="payment-bar">
        <div class="brokerage">
            <div class="txt">帮员工付提现手续费<span id="sxf">￥0</span></div>
            <div class="mui-switch mui-switch-mini" id="sxfbtn">
                <div class="mui-switch-handle"></div>
            </div>
        </div>
        <div>
            <div class="all-checkbox mui-input-row mui-checkbox mui-left">
                <label style="width:100%;">&nbsp;&nbsp;全选</label>
                <input type="checkbox" class="goods-check" id="allcheck">
            </div>
            <div class="shop-total">
                <span class="tol">总价：<i class="total" id="money">0.00</i></span>
            </div>
            <a href="javascript:void(0);" class="settlement h-setLink" data-url="/ijob/api/ApplySettlementController/toScanSettlement">立即结算</a>
        </div>
    </div>
    <%--<div id="homepage"></div>--%>
</div>
</body>
</html>

<script type="text/javascript">
    $("#allcheck").prop('checked', false);
    var totalsxf = 0;
    var totalMoney = 0;
    //$("#homepage").loadPage({path:"/h5/homepage"});
    $("#djsinfotemplate").loadData({condition:{id:ijob.storage.get("scanSettle.id")}}).then(function (result) {
        if(result.data.list[0]==null){
            $(".nodata").remove();
            mui.alert("暂无待结算人员！");
        }
        if(result.data.list[0].isEdit == false){
            $(".set_put").attr("readonly","readonly");
            $(".set_put").click(function () {
                $(this).blur();
            });
        }
        //若取消一个，则全部选项取消
        $(".evList").on('click',"input[name='checkbox1']",function() {
            var leng1 = $("input[name='checkbox1']:checked");
            var leng2 = $("input[name='checkbox1']");
            if (leng1.length == leng2.length) {
                $("#allcheck").prop('checked', true);
                TotalPrice();
            } else {
                $("#allcheck").prop('checked', false);
                TotalPrice();
            }
        });

        $(".evList").on('input propertychange',"input[class='set_put']",function() {
            TotalPrice();
        });

        //若取消一个，则全部选项取消
        $(".evList").on('click',"input[name='checkbox1']",function() {
            var leng1 = $("input[name='checkbox1']:checked");
            var leng2 = $("input[name='checkbox1']");
            if (leng1.length == leng2.length) {
                $("#allcheck").prop('checked', true);
                TotalPrice();
            } else {
                $("#allcheck").prop('checked', false);
                TotalPrice();
            }
        });
        // 全选
        $("#allcheck").on("change", function () {
            if ($(this).prop('checked') == true){
                $("input[name='checkbox1']").prop('checked',true);
                TotalPrice();
            }else {
                $("input[name='checkbox1']").prop('checked',false);
                TotalPrice();
            }
        });

        //输出总价
        function TotalPrice() {
            totalMoney = 0;
            totalsxf = 0;
            $(".evList input[name='checkbox1']:checked").each(function(i,item){
                var m = 0;
                m =  parseFloat($(this).parent().next().find("input[class='set_put']").val());
                totalMoney+= (isNaN(m)?0:m);
                totalsxf += (Math.ceil(100*m*0.006)/100)||0;
               /* m = parseFloat($(this).parent().next().find("span[class='rewardMoney']").text());
                totalMoney+= (isNaN(m)?0:m);*/
            });
            $("#money").text(template.money(totalMoney+(hasSxf==true?totalsxf:0)));
            $("#sxf").text(template.money(totalsxf));
            if( $("#money").text().length >= 10){
                $("#money").parent().css({"font-size":"0.40rem","color":"#ff3b30"});
            }else{
                $("#money").parent().css({"font-size":"0.48rem","color":"#108ee9"});
            }
        }

        $(".h-close").text(ijob.storage.get("applySettlement.title"));
    });

    var hasSxf = false;
    $("#sxfbtn").click(function(){
        if ($("#sxfbtn").hasClass("mui-active")) {
            hasSxf = true;
        }else{
            hasSxf = false;
        }
        $("#money").text(template.money(totalMoney+(hasSxf==true?totalsxf:0)));
    });
    $(".settlement").click(function () {
       /* var sxfs = 0;
        $("input[name='checkbox1']:checked").each(function(i,item){
            var temp = $(this).parent(".inputCheck").next(".evLb-man").find(".set_put");
            sxfs +=(Math.ceil(100*temp.val()*0.006)/100)||0;
        });*/
      /*  var btnArray = ['是', '否'];
        mui.confirm('是否代付提现手续费，手续费总共'+totalsxf+'元', null, btnArray, function(e) {
            var k = 0;
            if (e.index == 0) {//点击是
                k = 0.006;
            }*/
            var k = 0;
            if ($("#sxfbtn").hasClass("mui-active")) {
                k = 0.006;
            }
            var msg = "";
            var scanSettle  = {id:ijob.storage.get("scanSettle.id"),version:$("#allVersion").val(),scanSettleMemberList:[]};
            var arr = $("input[name='checkbox1']:checked").each(function(i,item){
                var temp = $(this).parent(".inputCheck").next(".evLb-man").find(".set_put");
                var obj = {
                    id:$(item).data("id"),
                    version:temp.data("version"),
                    salary:Math.ceil(100*temp.val())/100+Math.ceil(100*temp.val()*k)/100||0,
                    sxf:(Math.ceil(100*temp.val()*k)/100)||0
                };
                if(obj.salary<0.01){
                    msg += "单人最小支付金额为0.01元";
                    // mui.alert("最小支付金额为0.01元");
                    return false;
                }
                scanSettle.scanSettleMemberList.push(obj);
            });
            if(!msg){
                $(".settlement").btPost(scanSettle,function(result1){
                    if(result1.success){
                        /*window.history.replaceState('','', "forward?path=/h5/zp/historyPosition");*/
                        ijob.storage.set("tab","yjs:1");
                        var order = {order:{refID:result1.data.id,fee:Math.round(result1.data.dailySalary*100),description:("薪资总额"+result1.data.dailySalary+"元"+(k>0?",其中代付手续费"+Math.round(totalsxf*100)/100+"元":"")),type:enums.WxOrderType.ScanSettle}};
                        ijob.url.next.set("/ijob/api/ApplySettlementController/scanSettleCallback","json",settlecallback);
                        ijob.gotoPage({url:'/ijob/api/WeixinController/order',data:order});
                    }
                });
            }else{
                mui.alert(msg);
            }

        // });
    });

    function settlecallback(data) {
        window.location.href = "forward?path=/h5/zp/historyPosition";
    }
    //如果有回调方法，调用回调方法
    ijob.callbackfunc.call();

    function checkVal(arg){
        if($(arg).val() < 0){
            $(arg).val(-$(arg).val());
        }else if($(arg).val() == 0){
            $(arg).val(dailySalaryMoney);
        }
        if ($(arg).val().length > 7){
            $(arg).val($(arg).val().substr(0,7));
        }
    }

    function swit() {
        $(".mui-switch").click(function () {
            if(screen.height == 568 && screen.width == 320){
                if($(".mui-switch").hasClass("mui-active")){
                    $(".mui-switch-handle").css("transform","translate(20px, 0px)");
                }
            }else if (screen.height == 1024 && screen.width == 768){
                if($(".mui-switch").hasClass("mui-active")){
                    $(".mui-switch-handle").css("transform","translate(30px, 0px)");
                }
            }else {
                if($(".mui-switch").hasClass("mui-active")){
                    $(".mui-switch-handle").css("transform","translate(22px, 0px)");
                }
            }

        })
    }
    swit();
</script>