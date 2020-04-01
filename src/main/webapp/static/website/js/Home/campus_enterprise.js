$(document).ready(function() {

    /*会员登录*/
    $("#login").click(function () {
        $(".dialog-mask").show();
    });
    // 关闭
    $(".dialog-close").click(function () {
        $(".dialog-mask").hide();
    });

    // 头部导航切换
    $(".list li").on("click", function() {
        $(this).addClass("active").siblings().removeClass("active")
    })

    // 遮罩层弹出
    $(".banner .apply-link").on("click", function() {
        $(".mask").show();
        $("body").css("overflow", "hidden")
    })
    $(".mask").on("click", function() {
        $(this).hide();
        $("body").css("overflow", "auto");
    })


    // 头部导航跟随
    $(window).scroll(function() {
            if ($(this).scrollTop() >= $(".banner").height()) {
                $(".nav").css("backgroundColor", "rgba(0, 0, 0, 0.8)");
                $(".fixe_codeBox").css("opacity", 1)
            } else if ($(this).scrollTop() < $(".banner").height()) {
                $(".nav").css("backgroundColor", "rgba(0, 0, 0, 0.5)");
                $(".fixe_codeBox").css("opacity", 0)

            }

        })
        //删除滑动公众号
    $(".fixe_codeBox .remove").click(function() {
        $(".fixe_codeBox").remove();
    });

})