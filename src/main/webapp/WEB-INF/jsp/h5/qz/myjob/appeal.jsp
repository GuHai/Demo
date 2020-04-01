<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/6
  Time: 15:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>申诉</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/My_part-time/appeal.css">
    <link rel="stylesheet" href="/ijob/static/css/My_part-time/SettlementApplication_annal.css">
    <link rel="stylesheet" href="/ijob/css/mine/chooseResume_add.css">
</head>
<body>
<div class="wrap">
    <div class="title">${title}</div>
    <div class="jesuan" id="showpicker">
        <span class="jesuan_lf">申诉类型</span>
        <span class="jesuan_rt"><span id="userResult">不予结算薪资</span><i class="iconfont icon-arrow-right"></i></span>
    </div>
    <textarea class="textarea" name="text" id="appeal" cols="30" rows="7" wrap="physical" maxlength="200"
              placeholder="请填写缘由"></textarea>
    <p class="tips" id="result">0/200</p>
    <div class="upload">
        <label for="file">
            <i class="iconfont icon--jia"></i>
            <input type="file" id="file">
        </label>
    </div>
    <div class="footer_fixed">
        <div class="btnBox1">
            <input type="button" value="取消" class="btn_remove" onclick="self.location=document.referrer;">
            <input type="button" value="提交" class="btn_appeal" data-url="/ijob/api/AppealhandleController/add">
        </div>
    </div>
</div>
</body>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>
    $('#appeal').bind('input propertychange', function() {
        $('#result').html($(this).val().length + ' /200');
    });

    var picker = new mui.PopPicker();
    picker.setData([{
        text: '虚假职位信息',
        index:1
    }, {
        text: '不予结算薪资',
        index:2
    }, {
        text: '薪资结算错误',
        index:3
    }, {
        text: '其他',
        index:4
    }]);
    var appealType = 1;
    $("#showpicker").on('tap', function (event) {
        picker.show(function (items) {
            $("#userResult").html(items[0].text);
            appealType = items[0].index;
            //返回 false 可以阻止选择框的关闭`
            //return false;
        });
    });

    $(".btn_appeal").click(function(){
        $(this).btPost({
            "positionID":'${positionID}',
            "appealType":appealType
        },function(data){
            mui.toast(data.msg);
            setTimeout(function(){ self.location=document.referrer;},1500);
        });
    });
</script>
</html>
