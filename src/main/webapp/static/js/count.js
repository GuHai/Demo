//若取消一个，则全部选项取消
$(".page_invoiceIndex").on('click',"input[name='checkbox1']",function() {
    var leng1 = $("input[name='checkbox1']:checked");
    var leng2 = $("input[name='checkbox1']");
    if (leng1.length == leng2.length) {
        $("#AllCheck").prop('checked', true);
        TotalPrice();
    } else {
        $("#AllCheck").prop('checked', false);
        TotalPrice();
    }
});

// 全选
$("#AllCheck").on("change", function () {
    if ($(this).prop('checked') == true){
        $("input[name='checkbox1']").prop('checked',true);
        TotalPrice();
    }else {
        $("input[name='checkbox1']").prop('checked',false);
        TotalPrice();
    }
});
function TotalPrice() {
    var allprice = 0; //总价
    $(".Check:checked").each(function() {
        var oneprice = parseFloat($(this).parents(".input-row").find(".reg_num").text());
        allprice += oneprice;
    });
    $("#AllTotal").text(allprice.toFixed(2));
}

/*$(":checkbox").click(function(e){
    //停止事件冒泡,当点击的是checkbox时,就不执行父div的click
    TotalPrice();
    e.stopPropagation();
});*/
$(".input-row").click(function(){
    if($(this).find("input").attr("checked")==undefined || $(this).find("input").attr("checked")==false || $(this).find("input").attr("checked")!='' ){
        $(this).find("input").click();//如果没该行，存在点击第二轮，不起作用。
        $(this).find("input").attr("checked",true);
    }else{
        $(this).find("input").attr("checked",false);
    }
    TotalPrice();
});
