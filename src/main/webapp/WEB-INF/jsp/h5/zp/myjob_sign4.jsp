<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/18
  Time: 16:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>签到</title>
<%--
    <jsp:include page="../zp/base/resource.jsp"/>
--%>
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

    .JobV {
        padding-top: 5px;
    }

    .evLb-man .evLb-mT {
        padding: 0;
    }

    .Dman-site {
        padding: 0;
    }

    .hev-bise .hev-Br > a {
        width: 1.333rem;
    }

    .hev-bise .hev-Br > a.hev-BrSTwo {
        border: 1px solid #108ee9;
        color: #108ee9;
    }

    .JobV > a {
        height: 1.333rem;
    }

    .JobV > a > p {
        margin: 0;
        color: #666;
        line-height: 0.560rem;
    }

    input, select, textarea {
        font-size: 0.400rem;
    }

    .classify {
        position: fixed;
        z-index: 9;
        top: 0px;
    }

    .JobV {
        position: fixed;
        z-index: 9;
        top: 1.08rem;
    }

    .mui-checkbox.mui-left input[type=checkbox], .mui-radio.mui-left input[type=radio] {
        left: -3px;
    }

    .mui-input-row label {
        line-height: 0px;
    }
    .h-sign{
        display: flex;
        justify-content: space-between;
        margin-top: 0.2rem;
    }
    .h-sign > p.h-sP2{
        margin-left: 0;
    }
    .h-sign .btns{
        border: 1px solid rgb(102,102,102);
        color: #666666;
        border-radius: 0.133rem;
        width: 1.547rem;
        display: inline-block;
        text-align: center;
        height: 0.56rem;
        line-height: 0.56rem;
    }
    .evLbox.evLboxTwo .evLb-man {
        width: 100%;
    }
    .evList .evLb-man .evLb-mT .r_phone {
        position: absolute;
        top: 20%;
        right: 0;
    }
</style>
<div class="evList rx_evList" style="background:#f2f5f7;margin:2.533rem auto 2.267rem auto;">
    <script type="text/html" id="positionsignintemplate4" data-url="/ijob/api/SigninController/zp/getSigninInfo/3" data-type="POST">
            {{each list as signin}}
            <div class="evLbox evLboxTwo">
                <div class="evLb-man">
                    <div class="evLb-mT">
                        <div class="evLb-qq">
                            <div class="qqbox">
                                <img src="/ijob/upload/{{signin.resume.user.attachment |absolutelyPath}}"onerror="this.src='{{signin.resume.user.weixin.headimgurl}}';this.onerror=null;" />
                            </div>
                            <div class="tbox">
                                <p class="tboxS">
                                    {{signin.resume.user.realName}}
                                    {{if signin.resume.sex == 1}}
                                    <span class="iconfont icon-nan1"></span>
                                    {{else}}
                                    <span class="iconfont icon-nv1"></span>
                                    {{/if}}
                                  <%--  <span id="line" style="color:#999;">|</span>
                                    <span id="edu" style="font-size:0.373rem;">{{signin.resume.educationalList[0]}}</span>--%>
                                    <%--<a href="/ijob/api/ResumeController/h5/zp/index/previewOtherUserResume/{{signin.resume.id}}" class="h-look">查看简历</a>--%>
                                </p>
                                <div class="h-sign">
                                    <p class="h-sP2">暂未签到</p>
                                    <%--<p><a href="" class="btns">辞退</a></p>--%>
                                </div>
                                <div class="r_phone">
                                    <a  href="tel:{{signin.resume.phoneNumber}}" class="icon-tel"><span class="iconfont icon-dianhua"></span></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        {{/each}}
    </script>
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
        var input = $("input[name='checkbox']:checked");
        if(input&&input.length>0){
            var params = new Array();
            for (var i = 0; i < input.length; i++) {
                var been = {};
                been.version = $(input[i]).attr("version");
                been.resumeID = $(input[i]).attr("resumeID");
                been.positionID = $(input[i]).attr("positionID");
                been.id = $(input[i]).val();
                if (type == "0") {
                    been.state = 4;
                } else {
                    been.state = 6;
                    been.dismiss = 1;
                }
                if (type == "0") {
                    if ($(input[i]).attr("beenType") != "4") {
                        params.push(been);
                    }
                } else {
                    params.push(been);
                }
            }
            $(arg).btPost(params, function (data) {
                mui.alert("操作成功");
                $("#positionsignintemplate4").loadData(config).then(function (result) {
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

    $("#positionsignintemplate4").loadData(config).then(function(result){
        var date = new Date().format("yyyy-MM-dd");
        $("#Dtime").val(date);
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



