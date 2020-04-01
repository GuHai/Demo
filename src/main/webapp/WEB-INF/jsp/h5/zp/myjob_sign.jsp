
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
<script>
   /* (function ($) {
        $.init();
    })(mui);*/
</script>
<style>
.mui-checkbox, .mui-radio{float:left;width:0.800rem;height:0.800rem;margin-top:0.400rem;}
.mui-input-row label~input, .mui-input-row label~select, .mui-input-row label~textarea{padding-left:2px;}
.JobV{padding-top:5px;}
.evLb-man .evLb-mT{padding:0;}
.Dman-site{padding:0;}
.hev-bise .hev-Br>a{width:1.227rem;}
.hev-bise .hev-Br>a.hev-BrSTwo{border:1px solid #108ee9;color:#108ee9;}
.JobV>a{height:1.333rem;}
.JobV>a>p{margin:0;color:#666;line-height:0.560rem;}
input, select, textarea{font-size:0.560rem;}
.classify{position:fixed;z-index:9;top:0px;}
.JobV{position:fixed;z-index:9;top:1.08rem;}
.mui-checkbox.mui-left input[type=checkbox], .mui-radio.mui-left input[type=radio]{left:-3px;}
.mui-input-row label{line-height:0px;}
</style>

<div class="classify">
	<%--<div id="state">
		<span id="stateput" class="seateput">全部</span>
		<i class="iconfont icon-arrow-down1 icon-arrow-float"></i>
	</div>--%>
	<div class="rx-dateDa">
		<!-- <input type="date" class="csput" name="" value="2018-01-12" /> -->
		<i class="iconfont icon-riliriqi icon-arrow-float"></i>
		<input id="Dtime" style="color:#108ee9;text-align:center;font-size:0.400rem;border:0;" data-options='{"type":"date","beginYear":1956,"endYear":2025}' value="1990-10-10" />
	</div>
</div>

<div>
	<script type="text/html" id="positionsignintemplate1" data-url="/ijob/api/SigninController/zp/getSigninInfo/0" data-type="POST">
		{{each list as signinAndCount}}
		<div class="JobV JobVtwo" >
			<%--<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_sign?id={data.id}'})" class="JobVon">--%>
				<%--<p>{{signinAndCount.countMap.noSureCount}}</p>--%>
				<%--<p>未确认</p>--%>
			<%--</a>--%>
			<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_sign4?id={data.id}'})" class="JobVon">
				<p>{{signinAndCount.countMap.noSigninCount}}</p>
				<p>未签到</p>
			</a>
			<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_sign3?id={data.id}'})" class="">
				<p>{{signinAndCount.countMap.signinCountSum}}</p>
				<p>待确认</p>
			</a>
			<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_sign2?id={data.id}'})"  class="">
				<p>{{signinAndCount.countMap.sureCount}}</p>
				<p>待结束</p>
			</a>

			<%--<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_sign4?id={data.id}'})" class="">--%>
				<%--<p>{{signinAndCount.countMap.noSigninCount}}</p>--%>
				<%--<p>未签到</p>--%>
			<%--</a>--%>
		</div>
		<div class="evList rx_evList" style="background:#f2f5f7;margin:2.533rem auto 2.267rem auto;">
			{{each signinAndCount.signinList as signin}}
			<div class="evLbox evLboxTwo">
				<div class="mui-input-row mui-checkbox mui-left">
					<label></label>
					<input name="checkbox" value="{{signin.id}}" version="{{signin.version}}" resumeID="{{signin.resumeID}}" beenType="{{signin.state}}" date="{{signin.signinList[0].signTime |dateFormat:'yyyy-MM-dd'}}" positionID="{{signin.positionID}}" userID="{{signin.resume.userID}}" type="checkbox">
				</div>
				<div class="evLb-man">
					<div class="evLb-mT">
						<div class="evLb-qq">
							<div class="qqbox">
								{{if signin.resume.user.attachment == null}}
								<img src="{{signin.resume.user.weixin.headimgurl}}" />
								{{else}}
								<img src="{{signin.resume.user.attachment |absolutelyPath}}"onerror="this.src='{{signin.resume.user.weixin.headimgurl}}';this.onerror=null;" />
								{{/if}}
							</div>
							<div class="tbox">
								<p class="tboxS">{{signin.resume.resumeName}}
									<span style="color:#999;">|</span>
									<span style="font-size:0.373rem;">{{signin.resume.educationalList[0] |ifNull:'无','education'}}</span>
								</p>
								<div class="h-sign">
									<p>{{signin.signinList[0].signTime |dateFormat:'hh:mm'}}</p>
									<p class="h-sP2">今日签到<span>{{signin.signinList.length |ifNull:'0'}}</span>次</p>
								</div>
							</div>
							<a href="javascript:void(0);" class="h-look" style="color:#333;">
								{{if signin.state == 3}}
								培训中
								{{else}}
								工作中
								{{/if}}
							</a>
						</div>
					</div>
					<div class="Dman-site">
						<p>
							<span class="iconfont icon-fujin icon-fujin-hue"></span>
							{{signin.signinList[0].address.detailedAddress}}
							<span class="iconfont icon-arrow-right icon-float"></span>
						</p>
					</div>
					<img  src="/ijob/static/images/{{signin  | signState }}.png" class="h-tricon">
				</div>
			</div>
			{{/each}}
		</div>
		<%--<div class="hev-bise">--%>
			<%--<div class="hev-BL" style="width:20%;">--%>
				<%--<div class="mui-input-row mui-checkbox mui-left"  style="margin-top:0px;width:2.133rem;">--%>
					<%--<label style="width:100%;">&nbsp;&nbsp;全选</label>--%>
					<%--<input name="checkbox1" class="checkbox1" value="Item 1" type="checkbox">--%>
				<%--</div>--%>
			<%--</div>--%>
			<%--<div class="hev-Br" style="width:80%;">--%>
				<%--<a href="javascript:void(0);" data-url="/ijob/api/SigninController/zp/sureSignin" class="hev-BrS">到岗</a>--%>
				<%--<a href="javascript:void(0);" data-url="/ijob/api/BeenrecruitedController/h5/zp/refuseOrAgreeList" onclick="admissionOrRefuse(this,0)" class="hev-BrSTwo">录取</a>--%>
				<%--<a href="javascript:void(0);" data-url="/ijob/api/BeenrecruitedController/h5/zp/refuseOrAgreeList" onclick="admissionOrRefuse(this,1)" >辞退</a>--%>
			<%--</div>--%>
		<%--</div>--%>
		{{/each}}
	</script>
</div>


</body>
</html>
<script>

    /**
	 * 确认到岗
     * @param arg dom节点对象
     */
    var config = {condition:{
        positionID:ijob.storage.get("position.id")
		}};
	function sureSignin(arg){
	    var params = {};
        params.userIdList = new Array();
	    var inputList = $("input[name='checkbox']:checked").is(":checked");
	    if(inputList==false){
            mui.toast("尚未选择将要操作的用户！");
		}else{
            params.positionID = $(inputList[0]).attr("positionID");
            params.date = $(inputList[0]).attr("date");
            for (var i = 0 ;i < inputList.length ; i++){
                params.userIdList.push($(inputList[i]).attr("userID"));
            }
            $(arg).btPost(JSON.stringify(params),function (data) {
				if (data.code == "200"){
                    $("#positionsignintemplate1").loadData(config).then(function(result){
                        init ();
                    });
				}else{
					mui.alert(data.msg);
				}
            })
		}
	}

    /**
	 * 录取或者拒绝
     * @param arg dom 节点对象
	 * @param type 类别
     */
    function admissionOrRefuse(arg,type){
        var input = $("input[name='checkbox']:checked");
        var params = new Array();
        for (var i = 0 ;i < input.length ; i++){
            var been = {};
            been.version = $(input[i]).attr("version");
            been.resumeID = $(input[i]).attr("resumeID");
            been.positionID = $(input[i]).attr("positionID");
            been.id = $(input[i]).val();
            if (type == "0"){
                been.state = 4 ;
            }else{
                been.state = 6 ;
                been.dismiss = 1 ;
            }
            if(type == "0"){
                if ($(input[i]).attr("beenType") != "4"){
                    params.push(been);
				}
			}else{
                params.push(been);
			}
        }
        if(params.length>0){
            $(arg).btPost(params,function (data) {
                mui.alert("操作成功");
                $("#positionsignintemplate1").loadData(config).then(function(result){
                    init ();
                });
            })
		}else{
            mui.toast("请至少选择一项");
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
    $("#positionsignintemplate1").loadData(config).then(function(result){
        var userPicker = new mui.PopPicker();
        userPicker.setData([{
            value: '',
            text: '全部'
        }, {
            value: '4',
            text: '工作中'
        }, {
            value: '3',
            text: '培训中'
        }]);
        /*var showUserPickerButton = document.getElementById('state');
        showUserPickerButton.addEventListener('tap', function(evrnt) {
            userPicker.show(function(items) {
                $("#stateput").text(items[0].text);
                config.condition.beenState = parseInt(items[0].value);
                $("#positionsignintemplate1").loadData(config).then(function () {
                    init();
                })
            });
        },false);*/
        init ();

        $(".hev-BrS").click(function(){
            var _this = $(this);
            var params = {};
            params.userIdList = [];
            var inputList = $(".evLbox").find("input[name='checkbox']:checked");
            if(inputList&&inputList.length>0){
                params.positionID = $(inputList[0]).attr("positionID");
                params.date = $(inputList[0]).attr("date");
                for (var i = 0 ;i < inputList.length ; i++){
                    params.userIdList.push($(inputList[i]).attr("userID"));
                }
                _this.btPost(JSON.stringify(params),function (data) {
                    if (data.code == "200"){
                        $("#positionsignintemplate1").loadData(config).then(function(result){
                            init ();
                        });
                    }else{
                        mui.alert(data.msg);
                    }
                })
            }else{
                mui.toast("尚未选择将要操作的用户！");
            }
		});
    });
     function init (){
        var date = new Date().format("yyyy-MM-dd");
	    $("#Dtime").val(date);
        //集合时间
        var jihe=document.getElementById("Dtime");
        jihe.addEventListener('tap', function() {
            var optionsJson = this.getAttribute('data-options') || '{}';
            var options = JSON.parse(optionsJson);
            var picker = new mui.DtPicker(options);
            picker.show(function(rs) {
                $("#Dtime").val(rs.text);
                config.condition.signinTime = rs.value;
                $("#positionsignintemplate1").loadData(config).then(function (result) {
                });
                picker.dispose();
            });
        }, false);

         //全选
         $(".checkbox1").on("change", function () {
             $("input[name='checkbox']").prop('checked',$(this).prop('checked'));
         });
	}


</script>


