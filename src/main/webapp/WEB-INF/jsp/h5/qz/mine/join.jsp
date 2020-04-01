<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>招商加盟</title>
    <script src="/ijob/lib//lib-flexible.js"></script>
    <script src="/ijob/lib/mui/js/mui.min.js"></script>
    <script src="/ijob/lib/mui/js/mui.picker.min.js"></script>
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.picker.min.css">
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/static/css/base.css">
    <link rel="stylesheet" href="/ijob/static/css/mine/join.css">
</head>
<body>
<div class="wrap">
    <ul class="joinList">
        <li class="user inputLi">
            <input name="name" id="name" type="text" placeholder="请输入姓名" maxlength="20">
        </li>
        <li class="phone inputLi">
            <input name="phoneNumber" id="phoneNumber" type="text" placeholder="请输入手机号"  maxlength="20">
        </li>
    </ul>
    <div class="select-agents" id="agentspicker">
        <input type="hidden" id="joinType" name="joinType" value="1">
        <span>选择代理商</span>
        <span>
            <span id="agents">省代理</span>
            <i class="iconfont icon-arrow-right"></i>
        </span>
    </div>
    <div class="diqu">
        <input type="text" name="region" id="region" placeholder="请输入地区"  maxlength="20">
    </div>
    <div class="textBox">
        <textarea class="textarea" name="explain" id="explain" cols="30" rows="5" wrap="physical"
                  placeholder="请输入说明"></textarea>
    </div>
    <p class="text_info"><span id="fontSize">0</span>/200</p>
    <div class="btnBox">
        <input type="button" value="提交申请" class="btn" id="submitBtn">
    </div>
</div>
</body>
</html>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>
    //    $.init();
    var picker = new mui.PopPicker();
    picker.setData([{
        text: '省代理',
        value:'1'
    }, {
        text: '市代理',
        value:'2'
    }, {
        text: '区/县代理',
        value:'3'
    }, {
        text: '校园代理',
        value:'4'
    }]);
    $("#agentspicker").on('tap', function (event) {
        picker.show(function (items) {
            $("#agents").html(items[0].text);
            $("#joinType").val(items[0].value);
            //返回 false 可以阻止选择框的关闭
            //return false;
        });
    });
    var myreg=/^[1][3,4,5,7,8,9][0-9]{9}$/;
    /**
     * 提交加盟申请
     */
    function submitForm(){
        if ($("#name").val().trim() == null || $("#name").val().trim() == ""){
            mui.alert("请填写名字！","I Job");
        }else if ($("#phoneNumber").val().trim() == null || $("#phoneNumber").val().trim() == ""){
            mui.alert("请填写手机号码！","I Job");
        }else if (!verifi()){
            mui.alert("手机号码格式不正确！","I Job");
        }else if ($("#joinType").val().trim() == null || $("#joinType").val().trim() == ""){
            mui.alert("请选择代理类型！","I Job");
        }else if ($("#region").val().trim() == null || $("#region").val().trim() == ""){
            mui.alert("请指明你想代理的地区！","I Job");
        }else if ($("#explain").val().trim() == null || $("#explain").val().trim() == ""){
            mui.alert("请输入说明，以便我们工作人员与你交流！","I Job");
        }else if ($("#explain").val().length > 200){
            mui.alert("不能超过两百字！","I Job")
        }else{
            $.post("/ijob/api/JointableController/add",
                {
                    'name':$("#name").val(),
                    'phoneNumber':$("#phoneNumber").val(),
                    'joinType':$("#joinType").val(),
                    'region':$("#region").val(),
                    'explain':$("#explain").val()
                },function(data){
                    if(data.code == '200'){
                        mui.toast("数据提交成功，工作人员会尽快与你联系！","I Job");
                        ijob.gotoPage({url:"/indexMain"});
                    }else {
                        mui.toast("目前服务器比较繁忙，请稍后再试！","I Job");
                    }
            });
        }
    }
    /**
     * 验证手机号码是否正确
     * @returns {boolean}
     */
    function verifi(){
        if (!myreg.test($("#phoneNumber").val())) {
            return false;
        } else {
            return true;
        }
    }


    $(document).on("input propertychange", '#explain', function () {
        var len = $("#explain").val().length;
        $('#fontSize').text(len);
        $("#submitBtn").css({"background-color":""});
        if (len > 200) {
            $("#submitBtn").css({"background-color":"#999"});
        }
    });
    $(document).on("click", '#submitBtn', function () {
        if ($("#explain").val().length <= 200) {
            submitForm();
        }else{
            mui.toast("说明中内容超过200！");
        }
    });
    $(function(){
        $('#fontSize').text($("#explain").val().length);
    });

</script>