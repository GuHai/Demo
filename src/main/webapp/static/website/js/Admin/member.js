/*会员中心*/
$(function () {

    /*导入表格*/
    $(".Import").click(function () {
        $(".popup-backdrop").show();
    })
    $(".dialog-close,.closebtns").click(function () {
        $(".popup-backdrop").hide();
    })
    
    $(".confirmbtns").click(function () {
        if ($("input[name='textfield']").val() == '' || $("input[name='textfield']").val() == null || $("input[name='textfield']").val() == undefined) {
            $("#errmsg").text("请上传excel表格");
        }else if ($("input[name='Number']").val() == '' || $("input[name='Number']").val() == null || $("input[name='Number']").val() == undefined) {
            $("#errmsg").text("请输入总人数");
        }else if ($("input[name='Total']").val() == '' || $("input[name='Total']").val() == null || $("input[name='Total']").val() == undefined) {
            $("#errmsg").text("请输入总金额");
        }
    })

    /*导出表格*/
    $(".export").click(function(){
        window.open("/api/ApplySettlementController/importPayInfo/"+$(this).data("id")+"/"+$(this).data("name"));
    });

    $("#submitBtn").click(function () {
        $("#isEditVal").val($("#isEdit").prop("checked"));
        if(!$("#Number").val()){
            $("#errmsg").text("人数不能为空");
            return;
        }
        if(!$("#Total").val()){
            $("#errmsg").text("总额不能为空");
            return;
        }
        if(!$("#PositionName").val()){
            $("#errmsg").text("订单名称不能为空");
            return;
        }
        if(!$("#textfield").val()){
            $("#errmsg").text("文件内容不能为空");
            return;
        }
        $("#submitBtn").attr("disabled","disabled");
        $("#submitBtn").text("模板上传中，请等待");
        $(".myFrom").ajaxSubmit(function (result) {
            if(result.code==200){
                $("#errmsg").text("");
                loadPageByUrl('guanwang/salary?data.againID=all');
            }else{
                $("#errmsg").text(result.msg);
                $("#submitBtn").text("确认");
                $("#submitBtn").removeAttr("disabled");
            }

        });
    });
})
function isValidateFile(obj){

    var extend = obj.value.substring(obj.value.lastIndexOf(".")+1);
    if(!(extend=="xls"||extend=="xlsx")){
        $("#errmsg").text("请上传后缀名为xls或xlsx的文件!");
           var nf = obj.cloneNode(true);
                    nf.value='';
                    obj.parentNode.replaceChild(nf, obj);
           return false;
    }
    $("#textfield").val(obj.value);
    return true;
}
