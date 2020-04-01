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
    <title>产品功能建议</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/SubmitFeedback.css?version=4">
</head>
<body>
<div class="wrap page_advise">
    <form id="form">
        <input type="hidden" id="feedType" name="type">
        <div class="list-box">
            <div class="posi hisposi">
                <a href="javascript:void(0);"  class="link">
                    <span class="txt">请选择功能板块 </span>
                    <span id="hisposi"><span id="history">（必选）</span><span class="iconfont icon-arrow-right"></span></span>
                </a>
            </div>
            <div class="posi typeposi">
                <input type="text" id="phoneNumber" name="tel" placeholder="请输入联系电话或邮箱">
            </div>
        </div>
        <textarea class="textarea" name="text" id="feedback" cols="30" rows="5" wrap="physical"
                  placeholder="请详细描述你遇到的问题"></textarea>
        <p class="tips" id="result">0/500</p>
        <input type="hidden" id="feedContent" name="feedContent">
        <div class="upload" style=" width: 2.960rem;height: 2.987rem;">

                <img id="feedImgObj"  class="attachment up-img" data-name="feedImgObj" data-type="Photos"
                     data-id="" style="height: 100%;width: 100%"
                     src="" alt=""
                     onerror="this.src='/ijob/static/images/a9.png';this.onerror=null">

        </div>
        <div class="clearfix" style="1.867rem;overflow: hidden;clear: both;content: '';"></div>
        <div class="btnBox">
            <input id="submit" type="button" data-url="/ijob/api/FeedbackController/feedFackInfo" value="提交" class="btn">
        </div>
    </form>
</div>
<script>

    //工作过的岗位
    var picker = new mui.PopPicker();
    picker.setData([{
        text: '职位发布',
        value: '6'
    }, {
        text: '报名签到',
        value: '7'
    }, {
        text: '余额充值或提现',
        value: '8'
    }, {
        text: '消息咨询',
        value: '9'
    }, {
        text: '合伙人计划',
        value: '10'
    }]);
    $(document).on('tap', ".hisposi", function (event) {
        picker.show(function (items) {
            $("#history").html(items[0].text);
            $("#hisposi").val(items[0].value);
            $("#feedType").val(items[0].value);
        });
    });


    $(document).on("input propertychange", '#feedback', function () {
        var len = $("#feedback").val().length;
        $('#result').text(len + '/500');
        $(".btn").css({"background-color":""});
        if (len > 500) {
            $(".btn").css({"background-color":"#999"});
        }
    });
    $(".upload").attachment();

    $("#submit").click(function () {
        if($("#feedback").val()==null || $("#feedback").val()==""||$("#feedback").val()==undefined){
            mui.alert("请简要描述你的问题和意见");
        }else if($("#feedType").val()==null||$("#feedType").val()==undefined||$("#feedType").val()==''){
            mui.alert("请选择你要反馈的模块");
        }else if($("#phoneNumber").val()!=null&&$("#phoneNumber").val().length > 20){
            mui.alert("联系方式已超出20个字符");
        }else {
            if ($("#feedback").val().length <= 500){
                $("#feedContent").val($("#feedback").val());
                var feed = JSON.stringify($("form").serializeObjectJson()) ;
                console.log(feed);
                $("#submit").btPost(feed,function(data){
                    if(data.code == "200"){
                        mui.alert("我们已经收到您的建议。",function () {
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
    })
</script>
</body>
</html>