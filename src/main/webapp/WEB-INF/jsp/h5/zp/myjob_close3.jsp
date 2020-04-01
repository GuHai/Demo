<%@ page contentType="text/html;charset=UTF-8" language="java" %>
	<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>结算</title>
	<jsp:include page="../zp/base/resource.jsp"/>
	<link rel="stylesheet" href="/ijob/static/css/index/SearchJob.css">
	<link rel="stylesheet" href="/ijob/static/css/mine/add_preview.css">
	<link rel="stylesheet" href="/ijob/static/css/part/myjob.css">

	<style>
		.evList .evLb-man {width: 90%;}
	</style>
</head>
<body>

<div class="wrap">
	<div class="h-close"></div>
	<form name="form" action=""  method="post">
		<div class="details-calendar">
			<div class="box">
				<section class="date" data-editable="true">
					<div class="data-head">
						<div class="prev mui-icon mui-icon-back"></div>
						<div class="tomon"><span class="year"></span>年 <span class="month">1</span>&nbsp;&nbsp; 月</div>
						<div class="next mui-icon mui-icon-forward"></div>
					</div>
					<ol>
						<li>周日</li>
						<li>周一</li>
						<li>周二</li>
						<li>周三</li>
						<li>周四</li>
						<li>周五</li>
						<li>周六</li>
					</ol>
					<ul id="jobDate">

					</ul>
				</section>
			</div>
		</div>
	</form>
	<div class="evList" style="margin-bottom:1.467rem;">
		<script id="todayJob" type="text/html" data-url="/ijob/api/PositionController/zp/simpleSignList" data-type="POST">
			{{each list[0].signins as sign index}}
				<a href="javascript:void(0);" class="evLbox">
					<div class="mui-input-row mui-checkbox mui-left">
						<label></label>

						<input name="checkbox1"  data-ids="{{sign.ids}}" data-id="{{sign.userID}}" data-index="{{index}}" data-fee="" value="Item 1" type="checkbox" class="goods-check GoodsCheck">

					</div>
					<div class="evLb-man">
						<div class="evLb-mT">
							<div class="evLb-qq"><div class="qqbox"><img src="/ijob/upload/{{sign.user.attachment | absolutelyPath}}" onerror="this.src='{{sign.user.weixin.headimgurl}}';this.onerror=null;" />
							</div>
								<div class="tbox">
									<p class="tboxS">{{sign.user.mainName}}</p>
									<%--<p>{{apply.applyReason}}</p>--%>
									<p class="tsala"><span>共签到：{{sign.num }}</span>次，预计薪资<span class="salary" data-num="{{sign.num }}"></span>元</p>
                                    {{if sign.rewardMap != null&&sign.rewardMap.forwardName!=null}}
									<p class="reward">另需支付代理人{{sign.rewardMap.forwardName}}赏金<span class="rewardMoney" id="{{index}}" data-userID="{{sign.rewardMap.userID}}" data-positionID="{{sign.rewardMap.positionID}}">{{sign.rewardMap.reawrdMoney}}</span>元</p>
                                    {{/if}}
								</div>
							</div>
							{{if sign.hasUrge==true}}
							<div class="press">催款中</div>
							{{/if}}
							<div class="h-settle"><input type="number" class="setput" maxlength="7" onblur="checkVal(this)" data-num="{{sign.num }}" data-index="{{index}}" /><span class="yuan">元</span></div>
						</div>
					</div>
				</a>
			{{/each}}
		</script>
	</div>
	<%--<div class="h-setbox">--%>
		<%--<a href="javascript:void(0);" style="flex:1;" >共计：￥<span id="money">0</span></a>--%>
		<%--<a href="javascript:void(0);" class="h-setLink"   data-url="/ijob/api/ApplySettlementController/toSettlement">去结算</a>--%>
	<%--</div>--%>
	<div class="payment-bar">
		<div class="all-checkbox mui-input-row mui-checkbox mui-left">
			<label style="width:100%;">&nbsp;&nbsp;全选</label>
			<input type="checkbox" class="goods-check" id="allcheck">
		</div>
		<div class="shop-total">
			<strong>总价：<i class="total" id="money">0.00</i></strong>
		</div>
		<a href="javascript:void(0);" class="settlement h-setLink" data-url="/ijob/api/ApplySettlementController/toSettlement">立即结算</a>
	</div>
</div>
</body>
</html>
<script>

</script>
<script type="text/javascript">
    (function ($) {
        window.addEventListener('pageshow', function (e) {
            // 通过persisted属性判断是否存在 BF Cache
            if (e.persisted) {
                location.reload();
            }
        });
    })(mui);
    function showSalary (result){
        $(".salary").each(function (i,item) {
            $(this).text($(this).data("num")*result.data.list[0].dailySalary);
            var rewardMoneyTags = $(".rewardMoney");
            for (var i = 0 ; i < rewardMoneyTags.length ; i++){
                $(rewardMoneyTags[i]).text(parseFloat($(rewardMoneyTags[i]).text())*$(this).data("num"));
            }
        });
        $(".setput").each(function (i,item) {
            $(this).val($(this).data("num")*result.data.list[0].dailySalary);
        });
    }


	var appset = ijob.storage.get("applySettlement");
    var dailySalaryMoney = 1 ;
	$("#todayJob").loadData({condition:appset}).then(function(result){
	    console.log("=====>>"+result);
        dailySalaryMoney = result.data.list[0].dailySalary;
	    $(".setput").blur(function () {
			if(isNaN(this.value)||this.value==null||this.value==""){
			    this.value =result.data.list[0].dailySalary;
			}
        });

        showSalary(result);

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

        $(".evList").on('input propertychange',"input[class='setput']",function() {
            /*if(result.data.list[0].signins[$(this).data("index")].rewardMap){
                var rewardMoney = $(this).val()/result.data.list[0].signins[$(this).data("index")].rewardMap.hourlyWage*result.data.list[0].signins[$(this).data("index")].rewardMap.oneHourMoney;
                $("#"+$(this).data("index")).text(rewardMoney)
			}*/
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
		   var totalMoney = 0;
			$(".evList input[name='checkbox1']:checked").each(function(i,item){
			    var m = 0;
				m =  parseFloat($(this).parent().next().find("input[class='setput']").val());
			    totalMoney+= (isNaN(m)?0:m);
			    m = parseFloat($(this).parent().next().find("span[class='rewardMoney']").text());
                totalMoney+= (isNaN(m)?0:m);
			});
			$("#money").text(template.money(totalMoney));
        }

	    $(".h-close").text(ijob.storage.get("applySettlement.title"));


       var arr = [];
       var myarr = [];


       	if( result.data.list[0]){
            arr = arr.concat( ijob.getDateList(result.data.list[0].workDate));
            myarr = myarr.concat( ijob.getDateList(result.data.list[0].workDate));
        }
        $('.date').on('completionEvent', function() {
            $(".date").containDate(arr,myarr);
        });

        $(".date").on('dateClickEvent',function(event,state,dr){
            if(state){
                myarr.push(dr);
            }else{
                myarr.splice($.inArray(dr,myarr),1);
            }
            appset.workDate = "'"+myarr.join("','")+"'";
            $("#todayJob").loadData({condition:appset}).then(function(result1) {
                $(".nodata").remove();
                showSalary(result1);
            });

        });



        dateRenderInit();

        $(".h-setLink").click(function(){
            var arr = $('.setput');
            var sumMoney = 0;
            for (var i = 0 ; i < arr.length ;i++){
                if(parseFloat($(arr[i]).data('num')) > 0){
                    sumMoney = sumMoney + $(arr[i]).data('num');
				}
			}
            var len = $(".evList").find("input[type='checkbox']:checked").length;
            if(len==0){
                mui.toast("请选择至少一条需要结算的结算申请");
            }else if(sumMoney < 0){
                mui.toast("请输入正确的结算金额！");
			}
            else{
                if(sumMoney.length > 7){
                    sumMoney = sumMoney.substr(0,7);
				}
                var appeals = [];
                $(".evList").find("input[type='checkbox']:checked").each(function(i,item){
                    var appeal = {signIDS:$(this).data("ids"),userID:$(this).data("id"),positionID:result.data.list[0].id,workDate:JSON.stringify(ijob.getStrFromList(myarr)),applyPay:$(this).parent().next().find(".setput").val()}
					var rewardDocument = $("#"+$(this).data("index"));
                    if(rewardDocument.data("positionid")){
                        var rewardSetllment = {positionID:rewardDocument.data("positionid"),getRewardUser:rewardDocument.data("userid"),rewardMoney:parseFloat(rewardDocument.text())}
                        appeal.rewardSettlement = rewardSetllment;
					}
                    appeals.push(appeal);
                });
                $(this).btPost(appeals,function(result1){
                     if(result1.success){
                         window.history.replaceState('','', "forward?path=/h5/zp/index");
                         ijob.menu.set("myjob:2");
                         var  order = {order:{refID:result1.data.list[0].id,fee:result1.data.list[0].totalMoney*100,description:("薪资结算总共"+result1.data.list[0].size+"项，总共"+result1.data.list[0].totalMoney+"元"),type:enums.WxOrderType.Settlement}};
                         ijob.url.next.set("/ijob/api/ApplySettlementController/settleCallback");
                         ijob.gotoPage({url:'/ijob/api/WeixinController/order',data:order});
                     }
                });
            }
        });
	});

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


</script>