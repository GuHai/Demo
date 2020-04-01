

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>待结算</title>
    <jsp:include page="../zp/base/resource.jsp"/>
</head>
<body>

<style>
.mui-checkbox, .mui-radio{float:left;width:0.800rem;height:0.800rem;margin-top:0.400rem;}
.mui-input-row label~input, .mui-input-row label~select, .mui-input-row label~textarea{padding-left:2px;}
.mui-hbutton{position:fixed;bottom:0;z-index:3;}
</style>


<div class="JobV JobVtwo">
    <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_close_apply'})">申请结算</a>
    <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_close2_record2'})" class="JobVon">结算记录</a>
    <a href="javascript:void(0);"  onclick="ijob.gotoPage({path:'/h5/zp/myjob_close_pay'})" class="">支付订单</a>
    <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_close2_record3'})" class="">结算薪资</a>
 </div>
<div class="evList rx_evList" style="background:#f2f5f7;margin-top:0px;">
	<div class="evLbox evLboxTwo">
		<div class="evLb-man">
			<div class="evLb-mT">
				<div class="evLb-qq">
					<div class="qqbox"><img src="../../images/touxian.jpg" /></div>
					<div class="tbox">
						<p class="tboxS">赵朝朝</p>
						<p style="color:#ff3b30;font-size:0.320rem;">工作中</p>
					</div>
					<a href="javascript:void(0);" class="h-look" style="color:#ff3b30;">已结算</a>
				</div>
			</div>
			<div class="Dman-state">
				<p class="Ds-p1">共 签 到 : </p>
				<p class="Ds-p2">5天，9次，预计薪资400元</p>
				<i class="iconfont icon-arrow-right" style="float:right;"></i>
			</div>
			<div class="Dman-state">
				<p class="Ds-p1">结算总额: </p>
				<p class="Ds-p2"><span>380元</span>，总笔数1笔，已确定1笔</p>
				<i class="iconfont icon-arrow-right" style="float:right;"></i>
			</div>
		</div>
	</div>
	<div class="evLbox evLboxTwo">
		<div class="evLb-man">
			<div class="evLb-mT">
				<div class="evLb-qq">
					<div class="qqbox"><img src="../../images/touxian.jpg" /></div>
					<div class="tbox">
						<p class="tboxS">赵朝朝</p>
						<p style="color:#ff3b30;font-size:0.320rem;">工作中</p>
					</div>
					<a href="javascript:void(0);" class="h-look" style="color:#ff3b30;">已结算</a>
				</div>
			</div>
			<div class="Dman-state">
				<p class="Ds-p1">共 签 到 : </p>
				<p class="Ds-p2">5天，9次，预计薪资400元</p>
				<i class="iconfont icon-arrow-right" style="float:right;"></i>
			</div>
			<div class="Dman-state">
				<p class="Ds-p1">结算总额: </p>
				<p class="Ds-p2"><span>380元</span>，总笔数1笔，已确定1笔</p>
				<i class="iconfont icon-arrow-right" style="float:right;"></i>
			</div>
		</div>
	</div>
</div>
<div class="mui-hbutton">
	<a href="javascript:void(0);">去结算</a>
</div>

</body>
</html>


