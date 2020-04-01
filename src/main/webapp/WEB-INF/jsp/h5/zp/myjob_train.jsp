
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>我的招聘</title>
    <jsp:include page="../zp/base/resource.jsp"/>
</head>
<body>

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

    .evLb-man .evLb-mT {
        padding: 0;
    }

    .Dman-site {
        padding: 0;
    }

    .mui-checkbox.mui-left input[type=checkbox], .mui-radio.mui-left input[type=radio] {
        left: -3px;
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


<div class="JobV JobVtwo">
    <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_enroll_det?id={data.id}'})"  >新报名</a>
    <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_enroll_det2?id={data.id}'})">待面试</a>
    <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_train?id={data.id}'})" class="JobVon">培训中</a>
    <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_work?id={data.id}'})" class="">工作中</a>
    <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/myjob_disqu?id={data.id}'})" class="">未录取</a>
</div>
<div class="evList rx_evList" style="background:#f2f5f7;">
    <script id="trainTemplate"  type="text/html" data-url="/ijob/api/SigninController/zp/getSigninInfoOfTrainingOrWorking/{data.id}/3">
       {{each list as person}}
           <div class="evLbox evLboxTwo">
               <div class="mui-input-row mui-checkbox mui-left">
                   <label></label>
                   <input name="checkbox" value="{{person.id}}" resumeID="{{person.resumeID}}" positionID="{{person.positionID}}" version="{{person.version}}" type="checkbox">
               </div>
               <div class="evLb-man">
                   <div class="evLb-mT">
                       <div class="evLb-qq">
                           <input type="hidden" id="id" value="{{person.id}}" >
                           <input type="hidden" id="version" value="{{person.version}}">
                           <input type="hidden" id="beenRecruitedSum" value="{{person.beenRecruitedSum}}">
                           <div class="qqbox">
                               {{if person.resume.user.attachment != null}}
                               <img src="{{person.resume.user.attachment |absolutelyPath}}"/>
                               {{else}}
                               <img src="{{person.resume.user.weixin.headimgurl}}"/>
                               {{/if}}
                           </div>
                           <div class="tbox">
                               <p class="tboxS">{{person.resume.user.realName |ifNull:'保密'}}
                                   <span style="color:#999;">|</span>
                                   <span style="font-size:0.373rem;">{{person.resume.educationalList[0] |ifNull:'无','education'}}</span>
                               </p>
                               <div class="h-sign">
                                   <p>
                                       {{if person.resume.user.signin != null}}
                                       {{person.resume.user.signin.signTime |dateFormat:'hh:mm'}}
                                       {{else}}
                                       无
                                       {{/if}}
                                   </p>
                                   <p class="h-sP2">今日签到<span>{{person.resume.user.signinCount |ifNull:'0'}}</span>次</p>
                               </div>
                           </div>
                           <a href="javascript:void(0);" class="h-look" style="color:#666;">培训中</a>
                       </div>
                   </div>
                   <div class="Dman-site">
                       <p>
                           <span class="iconfont icon-fujin icon-fujin-hue"></span>
                           {{ if person.resume.user.signin != null}}
                           {{person.resume.user.signin.address.detailedAddress}}
                           {{else}}
                           未知
                           {{/if}}
                           <span class="iconfont icon-arrow-right icon-float"></span>
                       </p>
                   </div>
               </div>
           </div>
       {{/each}}
    </script>
</div>
<div class="hev-bise">
    <div class="hev-BL">
        <div class="mui-input-row mui-checkbox mui-left" style="margin-top:0px;width:2.133rem;">
            <label style="width:100%;">&nbsp;&nbsp;全选</label>
            <input name="checkbox1" value="Item 1" type="checkbox" class="checkbox1">
        </div>
    </div>
    <div class="hev-Br">
        <a href="javascript:void(0);" class="hev-BrS" data-url="/ijob/api/BeenrecruitedController/h5/zp/refuseOrAgreeList" onclick="admissionOrRefuse(this,'0')">录取</a>
        <a href="javascript:void(0);" data-url="/ijob/api/BeenrecruitedController/h5/zp/refuseOrAgreeList" onclick="admissionOrRefuse(this,'1')">辞退</a>
    </div>
</div>

<script type="text/javascript">
    $("#trainTemplate").loadData().then(function(result){
    });
    $(".checkbox1").on("change", function () {
       $("input[name='checkbox']").prop('checked',$(this).prop('checked'));
    });
    function admissionOrRefuse(arg,type){
        var btnArray = ['是', '否'];
        var tagArr = $("input[name='checkbox']:checked");
        if(tagArr.length == 0){
          mui.alert("尚未选择将要操作的用户！");
        }else {
            var input = $("input[name='checkbox']:checked");
            console.log(input.length);
            var params = new Array();
            for (var i = 0; i < input.length; i++) {
                var been = {};
                been.version = $(input[i]).attr("version");
                been.resumeID = $(input[i]).attr("resumeID");
                been.positionID = $(input[i]).attr("positionID");
                been.id = $(input[i]).val();
                var mess="";
                if (type == "0") {
                    been.state = 4;
                    var position = {
                        "id": $("#id").val(),
                        "version": $("#version").val(),
                        "beenRecruitedSum": $("#beenRecruitedSum").val() + 1
                    }

                   mess="确定录取选中的求职人员？";
                } else {
                    been.state = 6;
                    been.dismiss = 1;
                    mess="确定辞退选中的求职人员？";
                }
                params.push(been);
                mui.confirm(mess, null, btnArray, function(e) {
                    if (e.index == 0) {//点击是
                        if(type == "0"){
                            $.ajax({
                                url: "/ijob/api/PositionController/update",
                                type: "POST",
                                dataType: "json",
                                data: JSON.stringify(position),
                                contentType: "application/json; charset=utf-8",
                                success: function () {
                                    $("#trainTemplate").loadData()
                                }
                            });
                        }else{
                            $(arg).btPost(params,function (data) {
                                $("#trainTemplate").loadData()
                            })
                        }
                    }
                });
            }
        }
    }
</script>

</body>
</html>


