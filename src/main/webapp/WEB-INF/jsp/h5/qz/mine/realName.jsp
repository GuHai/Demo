<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/8
  Time: 10:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <title>我的实名认证</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/realName.css">
    <style>
        .blur {
            -webkit-filter: blur(2px); /* Chrome, Opera */
            -moz-filter: blur(2px);
            -ms-filter: blur(2px);
            filter: blur(2px);
        }
    </style>
</head>
<body>
<div class=wrap>
    <ul class="tabList">
        <li class="active" style="width: auto">个人用户</li>
        <li style="width: auto">企业用户</li>
    </ul>
    <div class="main">
        <script  type="text/html" id="jobtemplate"  data-url="/ijob/api/InformationController/myRealName">
            {{each list as map}}
            <input type="hidden" id="identityType" value="{{map.identityType}}">
            <div class="main1">
                <div class="formName">
                    <form action="" id="personForm" data-url="/ijob/api/PersonalauthenController/updatePersonAndCert">
                        <input name="id" value="{{map.Personalauthen.id}}" type="hidden" id="blockID"/>
                        <input name="version" value="{{map.Personalauthen.version}}" type="hidden" id="versionblockID"/>
                        <input  value="{{map.Personalauthen.personIDCard}}" type="hidden" id="personIDCardFlag"/>
                        <%--<div class="inputBox">
                            <input type="text" placeholder="请输入完整的学校名称" id="schoolName"  name="schoolName" value="{{map.Personalauthen.schoolName}}" maxlength="20">
                        </div>--%>
                        <div class="inputBox">
                            <input type="text" placeholder="请输入姓名" id="realName" name="realName"  value="{{map.Personalauthen.realName}}" maxlength="5">
                        </div>
                        <div class="inputBox">
                            <input type="text" placeholder="请输入身份证号"  name="personIDCard" id="personIDCard"  value="{{map.Personalauthen.personIDCard}}"  maxlength="20">
                        </div>
                        <div class="inputBox">
                            <input type="text" placeholder="请输入手机号"  name="personPhoneNumber" id="personPhoneNumber" pattern="^1[3-9]\d{9}$"  value="{{map.Personalauthen.personPhoneNumber}}"  maxlength="20">
                        </div>
                        <div class="inputBox">
                            <input type="text" id="personCode" name="code" placeholder="请输入验证码" class="code"  maxlength="16">
                            <input type="button" id="getPersonCode" onclick="getPersonCodeBtn()" value="获取验证码" class="getcode">
                        </div>
                        <div class="fileBox">
                            <label for="file_z" class="upload">
                                <div class="info">拍摄身份证正面照</div>
                                <img  class="attachment" data-name="gzAttachment"  style="width:150px;height: 100px" data-type="Certificate"
                                      id="personIDCardJustOriginal"
                                      src="/ijob/upload/{{map.Personalauthen.gzAttachment | absolutelyPath }}"
                                      data-id="{{map.Personalauthen.personIDCardJustOriginal}}"  alt=""
                                      onerror="this.src='/ijob/static/images/sfz.png';this.onerror=null">

                            </label>
                            <label for="file_z" class="upload">
                                <div class="info">拍摄身份证反面照</div>
                                <img  class="attachment" data-name="gfAttachment"  style="width:150px;height: 100px" data-type="Certificate"
                                      id="personIDCardBackOriginal"
                                      src="/ijob/upload/{{map.Personalauthen.gfAttachment | absolutelyPath }}"
                                      data-id="{{map.Personalauthen.personIDCardBackOriginal}}"
                                      onerror="this.src='/ijob/static/images/sfz.png';this.onerror=null">

                            </label>
                        </div>
                        <footer class="foot">
                            <div class="btn" id="submit_person">
                                提交
                            </div>
                        </footer>
                    </form>
                </div>
                <div class="realName">
                    <div class="realText">
                        <p class="selfName"> 姓　名：{{map.Personalauthen.realName}}</p>
                        <p class="selfCard">身份证：{{map.Personalauthen.personIDCard}}</p>
                        <p class="selfPhone">手机号：{{map.Personalauthen.personPhoneNumber}}</p>
                        <p class="selfPhone">状　态：{{map.Personalauthen.status==0?'待审核':(map.Personalauthen.status==1?'审核通过':'审核不通过')}}</p>
                    </div>
                    <div class="realImg">
                        <img  class="img_zm" src="/ijob/upload/{{map.Personalauthen.gzAttachment | absolutelyPath }}"
                              onerror="this.src='/ijob/static/images/sfz.png';this.onerror=null">
                        <img  class="img_fm" src="/ijob/upload/{{map.Personalauthen.gfAttachment | absolutelyPath }}"
                              onerror="this.src='/ijob/static/images/sfz.png';this.onerror=null">
                    </div>
                    <div class="btnBox">
                        <input type="button" class="btn_back active" onclick="ijob.back()" value="返回">
                    </div>
                </div>
            </div>
            <div class="main2">
                <div class="formFirm">
                    <form action="" id="enterForm" data-url="/ijob/api/EnterpriseauthenController/updateEnterpriseAndCert">
                        <input name="id" value="{{map.Enterpriseauthen.id}}" type="hidden" id="EnterpriseauthenID"/>
                        <input name="version" value="{{map.Enterpriseauthen.version}}" type="hidden" id="EnterpriseauthenVersion"/>
                        <div class="firmInfo">
                            <h2>企业信息</h2>
                            <label for="" class="firmName"><input type="text" placeholder="请输入公司名称" maxlength="20" id="enterpriseName" name="enterpriseName" value="{{map.Enterpriseauthen.enterpriseName}}"></label>
                            <%--<label for="" class="creditNub"><input type="text" placeholder="请输入社会信用代码" maxlength="20" id="creditCode"   name="creditCode"  value="{{map.Enterpriseauthen.creditCode}}"></label>--%>
                            <div class="sub">
                                <%--<p class="sub_text">上传营业执照</p>
                                <input type="hidden"  id="licenseOriginal" name="licenseOriginal" value="">--%>
                                    <div class="info">上传营业执照</div>
                                    <img  class="attachment" data-name="yyAttachment" style="width: 9rem;height: 5.5rem;overflow: hidden;" data-type="Certificate"
                                          id="licenseOriginal"
                                          src="/ijob/upload/{{map.Enterpriseauthen.yyAttachment | absolutelyPath }}"
                                          data-id="{{map.Enterpriseauthen.licenseOriginal}}"
                                          onerror="this.src='/ijob/static/images/sfz.png';this.onerror=null">
                            </div>
                        </div>
                        <%--<div class="frInfo">
                            <h2>法人信息</h2>
                            <label for="" class="frName"><input type="text" placeholder="请输入法人姓名" maxlength="10" id="legalName"  name="legalName"  value="{{map.Enterpriseauthen.legalName}}"></label>
                            <label for="" class="idNub"><input type="text" placeholder="请输入身份证号" maxlength="20"  id="legalIDCard" name="legalIDCard"  value="{{map.Enterpriseauthen.legalIDCard}}"></label>
                            <div class="fileBox">
                                        <div class="up_zm">
                                            <div class="info">拍摄身份证正面照</div>
                                            <img  class="attachment" data-name="fzAttachment"  data-type="Certificate"
                                              id="legalIDCardJustOriginal" style="width:150px;height: 100px"
                                               src="/ijob/upload/{{map.Enterpriseauthen.fzAttachment | absolutelyPath }}"
                                               data-id="{{map.Enterpriseauthen.legalIDCardJustOriginal}}"
                                               onerror="this.src='/ijob/static/images/sfz.png';this.onerror=null">


                                        </div>

                                        <div class="up_fm">
                                        <div class="info">拍摄身份证反面照</div>
                                        <img  class="attachment" data-name="ffAttachment" data-type="Certificate"
                                              id="legalIDCardBackOriginal" style="width:150px;height: 100px"
                                              src="/ijob/upload/{{map.Enterpriseauthen.ffAttachment | absolutelyPath }}"
                                              data-id="{{map.Personalauthen.legalIDCardBackOriginal}}"
                                              onerror="this.src='/ijob/static/images/sfz.png';this.onerror=null">
                                        </div>

                            </div>
                        </div>--%>
                        <div class="runInfo">
                            <%--<h2>管理者信息</h2>--%>
                            <label for="" class="runName"><input type="text" placeholder="请输入姓名"  id="adminName" name="adminName"  value="{{map.Enterpriseauthen.adminName}}"  maxlength="5"></label>
                            <label for="" class="IdNub"><input type="text" placeholder="请输入身份证号" id="adminIDCard"   name="adminIDCard" value="{{map.Enterpriseauthen.adminIDCard}}"  maxlength="20"></label>
                            <label for="" class="run_phone"><input type="text" placeholder="请输入手机号"  id="adminPhoneNumber"  name="adminPhoneNumber" value="{{map.Enterpriseauthen.adminPhoneNumber}}"  maxlength="20"></label>
                            <label for="" class="run_code">
                                <input type="text" id="enterCode" name="code" placeholder="请输入验证码" maxlength="16">
                                <input type="button" id="enterCodeBtn" onclick="getEnterCodeBtn()" value="获取验证码">
                            </label>
                            <div class="fileBox">
                                    <div class="up_zm">
                                        <div class="info">拍摄身份证正面照</div>
                                    <img  class="attachment" data-name="azAttachment" data-type="Certificate"
                                          id="adminIDCardJustOriginal" style="width:150px;height: 100px"
                                          src="/ijob/upload/{{map.Enterpriseauthen.azAttachment | absolutelyPath }}"
                                          data-id="{{map.Enterpriseauthen.adminIDCardJustOriginal}}"
                                          onerror="this.src='/ijob/static/images/sfz.png';this.onerror=null">
                                    </div>



                                    <div class="up_fm">
                                    <div class="info">拍摄身份证反面照</div>
                                    <img  class="attachment" data-name="afAttachment" data-type="Certificate"
                                          id="adminIDCardBackOriginal" style="width:150px;height: 100px"
                                          src="/ijob/upload/{{map.Enterpriseauthen.afAttachment | absolutelyPath }}"
                                          data-id="{{map.Enterpriseauthen.adminIDCardBackOriginal}}"
                                          onerror="this.src='/ijob/static/images/sfz.png';this.onerror=null">
                                    </div>

                            </div>
                        </div>
                    </form>
                    <div class="btnBox">
                        <input type="button" class="btn" id="submit_enter" class="active" value="提交">
                    </div>
                </div>
                <div class="realFirm">
                    <div class="info1">
                        <h2>企业信息</h2>
                        <p>公司名称：{{map.Enterpriseauthen.enterpriseName}}</p>
                        <%--<p>社会信用代码：{{map.Enterpriseauthen.creditCode}}</p>--%>
                        <img  src="/ijob/upload/{{map.Enterpriseauthen.yyAttachment | absolutelyPath }}"
                              onerror="this.src='/ijob/static/images/sfz.png';this.onerror=null">
                    </div>
                    <%--<div class="info2">
                        <h2>法人信息</h2>
                        <p>法人姓名：{{map.Enterpriseauthen.legalName}}</p>
                        <p>身份证号：{{map.Enterpriseauthen.legalIDCard}}</p>
                        <img src="/ijob/upload/{{map.Enterpriseauthen.fzAttachment | absolutelyPath }}"
                              onerror="this.src='/ijob/static/images/sfz.png';this.onerror=null">
                        <img src="/ijob/upload/{{map.Enterpriseauthen.ffAttachment | absolutelyPath }}"
                              onerror="this.src='/ijob/static/images/sfz.png';this.onerror=null">
                    </div>--%>
                    <div class="info3">
                        <h2>管理员信息</h2>
                        <p>姓名：{{map.Enterpriseauthen.adminName}}</p>
                        <p>身份证号码：{{map.Enterpriseauthen.adminIDCard}}</p>
                        <p>手机号：{{map.Enterpriseauthen.adminPhoneNumber}}</p>
                        <img  src="/ijob/upload/{{map.Enterpriseauthen.azAttachment | absolutelyPath }}"
                              onerror="this.src='/ijob/static/images/sfz.png';this.onerror=null">
                        <img src="/ijob/upload/{{map.Enterpriseauthen.afAttachment | absolutelyPath }}"
                              onerror="this.src='/ijob/static/images/sfz.png';this.onerror=null">
                    </div>
                    <div class="btnBox">
                        <input type="button" class="btn_back" onclick="ijob.back();" value="返回">
                    </div>
                </div>
                </div>
            {{/each}}
        </script>
    </div>
</div>
</body>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>


    $(".tabList>li").on("click", function () {
        var index = $(this).index();
        $(this).addClass("active").siblings().removeClass("active");
        $(".main>div").eq(index).show().siblings().hide();
    })

    var isIDCard1=/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;
    var isIDCard2=/^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X|x)$/;
    var myreg=/^[1][3,4,5,6,7,8,9][0-9]{9}$/;
    var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
    //判断是否为空字符
    var regular = /\s+/g;
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



    /**
     * 验证身份证号码是否正确
     * @returns {boolean}
     */
    function identity(arg){
        if(arg==1){
            if(($("#personIDCard").val().trim()).length==18){
                if (!isIDCard2.test($("#personIDCard").val())) {

                    return false;
                } else {
                    return true;
                }
            }else if(($("#personIDCard").val().trim()).length==15){
                if (!isIDCard1.test($("#personIDCard").val())) {
                    return false;
                } else {
                    return true;
                }
            }
        }else{
             if(($("#adminIDCard").val().trim()).length==18){
                if (!isIDCard2.test($("#adminIDCard").val())) {
                    return false;
                } else {
                    return true;
                }
            }else if(($("#adminIDCard").val().trim()).length==15){
                if (!isIDCard1.test($("#adminIDCard").val())) {
                    return false;
                } else {
                    return true;
                }
            }
        }

    }

    var myPersonCode = "";
    var myTime = 60;
    var personIntervalID = 0;
    var isPersonClick = true;
    var enterCode = "";
    var enterTime = 60;
    var enterItervalID = 0;
    var isEnterClick = true;

    /**
     * 获得企业手机验证码
     * */
    function getEnterCodeBtn() {


        if($("#adminPhoneNumber").val() == null || $("#adminPhoneNumber").val().trim() == "" ){
            mui.toast("请输入手机号码!");
        }else if(!isEnterClick){
            mui.toast("请等下再获取！！");
        }else if(!verifi(2)){
            mui.toast("手机号码不正确哦！");
        }else  {
            isEnterClick = false;
            enterItervalID = setInterval("setValueOfEnterCodeBtn()", 1000);
            $.post("/ijob/api/ContentsendrecordController/sendSMSCode",
                {"phoneNumber": $("#adminPhoneNumber").val(), "businessType": 1},
                function (data) {
                    if (data.code == "200") {
                        enterCode = data.data.msgContent;
                        $("#enterCodeBtn").unbind("click",getEnterCodeBtn);
                    } else if (parseInt(data.code) == 500) {
                        mui,toast("参数异常！");
                    } else if (parseInt(data.code) == 510) {
                        mui.toast("对不起，你的可接收短信已到达上限，请明天再来。");
                    }else if (parseInt(data.code) == 511) {
                        mui.toast("该手机号码已经存在");
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
            isEnterClick = true;
            $("#enterCodeBtn").bind("click",getEnterCodeBtn);
            clearInterval(enterItervalID);
        }
    }

    /**
     *  获得个人认证验证码
     * */
    function getPersonCodeBtn() {
        if($("#personPhoneNumber").val() == null || $("#personPhoneNumber").val() == "" ){
            mui.toast("请输入手机号码!");
        }else if(!isPersonClick){
            mui.toast("请等下再获取！！");
        }else if(!verifi(1)){
            mui.toast("手机号码不正确哦！");
        }else{
            isPersonClick = false;
            personIntervalID = setInterval("setValueOfCodeBtn()", 1000);
            $.post("/ijob/api/ContentsendrecordController/sendSMSCode",
                {"phoneNumber": $("#personPhoneNumber").val(), "businessType": 1},
                function (data) {
                    if (data.code == "200") {
                        myPersonCode = data.data.msgContent;
                    } else if (data.code == "500") {
                        mui.toast("参数异常！");
                    } else if (data.code == "510") {
                        mui.toast("对不起，你的可接收短信已到达上限，请明天再来。");
                    }else if(data.code == "408"){
                        mui.toast(data.msg);
                    } else if (data.code == "511") {
                        mui.toast("该手机号码已经存在");
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
            isPersonClick = true;
            clearInterval(personIntervalID);
        }
    }




    $("#jobtemplate").loadData().then(
        function(result){
            if ($("#identityType").val()==1){
                $(".tabList").hide();
                $(".wrap .main .main1").css("margin-top","0")
            }
            /*if($("#versionblockID").val() != 0 ){
                $(".realName").show().siblings().hide();
            }else {
                $(".formName").show().siblings().hide();
            }*/

            /*if($("#personIDCardFlag").val() || result.Personalauthen.status==2){
                $(".realName").show().siblings().hide();
            }else {
                $(".formName").show().siblings().hide();
            }
            if($("#EnterpriseauthenVersion").val() != 0 || result.Enterpriseauthen.status==2){
                $(".realFirm").show().siblings().hide();
            }else{
                $(".formFirm").show().siblings().hide();
            }*/
            if(1>=result.data.list[0].Personalauthen.status){
                $(".realName").show().siblings().hide();
                $("img").addClass("blur");
            }else{
                $(".formName").show().siblings().hide();
            }
            if(1==result.data.list[0].Personalauthen.status){
                $(".realName").find("img").eq(1).after("<img src='/ijob/static/images/shtg.png' style='position: absolute;\n" +
                    "    width: 200;\n" +
                    "    height: 100;\n" +
                    "    left: 20%;\n" +
                    "    top: 45%;'>")
            }

            if(1>=result.data.list[0].Enterpriseauthen.status){
                $(".realFirm").show().siblings().hide();
                //$("img").addClass("blur");
            }else{
                $(".formFirm").show().siblings().hide();
            }


            $(".main1").attachment();
            $(".main2").attachment();
            $("#submit_person").click(function(){
          /*      if($("#schoolName").val() == null || $("#schoolName").val() == "" || regular.test($("#schoolName").val())){
                    mui.toast("请填写学校名称！");
                }else */
                if($("#realName").val() == null || $("#realName").val().trim() == "" || regular.test($("#realName").val().trim())){
                    mui.toast("请填写真实姓名！");
                }else if($("#personIDCard").val() == null || $("#personIDCard").val() == "" ){
                    mui.toast("请填写身份证号码！");
                }else if($("#personPhoneNumber").val() == null || $("#personPhoneNumber").val() == "" ){
                    mui.toast("请填写手机号！");
                }else if(!identity(1)){
                    mui.toast("身份证格式错误");
                }else if(!verifi(1)){
                    mui.toast("手机号码格式错误");
                }else if($("#personCode").val().trim() == "" || $("#personCode").val().trim() == null){
                    mui.toast("请输入验证码！");
                }else if($("#personIDCardJustOriginal").attr("src") == '/ijob/static/images/sfz.png'){
                    mui.toast("请上传身份证正面照！");
                }else if($("#personIDCardBackOriginal").attr("src") == '/ijob/static/images/sfz.png'){
                    mui.toast("请上传身份证反面照！");
                }else{
                    var obj = $("#personForm").serializeObjectJson();
                    if(!obj.gzAttachment  && !$("#personIDCardJustOriginal").data("id")){
                        mui.toast("请重新上传身份证正面照！");
                    }else if(!obj.gfAttachment  && !$("#personIDCardBackOriginal").data("id")){
                        mui.toast("请重新上传身份证反面照！");
                    }else{
                        if(ijob.storage.get("data.becomeBroker")){
                            obj.sendBrokerInfo = 1;
                        }
                        $("#personForm").btPost(JSON.stringify(obj),function(data){
                            if(data.code==200){
                                window.history.go(-1);
                                mui.toast("认证成功");
                            }else if(data.code == "408"){
                                mui.toast(data.msg);
                            }
                        });
                    }
                }
            });

            $("#submit_enter").click(function(){
                if($("#enterpriseName").val().trim() == "" || $("#enterpriseName").val().trim() == null) {
                    mui.toast("请输入公司名称!");
                }/*else if($("#creditCode").val() == null || $("#creditCode").val().trim() == "" || regular.test($("#creditCode").val().trim())){
                    mui.toast("请输入企业社会信用代码!");
                }else if($("#legalName").val() == null || $("#legalName").val().trim() == "" || regular.test($("#legalName").val().trim())){
                    mui.toast("请输入法人姓名!");
                }else if($("#legalIDCard").val() == null || $("#legalIDCard").val().trim() == "" ){
                    mui.toast("请输入法人身份证号码!");
                }*/else if($("#adminName").val() == null || $("#adminName").val().trim() == "" || regular.test($("#adminName").val().trim())){
                    mui.toast("请输入管理员姓名!");
                }else if($("#adminIDCard").val() == null || $("#adminIDCard").val().trim() == "" ){
                    mui.toast("请输入管理员身份证号码!");
                }else if($("#adminPhoneNumber").val().trim() == null || $("#adminPhoneNumber").val().trim() == "" ){
                    mui.toast("请输入管理员手机号码!");
                }else  if(!identity(2)){
                    mui.toast("身份证格式错误");
                }else if(!verifi(2)){
                    mui.toast("手机号码格式错误");
                }else if($("#enterCode").val().trim() == "" || $("#enterCode").val().trim() == null){
                    mui.toast("验证码填写错误");
                }else if($("#licenseOriginal").attr('src') =='/ijob/static/images/sfz.png'){
                    mui.toast("请上传营业执照!");
                }/*else if($("#legalIDCardJustOriginal").attr('src') == '/ijob/static/images/sfz.png'){
                    mui.toast("请上传法人身份证正面照!");
                }else if($("#legalIDCardBackOriginal").attr('src') == '/ijob/static/images/sfz.png'){
                    mui.toast("请上传法人身份证反面照!");
                }*/else if($("#adminIDCardJustOriginal").attr('src') == '/ijob/static/images/sfz.png'){
                    mui.toast("请上传身份证正面照");
                }else if($("#adminIDCardBackOriginal").attr('src') == '/ijob/static/images/sfz.png'){
                    mui.toast("请上传身份证反面照");
                }else{
                    $("#enterForm").btPost(JSON.stringify($("#enterForm").serializeObjectJson()),function(data){
                        if(data.code==200){
                            window.history.go(-1);
                            mui.toast("认证成功");
                        }else if(data.code == "408"){
                            mui.toast(data.msg);
                        }
                    });
                }
            });
            $("#legalName,#adminName").keyup(function () {
                var len = $(this).val().length;
                if(len > 5){
                    mui.toast("不能超过5字符!");
                }
            })
        });

</script>
</html>
