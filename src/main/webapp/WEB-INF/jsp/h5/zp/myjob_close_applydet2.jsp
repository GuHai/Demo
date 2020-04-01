

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>申请结算详情</title>
	<jsp:include page="../zp/base/resource.jsp"/>
</head>
<body>

<style>
.mui-checkbox, .mui-radio{float:left;width:0.800rem;height:0.800rem;margin-top:5px;}
.mui-input-row label~input, .mui-input-row label~select, .mui-input-row label~textarea{padding-left:2px;}
.mui-checkbox input[type=checkbox], .mui-radio input[type=radio]{top:0.213rem;}
</style>

<div class="Settlement" style="margin-top: 0rem !important;">
	<div class="Set-com">
		<script id="todayJob" type="text/html" data-url="/ijob/api/ApplySettlementController/findList/{position.id}/{position.userID}"  data-type="POST">
			{{each list as apply}}
				<div class="Set-comList">
					<div class="mui-input-row mui-checkbox mui-left">
						<label></label>
						<input name="checkbox"  data-id="{{apply.id}}" data-fee="{{apply.applyPay}}" value="Item 1" type="checkbox" />

<%--
						<input name="checkbox" value="Item 1" type="checkbox">
--%>
					</div>
					<a href="javascript:void(0)">
						<div class="Set-comT">
							<div class="Set-comTp1">
								<p>{{apply.createTime | dateFormat:'yyyy年MM月dd日'}}</p>
								<span>{{apply.applyPay}}元</span>
							</div>
							<div class="Set-comTp2">
								<p>{{apply.applyReason}}</p>
								<span>{{apply.state | enums:'AgreeStatus'}}</span>
							</div>
						</div>
					</a>
				</div>
			{{/each}}
		</script>
	</div>
</div>
<%--<div class="hlink">
	<a href="javascript:void(0);" class="mui-hbut-on">拒绝</a>
	<a href="javascript:void(0);" class="btn_remove"  >去结算</a>
</div>--%>
<div class="h-setbox">
	<a href="javascript:void(0);" style="flex:1;" >共计：￥<span id="money">0</span></a>
	<a href="javascript:void(0);" class="h-setLink" style="width:3.333rem;"  data-url="/ijob/api/ApplySettlementController/toSettlement">去结算</a>
</div>

<script type="text/javascript">
        $("#todayJob").loadData({condition:ijob.storage.get("applySettlement")}).then(function(result1) {

            $(".Set-com").on('click',function(){
                var totalMoney = 0;
                $(".Set-com input[name='checkbox']:checked").each(function(i,item){
                    totalMoney+= parseFloat($(this).data("fee"));
                });
                $("#money").text(totalMoney);
            });



            $(".h-setLink").click(function(){
                var len = $(".Set-com").find("input[type='checkbox']:checked").length;
                if(len==0){
                    mui.toast("请选择至少一条需要结算申请项");
                }else{
                    var appeals = [];
                    $(".Set-com").find("input[type='checkbox']:checked").each(function(i,item){
                        appeals.push({positionID:result1.data.list[0].positionID,id:$(this).data("id"),applyPay:$(this).data("fee")});
                    });

                    $(this).btPost(appeals,function(result){
                        if(result.success){
                            var  order = {order:{refID:result.data.list[0].id,fee:result.data.list[0].totalMoney*100,description:("薪资结算总共"+result.data.list[0].size+"项，总共"+result.data.list[0].totalMoney+"元"),type:enums.WxOrderType.Settlement}};
                            ijob.url.next.set("/ijob/api/ApplySettlementController/settleCallback");
                            ijob.gotoPage({url:'/ijob/api/WeixinController/order',data:order});
                        }
                    });
                }
            });
        });
</script>
	
</body>
</html>
