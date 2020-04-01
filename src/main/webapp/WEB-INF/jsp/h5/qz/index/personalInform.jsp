<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/19
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>完善个人信息</title>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/inform.css?version=4">
</head>
<body>
<div class="wrap">
    <div class="tips">为保证求职者的合法权益，请完善个人信息。</div>
    <script  type="text/html" id="jobtemplate"  data-url="/ijob/api/PersonalauthenController/qz/getPersonalauthen">
    {{each list as person}}
        <form class="myform" id="myform">
            <ul>
                <li>
                    <input type="text" class="name" id="realName" name="realName" placeholder="请输入姓名" value="{{person.realName}}" maxlength="5">
                </li>
                <li class="mobile" id="cardID">
                    <input type="text" class="phone" id="personIDCard" name="personIDCard" placeholder="请输入身份证号码" value="{{person.personIDCard}}">
                </li>
               <%-- <li>
                    <input type="number" class="age" id="birthday"  name="age"  onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"  placeholder="请输入年龄" value="{{person.birthday | dateFormat:'AA'}}" maxlength="2">
                </li>--%>
               <%-- <li class="gender">
                    <span class="tit">性别</span>
                    <span class="info_gender_radio">
                            <div class="radios mui-input-row mui-radio mui-left">
                                <input name="sex" id="man"  value="1" type="radio"><span>男</span>
                            </div>
                            <div class="radios mui-input-row mui-radio mui-left">
                                <input name="sex" id="woman"  value="2" type="radio"><span>女</span>
                            </div>
                        </span>
                </li>--%>
                <input id="birthday"  name="age" type="hidden" >
                <input id="gender"  name="sex" type="hidden">
                <li class="mobile">
                    <input type="number"  class="phone" id="personPhoneNumber" name="personPhoneNumber" placeholder="请输入手机号" value="{{person.personPhoneNumber}}">
                </li>
                <li class="code">
                    <input type="number" class="c_code_msg" name="code" placeholder="请输入验证码" maxlength="2">
                    <span class="msgs">获取验证码</span>
                </li>

            </ul>
            <div class="btnconfirm" data-url="/ijob/api/PersonalauthenController/qz/addPersonalauthen">确认</div>
        </form>
    {{/each}}
    </script>


</div>
</body>
<script>

    $(function () {
        var isPageHide = false;
        window.addEventListener('pageshow', function () {
            if (isPageHide) {
                window.location.reload();
            }
        });
        window.addEventListener('pagehide', function () {
            isPageHide = true;
        });
    });


     function IdentityCodeValid(code) {
         code = ( code||"").toUpperCase();
        var city={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外 "};
        var tip = "";
        var pass= true;
        if(!code || !/^\d{6}(18|19|20)?\d{2}(0[1-9]|1[012])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i.test(code)){
            tip = "身份证号格式错误";
            pass = false;
        }
        else if(!city[code.substr(0,2)]){
            tip = "地址编码错误";
            pass = false;
        }
        else{
            //18位身份证需要验证最后一位校验位
            if(code.length == 18){
                code = code.split('');
                //∑(ai×Wi)(mod 11)
                //加权因子
                var factor = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];
                //校验位
                var parity = [ 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 ];
                var sum = 0;
                var ai = 0;
                var wi = 0;
                for (var i = 0; i < 17; i++)
                {
                    ai = code[i];
                    wi = factor[i];
                    sum += ai * wi;
                }
                var last = parity[sum % 11];
                if(parity[sum % 11] != code[17]){
                    tip = "请填写正确的身份证号码！"; //校验位错误
                    pass =false;
                }
            }
        }
        if(!pass) mui.alert(tip);
        return pass;
    }

    var needCardID = ijob.storage.get("personal.needCardID")||false;
    var toreal = ijob.storage.get("personal.toreal")||false; //去实名认证
    var tomyjob = ijob.storage.get("personal.tomyjob")||"${tomyijob}"||false;
    $("#jobtemplate").loadData().then(function(result){
        /*if(result.data.list[0].sex==1){
            $("#man").prop('checked', true);
        }else if(result.data.list[0].sex==2){
            $("#woman").prop('checked', true);
        }
        if(needCardID==false){
            $("#cardID").remove();
        }else{
            if($("#personPhoneNumber").val()){
                $(".code").remove();
            }
            if(result.data.list[0].sex){
                $(".gender").remove();
            }
            $("#myform li:not('.gender')").each(function (i,item) {
                if($(this).find("input").val()){
                    $(this).remove();
                }
            });
        }*/
        if(result.code==500){
            ijob.rebackpage(result.msg,-1,2000);
        }else{
            $(".btnconfirm").on("click",function () {
                if ($("#realName").is(':visible') && $("#realName").val() == ''){
                    mui.alert("请输入姓名！"); return false;
                }
                /*else if ($("#birthday").is(':visible') && $("#birthday").val() == ''){
                    mui.alert("请输入年龄！"); return ;
                }else if ($(".gender").is(':visible') && ($('input:radio[name="sex"]:checked').val() == undefined || $('input:radio[name="sex"]:checked').val() == null)){
                    mui.alert("请选择性别！"); return ;
                }*/
                else if ($("#personPhoneNumber").is(':visible') &&$("#personPhoneNumber").val() == ''){
                    mui.alert("请输入手机号！"); return ;
                }else if ($(".c_code_msg").is(':visible') &&$(".c_code_msg").val() == ''){
                    mui.alert("请输入验证码！"); return ;
                }else if ($("#cardID").is(':visible') &&$("#personIDCard").val() == ''){
                    mui.alert("请输入身份证号码！"); return ;
                }
                /*else if ($("#cardID").is(':visible')  &&  /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/.test($("#personIDCard").val())== false ){
                    mui.alert("请输入有效的身份证号码！"); return ;

                }*/
                else if($("#cardID").is(':visible')  && (IdentityCodeValid($("#personIDCard").val())==false)){
                    return ;
                }else{

                    if(getJudge()){
                        $(this).btPost($("#myform").serializeObjectJson(),function(result2){
                            if(result2.code==500){
                                if(result2.msg.indexOf("未通过")>0){
                                    ijob.delayGotoPage({path:'/h5/qz/mine/realName'},result2.msg+"</br>跳转到实名认证页面",1);
                                }else{
                                    mui.alert(result2.msg);
                                }
                            }else if(result2.code==403){ //直接跳转到提现页面
                                if(toreal=="true"||toreal == true){ //如果是直接认证，那啥都不干，直接返回
                                    ijob.rebackpage("完善个人信息成功");
                                }else if(tomyjob=="true"||tomyjob==true){
                                    ijob.storage.set("personal.tomyjob",null);
                                    ijob.delayGotoPage({path:'/h5/qz/myjob/my_part_time_job'},"完善个人信息成功",1);
                                }else if(ijob.storage.get("posiid")!=null){
                                    var posiid = ijob.storage.get("posiid");
                                    ijob.storage.set("posiid",null);
                                    if(ijob.storage.get("homepageType")){
                                        ijob.gotoPage({url:"${site}/share/"+ijob.storage.get("jobtype")+"/" + posiid+"/money"});
                                    }else {
                                        ijob.gotoPage({url:"${site}/share/"+ijob.storage.get("jobtype")+"/" + posiid});
                                    }
                                }else if(ijob.storage.get("full.id")!=null){
                                    ijob.gotoPage({path:'/h5/qz/myjob/full_time_detail'});
                                }else{
                                    ijob.storage.set("personal.needCardID",null);
                                    ijob.gotoPage({path:'/h5/qz/mine/salaryCard_withdraw'});
                                }

                            }else{
                                if(ijob.storage.get("posiid")!=null){
                                    ijob.gotoPage({url:"${site}/share/"+ijob.storage.get("jobtype")+"/" + ijob.storage.get("posiid")});
                                }
                                ijob.storage.set("personal.needCardID",null);
                                ijob.rebackpage(result.msg,-2);
                            }
                        });
                    }

                }
            })
            //获取短信验证码
            var validCode = true;
            $(".msgs").click(function() {
                var time = 60;
                var code = $(this);
                if ($("#personPhoneNumber").val() && validCode) {
                    validCode = false;
                    var t = setInterval(function() {
                        time--;
                        code.html(time + "秒");
                        if (time == 0) {
                            clearInterval(t);
                            code.html("重新获取");
                            validCode = true;
                        }
                    }, 1000);

                    getPersonCodeBtn();
                }
            });


            /**
             *  获得个人认证验证码
             * */
            function getPersonCodeBtn() {
                if($("#personPhoneNumber").val() == null || $("#personPhoneNumber").val() == "" ){
                    mui.toast("请输入手机号码!");
                }else if(!/^[1][3,4,6,5,7,8,9][0-9]{9}$/.test($("#personPhoneNumber").val())){
                    mui.toast("手机号码不正确哦！");
                }else{
                    $.post("/ijob/api/ContentsendrecordController/sendSMSCode",
                        {"phoneNumber": $("#personPhoneNumber").val(), "businessType": 1},
                        function (data) {
                            if (data.code == "200") {
                                // validCodeNo = data.data.msgContent;
                            } else if (data.code == "500") {
                                mui.toast("参数异常！");
                            } else if (data.code == "510") {
                                mui.toast("对不起，你的可接收短信已到达上限，请明天再来。");
                            }else if(data.code == "408"){
                                mui.toast(data.msg);
                            }
                        });
                }
            }
            function getJudge() {
                // 判断
                var msg = "";

                var idCard = $("#personIDCard").val();
                var birthday = new Date(idCard.substring(6,10),idCard.substring(10,12),idCard.substring(12,14));
                var age  = Math.floor((new Date().getTime()-birthday.getTime())/(365*24*3600*1000));
                $("#birthday").val(age);
                $("#gender").val(idCard.substring(16,17)%2==1?1:2);
                if($("#birthday").val()){
                    var len = $("#birthday").val().length;
                    if(len!=2){
                        msg+="<p>年龄只能是2位数</p>";
                    }
                }

                if($(".c_code_msg").val()){
                    var len =  $(".c_code_msg").val().length;
                    if(len != 6){
                        msg+="<p>验证码必须是6位</p>";
                    }
                }

                if(msg){
                    mui.toast(msg);
                }
                return msg == "";
            }
        }
    });


</script>
</html>
