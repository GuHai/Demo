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
    <title>提交反馈</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/SubmitFeedback.css?version=4">
</head>
<body>
<div class="wrap">
    <input id="getPositionList" data-url="/ijob/api/PositionController/getPositionList" type="hidden">
    <form id="form">
        <div class="list-box">
            <div class="posi hisposi">
                <a href="javascript:void(0);"  class="link">
                    <span class="txt">工作过的职位 </span>
                    <span id="hisposi"><span id="history"></span><span class="iconfont icon-arrow-right"></span></span>
                </a>
            </div>
            <div class="posi typeposi">
                <a href="javascript:void(0);"  class="link">
                    <span class="txt">投诉类型</span>
                    <span id="typeselect"><span id="type">（必选）</span><span class="iconfont icon-arrow-right"></span></span>
                </a>
            </div>
        </div>
        <input type="hidden" id="feedType" name="type">
        <input type="hidden" id="feedPositionID" name="positionID">
        <textarea class="textarea" id="feedback" cols="30" rows="5" wrap="physical"
                  placeholder="请简要描述你的问题和意见"></textarea>
        <p class="tips" id="result">0/500</p>
        <input type="hidden" id="feedContent" name="feedContent">
        <div class="upload" style=" width: 2.960rem;height: 2.987rem;">

                <img id="feedImgObj"  class="attachment up-img" data-name="feedImgObj" data-type="Photos"
                     data-id="" style="height: 100%;width: 100%"
                     src="" alt=""
                     onerror="this.src='/ijob/static/images/a9.png';this.onerror=null">

        </div>
        <div class="clearfix" style="height: 2.7rem;overflow: hidden;clear: both;content: '';"></div>
        <div class="btnBox">
            <input id="submit" type="button" data-url="/ijob/api/FeedbackController/feedFackInfo" value="提交" class="btn">
            <a href="javascript:void(0);" class="records" onclick="ijob.gotoPage({path:'/h5/qz/mine/historyComplaint'})" > 投诉记录</a>
        </div>
        <a id="getPersonalauthen" style="display: none" data-url="/ijob/api/PersonalauthenController/qz/getPersonalauthen"></a>
    </form>
</div>
<script>

    $("#getPositionList").btPost(null,function(result1){
        //工作过的岗位
        var picker = new mui.PopPicker();
        picker.setData(result1.data.list);
        $(document).on('tap', ".hisposi", function (event) {
            picker.show(function (items) {
                $("#history").html(items[0].text);
                $("#hisposi").val(items[0].value);
                $("#feedPositionID").val(items[0].value);
            });
        });

        //投诉类型 1,工资纠纷,2,虚假信息,3,违约现象,4,平台问题,5,其它问题
        var picker1 = new mui.PopPicker();
        picker1.setData([{
            text: '工资纠纷',
            value: '1'
        }, {
            text: '虚假信息',
            value: '2'
        }, {
            text: '违约现象',
            value: '3'
        }, {
            text: '平台问题',
            value: '4'
        }, {
            text: '其它问题',
            value: '5'
        }]);
        $(document).on('tap', ".typeposi", function (event) {
            picker1.show(function (items) {
                if(items[0].value == 4||items[0].value == 5){
                    $(".hisposi").hide();
                    $("#feedPositionID").val(null);
                }else{
                    $(".hisposi").show();
                }
                if(ijob.storage.get("data.positionID")!=null){
                    $("#feedPositionID").val(null);
                    $(".hisposi").hide();
                }
                $("#feedType").val(items[0].value)
                $("#type").html(items[0].text);
                $("#typeselect").val(items[0].value);
            });
        });

        if(ijob.storage.get("data.positionID")!=null){
            $(".hisposi").hide();
        }

        $(document).on("input propertychange", '#feedback', function () {
            var len = $("#feedback").val().length;
            $('#result').text(len + '/500');
            $(".btn").css({"background-color":""});
            if (len > 500) {
                $(".btn").css({"background-color":"#999999"});
            }
        });
        $(".upload").attachment();

        $("#submit").click(function () {
            $("#getPersonalauthen").btPost(null,function(data){
                if($("#feedType").val()!=5&&$("#feedType").val()!=4&&ijob.storage.get("data.positionID")!=null){
                    $("#feedPositionID").val(ijob.storage.get("data.positionID"));
                }
                if($("#feedback").val()==null || $("#feedback").val()==""){
                    mui.alert("请简要描述你的问题和意见");
                }else if($("#feedType").val()==null||$("#feedType").val()==undefined||$("#feedType").val()==""){
                    mui.alert("请选择你要投诉的类型");
                }else if($("#feedType").val()!=5&&$("#feedType").val()!=4&&($("#feedPositionID").val()==null||$("#feedPositionID").val()==undefined||$("#feedPositionID").val()=="")){
                    mui.alert("请选择你要投诉的职位");
                }else {
                    if ($("#feedback").val().length <= 500){
                        $("#feedContent").val($("#feedback").val());
                        var feed = JSON.stringify($("form").serializeObjectJson()) ;
                        $("#submit").btPost(feed,function(data){
                            if(data.code == "200"){
                                var btnArray = ['确定'];
                                mui.confirm("我们已经收到您的举报。", '提示', btnArray, function () {
                                    // window.location.href = "http://localhost:8080/indexMain";
                                    history.go(-1);
                                });
                            }else {
                                mui.alert("服务器繁忙，请稍后再试!");
                            }
                        });
                    }else{
                        mui.alert("字数超出五百字！");
                    }
                }
            });
        })
    });

</script>
</body>
</html>