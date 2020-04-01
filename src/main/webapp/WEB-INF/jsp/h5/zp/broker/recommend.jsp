<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/11
  Time: 11:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>推荐</title>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/broker/broker.css?version=4">
</head>
<body>
<div class="wrap">
    <div class="page_recommend">
        <form id="form">
            <div class="main-list-box">
                <div class="mui-row-input">
                    <input type="text" name="name" maxlength="5" placeholder="请输入姓名(必填)">
                </div>
                <div class="mui-row-input">
                    <input type="number"oninput="if(value.length>11)value=value.slice(0,11)" name="phoneNumber" placeholder="请输入手机号码(必填)">
                </div>
                <div class="mui-row-input sex">
                    <span class="sex">性别</span>
                    <div class="mui-radio">
                        <label><input type="radio" name="sex" value="1" checked>男</label>
                        <label><input type="radio" name="sex" value="2">女</label>
                    </div>
                </div>
                <div class="mui-row-input">
                    <input type="number" name="age" oninput="if(value.length>2)value=value.slice(0,2)" placeholder="请输入年龄">
                </div>
                <div class="mui-row-input remark">
                    <input type="text" name="mark" maxlength="88" placeholder="请填写备注">
                </div>
            </div>
            <div class="btns-box">
                <a href="javascript:void(0);" class="btns" data-url="/ijob/api/FullTimeController/personRecommend" id="btns">确认</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
<script>
    $(function () {
        /*确认*/
        $("#btns").click(function () {
            var myreg = /(^1[3|4|5|7|8]\d{9}$)|(^09\d{8}$)/;
           if ($("input[name='name']").val() == '' || $("input[name='name']").val() == null){
              mui.alert("请输入姓名");
           }else if($('input:radio[name="sex"]:checked').val() == null){
               mui.alert("请选择性别");
           }else if($("input[name='phoneNumber']").val() == '' || $("input[name='phoneNumber']").val() == null){
               mui.alert("请输入手机号码！");
           }else if($("input[name='phoneNumber']").val().length != 11){
               mui.alert('请输入正确的手机号码！');
           }else if(!myreg.test($("input[name='phoneNumber']").val())){
               mui.alert('手机号码格式错误！');
           }else{
               /*ijob.gotoPage({path:'/h5/zp/broker/broker'})*/
               var postRecommendBroker = {
                   brokerID:ijob.storage.get("broker.code"),
                   postID:ijob.storage.get("full.id"),
                   recommend:$("#form").serializeObjectJson(),
                   status:1
               };
               $(this).btPost(postRecommendBroker,function (result) {
                   if(result.code==200){
                        mui.toast("推荐成功")
                       window.history.back();
                   }else if(result.code != 200 && result.code != 500){
                        mui.toast(result.msg);
                   }else {
                       mui.toast("服务器繁忙");
                   }
               })
           }
        })
    })

</script>