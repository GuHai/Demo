$(function () {
        // 选择其中一个
        $('.mui-checkbox').find('input[type=checkbox]').bind('click', function(){
            $('.mui-checkbox').find('input[type=checkbox]').not(this).attr("checked", false);
        });
        // 类型切换
        $("#select-com").click(function () {
            if($(this).prop("checked") == true){
                $(".personal_list").hide();
                $(".company_list").show();
            }
        })
        $("#select-per").click(function () {
            if($(this).prop("checked") == true){
                $(".personal_list").show();
                $(".company_list").hide();
            }
        })
        $(".company_list .success").click(function () {
            if ($("#c_money").val() == ''){
                mui.alert("请填写金额");
            }else if ($("#companyName").val() == ''){
                mui.alert("请填写公司名称");
            } else{
                ijob.gotoPage({path:'/h5/qz/myjob/recharge_result'});
            }
        })
        $(".personal_list .success").click(function () {
            if ($("#p_money").val() == ''){
                mui.alert("请填写金额");
            }else if ($("#companyName").val() == ''){
                mui.alert("请填写汇款人姓名");
            }else if ($("#remittanceBankCard").val() == ''){
                mui.alert("请填写汇款银行卡号");
            }else{
                ijob.gotoPage({path:'/h5/qz/myjob/recharge_result'});
            }
        })

    })