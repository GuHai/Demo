$(function () {

    var hasSxf = false;




    //若取消一个，则全部选项取消
    $(".table-list").on('click',"input[name='checkbox1']",function() {
        var leng1 = $("input[name='checkbox1']:checked");
        var leng2 = $("input[name='checkbox1']");
        if (leng1.length == leng2.length) {
            $("#AllCheck").prop('checked', true);
            TotalPrice();
        } else {
            $("#AllCheck").prop('checked', false);
            TotalPrice();
        }
        count();
    });

    // 全选所有
    $("#AllCheck").on("change", function () {
        if ($(this).prop('checked') == true){
            $("input[name='checkbox1']").prop('checked',true);
            TotalPrice();
        }else {
            $("input[name='checkbox1']").prop('checked',false);
            TotalPrice();
        }
        count();
    });
    
    $("#sxfbtn").on("click",function () {
        if ($("#sxfbtn").prop("checked")) {
            hasSxf = true;
        }else{
            hasSxf = false;
        }
        TotalPrice();
    });

    // 全选本页
    $("#pageCheck").on("change", function () {
        if ($(this).prop('checked') == true){
            $("input[name='checkbox1']").prop('checked',true);
            TotalPrice();
        }else {
            $("input[name='checkbox1']").prop('checked',false);
            TotalPrice();
        }
        count();
    });

    $("#sxfbtn").on('click',function(){
        TotalPrice();
    });

    function TotalPrice() {
        var totalsxf = 0;
        var allprice = 0;
        $(".Check:checked").each(function() {
            var oneprice = parseFloat($(this).parents(".trbox").find(".price").data("salary"));
            allprice += oneprice;
            totalsxf += (Math.ceil(100*oneprice*0.006)/100)||0;
        });
        $("#AllTotal").text(template.money(allprice+(hasSxf==true?totalsxf:0)));
        $("#sxfmsg").text(template.money(totalsxf));
    }
    function count() {
        var leng1 = $("input[name='checkbox1']").length;
        var leng2 = $("input[name='checkbox1']:checked").length;
        $("#num").html(leng2+"/"+dict.SalaryExcel.Gong+leng1+dict.SalaryExcel.Bi);
    }

})
