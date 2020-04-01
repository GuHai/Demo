<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>实名认证</title>
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/static/css/base.css">
    <link rel="stylesheet" href="/ijob/static/css/mine/realName.css">
    <script src="/ijob/lib//lib-flexible.js"></script>
    <script src="/ijob/lib/mui/js/mui.min.js"></script>
</head>
<body>
<div class=wrap>
    <ul class="tabList">
        <li class="active">个人用户</li>
        <li>企业用户</li>
    </ul>
    <div class="main">
        <div class="main1">
            <c:choose>
                <c:when test="${sessionScope.Personalauthen == null}">
                    <div class="formName" style="display: block">
                        <form id="personForm" name="personForm" action="/ijob/api/PersonalauthenController/add" method="post">
                            <div class="inputBox">
                                <input type="text" id="schoolName" name="schoolName" placeholder="请输入完整的学校名称">
                            </div>
                            <div class="inputBox">
                                <input type="text" id="realName" name="realName" placeholder="请输入姓名">
                            </div>
                            <div class="inputBox">
                                <input type="text" id="personIDCard" name="personIDCard" placeholder="请输入身份证号">
                            </div>
                            <div class="inputBox">
                                <input type="text" id="personPhoneNumber" name="personPhoneNumber" placeholder="请输入手机号" pattern="^1[3-9]\d{9}$">
                            </div>
                            <div class="inputBox">
                                <input type="text" id="personCode" placeholder="请输入验证码" class="code">
                                <input type="button" id="getPersonCode" onclick="getPersonCodeBtn()" value="获取验证码" class="getcode">
                            </div>
                            <div class="fileBox">
                                <label for="file_z" class="upload">
                                    <div class="info">拍摄身份证正面照</div>
                                    <input type="hidden" value="just" name="personIDCardJustOriginal" id="personIDCardJustOriginal">
                                    <img src="/ijob/static/images/sfz.jpg" id="personJustImg" alt="">
                                    <input type="file" id="file_z">
                                </label>
                                <label for="file_f" class="upload">
                                    <div class="info">拍摄身份证反面照</div>
                                    <input type="hidden" value="back" name="personIDCardBackOriginal" id="personIDCardBackOriginal">
                                    <img src="/ijob/static/images/sfz.jpg" id="personBackImg" alt="">
                                    <input type="file" id="file_f">
                                </label>
                            </div>
                            <input type="button" class="btn" value="提交" onclick="personSubmit()">
                        </form>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="realName" style="display: block">
                        <div class="realText">
                            <p class="selfName">${sessionScope.Personalauthen.realName}</p>
                            <p class="selfCard">${sessionScope.Personalauthen.personIDCard}</p>
                            <p class="selfPhone">${sessionScope.Personalauthen.personPhoneNumber}</p>
                        </div>
                        <div class="realImg">
                            <img src="${sessionScope.Personalauthen.personIDCardJustTreatment}" alt="身份证正面" class="img_zm">
                            <img src="${sessionScope.Personalauthen.personIDCardBackTreatment}" alt="身份证反面" class="img_fm">
                        </div>
                        <div class="btnBox">
                            <input type="button" class="btn_back" value="返回">
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="main2">
            <c:choose>
                <c:when test="${sessionScope.Enterpriseauthen == null}">
                    <div class="formFirm" style="display: block">
                        <form id="enterpriseauthenForm" action="/ijob/api/EnterpriseauthenController/add" method="post">
                            <div class="firmInfo">
                                <h2>企业信息</h2>
                                <label for="" class="firmName">
                                    <input type="text" id="enterpriseName" name="enterpriseName" placeholder="请输入公司名称">
                                </label>
                                <label for="" class="creditNub">
                                    <input type="text" id="creditCode" name="creditCode" placeholder="请输入社会信用代码">
                                </label>
                                <div class="sub">
                                    <p class="sub_text">上传营业执照</p>
                                    <input type="hidden"  id="licenseOriginal" name="licenseOriginal" value="">
                                    <img src="" alt="" class="sub_img">
                                </div>
                            </div>
                            <div class="frInfo">
                                <h2>法人信息</h2>
                                <label for="" class="frName">
                                    <input type="text" placeholder="请输入法人姓名" id="legalName" name="legalName" >
                                </label>
                                <label for="" class="idNub">
                                    <input type="text" placeholder="请输入身份证号" id="legalIDCard" name="legalIDCard" >
                                </label>
                                <div class="fr_up">
                                    <div class="fr_up_zm">
                                        <h5>拍摄身份证正面照</h5>
                                        <label for="file_zm">
                                            <input type="hidden" id="legalIDCardJustOriginal" name="legalIDCardJustOriginal" value="">
                                            <img src="/ijob/static/images/sfz.jpg" alt="">
                                            <input type="file" id="file_zm">
                                        </label>
                                    </div>
                                    <div class="fr_up_fm">
                                        <h5>拍摄身份证反面照</h5>
                                        <label for="file_fm">
                                            <input type="hidden"  id="legalIDCardBackOriginal" name="legalIDCardBackOriginal" value="">
                                            <img src="/ijob/static/images/sfz.jpg" alt="">
                                            <input type="file" id="file_fm">
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="runInfo">
                                <h2>管理者信息</h2>
                                <label for="" class="runName">
                                    <input type="text" placeholder="请输入姓名" id="adminName" name="adminName" >
                                </label>
                                <label for="" class="IdNub">
                                    <input type="text" placeholder="请输入身份证号码" id="adminIDCard" name="adminIDCard" >
                                </label>
                                <label for="" class="run_phone">
                                    <input type="text" placeholder="请输入手机号" id="adminPhoneNumber" name="adminPhoneNumber" >
                                </label>
                                <label for="" class="run_code">
                                    <input type="text" id="enterCode" placeholder="请输入验证码">
                                    <input type="button" id="enterCodeBtn" onclick="getEnterCodeBtn()" value="获取验证码">
                                </label>
                                <div class="run_up">
                                    <div class="run_up_zm">
                                        <h5>拍摄身份证正面照</h5>
                                        <label for="run_file_zm">
                                            <input type="hidden"  id="adminIDCardJustOriginal" name="adminIDCardJustOriginal" value="">
                                            <img src="/ijob/static/images/sfz.jpg" alt="">
                                            <input type="file" id="run_file_zm">
                                        </label>
                                    </div>
                                    <div class="run_up_fm">
                                        <h5>拍摄身份证反面照</h5>
                                        <label for="run_file_fm">
                                            <input type="hidden"  id="adminIDCardBackOriginal" name="adminIDCardBackOriginal" value="">
                                            <img src="/ijob/static/images/sfz.jpg" alt="">
                                            <input type="file" id="run_file_fm">
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="btnBox">
                                <input type="button" class="btn" value="提交" onclick="enterSubmit()">
                            </div>
                        </form>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="realFirm" style="display: block">
                        <div class="info1">
                            <h2>企业信息</h2>
                            <p>${sessionScope.Enterpriseauthen.enterpriseName}</p>
                            <p>${sessionScope.Enterpriseauthen.creditCode}</p>
                            <img src="${sessionScope.Enterpriseauthen.licenseTreatment}" alt="">
                        </div>
                        <div class="info2">
                            <h2>法人信息</h2>
                            <p>${sessionScope.Enterpriseauthen.legalName}</p>
                            <p>${sessionScope.Enterpriseauthen.legalIDCard}</p>
                            <img src="${sessionScope.Enterpriseauthen.legalIDCardJustTreatment}" alt="">
                            <img src="${sessionScope.Enterpriseauthen.legalIDCardBackTreatment}" alt="">
                        </div>
                        <div class="info3">
                            <h2>管理员信息</h2>
                            <p>${sessionScope.Enterpriseauthen.adminName}</p>
                            <p>${sessionScope.Enterpriseauthen.adminIDCard}</p>
                            <p>${sessionScope.Enterpriseauthen.adminPhoneNumber}</p>
                            <img src="${sessionScope.Enterpriseauthen.adminIDCardJustTreatment}" alt="">
                            <img src="${sessionScope.Enterpriseauthen.adminIDCardBackTreatment}" alt="">
                        </div>
                        <div class="btnBox">
                            <input type="button" class="btn_back" value="返回">
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</body>
</html>
<script src="/ijob/lib/jquery-2.2.3.js"></script>
<script>
    $(".tabList>li").on("click", function () {
        var index = $(this).index();
        $(this).addClass("active").siblings().removeClass("active");
        $(".main>div").eq(index).show().siblings().hide();
    })
</script>
<script>
    var myPersonCode = "";
    var myTime = 60;
    var personIntervalID = 0;
    var isPersonClick = true;
    var enterCode = "";
    var enterTime = 60;
    var enterItervalID = 0;
    var isEnterClick = true;
    var myreg=/^[1][3,4,5,7,8,9][0-9]{9}$/;

    <!-- 企业认证开始 -->
    /**
     *
     * 进行企业认证
     * */
    function enterSubmit(){
        if($("#enterpriseName").val() == null || $("#enterpriseName").val() == "" ){
           mui.alert("请输入企业名称!");
        }else if($("#creditCode").val() == null || $("#creditCode").val() == "" ){
           mui.alert("请输入企业社会信用代码!");
        }else if($("#licenseOriginal").val() == null || $("#licenseOriginal").val() == "" ){
           mui.alert("请上传营业执照!");
        }else if($("#legalName").val() == null || $("#legalName").val() == "" ){
           mui.alert("请输入法人姓名!");
        }else if($("#legalIDCard").val() == null || $("#legalIDCard").val() == "" ){
           mui.alert("请输入法人身份证号码!");
        }else if($("#legalIDCardJustOriginal").val() == null || $("#legalIDCardJustOriginal").val() == "" ){
           mui.alert("请上传法人身份证正面照!");
        }else if($("#legalIDCardBackOriginal").val() == null || $("#legalIDCardBackOriginal").val() == "" ){
           mui.alert("请上传法人身份证反面照!");
        }else if($("#adminName").val() == null || $("#adminName").val() == "" ){
           mui.alert("请输入管理员姓名!");
        }else if($("#adminIDCard").val() == null || $("#adminIDCard").val() == "" ){
           mui.alert("请输入管理员身份证号码!");
        }else if($("#adminPhoneNumber").val() == null || $("#adminPhoneNumber").val() == "" ){
           mui.alert("请输入管理员手机号码!");
        }else if(!verifi(2)){
           mui.alert("手机号码格式存在错误!");
        }else if($("#enterCode").val() != enterCode){
           mui.alert("验证码错误!");
        }else if($("#adminIDCardJustOriginal").val() == null || $("#adminIDCardJustOriginal").val() == ""){
           mui.alert("请上传法人身份证正面照");
        }else if($("#adminIDCardBackOriginal").val() == null || $("#adminIDCardBackOriginal").val() == ""){
           mui.alert("请上传法人身份证反面照");
        }else {
            document.getElementById("enterpriseauthenForm").submit();
        }

    }

    /**
     * 获得企业手机验证码
     * */
    function getEnterCodeBtn() {
        if($("#adminPhoneNumber").val() == null || $("#adminPhoneNumber").val() == "" ){
           mui.alert("请输入手机号码!");
        }else if(!isEnterClick){
           mui.alert("请等下再获取！！");
        }else if(!verifi(2)){
           mui.alert("手机号码不正确哦！你他妈的给老子填写假的试试看！");
        }else {
            $.post("/ijob/api/ContentsendrecordController/sendSMSCode",
                {"phoneNumber": $("#adminPhoneNumber").val(), "businessType": 1},
                function (data) {
                    if (data.code == "200") {
                        enterCode = data.data.msgContent;
                        enterItervalID = setInterval("setValueOfEnterCodeBtn()", 1000);
                        $("#enterCodeBtn").unbind("click",getEnterCodeBtn);
                    } else if (data.code == "500") {
                       mui.alert("参数异常！");
                    } else if (data.code == "510") {
                       mui.alert("对不起，你的可接收短信已到达上限，请明天再来。");
                    }
                });
        }
    }
    /**
     *  管理员验证码获取状态
     * */
    function setValueOfEnterCodeBtn(){
        if (enterTime > 0){
            $("#enterCodeBtn").val("重新获取(" + enterTime + "S)");
            enterTime--;
            isEnterClick = false;
        }else{
            $("#enterCodeBtn").val("获取验证码");
            enterTime = 60;
            clearInterval(enterItervalID);
            isEnterClick = true;
            $("#enterCodeBtn").bind("click",getEnterCodeBtn);
        }
    }
    <!-- 企业认证结束 -->

    <!-- 个人认证开始 -->
    /**
     *  个人实名认证数据提交
     * */
    function personSubmit(){
        if($("#schoolName").val() == null || $("#schoolName").val() == "" ){
           mui.alert("请填写学校名称！");
        }else if($("#realName").val() == null || $("#realName").val() == "" ){
           mui.alert("请填写真实姓名！");
        }else if($("#personIDCard").val() == null || $("#personIDCard").val() == "" ){
           mui.alert("请填写身份证号码！");
        }else if($("#personPhoneNumber").val() == null || $("#personPhoneNumber").val() == "" ){
           mui.alert("请填写手机号！");
        }else if(!verifi(1)){
           mui.alert("手机号码不正确！");
        }else if($("#personCode").val() == null || $("#personCode").val() == "" ){
           mui.alert("请填写验证码！");
        }else if($("#personCode").val() != myPersonCode){
           mui.alert("验证码不正确！");
        }else if($("#personIDCardJustOriginal").val() == null || $("#personIDCardJustOriginal").val() == "" ){
           mui.alert("请上传身份证正面照！");
        }else if($("#personIDCardBackOriginal").val() == null || $("#personIDCardBackOriginal").val() == "" ){
           mui.alert("请上传身份证反面照！");
        }else{
            document.getElementById("personForm").submit();
        }
    }
    /**
     *  获得个人认证验证码
     * */
    function getPersonCodeBtn() {
        if($("#personPhoneNumber").val() == null || $("#personPhoneNumber").val() == "" ){
           mui.alert("请输入手机号码!");
        }else if(!isPersonClick){
           mui.alert("请等下再获取！！");
        }else if(!verifi(1)){
           mui.alert("手机号码不正确哦！你他妈的给老子填写假的试试看！");
        }else {
            $.post("/ijob/api/ContentsendrecordController/sendSMSCode",
                {"phoneNumber": $("#personPhoneNumber").val(), "businessType": 1},
                function (data) {
                    if (data.code == "200") {
                        myPersonCode = data.data.msgContent;
                        personIntervalID = setInterval("setValueOfCodeBtn()", 1000);
                    } else if (data.code == "500") {
                       mui.alert("参数异常！");
                    } else if (data.code == "510") {
                       mui.alert("对不起，你的可接收短信已到达上限，请明天再来。");
                    }
                });
        }
    }

    /**
     * 设置验证码按钮状态
     */
    function setValueOfCodeBtn(){
        if (myTime > 0){
            $("#getPersonCode").val("重新获取(" + myTime + "S)");
            myTime--;
            isPersonClick = false;
        }else{
            $("#getPersonCode").val("获取验证码");
            myTime = 60;
            clearInterval(personIntervalID);
            isPersonClick = true;
        }
    }
    <!-- 个人认证结束 -->

    /**
     * 验证手机号码是否正确
     * @returns {boolean}
     */
    function verifi(arg){
        if (arg == 1 ){
            if (!myreg.test($("#personPhoneNumber").val())) {
                return false;
            } else {
                return true;
            }
        }else {
            if (!myreg.test($("#adminPhoneNumber").val())) {
                return false;
            } else {
                return true;
            }
        }

    }
</script>