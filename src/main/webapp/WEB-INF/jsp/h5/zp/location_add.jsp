<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/8
  Time: 17:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>选择模板</title>
    <jsp:include page="../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/chooseResume.css">
</head>
<body>
<style>
    #chooseResume .main .resumeList > li .list-title>span{float:right;font-size:0.346rem;color:#666;}
    #chooseResume .head > a .head-lf_span{font-size:0.4rem !important;}
    #chooseResume .main .resumeList > li .list-content .default{width:1.813rem;height:0.586rem;}
    #chooseResume .main .resumeList > li .list-content .list-cz .delete,
    #chooseResume .main .resumeList > li .list-content .list-cz .edit{font-size:0.4rem;}
</style>
    <div id="chooseResume" class="wrap">
        <div>
            <script type="text/html" id="mypositiontemplatetemplate"  data-url="/ijob/api/PositionController/h5/zp/getMyPositionTemplateList" data-type="POST">
                <%--<header class="head">--%>
                <%--<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/location_tem?positionTemp.id=0'})">--%>
                <%--<span class="head-lf_span"><i class="iconfont icon-jia" style="font-size:0.480rem;margin-right:0.213rem;"></i>新增模板</span>--%>
                <%--<span class="head-rt_span iconfont icon-arrow-right"></span>--%>
                <%--</a>--%>
                <%--</header>--%>
                <div class="main">
                    <ul class="resumeList">
                        {{each list as posiTemp}}
                        <li>
                            <div class="list-title"><div class="v">{{posiTemp.title}}</div>
                                {{if posiTemp.open == 11}}
                                <i class="iconfont icon-gou checkmarkempty" style="display: block"></i>
                                {{/if}}
                            </div>
                            <div class="list-content">
                                {{if posiTemp.open == 11}}
                                <div class="default active" tempId="{{posiTemp.id}}" version="{{posiTemp.version}}" onclick="setDefault(this)">已默认</div>
                                {{else if posiTemp.open == 12}}
                                <div class="default" tempId="{{posiTemp.id}}" version="{{posiTemp.version}}" onclick="setDefault(this)">设为默认</div>
                                {{/if}}
                                <div class="list-cz">
                                    <%--<a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/location_tem?positionTemp.id={{posiTemp.id}}'})"class="edit"><i class="iconfont icon-edit-fill"></i>编辑</a>--%>
                                    <a href="javascript:void(0);" class="delete" data-url="/ijob/api/PositionController/delete" onclick="deletePositionTemplate(this,'{{posiTemp.id}}','{{posiTemp.version}}')"><i class="iconfont icon-shanchu2"></i>删除</a>
                                </div>
                            </div>
                        </li>
                        {{/each}}
                        <%--<li>
                            <div class="list-title"><div class="v">模特招聘模特招聘模特招聘模特招聘模特招聘模特招聘模特招聘</div></div>
                            <div class="list-content">
                                <div class="default">设为默认</div>
                                <div class="list-cz">
                                    <a href="javascript:void(0);" class="edit"><i class="iconfont icon-edit-fill"></i>编辑</a>
                                    <a href="javascript:void(0);" class="delete"><i class="iconfont icon-shanchu2"></i>删除</a>
                                </div>
                            </div>
                        </li>--%>
                    </ul>
                </div>
                <div style="clear:both;content:'';height:1.6rem;overflow:hidden;"></div>
            </script>
        </div>
        <header class="choose_foot">
            <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/location_tem?positionTemp.id=0'})">
                <span class="head-lf_span">
                    <%--<i class="iconfont icon-jia" style="font-size:0.480rem;margin-right:0.213rem;"></i>--%>
                    新增模板
                </span>
                <%--<span class="head-rt_span iconfont icon-arrow-right"></span>--%>
            </a>
        </header>
        <div id="homepage"></div>
    </div>


</body>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});

    ijob.storage.set("positionObj",null);
    ijob.storage.set("id",null);
    ijob.storage.set("labelList",null);
    ijob.storage.set("jobContent",null);
    ijob.storage.set("position.workDateArr",null);
    console.log(ijob.storage.get("positionObj"))
    $("#mypositiontemplatetemplate").loadData().then(function (result){
        if (result.data.list == 0){
            $("#mypositiontemplatetemplate").after("<p style='text-align: center;margin-top:5rem;'>您还没有模板哦！ </p>");
            $(".nodata").hide();
        }
    });

    /**
     * 删除职位模版
     * @param arg 事件触发的对象
     * @param positionTempID 职位模版ID
     * @param version 职位模版版本号
     */
    function deletePositionTemplate(arg,positionTempID,version){
        var btn = ['取消', '确定'];
        mui.confirm('确定要删除该模板吗？', '提示', btn, function (e) {
            if (e.index == 1) {
                $(arg).btPost({"id":positionTempID,"version":version},function(data){
                    if (data.code == "200"){
                        mui.toast("删除成功！");
                        $("#mypositiontemplatetemplate").loadData();
                    }else{
                        mui.toast("删除失败！");
                    }
                });
            }
        });

    }

    //设为默认模板
    function setDefault(obj) {
        var oldDefaultID = $(".active").attr("tempId");
        var oldDefaultVersion = $(".active").attr("version");
        if ($(obj).attr("tempId") != oldDefaultID) {
            $(".active").removeClass("active").text("设为默认");
            $(obj).addClass("active").text("默认");
            var newDefaultID = $(obj).attr("tempId");
            $.post("/ijob/api/PositionController/h5/zp/updateDefaultTemp", {
                "newDefId": newDefaultID,
                "newDefVersion": $(obj).attr("version"),
                "oldDefId":oldDefaultID,
                "oldDefVersion":oldDefaultVersion
            }, function (data) {
                if (data.code != "200") {
                    mui.toast("服务器繁忙！");
                }else{
                    $("#mypositiontemplatetemplate").loadData().then(function (result){
                        var btn = ['取消', '确定'];
                        mui.confirm('需要立即去发布职位吗？', '提示', btn, function (e) {
                            if (e.index == 1) {
                                ijob.gotoPage({path:'/h5/zp/postJob2?positionTemp.id=0'})
                            }
                        });
                    });
                }
            });
        }
    }
</script>
</html>
