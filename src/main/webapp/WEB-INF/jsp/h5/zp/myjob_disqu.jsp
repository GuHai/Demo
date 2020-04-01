<%@ page contentType="text/html;" language="java" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>未录取</title>
    <jsp:include page="../zp/base/resource.jsp"/>
</head>
<body>

<style>
.mui-checkbox, .mui-radio{float:left;width:0.800rem;height:0.800rem;margin-top:0.400rem;}
.mui-input-row label~input, .mui-input-row label~select, .mui-input-row label~textarea{padding-left:2px;}
.JobV{position:fixed;top:0;z-index:9;}
.JobInfo {
	width: 100%;
	overflow: hidden;
	margin-bottom: 1.733rem;
	margin-top: 1.066rem;
}
.JobInfo .JIman .manName{padding-bottom:0.267rem;}

</style>


<div class="JobV JobVtwo">
	<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_enroll_det?id={data.id}'})"  >新报名</a>
	<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_enroll_det2?id={data.id}'})">待面试</a>
	<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_train?id={data.id}'})">培训中</a>
	<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_work?id={data.id}'})">工作中</a>
	<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_disqu?id={data.id}'})" class="JobVon">未录取</a>
</div>
<div class="JobInfo">
	<script id="disquTemplate"  type="text/html" data-url="/ijob/api/BeenrecruitedController/zp/getDisquInfo/{data.id}/1">
		{{each list as person}}
			<a href="javascript:void(0);" class="JIman">
				<div class="manName">
					<div class="qq">
						{{if person.resume.user.attachment != null}}
						<img src="{{person.resume.user.attachment |absolutelyPath}}"/>
						{{else}}
						<img src="{{person.resume.user.weixin.headimgurl}}"/>
						{{/if}}
					</div>
					<div class="info">
						<p class="info-name"><span>{{person.resume.user.realName |ifNull:'保密'}}</span>{{person.resume.educationalList[0] |ifNull:'无','education'}}</p>
						<p>
							{{if  person.resume.intentiontypeList.length != 0 }}
								{{each person.resume.intentiontypeList as intentiontype index}}
									{{if index==0}}
										{{intentiontype.huntingtype | ifNull:'无','name'}}
									{{/if}}
								{{/each}}
							{{else}}
								无
							{{/if}}
						</p>
					</div>
				</div>
				<div class="manText">今年{{person.resume.user.birthday | dateFormat:'AA'}}岁，身高{{person.resume.height}}CM，体重{{person.resume.weight}}公斤。{{person.resume.evaluation}}
				</div>
			</a>
		{{/each}}
	</script>
</div>
<script>
	$("#disquTemplate").loadData().then(function (result) {
    })
</script>

</body>
</html>


