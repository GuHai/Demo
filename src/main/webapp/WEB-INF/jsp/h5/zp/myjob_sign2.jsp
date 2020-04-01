

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>签到</title>
	<%--<jsp:include page="../zp/base/resource.jsp"/>--%>
</head>
<body>
<style>
	.mui-checkbox, .mui-radio{float:left;width:0.800rem;height:0.800rem;margin-top:0.400rem;}
	.mui-input-row label~input, .mui-input-row label~select, .mui-input-row label~textarea{padding-left:2px;}
	.JobV{padding-top:5px;}
	.evLb-man .evLb-mT{padding:0;}
	.Dman-site{padding:0;}
	.hev-bise .hev-Br>a{width: 2.5rem;text-align:  center;margin-left: 0;}
	.hev-bise .hev-Br>a.hev-BrSTwo{border:1px solid #108ee9;color:#108ee9;}
	.JobV>a{height:1.333rem;}
	.JobV>a>p{margin:0;color:#666;line-height:0.560rem;}
	input, select, textarea{font-size:0.400rem;}
	.classify{position:fixed;z-index:9;top:0px;}
	.JobV{position:fixed;z-index:9;top:1.08rem;}
	.mui-checkbox.mui-left input[type=checkbox], .mui-radio.mui-left input[type=radio]{left:-3px;}
	.mui-input-row label{line-height:0px;}
	.hev-bise .hev-Br > a.tips{border: 0;width: 4.95rem;color: #999;font-size: 0.3rem;border-radius: 0;line-height: 2.5;}
</style>
	<div class="evList rx_evList" style="background:#f2f5f7;margin:2.533rem auto 2.267rem auto;">
		<script type="text/html" id="positionsignintemplate2" data-url="/ijob/api/SigninController/zp/getSigninInfo/1" data-type="POST">
		{{each list as signin}}
			<div class="evLbox evLboxTwo">
				<div class="mui-input-row mui-checkbox mui-left">
					<label></label>
					<input name="checkbox" value="{{signin.id}}" data-signid="{{signin.signinList[0].id}}"  version="{{signin.version}}" resumeID="{{signin.resumeID}}" beenType="{{signin.state}}" date="{{signin.signinList[0].signTime |dateFormat:'yyyy-MM-dd'}}" positionID="{{signin.positionID}}" userID="{{signin.resume.userID}}" type="checkbox">
				</div>
				<div class="evLb-man">
					<div class="evLb-mT">
						<div class="evLb-qq">
							<div class="qqbox">
								<img src="/ijob/upload/{{signin.resume.user.attachment |absolutelyPath}}"onerror="this.src='{{signin.resume.user.weixin.headimgurl}}';this.onerror=null;" />
							</div>
							<div class="tbox">
								<p class="tboxS">
									{{signin.resume.user.realName}}
									<span id="line" style="color:#999;">|</span>
									<span id="edu" style="font-size:0.373rem;">{{signin.resume.educationalList[0]}}</span>
									<a href="/ijob/api/ResumeController/h5/zp/index/previewOtherUserResume/{{signin.resume.id}}" class="h-look">查看简历</a>
								</p>
								<div class="h-sign">
									<p>{{signin.signinList[0].signTime |dateFormat:'hh:mm'}}</p>
									<p class="h-sP2">今日签到<span>{{signin.signinList.length |ifNull:'0'}}</span>次</p>
								</div>
							</div>
						</div>
					</div>
					<div class="Dman-site">
						<p  onclick="ijob.gotoPage({'path':'/h5/qz/myjob/sign_recode2?sign.positionID={{signin.signinList[0].positionID}}&sign.userID={{signin.signinList[0].userID}}'})">
							<span class="iconfont icon-fujin icon-fujin-hue"></span>
							{{signin.signinList[0].address.detailedAddress}}
							<span class="iconfont icon-arrow-right icon-float"></span>
						</p>
					</div>
				</div>
			</div>
			{{/each}}
		</script>
	</div>
	<div class="hev-bise">
		<div class="hev-BL" style="width:18%;">
			<div class="mui-input-row mui-checkbox mui-left" style="margin-top:0px;width:2.133rem;">
				<label style="width:100%;line-height: 3px;margin-left: 0.133rem;">&nbsp;&nbsp;全选</label>
				<input name="checkbox1" class="checkbox1" value="Item 1" type="checkbox">
			</div>
		</div>
		<div class="hev-Br" style="width:82%;">
			<a href="javascript:void(0);" class="hev-BrS" data-url="/ijob/api/SigninController/changeWorkState/2">结束当天工作</a>
			<a href="javascript:void(0);" class="tips">24点之后系统会默认结束当天工作</a>
		</div>
	</div>


<script type="text/javascript">
    /**
     * 录取或者拒绝
     * @param arg dom 节点对象
     * @param type 类别
     */
    var config = {condition:{
            positionID:ijob.storage.get("position.id")
        }};
    function admissionOrRefuse(arg,type) {
        var inputList = $("input[name='checkbox']:checked");
        if(inputList&&inputList.length>0){
            var params = new Array();
            for (var i = 0; i < inputList.length; i++) {
                var been = {};
                been.version = $(inputList[i]).attr("version");
                been.resumeID = $(inputList[i]).attr("resumeID");
                been.positionID = $(inputList[i]).attr("positionID");
                been.id = $(inputList[i]).val();
                if (type == "0") {
                    been.state = 4;
                } else {
                    been.state = 6;
                    been.dismiss = 1;
                }
                if (type == "0") {
                    if ($(inputList[i]).attr("beenType") != "4") {
                        params.push(been);
                    }
                } else {
                    params.push(been);
                }
            }
            $(arg).btPost(params, function (data) {
                mui.alert("操作成功");
                $("#positionsignintemplate2").loadData(config).then(function (result) {
                });
            })
        } else {
            mui.toast("尚未选择将要操作的用户！");
        }
    }
    Date.prototype.format = function(fmt) {
        var o = {
            "M+" : this.getMonth()+1,                 //月份
            "d+" : this.getDate(),                    //日
            "h+" : this.getHours(),                   //小时
            "m+" : this.getMinutes(),                 //分
            "s+" : this.getSeconds(),                 //秒
            "q+" : Math.floor((this.getMonth()+3)/3), //季度
            "S"  : this.getMilliseconds()             //毫秒
        };
        if(/(y+)/.test(fmt)) {
            fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
        }
        for(var k in o) {
            if(new RegExp("("+ k +")").test(fmt)){
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
            }
        }
        return fmt;
    }

    $("#positionsignintemplate2").loadData(config).then(function(result){


        var ids = [];
        $(".hev-BrS").click(function(){
            ids = [];
            $(".evList input:checked").each(function (i,item){
                ids.push({id:$(item).data("signid")});
            });
            if (ids.toString() == ""){
                console.log(menu);
                mui.toast("请选择需要操作的数据！");
            }else {
                $(this).btPost(ids, function (result) {
                    if (result.success) {
                        ijob.menu.set("myjob:2");
                        window.location.reload();
                    } else {
                        mui.toast(result.msg);
                    }
                });
            }
        });

        function txt() {
            if($("#edu").text() == null || $("#edu").text() == undefined || $("#edu").text().trim(" ") == ''){
                $("#line").hide();
            }
        }
        txt();
    });


</script>

</body>
</html>


