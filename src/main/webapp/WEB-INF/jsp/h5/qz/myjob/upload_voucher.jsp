<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>上传凭证</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/recharge.css?version=4">
</head>
<body>
<div class="wrap">
    <div class="page_upload_voucher">
        <div class="input-type-list">
            <div class="flex_input">
                <div class="title">充值账户类型</div>
                <div class="select-type">
                    <div class="company mui-input-row mui-radio mui-left">
                        <label><input type="radio" checked="checked" name="checkbox" id="select-com" />&nbsp;<span class="txt">企业充值</span></label>
                    </div>
                    <div class="personal mui-input-row mui-radio mui-left">
                        <label><input type="radio" id="select-per" name="checkbox" />&nbsp;<span class="txt">个人充值</span></label>
                    </div>
                </div>
            </div>
            <%--企业充值--%>
            <div class="type_main_list company_list">
                <form id="company">
                    <div class="mui-input-row">
                        <div class="title">已充值金额</div>
                        <div class="input">
                            <input type="number" placeholder="请填写金额" name="money" id="c_money" onblur="blurFnc(this)"/>
                        </div>
                        <div class="yuan">元</div>
                    </div>
                    <div class="mui-input-row com_name">
                        <div class="title">汇款公司名称</div>
                        <div class="input">
                            <input type="text" placeholder="请填写公司名称" name="remittanceName" id="companyName" maxlength="20"/>
                        </div>
                    </div>
                    <div class="per_list" style="display: none">
                        <div class="mui-input-row">
                            <div class="title">汇款人姓名</div>
                            <div class="input">
                                <input type="text" placeholder="请填写汇款人姓名" name="p_remittanceName" id="name"/>
                            </div>
                        </div>
                        <div class="mui-input-row">
                            <div class="title">汇款银行卡号</div>
                            <div class="input">
                                <input type="number" placeholder="请填写汇款银行卡号" name="remittanceBankCard" id="card" onkeyup='this.value=this.value.replace(/\D/gi,"")'/>
                            </div>
                        </div>
                    </div>
                    <div class="img-box">
                        <p class="tit">上传回执凭证</p>
                        <section class="img-section">
                            <div class="z_photo upimg-div clearfix" id="com_photes">
                                <section class="z_file fl">
                                    <img data-editable="true" class="attachment up-img" data-name="attachmentList0" class="attachmentList0"
                                         data-type="Photos"
                                         data-id="" style="height: 100%;width: 100%"
                                         src="#" alt=""
                                         onerror="this.src='/ijob/static/images/a9.png';this.onerror=null" />
                                </section>
                            </div>
                        </section>
                    </div>
                    <div class="btnbox">
                        <a href="javascript:void(0)" class="success" data-type="2" data-url="/ijob/api/RechargeController/addVoucher">完成</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <a data-url="/ijob/api/RechargeController/getHistoryVoucherInfo" id="get"></a>
</div>
</body>
</html>
<%--<script type="text/javascript" language="javascript"  src="/ijob/static/js/index/voucher.js" charset="UTF-8" ></script>--%>
<script>
    $("#get").btPost(null,function (result) {
        var person = {},enter ;
        if(result.data != null){
            for (var i = 0 ; i<result.data.list.length;i++){
                if(result.data.list[i].type == false){
                    person = result.data.list[i];
                }else{
                    enter = result.data.list[i]
                }
            }
            if(enter){
                $("#companyName").val(enter.remittanceName);
            }
            if(person!=null||person!=undefined||person!=""){
                $("#name").val(person.remittanceName);
                $("#card").val(person.remittanceBankCard);
            }
            if(ijob.storage.get("type")==0){
                // 类型切换
                $("#select-per").click(function () {
                    if ($(this).is(':checked')) {
                        $(".per_list").show();
                        $(".com_name").hide();
                        type = 0;
                        $("#companyName").val(null);
                        /*formReset()*/
                    }
                })
            }else {
                $("#select-com").click(function () {
                    if ($(this).is(':checked')) {
                        $(".per_list").hide();
                        $(".com_name").show();
                        type = 1;
                        $("#name").val(null);
                        $("#card").val(null);
                        /*formReset()*/
                    }
                })
            }
        }
    });

    // 上传图片
    var index = 0, type = 1,isSubmit = false;
    $("#com_photes").attachment();
    $("#com_photes").on("uploadCompletionEvent", function () {
        index++;
        if(index<9){
            $(this).prepend("<section  class=\"z_file fl\">\n" +
                "    <img   data-editable=\"true\" class=\"attachment up-img\" data-name=\"attachmentList" + index + "\" data-type=\"Photos\"\n" +
                "          data-id=\"\" style=\"height: 100%;width: 100%\"\n" +
                "          src=\"#\" alt=\"\"\n" +
                "          onerror=\"this.src='/ijob/static/images/a9.png';this.onerror=null\">\n" +
                "</section>");
            setTimeout(function () {
                $("#com_photes").find("section").eq(0).attachment();
            }, 100);
        }
    });

    // 选择其中一个
    $('.mui-checkbox').find('input[type=checkbox]').bind('click', function(){
        $('.mui-checkbox').find('input[type=checkbox]').not(this).attr("checked", false);
    });
    // 类型切换
    $("#select-per").click(function () {
        if ($(this).is(':checked')) {
            $(".per_list").show();
            $(".com_name").hide();
            type = 0;
            $("#companyName").val(null);
            /*formReset()*/
        }
    })
    $("#select-com").click(function () {
        if ($(this).is(':checked')) {
            $(".per_list").hide();
            $(".com_name").show();
            type = 1;
            $("#name").val(null);
            $("#card").val(null);
            /*formReset()*/
        }
    })
    function formReset() {
        $(':input', '#company')
            .not(':button, :submit, :reset, :hidden,:radio') // 去除不需要重置的input类型
            .val('')
            .removeAttr('checked')
            .removeAttr('selected');
    }

    $(".success").click(function () {
        blurFnc(document.getElementById("c_money"));
        var _this = $(this);
        var obj = $("#company").serializeObjectJson();
        obj.type = type;
        checkObj(obj);
        ijob.storage.set("type",type);
        if(isSubmit==true){
            if(type == 1){
                obj = ijob.parseFromFormObject(obj, ["attachmentList"]);
                if(obj.attachmentList!=null&&obj.attachmentList.length!=0){
                    $(_this).btPost(obj,function (result) {
                        formReset();
                        if(result.code == 200){
                            ijob.gotoPage({path:'/h5/qz/myjob/recharge_result?data.money='+obj.money});
                        }else {
                            obj = null ;
                            mui.alert("请检查您的数据是否填写正确！");
                        }
                    })
                }else{
                    mui.alert("请上传支付凭证！")
                }
            }else{
                $.post("/ijob/api/RechargeController/getCardDetail/"+obj.remittanceBankCard ,null,function (result) {
                    var msg = JSON.parse(result.data);
                    if(isSubmit == true&& msg.validated == true){
                        obj = ijob.parseFromFormObject(obj, ["attachmentList"]);
                        if(obj.attachmentList!=null&&obj.attachmentList.length!=0){
                            $(_this).btPost(obj,function (result) {
                                formReset();
                                if(result.code == 200){
                                    ijob.gotoPage({path:'/h5/qz/myjob/recharge_result?data.money='+obj.money});
                                }else {
                                    obj = null ;
                                    mui.alert("请检查您的数据是否填写正确！");
                                }
                            })
                        }else{
                            mui.alert("请上传支付凭证！")
                        }
                    }else {
                        mui.alert("银行卡卡号不正确!")
                    }
                })
            }
        }
    });


    function checkObj(obj){
        isSubmit = false ;
        if(obj.type == 0){
            if (obj.money < 1 || obj.money ==null || obj.money == undefined ){
                mui.alert("请填写金额,并且金额不能少于1元");
            }else if (obj.money.length >8){
                mui.alert("暂不支持巨额充值！");
            }else if (obj.p_remittanceName.trim() == ''){
                mui.alert("请填写汇款人姓名");
            }else if (obj.p_remittanceName.trim().length > 6){
                mui.alert("请输入正确的汇款人姓名");
            }else if (obj.remittanceBankCard.trim() == ''){
                mui.alert("请填写汇款银行卡号");
            }else if (obj.remittanceBankCard.trim().length < 9 ){
                mui.alert("请填写汇款银行卡号");
            }else{
                isSubmit = true ;
            }
            obj.remittanceName = obj.p_remittanceName;
        }else if(obj.type == 1){
            if (obj.money == '' || obj.money < 1 || obj.money ==null || obj.money == undefined){
                mui.alert("请填写金额");
            }else if (obj.money.length >8){
                mui.alert("暂不支持巨额充值！");
            }else if (obj.remittanceName.trim() == ''){
                mui.alert("请填写公司名称");
            }else if (obj.remittanceName.trim().length  > 24){
                mui.alert("请填写正确的公司名称");
            }else{
                isSubmit = true ;
            }
            obj.remittanceBankCard == null;
        }
        obj.p_remittanceName = null;
    }
    function blurFnc(arg){
        var tempVal = $(arg).val();
        var tempArg = tempVal.split(".");
        if (tempVal==null||tempVal==""||tempVal==undefined){
            $(arg).val("");
        }else if(tempVal.length > 11&&tempVal.indexOf(".")==-1){
            $(arg).val(parseInt(tempVal.substring(0,11)));
        }
        if(tempArg.length > 1){
            if(tempArg[0] == ''){
                $(arg).val(parseInt(tempArg[1]));
            }else if(tempArg[1] == ''){
                $(arg).val(parseInt(tempArg[0]));
            }else if(tempArg[1].length > 2){
                if(tempArg[0].length<10)
                    $(arg).val(tempArg[0] + "." +tempArg[1].substring(0,2));
                else
                    $(arg).val("");
            }
        }else {
            $(arg).val("");
            $(arg).val(tempArg[0]);
        }
    }

</script>
