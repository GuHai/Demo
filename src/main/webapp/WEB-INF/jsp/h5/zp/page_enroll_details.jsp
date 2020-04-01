

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>已录取</title>
	<jsp:include page="../zp/base/resource.jsp"/>
   	<link rel="stylesheet" href="/ijob/static/css/index/index.css?version=4">
</head>
<body>

<style>
.mui-checkbox, .mui-radio{float:left;width:0.693rem;height:0.693rem;margin-top:0.400rem;margin-right: 0.2rem;}
.mui-input-row label~input, .mui-input-row label~select, .mui-input-row label~textarea{padding-left:2px;}
.JobV{position:fixed;z-index:9;top:0;}
.mui-checkbox.mui-left input[type=checkbox], .mui-radio.mui-left input[type=radio]{left:0;text-align: center;padding-right: 0.3rem}
.mui-input-row label{line-height:3px;}
.evLb-man .evLb-mT .evLb-qq .tbox .time{color: #333;font-size: 0.4rem;position: relative;/*position: absolute;top: 0.95rem;left: 1.267rem;width: 86%;*/}
.evLb-man .evLb-mT .evLb-qq .tbox .time .txt{font-size: 0.32rem;color: #999;}
.evLb-man .evLb-mT .evLb-qq .tbox .time em{font-size: 0.32rem;position:  absolute;right: 0;}
.fix-block-r button{line-height: 1.067rem;color: #108ee9;padding: 0;text-align: center;display: block;width: 1.067rem;height: 1.067rem;border-radius: 100%;border: solid 1px #108ee9;background-color: rgba(255, 255, 255, 0.7);}
</style>
<div class="evList rx_evList" style="background:#f2f5f7;margin-top: 0rem">
	<div class="myjob_rnroll_data">
		<div class="details-calendar">
			<div class="box">
				<section class="date" data-editable="true">
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
    <div class="enrollList">

		<script id="beeninfo" type="text/html" data-url="/ijob/api/BeenrecruitedController/findBeenByWorkDate" data-type="POST">
			{{each list as been index}}
				<div class="evLbox evLboxTwo">
					<div class="mui-input-row mui-checkbox mui-left">
						<label></label>
						<input name="checkbox"  data-index="{{index}}" value="{{been.beenID}}" positionID="{{been.positionID}}" resumeID="{{been.id}}" version="{{been.version}}" type="checkbox">
					</div>
					<div class="evLb-man" style="width: 90%;">
						<div class="evLb-mT">
							<div class="evLb-qq">
								<div class="qqbox">
									<img src="/ijob/upload/{{been |absolutelyPath}}"onerror="this.src='{{been.headimgurl}}';this.onerror=null;" />
								</div>
								<div class="tbox">
									<p class="tboxS">
										{{been.realName}}
										<%--<span class="xian" style="color:#999;"></span>--%>
										<span class="xueli" style="font-size:0.373rem;">|&nbsp;{{been.level | enums:'EduLevel'}}</span>
									</p>
									<div class="time"><span class="tit">报名时间</span><span class="txt datecontent" data-text="{{been.workDate | mdstrFormat}}">{{been.workDate | mdstrFormat}}</span><em>展开<i class="iconfont icon-arrow-down1"></i></em></div>
								</div>
								<a href="/ijob/api/ResumeController/h5/zp/index/previewOtherUserResume/{{been.id}}" class="h-look">查看简历</a>
							</div>
						</div>
					 </div>
				</div>
			{{/each}}
		</script>
    </div>
	<div class="fix-block-r" style="display: none">
		<button id="gotoGroupChat">群聊</button>
	</div>
</div>
<div class="hev-bise">
	<div class="hev-BL">
		<div class="mui-input-row mui-checkbox mui-left" style="margin-top:0px;width:2.133rem;">
			<label style="width:100%;">&nbsp;&nbsp;全选</label>
			<input name="checkbox1"  class="checkbox1" value="Item 1" type="checkbox">
		</div>
	</div>
	<div class="hev-Br">
		<a href="javascript:void(0);" data-url="/ijob/api/BeenrecruitedController/h5/zp/refuseOrAgreeList" onclick="operationListYLQ(1,this)" class="hev-BrS">辞退</a>
	</div>
</div>
</body>
</html>

<script type="text/javascript">


	$.getJSON("/ijob/api/PositionController/getSimplePosition/"+ijob.storage.get("position.id"),function(result){
        var arr = [];
        var myarr = [];
        var datetime = result.data.workDate;
        var arrnum = ijob.getDatePersonList(datetime);

        if( result.data){
            arr = arr.concat( ijob.getDateList(result.data.workDate));
        }
        $('.date').on('completionEvent', function() {
            $(".date").containDate(arr,myarr);
            $(".date").remainder(arrnum,true);
        });

        var userIds ="";
        $("#gotoGroupChat").on('click',function () {
            if(userIds.length>0){
                ijob.gotoPage({path:'/h5/information/chat?chat.isGroup=true&chat.positionName='+result.data.title+'&chat.toUserID='+userIds+'&chat.positionID='+ result.data.id});
            }
        });

        $(".date").on('dateClickEvent',function(event,state,dr){
            if(state){
                myarr.push(dr);
            }else{
                myarr.splice($.inArray(dr,myarr),1);
            }
            var selDate = {
                workDate:myarr.join(","),
				positionID:ijob.storage.get("position.id")
			}
          	$("#beeninfo").loadData({condition:selDate}).then(function(result2){
                // 群聊
				if (result2.data.list&&result2.data.list.length > 0){
				    $(".fix-block-r").show();
				}else{
                    $(".fix-block-r").hide();
				}
          	    userIds = "";
                for(var i in result2.data.list){
					userIds += result2.data.list[i].userID+";";
				}

                $(".nodata").css("margin-top","30%");

                $(".checkbox1").on('click',function(){
                    var flag =  $(".checkbox1").prop('checked');
                    $("input[name='checkbox']").each(function(i,item){
                        if($(item).prop("checked")!=flag){
                            $(item).prop("checked",flag)
                        }
                    });
                });

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
                        }else {
                            em.hide();
						}
                    });
                };
                hide();

                $('.time em').unbind().click(function(){
                    if(more){
                        $(this).prev().html($(this).prev(".txt").data("text"));
                        $(this).html("收回<i class=\"iconfont icon-arrow-up\"></i>");
                        more = false;
                    }else{
                        hide();
                    }
                });

                appendText();
			});
        });
        dateRenderInit();

        function appendText() {
            $(".xueli").each(function(){
                if($(this).html().trim(" ") == '|&nbsp;'){
                    $(this).hide();
                }
            });
        }
	});
    function operationListYLQ(type,arg){
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
            mui.confirm('确定辞退选中的求职人员？', null, btnArray, function(e) {
                if (e.index == 0) {//点击是
                    $(arg).btPost(arr,function (data) {
                        if(data.code == "500"){
                            mui.alert(data.msg);
                        }else{
                            mui.alert("已辞退",function () {
                                window.location.reload();
                            });
                        }
                    });
                }
            });
        }
    }
</script>


