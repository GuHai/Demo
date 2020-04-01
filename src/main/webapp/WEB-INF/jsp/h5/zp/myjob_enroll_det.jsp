

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>我的招聘</title>
	<jsp:include page="../zp/base/resource.jsp"/>
   	<link rel="stylesheet" href="/ijob/static/css/index/index.css">
</head>
<body>

<style>
.mui-checkbox, .mui-radio{float:left;width:0.693rem;height:0.693rem;margin-top:0.400rem;margin-right: 0.2rem;}
.mui-input-row label~input, .mui-input-row label~select, .mui-input-row label~textarea{padding-left:2px;}
.JobV{position:fixed;z-index:9;top:0;}
.mui-checkbox.mui-left input[type=checkbox], .mui-radio.mui-left input[type=radio]{left:0;text-align: center;padding-right: 0.3rem}
.mui-input-row label{line-height:3px;}
.date>ul>.act_wk {color: #333;}
.date>ul>.act_wk.act_date{color:#fff}
.evLbox .evLb-man {width: 90%;}
</style>



<%--<div class="JobV JobVtwo">
	<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_enroll_det?id={data.id}'})" class="JobVon">新报名</a>
	<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_enroll_det2?id={data.id}'})"class="">待面试</a>
	<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_train?id={data.id}'})" class="">培训中</a>
	<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_work?id={data.id}'})" class="">工作中</a>
	<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_disqu?id={data.id}'})" class="">未录取</a>
 </div>--%>



<div class="evList rx_evList" style="background:#f2f5f7;margin-top: 0rem">
	<script type="text/html" id="enrollDet1" data-url="api/PositionController/zp/getPositionWait/{data.id}/1">
		{{each list as posi}}
			<input type="hidden" id="id" value="{{posi.id}}" >
			<input type="hidden" id="version" value="{{posi.version}}">
			<input type="hidden" id="beenRecruitedSum" value="{{posi.beenRecruitedSum |ifNull:'0'}}">
			<input type="hidden" id="recruitsSum" value="{{posi.recruitsSum}}">
			<div class="myjob_rnroll_data">
				<div class="details-calendar">
					<div class="box">
						<section class="date" data-editable="false">
							<div class="data-head">
								<div class="prev mui-icon mui-icon-back"></div>
								<div class="tomon"><span class="year">2018</span>年 <span class="month">3</span>&nbsp;&nbsp;&nbsp;&nbsp;月
								</div>
								<div class="next mui-icon mui-icon-forward"></div>
							</div>
							<ol>
								<li>日</li>
								<li>一</li>
								<li>二</li>
								<li>三</li>
								<li>四</li>
								<li>五</li>
								<li>六</li>
							</ol>
							<ul id="jobDate">

							</ul>
						</section>
					</div>
				</div>
			</div>
			{{each posi.beenrecruitedList as been index }}
				<div class="evLbox evLboxTwo">
					<div class="mui-input-row mui-checkbox mui-left">
						<label></label>
						<input name="checkbox"  data-index="{{index}}"  resumeID="{{been.resumeID}}" positionID="{{been.positionID}}" value="{{been.id}}" version="{{been.version}}" type="checkbox">
					</div>
					<div class="evLb-man">
						<div class="evLb-mT">
							<div class="evLb-qq">
								<%--<p>{{been.vip==1?'VIP':''}}</p>--%>
								<div class="qqbox {{been.vip==1?'bgimg':''}}">
									<img src="/ijob/upload/{{been.resume.user | absolutelyPath:'attachment'}}"  onerror="this.src='{{been.resume.user.weixin.headimgurl}}';this.onerror=null;" />
                                </div>
								<div class="tbox">
									<p class="tboxS">{{been.resume.user.realName | ifNull:'尚未填写'}}{{if been.resume.phoneNumber!=null}}|<a href="tel:{{been.resume.user.phoneNumber}}">{{been.resume.user.phoneNumber}}</a>{{/if}}
										<span id="line" style="color:#999;"></span>
									<%--	{{each been.resume.educationalList as educational index}}
										{{if index==0}}
										<span id="edu" style="font-size:0.373rem;">|&nbsp; {{educational.education}}</span>
										{{/if}}
										{{/each}}--%>
									</p>
									<div class="time"><span class="tit">报名时间：</span><span class="txt datecontent" data-text="{{been.workDate | mdstrFormat}}">{{been.workDate | mdstrFormat}}</span><em>展开</em></div>
								</div>
								<a href="/ijob/api/ResumeController/h5/zp/index/previewOtherUserResume/{{been.resume.userID}}" class="h-look">查看简历</a>
							</div>
						</div>

					</div>
				</div>
			{{/each}}
		{{/each}}
	</script>

</div>
<div class="clearfix" style="content: '';height: 1.333rem;overflow: hidden;clear: both;"></div>
<div class="hev-bise">
	<div class="hev-BL">
		<div class="mui-input-row mui-checkbox mui-left" style="margin-top:0px;width:2.133rem;">
            <label style="width:100%;">&nbsp;&nbsp;全选</label>
            <input name="checkbox1"  class="checkbox1" value="Item 1" type="checkbox">
        </div>
	</div>
	<div class="hev-Br">
		<a href="javascript:void(0);" data-url="/ijob/api/BeenrecruitedController/h5/zp/refuseOrAgreeList" onclick="operationList(0,this)" class="hev-BrS">录取</a>
		<a href="javascript:void(0);" data-url="/ijob/api/BeenrecruitedController/h5/zp/refuseOrAgreeList" onclick="operationList(1,this)" >拒绝</a>
	</div>
</div>
<div id="homepage"></div>
</body>
</html>

<script type="text/javascript">

    $("#homepage").freshPage({path:"/h5/homepage"});
    //全选
    function allSelect(arg){
        if ($(arg).prop("name") == "checkbox1"){
            // $("input[name='checkbox']").prop('checked',$(arg).prop('checked'));
            $("input[name='checkbox']:not(:checked)").each(function(i,item){
				$(item).trigger("click");
            });
		}else {
            $("input[name='checkbox1']").prop('checked',false);
		}
    }
    var arrnumreal = [];
    var beenPersonnum =0;
    var datejson = null;

    loadDataHandler();
    function loadDataHandler(){
        $("#enrollDet1").loadData().then(function (result) {
            var datetime = result.data.list[0].workDate;
            var arr = ijob.getDateList(datetime);
            var arrnum = ijob.getDatePersonList(datetime);
            var myarr = [];

            $('.date').on('completionEvent', function() {
                $(".date").containDate(arr,myarr);
                $(".date").remainder(arrnum);
            });

            $(".date").on('dateClickEvent',function(event,state,dr){
                if(state){
                    myarr.push(dr);
                }else{
                    myarr.splice($.inArray(dr,myarr),1);
                }
            });

            dateRenderInit();

            var more = true;
            //限制字符个数
            var hide = function (){
                $(".time .txt").each(function(){
                    var maxheight=16;
                    var em = $(this).next("em");
                    if($(this).text().length>maxheight){
                        $(this).html($(this).text().substring(0,maxheight));
                        $(this).html($(this).html()+'...');
                        more = true;
                        em.html("展开<i class=\"iconfont icon-arrow-down1\"></i>");
                    } else {
                        em.hide();
                    }
                });
            };
            hide();
            $('.time em').click(function(){
                if(more){
                    $(this).prev().html($(this).prev(".txt").data("text"));
                    $(this).html("收回<i class=\"iconfont icon-arrow-up\"></i>");
                    more = false;
                }else{
                    hide();
                }
            });

            $(".evList").on('click','input',function(){
                var _this = $(this);
                datejson = {};
                $("input[name='checkbox']:checked").each(function(i,item){
                    var been = result.data.list[0].beenrecruitedList[$(this).data("index")];
                    var arr = ijob.getDateList(been.workDate);
                    for(var i in arr){
                        datejson[arr[i]] = (datejson[arr[i]]||0) + 1;
                    }
                });
                calcarr(_this);
            });

            function calcarr(_this){
                var flag = true;

                var arrnumrealtemp = [];
                var beenPersonnumtemp = 0;
                for(var j in arrnum){
                    var dn = arrnum[j];
                    var pn = {
                        date:dn.date,
                        num:dn.num-(datejson[dn.date]||0)
                    }
                    if(pn.num<0){ //如果人数小于0了，不能再勾选了
                        mui.toast("当天的报名人数已经满了");
                        _this.prop('checked',false);
                        flag = false;
                        break;
                    }else{
                        arrnumrealtemp.push(pn);
                        beenPersonnumtemp += (datejson[dn.date]||0);
                    }
                }
                if(flag==true){
                    arrnumreal = arrnumrealtemp;
                    beenPersonnum = beenPersonnumtemp;
                }
                $(".date").remainder(arrnumreal);
                return flag;
            }

            $(".checkbox1").on('click',function(){
                var flag =  $(".checkbox1").prop('checked');
                $("input[name='checkbox']").each(function(i,item){
                    if($(item).prop("checked")!=flag){
                        $(item).prop('checked', flag);
                        datejson = {};
                        $("input[name='checkbox']:checked").each(function(i,item){
                            var been = result.data.list[0].beenrecruitedList[$(this).data("index")];
                            var arr = ijob.getDateList(been.workDate);
                            for(var i in arr){
                                datejson[arr[i]] = (datejson[arr[i]]||0) + 1;
                            }
                        });
                        var f  = calcarr($(this));
                        if(f==false){
                            $(item).prop('checked', !flag);
                            return false;
                        }
                    }
                });
            });

        });
	}


    function operationList(type,arg){
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
				params.positionID = $(tagArr[i]).attr("positionID");
				params.resumeID = $(tagArr[i]).attr("resumeID");
				if(type == 0){
					params.state = 4;
				}else if(type == 1){
					params.state = 6 ;
				}else if(type == 2){
					params.state = 4;
				}
				arr.push(params);
            }
            if(type == 0){
                mui.confirm('确定录取选中的求职人员？', null, btnArray, function(e) {
                    if (e.index == 0) {//点击是
                        var beenRecruitedSumTemp,recruitsSum = parseInt($("#recruitsSum").val());
                        if($("#beenRecruitedSum").val() == null){
                            beenRecruitedSumTemp = 0;
                        }else{
                            beenRecruitedSumTemp = parseInt($("#beenRecruitedSum").val());
                        }
                        if(recruitsSum >= (beenRecruitedSumTemp + beenPersonnum) ){
                            $(arg).btPost(arr,function (data) {
                                if(data.code==200){
                                    mui.alert("录取成功");
                                    // loadDataHandler();
									window.location.reload();
                                }else{
                                    mui.alert(data.msg);
                                }
                            });
                        }else{
                            mui.alert("该职位人员已到达录取上限");
                        }
                    }
                });
            }else if(type == 1){
                mui.confirm('确定拒绝选中的求职人员？', null, btnArray, function(e) {
                    if (e.index == 0) {//点击是
                        $(arg).btPost(arr,function (data) {
                            if(data.code == "500"){
                               mui.alert(data.msg);
                            }else{
                                loadDataHandler();
                                mui.alert("已拒绝");
							}
                        });
                    }
                });
            }
        }
    }

</script>


