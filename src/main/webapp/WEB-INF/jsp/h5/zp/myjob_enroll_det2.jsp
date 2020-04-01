

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>我的招聘</title>
	<jsp:include page="../zp/base/resource.jsp"/>

	<style>
		.mui-checkbox, .mui-radio {
			float: left;
			width: 0.800rem;
			height: 0.800rem;
			margin-top: 0.400rem;
		}

		.mui-input-row label ~ input, .mui-input-row label ~ select, .mui-input-row label ~ textarea {
			padding-left: 2px;
		}

		.JobV {
			position: fixed;
			z-index: 9;
			top:0;
		}

		.mui-input-row label {
			line-height: 0px;
		}
	</style>
</head>
<body>

<script type="text/html" id="enrollDet2" data-url="api/PositionController/zp/getPositionWait/{data.id}/2">

	<div class="JobV JobVtwo">
		<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_enroll_det?id={data.id}'})"  >新报名</a>
		<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_enroll_det2?id={data.id}'})" class="JobVon">待面试</a>
		<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_train?id={data.id}'})" class="">培训中</a>
		<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_work?id={data.id}'})" class="">工作中</a>
		<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_disqu?id={data.id}'})" class="">未录取</a>
	 </div>
	<div class="evList rx_evList" style="background:#f2f5f7;">
		{{each list as posi}}
			{{each posi.beenrecruitedList as been}}
			<div class="evLbox evLboxTwo">
				<div class="mui-input-row mui-checkbox mui-left">
					<label></label>
					<input name="checkbox" onclick="allSelect(this)" resumeID="{{been.resumeID}}" positionID="{{been.positionID}}" value="{{been.id}}" version="{{been.version}}" type="checkbox">
				</div>
				<div class="evLb-man">
					<div class="evLb-mT">
						<div class="evLb-qq">
							<input type="hidden" id="id" value="{{been.id}}" >
							<input type="hidden" id="version" value="{{been.version}}">
							<input type="hidden" id="beenRecruitedSum" value="{{been.beenRecruitedSum}}">
							<div class="qqbox"><img src="/ijob/upload/{{been.resume.user.attachment | absolutelyPath}}"  onerror="this.src='{{been.resume.user.weixin.headimgurl}}';this.onerror=null;" /></div>
							<div class="tbox">
								<p class="tboxS">{{been.resume.user.realName | ifNull:'尚未填写'}}
									<span style="color:#999;">|</span>
									{{each been.resume.educationalList as educational index}}
										{{if index==0}}
										<span class="DS2"> {{educational.education | ifNull:'暂无学历'}}</span>
										{{/if}}
									{{/each}}
								</p>
								<p>{{been.resume.user.birthday | dateFormat:'AA'}}岁</p>
							</div>
							<a href="/ijob/api/ResumeController/h5/zp/index/previewOtherUserResume/{{been.resume.id}}" class="h-look">查看简历</a>
						</div>
					</div>
					<div class="Dman-enroll">
						<div class="De-le">邀请面试时间：{{been.interview | dateFormat:'yyyy年MM月dd日'}}</div>
						<div class="De-ri">
							<a href="javascript:void(0);" name="{{posi.beenrecruitedList[0].version}}" data-url="/ijob/api/BeenrecruitedController/update" onclick="refuseOrAgree(this,'{{been.id}}',0)" class="De-enon">录取</a>
							<a href="javascript:void(0);" name="{{posi.beenrecruitedList[0].version}}" data-url="/ijob/api/BeenrecruitedController/update" onclick="refuseOrAgree(this,'{{been.id}}',1)">拒绝</a>
						</div>
					</div>
				</div>
			</div>
			{{/each}}
		{{/each}}

	</div>
	<div class="hev-bise">
		<div class="hev-BL">
			<div class="mui-input-row mui-checkbox mui-left" style="margin-top:0px;width:2.133rem;">
				<label style="width:100%;">&nbsp;&nbsp;全选</label>
				<input onchange="allSelect(this)" class="checkbox1" name="checkbox1" value="Item 1" type="checkbox">
			</div>
		</div>
		<div class="hev-Br">
			<a href="javascript:void(0);" data-url="/ijob/api/BeenrecruitedController/h5/zp/refuseOrAgreeList" class="hev-BrS" onclick="refuseOrAgreeList(0,this)">录取</a>
			<a href="javascript:void(0);" data-url="/ijob/api/BeenrecruitedController/h5/zp/refuseOrAgreeList" data-url="" onclick="refuseOrAgreeList(1,this)">拒绝</a>
		</div>
	</div>
</script>
</body>
</html>
<script type="text/javascript">
    $("#enrollDet2").loadData().then(function (result) {
    });
	 //全选
	function allSelect(arg){
        if ($(arg).prop("name") == "checkbox1"){
            $("input[name='checkbox']").prop('checked',$(arg).prop('checked'));
        }else {
            $("input[name='checkbox1']").prop('checked',false);
        }
	}

 /*   function refuseOrAgree (arg,beenrecruitedID,state){
        var tagArr = $("input[name='checkbox']:checked");
        if(tagArr.length>0){
            for (var i = 0;i<tagArr.length;i++){
                $(tagArr[i]).prop('checked',true);
            }
        }
        $(arg).closest('.evLb-man').parent().find("input[name='checkbox']").prop('checked','checked');
        refuseOrAgreeList(state,arg)
    }*/

     function refuseOrAgree (arg,beenrecruitedID,state){
       var params = {
            "id" : beenrecruitedID,
            "version" : $(arg).attr("name")
        }
        if (state == 0){
            var btnArray = ['是', '否'];
            mui.confirm('确定录取该求职人员？', null, btnArray, function(e) {
                if (e.index == 0) {//点击是
                    params.state = 3;
                    $(arg).btPost(params,function (data) {
                        if(data.code="200"){
                            var position = {
                                "id":$("#id").val(),
                                "version":$("#version").val(),
                                "beenRecruitedSum":$("#beenRecruitedSum").val()+1
                            }
                            $.ajax({
                                url:"/ijob/api/PositionController/update",
                                type:"POST",
                                dataType:"json",
                                data: JSON.stringify(position),
                                contentType:"application/json; charset=utf-8",
                                success: function () {
                                    mui.alert("已录取",function () {
                                        $("#enrollDet2").loadData();
                                    });
                                }
                            });
                        }
                    });
                }
            });
        }else if (state == 1){
            var btnArray = ['是', '否'];
            mui.confirm('确定拒绝该求职人员？', null, btnArray, function(e) {
                if (e.index == 0) {//点击是
                    params.state = 6;
                    $(arg).btPost(params,function (data) {
                        $("#enrollDet2").loadData();
                       mui.alert("已拒绝");
                    });
                }
            });
        }else{
            var btnArray = ['是', '是'];
            mui.confirm('请不要乱改我代码！！', null, btnArray, function(e) {
            });
        }
    }

    function refuseOrAgreeList(type,arg){
		var arr = new Array();
        var btnArray = ['是', '否'];
        var tagArr = $("input[name='checkbox']:checked");
        if(tagArr.length == 0){
           mui.alert("尚未选择将要操作的用户！");
		}else{
            for (var i = 0;i<tagArr.length;i++){
				var params = {};
				params.id = $(tagArr[i]).val();
				params.version = $(tagArr[i]).attr("version");
                params.resumeID = $(tagArr[i]).attr("resumeID");
                params.positionID = $(tagArr[i]).attr("positionID");
				if(type == 0){
				    params.state = 3;
				}else if(type == 1){
				    params.state = 6 ;
				}
				arr.push(params);
            }
            if(type == 0){
                mui.confirm('确定录取选中的求职人员？', null, btnArray, function(e) {
                    if (e.index == 0) {//点击是
                        $(arg).btPost(arr,function (data) {
                            if(data.code == "500"){
                               mui.alert(data.msg);
							}
                            $("#enrollDet2").loadData();
                           mui.alert("已录取");
                        });
                    }
                });
			}else if(type == 1){
                mui.confirm('确定拒绝选中的求职人员？', null, btnArray, function(e) {
                    if (e.index == 0) {//点击是
                        $(arg).btPost(arr,function (data) {
                            if(data.code == "500"){
                               mui.alert(data.msg);
                            }
                            $("#enrollDet2").loadData();
                           mui.alert("已拒绝");
                        });
                    }
                });
			}else{
                var btnArray = ['是', '是'];
                mui.confirm('请不要乱改我代码！！', null, btnArray, function(e) {
                    mui.confirm('记住没有！！', null, btnArray, function(e) {
                        mui.confirm('好好生活，晓得不！！', null, btnArray, function(e) {
                        });
                    });
                });
			}
		}

	}
</script>


