<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>编辑简历</title>
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/css/base.css">
    <link rel="stylesheet" href="/ijob/css/mine/chooseResume_add.css">
    <jsp:include page="../../qz/base/resource.jsp"/>
    <script>
        window.addEventListener('pageshow', function (e) {
            // 通过persisted属性判断是否存在 BF Cache
            if (e.persisted) {
                location.reload();
            }
        });
    </script>
</head>

<body>
<div class="wrap">
    <script type="text/html" id="getResume" data-url="/ijob/api/ResumeController/h5/mine/getChooseResume_addPageData"
            data-type="GET">
        {{each list as map}}
        <div class="basisInfo">
            <a href="javascript:void(0)" onclick="myResum()">
                <input type="hidden" id="resumeId" name="id" value="{{map.Resume.id}}">
                <input type="hidden" id="version" name="version" value="{{map.Resume.version}}">
                <img class="info_img" src="{{map.Resume.imgPath}}"
                     onerror="this.src='{{map.Weixin.headimgurl}}';this.onerror=null" alt="">
                <div class="info_text">
                    <p class="info_text_name">
                        <span id="resumeName">
                            {{if map.Resume.resumeName}}
                            {{map.Resume.resumeName}}
                            {{/if}}
                        </span>
                        <em id="sex">
                            {{if map.Resume.sex}}
                            {{map.Resume.sex == 1 ? "男":"女"}}
                            {{else}}
                            保密
                            {{/if}}
                        </em>
                        {{if map.Resume.educationalList[0]}}
                       <span id="line">&nbsp;|&nbsp;</span>
                        {{/if}}
                        <em id="edu" style="margin-left: 0px">{{map.Resume.educationalList[0] && map.Resume.educationalList[0].education}}</em>
                    </p>
                    <p class="info_text_zw">工作号：{{map.Information.workNumber |ifNull:'无工作号' }}</p>
                    <i class="iconfont icon-arrow-right arrow"></i>
                </div>
            </a>
        </div>
        <div class="evaluate" onclick="jumpPage('Self_evaluation?resume.id={{map.Resume.id}}')">
            <div class="evaluate-title">
                <h1>自我评价</h1>
                <i class="iconfont icon-arrow-right"></i>
            </div>
            <div class="evaluate-msg">
                <div id="evaluation" class="company">{{map.Resume.evaluation}}</div>
            </div>
        </div>

        <div class="jobs" id="jobs">
            {{if map.Resume.id != null}}
            {{each map.Resume.workexperienceList as item}}
            <div class="jobs_msg" onclick="ijob.gotoPage({path: 'h5/qz/mine/add_workExperience?workId={{item.id}}'})">
                <div class="company">{{item.companyName}}</div>
                <%--<div class="time">{{item.startTime |dateFormat:'yyyy.MM'}}<span> - </span>{{item.endTime |dateFormat:'yyyy.MM'}}</div>--%>
            </div>
            {{/each}}
            {{/if}}
            <div class="jobs_add">
                <a href="javascript:void(0)" onclick="jumpPage('add_workExperience?workId=0')"><i
                        class="iconfont icon--jia"></i>工作经历</a>
            </div>
        </div>

        <div class="paperwork" id="paperwork">
            {{if map.Resume.id != null}}
            {{each map.Resume.documentList as item}}
            <div class="paperwork_msg"
                 onclick="ijob.gotoPage({path: 'h5/qz/mine/add_document?documentid={{item.id}}'})">
                <div class="company">{{item.documentName}}</div>
                <div class="time">有效期：{{item.effective |dateFormat:'yyyy-MM-dd'}}</div>
            </div>
            {{/each}}
            {{/if}}
            <%--<div class="paperwork_add">
                <a href="javascript:void(0)" onclick="jumpPage('add_document?documentid=0')"> <i
                        class="iconfont icon--jia"></i>有效证件</a>
            </div>--%>
        </div>

        {{/each}}
    </script>
</div>
<div style="clear: both;content: '';height: 1.466rem;"></div>
<div class="footer_fixed">
    <a href="javascript:void(0);" onclick="preview()">
        <div class="btn" id="saveandupdate" data-url="/">预览</div>
    </a>
</div>
</body>
</html>
<script type="text/javascript">

    ijob.storage.set('Resume.id', null);

    $("#getResume").attr("data-url", '/ijob/api/ResumeController/h5/mine/getChooseResume_addPageData?ver=' + new Date().getTime());//打破安卓机微信的缓存
    $("#getResume").loadData().then(function (result) {
        ijob.storage.set('userHeadImg', result.data.list[0].Weixin.headimgurl);//头像
        ijob.storage.set("Resume.id", result.data.list[0].Resume.id);
        if (!$.trim($('#resumeName').text())) {//没有简历
            if ('<shiro:principal property="realName" />' != 'null') {
                $("#resumeName").val('<shiro:principal property="realName" />'); //如果已实名认证，用真实姓名
            } else {
                $("#resumeName").val(result.data.list[0].Weixin.nickname);//用微信名
            }
        }
        txt();
    });

    //跳转到基础信息
    function myResum() {
        var resumeId = $('#resumeId').val();//默认是修改
        if (!resumeId) {
            resumeId = 0;//新增
        }
        ijob.gotoPage({path: 'h5/qz/mine/chooseResume_edit?Resume.id=' + resumeId})
    }

    /**
     * 跳转页面，新增用户工作经历，证件信息。
     * @param url 页面地址。
     */
    function jumpPage(url) {
        if ($("#resumeId").val()) {
            ijob.gotoPage({path: "h5/qz/mine/" + url});
        } else {
            mui.alert("请完善基本信息！");
        }
    }
    // 判断自我评价是否为空
    function txt() {
        // 自我评价
        if ($("#evaluation").text() == undefined ||$("#evaluation").text() == null||$("#evaluation").text().trim(" ") == '') {
            $(".evaluate-msg").hide();
        }
        // 性别间距
        if($("#resumeName").text() == null ||$("#resumeName").text() == undefined || $("#resumeName").text().trim(" ") == ''){
            $("#sex").css("margin-left","0");
        }
        //隐藏竖线
        if($("#edu").text() == null ||$("#edu").text() == undefined || $("#edu").text().trim(" ") == ''){
            $("#line").hide();
        }
    }

    /**
     * 跳转到预览简历
     */
    function preview() {
        var resumeId = $("#resumeId").val();
        //判断格式
        if (resumeId) {//简历是否已经保存
            ijob.gotoPage({path: "/h5/qz/mine/add_preview?resumeID=" + resumeId});//路径跳转
        } else {
            mui.alert("请完善基本信息！");
        }


        // if (!(ijob.storage.get("tempResume") || $("#resumeId").val())) {
        //     mui.alert("请先完善基本信息！");
        // } else {
        //     var resume = {
        //         id: $("#resumeId").val(),
        //         version: $("#version").val(),
        //         resumeTitle: $("#resumeTitle").val(),
        //     };
        //
        //     var url = "";
        //     if (ijob.storage.get('Resume.id') == '0') {
        //         //添加
        //         url = "/ijob/api/ResumeController/add";
        //     } else {
        //         //修改
        //         url = "/ijob/api/ResumeController/update";
        //         // resume = JSON.stringify(resume);
        //     }
        //     $("#saveandupdate").attr("data-url", url);
        //
        //
        //     $("#saveandupdate").btPost(resume, function (result) {
        //         if (result.code == "200") {
        //             // ijob.storage.set('isChooseResumeReLoad',true);
        //             ijob.gotoPage({path: "/h5/qz/mine/add_preview?resumeID=" + result.data.id});
        //         } else {
        //             mui.toast("保存失败！");
        //         }
        //     });
        // }
    }
</script>