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
                positionObj.sexRequirements = 2;
                removeTag(tag);
            }
        }
        if(!$(this).hasClass("active")){
            $(this).addClass("active");
            var tag = {
                type:false,
                name:$(this).text()
            }
            tagList.push(tag);
            positionObj.sexRequirements = $(this).data("value");
        }else{
            var tag = {
                type:false,
                name:$(this).text()
            }
            removeTag(tag);
            positionObj.sexRequirements = 2;
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
                positionObj.settlement = null;
                removeTag(tag);
            }
        }
        if(!$(this).hasClass("active")){
            $(this).addClass("active");
            var tag = {
                type:false,
                name:$(this).text()
            }
            positionObj.settlement = $(this).data("value");
            tagList.push(tag);
        }else{
            var tag = {
                type:false,
                name:$(this).text()
            }
            removeTag(tag);
            positionObj.settlement = null;
            $(this).removeClass("active");
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
            removeTag(tag);
        } else {
            otherLi.addClass("active");
            var tag = {
                type:false,
                name:$(this).text()
            }
            tagList.push(tag);
        }
    });
    // 重置
    $(".nav_footer .resetting").click(function () {
        // 性别
        $(".post-sort .genderlist li").removeClass("active");
        // 结算
        $(".post-sort .accounts li").removeClass("active");
        // 其他标签
        $(".post-sort .otherlist li").removeClass("active");
    })
});
function removeTag(tag){
    var count = -1;
    for (var i = 0 ;i < tagList.length ;i++){
        if(tagList[i].name == tag.name && tagList[i].type == tag.type){
            count = i;
        }
    }
    if(count >= 0){
        tagList.splice(count,1);
    }
}