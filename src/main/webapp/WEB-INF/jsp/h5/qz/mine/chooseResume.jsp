<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>简历</title>
    <script src="/ijob/lib//lib-flexible.js"></script>
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <script src="/ijob/lib/jquery-2.2.3.js"></script>
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <jsp:include page="../../qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/base.css">
    <link rel="stylesheet" href="/ijob/static/css/mine/chooseResume.css">
    <script>
        //避免 ios “往返缓存” 不触发load事件的问题（不会再解析 Dom，当然也不会运行页面解析时的 js ，例如 onLoad 事件里面的）
        //无论是否是 “往返缓存” 都会在页面打开的时候运行的事件
        window.addEventListener('pageshow', function () {
            //根据 session 中的值判断是否需要刷新  有/没有
            if (ijob.storage.get('isChooseResumeReLoad')) {
                //清除
                ijob.storage.set("isChooseResumeReLoad",null);
                //是 “往返缓存” 页面刷新
                window.location.reload();
            }
        });
    </script>
</head>
<body>
<div id="chooseResume" class="wrap">

    <div class="main">
        <ul class="resumeList">

            <script type="text/html" id="getResumeList" data-url="/ijob/api/ResumeController/h5/mine/getResumeList"
                    data-type="GET">
                {{each list as resume}}
                <li class="resumeItem">
                    <div class="list-title resume" resumeid="{{resume.id}}" id="{{$index}}">
                        {{resume.resumeTitle}}
                        {{if resume.isDefault}}
                        <i class="iconfont icon-gou checkmarkempty" style="display: block"></i>
                        {{/if}}
                    </div>
                    <div class="list-content">
                        {{if resume.isDefault}}
                        <div class="default active" name="{{resume.version}}" id="{{resume.id}}"
                             onclick="setDefault(this,'{{$index}}')">默认
                        </div>
                        {{else}}
                        <div class="default" name="{{resume.version}}" id="{{resume.id}}" onclick="setDefault(this,'{{$index}}')">
                            设为默认
                        </div>
                        {{/if}}
                        <div class="list-cz">
                            <%--<a onclick="ijob.gotoPage({path:'/h5/qz/mine/chooseResume_add?data.Resume.id={{resume.id}}'})"--%>
                               <%--class="edit"><i class="iconfont icon-edit-fill"></i>编辑</a>--%>
                            <a class="delete" onclick="delResume('{{resume.id}}',this)"><i
                                    class="iconfont icon-shanchu2"></i>删除</a>
                        </div>
                    </div>
                </li>
                {{/each}}
            </script>
        </ul>
    </div>
    <div style="content: '';clear: both;height: 1rem;"></div>
    <footer class="choose_foot">
        <a href="javascript:void(0)" onclick="ijob.gotoPage({path:'/h5/qz/mine/chooseResume_add?data.Resume.id=0'})">
            <span class="head-lf_span">
                <%--<i class="iconfont icon-jia"></i>--%>
                新增简历
            </span>
            <%--<span class="head-rt_span iconfont icon-arrow-right"></span>--%>
        </a>
    </footer>
</div>
<script type="text/javascript">
    var defaultID;

    function setDefault(obj,id) {
        if ($(obj).attr("id") != defaultID) {
            $(".active").removeClass("active").text("设为默认");
            $(obj).addClass("active").text("默认");
            $("i").remove(".checkmarkempty");
            console.log();
            var htmlStr = "<i class=\"iconfont icon-gou checkmarkempty\" style=\"display: block\"></i>";
            $("#"+id).html($("#"+id).html() + htmlStr);
            defaultID = $(obj).attr("id");
            $.post("/ijob/api/ResumeController/h5/mine/updateDefault", {
                "id": defaultID,
                "version": $(obj).attr("name"),
                "isDefault": true
            }, function (data) {
                if (data.code == "200") {
                    $(obj).attr("name", parseInt($(obj).attr("name")) + 1);
                } else {
                    mui.alert("服务器繁忙！");
                }
            });
        }
        if (ijob.storage.get("isByEnroll")) {

            //退出到报名页面，将重置为false;
            ijob.storage.set("isByEnroll", false);
            // 传递到上一页的参数，放 session 中
            ijob.storage.set("resumeId",$(obj).parent().prev().attr("resumeid"));
            ijob.storage.set("resumeName",$(obj).parent().prev().text().trim());
            //返回上一页
            history.go(-1);
        }
    }

    function delResume(id,_self) {
        var btn = ['取消', '确定'];
        mui.confirm('确定要删除简历吗？', '提示', btn, function (e) {
            if (e.index == 1) {
                //用 ajax 删除
                $.ajax({
                    url:'/ijob/api/ResumeController/delete/' + id,
                    type:"GET",
                    complete: function (data) {
                        if(data.code == "500"){
                            mui.alert("删除失败！");
                        }else {
                            //不再刷新，直接删除 dom
                            $(_self).closest("li").remove();
                            if ($('.resumeItem').length == 0){
                                $("#getResumeList").after("<p style='text-align: center;margin-top:5rem;'>您还没有简历哦！赶紧填写一份简历吧! </p>");
                            }
                            mui.toast("删除成功！");
                        }
                    }
                })
                // mui.alert("adfasdf");
                // console.log("aerqr");
            }
        });
    }


    $("#getResumeList").loadData().then(function (result) {
        if (result.data.list == 0){
            $("#getResumeList").after("<p style='text-align: center;margin-top:5rem;'>您还没有简历哦！赶紧填写一份简历吧! </p>");
            $(".nodata").hide();
        }
        //初始化,重置，清空
        ijob.storage.set("tempResumeSex", null);
        ijob.storage.set("tempResume", null);
        ijob.storage.set("tempEducationals", null);
        ijob.storage.set("tempWorkexperiences", null);
        ijob.storage.set("tempDocuments", null);
        ijob.storage.set("tempEvaluation", null);
        ijob.storage.set("tempResumeResumeTitle",null);
        ijob.storage.set("resumeTitle",null);
        //加载后才有值
        defaultID = $(".active").attr("id");



        $('.resume').click(function () {
            var resumeId = $(this).attr("resumeid");
            var resumeName = $(this).text().trim();
            var url = '/h5/qz/mine/chooseResume_add?data.Resume.id=' + resumeId;
            // if("http://localhost:8080/ijob/forward?path=/h5/qz/index/sign_up" === document.referrer){
            // console.log(ijob.storage.get("isByEnroll"));
            if (ijob.storage.get("isByEnroll")) {
                //退出到报名页面，将重置为false;
                ijob.storage.set("isByEnroll", false);
                // 传递到上一页的参数，放 session 中
                ijob.storage.set("resumeId",resumeId);
                ijob.storage.set("resumeName",resumeName);
                //返回上一页
                history.go(-1);
            } else {
                //跳转到预览
                ijob.gotoPage({path:url});
            }
        });
    });
</script>
</body>
</html>