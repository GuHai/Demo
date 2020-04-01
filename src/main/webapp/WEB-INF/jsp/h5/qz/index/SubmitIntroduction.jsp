<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/21
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>填写简介</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/SubmitFeedback.css?version=4">
</head>
<body>
<div class="wrap page_SubmitIntroduction">
    <form id="form">
        <textarea class="textarea" name="text" id="feedback"  wrap="physical"
                  placeholder="请填写工作号的简介"></textarea>
        <p class="tips" id="result"><span id="tips">0</span>/500</p>

        <div class="btnBox" data-url="/ijob/api/InformationController/h5/mine/updateBrief" style="height: 1.067rem;line-height: 1.067rem">
            <input id="submit" type="button" value="提交" class="btn">
        </div>
    </form>
</div>
<div class="wraptext" style="display: none">
    <div class="text">
       <%-- <h5>湖南一生科技有限公司地处湖南长沙市，公司根据技术开发运营需要设置多个职能部门，包括经理室、财务室、行政办、技术部等。</h5>
        <h5>团队经过多年发展，造就了一支结构合理、业务精通、技术精湛、勇于开拓创新且忠诚度高的人才队伍，也使团队从小变大、由弱至强，成长为行业的一个实力派“小巨人，并于2017年12月成立改公司。</h5>
        <h5>在全体员工的共同努力下，项目经营取得显著成绩，服务水平不断提升，经济效益和综合实力显著提高，发展呈现良好局面，为行业互联网转型发展再作新贡献，使部分政府机构、企业得到了长足发展。</h5>
        <h5>我们本着以“客户利益高于一切”，急客户之所急，想客户之所想”的经营理念，期盼与您的合作。</h5>--%>
    </div>
    <div class="clearfix" style="height: 1.92rem;overflow: hidden;content:'';clear: both;"></div>
    <div class="back mui-action-back intrbtns">
        <input type="button" class="btn" value="返回" onclick="javascript:history.back(-1);">
    </div>
</div>
<script>
    var edit = ijob.storage.get("edit"),workNumberID = ijob.storage.get("workNumberID"),brief = ijob.storage.get("brief");
    brief = (brief.slice(1,brief.length-1)).trim();
    if(edit==null||edit==''||edit==undefined){
        /*$(".btnBox").hide();
        $("#feedback").attr("readonly","readonly");*/
        $(".page_SubmitIntroduction").hide();
        $(".wraptext").show();
        $(".wraptext .text").html("<h5>"+brief+"</h5>");
    }else {
        $("#tips").text(brief.length);
    }
    $("#feedback").val(brief);
    var isSubmit = true ;
    $(document).on("input propertychange", '#feedback', function () {
        var len = $("#feedback").val().length;
        $('#result').text(len + '/500');
        $(".btn").css({"background-color":""});
        if (len > 500) {
            $(".btn").css({"background-color":"#999"});
            isSubmit = false ;
        }
    });
    $(".btnBox").click(function () {
        if($("#feedback").val().length > 500){
            mui.alert("您的字数过多！");
        }else if($("#feedback").val().trim(" ")==""){
            mui.alert("不能提交空简介！");
        }else {
            $("#feedback").val($("#feedback").val().trim(" "));
            var obj = {
                brief:$("#feedback").val().trim(" ")
            }
            if(workNumberID!=null){
                obj.id = workNumberID;
            }
            $(this).btPost(obj,function (result) {
                if (result.code==200){
                    ijob.storage.set("edit",null);
                    ijob.storage.set("workNumberID",null);
                    ijob.storage.set("brief",null);
                    $(".btnBox").hide();
                    mui.toast("简介修改成功");
                    setTimeout(function() {
                        window.history.back();
                    }, 1000);
                }else {
                    mui.alert("修改失败！");
                }
            });
        }
    });
</script>
</body>
</html>