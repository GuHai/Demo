$(function () {
    // 性别要求
    $(".post-sort .genderlist li").click(function () {
        var arr = $(".post-sort .genderlist li");
        for (var i = 0 ; i < arr.length ; i++){
            if(arr[i] != this){
                $(arr[i]).removeClass("active");
                var tag = {
                    type:false,
                    name:$(arr[i]).text()
                }
            }
        }
        if(!$(this).hasClass("active")){
            $(this).addClass("active");
            var tag = {
                type:false,
                name:$(this).text()
            }
        }else{
            var tag = {
                type:false,
                name:$(this).text()
            }
            $(this).removeClass("active");
        }
    });
    // 结算方式
    $(".post-sort .accounts li").click(function () {
        var arr = $(".post-sort .accounts li");
        for (var i = 0 ; i < arr.length ; i++){
            if(arr[i] != this){
                $(arr[i]).removeClass("active");
                var tag = {
                    type:false,
                    name:$(arr[i]).text()
                }
            }
        }
        if(!$(this).hasClass("active")){
            $(this).addClass("active");
            var tag = {
                type:false,
                name:$(this).text()
            }
        }else{
            var tag = {
                type:false,
                name:$(this).text()
            }
            $(this).removeClass("active");
        }
    });
    /*工作要求*/
    $(".post-sort .requirelist li span").click(function() {
        var requireLi = $(this).parent("li");
        var conditionState = requireLi.hasClass("active");
        if (conditionState == true) {
            requireLi.removeClass("active");
            var tag = {
                type:false,
                name:$(this).text()
            }
        } else {
            requireLi.addClass("active");
            var tag = {
                type:false,
                name:$(this).text()
            }
        }
    });
    /*职位性质*/
    $(".post-sort .naturelist li span").click(function() {
        var natureLi = $(this).parent("li");
        var conditionState = natureLi.hasClass("active");
        if (conditionState == true) {
            natureLi.removeClass("active");
            var tag = {
                type:false,
                name:$(this).text()
            }
        } else {
            natureLi.addClass("active");
            var tag = {
                type:false,
                name:$(this).text()
            }
        }
    });
    /*福利待遇*/
    $(".post-sort .welfarelist li span").click(function() {
        var welfareLi = $(this).parent("li");
        var conditionState = welfareLi.hasClass("active");
        if (conditionState == true) {
            welfareLi.removeClass("active");
            var tag = {
                type:false,
                name:$(this).text()
            }
        } else {
            welfareLi.addClass("active");
            var tag = {
                type:false,
                name:$(this).text()
            }
        }
    });
    /*其他标签*/
    $(".post-sort .otherlist li span").click(function() {
        var otherLi = $(this).parent("li");
        var conditionState = otherLi.hasClass("active");
        if (conditionState == true) {
            otherLi.removeClass("active");
            var tag = {
                type:false,
                name:$(this).text()
            }
        } else {
            otherLi.addClass("active");
            var tag = {
                type:false,
                name:$(this).text()
            }
        }
    });
    // 重置
    $(".nav_footer .resetting").click(function () {
        // 性别
        $(".post-sort .genderlist li").removeClass("active");
        // 结算
        $(".post-sort .accounts li").removeClass("active");
        // 工作要求
        $(".post-sort .requirelist li").removeClass("active");
        // 职位性质
        $(".post-sort .naturelist li").removeClass("active");
        // 福利待遇
        $(".post-sort .welfarelist li").removeClass("active");
        // 其他标签
        $(".post-sort .otherlist li").removeClass("active");
    })
});

