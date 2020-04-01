$(function () {
    // var slide = null;

    /*// 立即上传
    $(".uploadbtns").click(function () {
        if($(".enterpriseName").val() == null || $(".enterpriseName").val() == "" ){
            mui.alert("请输入企业全称");
        }else if($("#money").text() == "请选择保额"){
            mui.alert("请选择保额");
        }else if($("#selectedSort").text() == "统一选择员工所属职业名称"){
            mui.alert("请选择员工所属职业名称");
        }else if($(".insured-box li").length == 0){
            mui.alert("至少要添加一个被保人");
            $(".insured-box").remove();
        }else {
            var insRecord = $("#form").serializeObjectJson();
            insRecord.status = 1;
            $("#saveRecord").btPost(insRecord,function(result){
                $("#version").val(result.data.version);
                if(result.code==200){
                    ijob.gotoPage({path:'/h5/zp/insurance/prompt'});
                }else{
                    mui.toast('上传失败...');
                }
            });
        }
    });*/

    /*// 保存
    $(".conserve").click(function () {
        if($("#selectedSort").text() == "统一选择员工所属职业名称"){
            mui.alert("请选择员工所属职业名称");
        }else if($(".insuredName").val() == null || $(".insuredName").val() == ""){
            mui.alert("请输入被保人姓名");
        }else if($('input:radio[name="sex"]:checked').val() == null){
            mui.alert("请选择性别");
        }else if($(".identity").val() == null || $(".identity").val() == ""){
            mui.alert("请输入身份证号码");
        }else {
            ijob.gotoPage({path:'/h5/zp/insurance/uploadList'})
        }
    })*/

    // 统一选择员工所属职业名称
    $(".occupationName").click(function () {

        if(arrangement!=""){
            $("#sort1 li")[2].click();
        }
        $(".popup-backdrop").show();
        slide = new Slide($(".upload-list"),$(".popup-backdrop"),".popup-inner");
        slide.disTouch();
        $(".screenlist").show();
        $(".search-list-box").hide();
        $("#searchInput").val("");
    })

   /* /!*选择一级目录*!/
    $("#sort1 li").each(function () {
        var _this = $(this);
        _this.click(function (e) {
            $("#sort2").show();
            _this.addClass("active").siblings("li").removeClass("active");
            _this.parents("#sort1").addClass("floating");
            _this.parents("#sort1").siblings("#sort2").addClass("drift");
            if ($(e.target) != _this.index()){
                _this.parents("#sort1").siblings("#sort2").children("li").removeClass("active");
            }

        })
    })*/

})

