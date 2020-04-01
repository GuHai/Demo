

	<%@ page contentType="text/html;charset=UTF-8" language="java" %>
	<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>待结算</title>
   <jsp:include page="../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/index/index.css">

</head>
<body>

<style>
.JobV{position:fixed;z-index:9;top:0;}
.duty-man{background:#fff;padding:0;}
.mui-checkbox, .mui-radio{float:left;width:0.8rem;height:0.8rem;margin-top:1.92rem;}
.mui-input-row label~input, .mui-input-row label~select, .mui-input-row label~textarea{padding-left:2px;}
.mui-input-row label{line-height:0.16rem;}
.list{margin-top:0.933rem}
</style>

<div class="wrap">
	<div class="main">
		<div class="JobV JobVtwo">
			<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_close_apply'})" class="JobVon">申请结算</a>
			<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_close2_record2'})" class="">结算记录</a>
			<a href="javascript:void(0);"  onclick="ijob.gotoPage({path:'/h5/zp/myjob_close_pay'})" class="">支付订单</a>
			<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_close2_record3'})" class="">结算薪资</a>
        </div>
	    <div class="list">
            <ul class="list-ul">
                <li class="list-li">
                    <div class="list-container"><%--/ijob/api/PositionController/zp/getUserPositionWaitApplySettlementInfoByPositionID/{position.id}--%>
						<script type="text/html" id="appleylist" data-res="LOCAL" data-url="position.list[{position.index}]">
							{{each list as posi}}
							<div class="mui-input-row mui-checkbox mui-left">
								<label></label>
								<input name="checkbox" value="Item 1" type="checkbox">
                        	</div>
							<div class="duty-man">
								<div class="Dman-name">
									<div class="Dman-qq">头像盒子</div>
									<div class="Dnam-t">
										<div class="Dnam-tT">
											<p class="DT-p1">赵朝朝</p>
										</div>
										<div class="Dnam-tF">
											<p class="DT-p2">工作中</p>
										</div>
										<div class="h-apply">
											<a href="javascript:void(0);" class="">去结算</a>
											<a href="javascript:void(0);" class="h-applyhue">拒绝</a>
										</div>
									</div>
								</div>
								<div class="Dman-state">
									<p class="Ds-p1">申请结算: </p>
									<p class="Ds-p2">{{posi.applySettlementList[0].user.applySettlementSum |ifNull:'0'}}次，未处理:{{posi.applySettlementList[0].user.applySettlementNoHandle |ifNull:'0'}}次，拒绝:{{posi.applySettlementList[0].user.applySettlementRefuse |ifNull:'0'}}次</p>
									<i class="iconfont icon-arrow-right" style="float:right;"></i>
								</div>
								<div class="Dman-state">
									<p class="Ds-p1">共 签 到 : </p>
									<p class="Ds-p2">{{posi.applySettlementList[0].user.signinCount |ifNull:'0'}}天,预计薪资
										{{if posi.applySettlementList[0].user.signinCount == null}}
										0
										{{else}}
										{{posi.applySettlementList[0].user.signinCount * posi.dailySalary}}
										{{/if}}
										元</p>
									<i class="iconfont icon-arrow-right" style="float:right;"></i>
								</div>
								<div class="Dman-state">
									<p class="Ds-p1">结算总额: </p>
									<p class="Ds-p2"><span>{{posi.applySettlementList[0].user.applySettlementSum}}元</span>，总笔数1笔，已确认1笔</p>
									<i class="iconfont icon-arrow-right" style="float:right;"></i>
								</div>
							</div>
							{{/each}}
						</script>
                    </div>
                </li>					
	    	</ul>
	    </div>
	</div>
</div>
<div class="hev-bise">
	<div class="hev-BL">
		<div class="mui-input-row mui-checkbox mui-left" onclick="selectALLNO();" style="margin-top:0px;width:2.133rem;">
            <label style="width:100%;">&nbsp;&nbsp;全选</label>
            <input name="checkbox1" value="Item 1" type="checkbox">
        </div>
	</div>
	<div class="hev-Br">
		<a href="javascript:void(0);" class="hev-BrS">去结算</a>
		<a href="javascript:void(0);">拒绝</a>
	</div>
</div>

<script type="text/javascript">
    $("#appleylist").loadData().then(function (result) {
        //result 服务器响应过来的数据
    });
</script>

</body>
</html>

