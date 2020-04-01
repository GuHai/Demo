// 图片、视频
$(function () {
    // 隐藏、显示
    $(".video").click(function () {
        var msg = $("#message").val();
        if($(this).find("button").length>0&&msg.length>0){
            request({"type":"Text","context":msg,"groupID":groupID,"userID":userID});
            $("#message").val("");

        }else{
            $(".send-show").toggle();
            $(".expression-show").hide();
            if($(this).find("button").length>0){
                $("#message").keyup();
            }
        }
        showHeight2();
    });

    // 表情
    $(".expression").click(function () {
        $(".expression-show").toggle();
        $(".send-show").hide();
        showHeight1();
    });
    
    $("#message").keyup(function () {
        if($(this).val() != "" || $(this).val() == null){
            $(".video").html("<button class=\"sendbtn\" >"+dict.Photo.Send+"</button>");
            $(this).css("width","62%");
            $(this).siblings(".icon-select").css("width","30%")
            $(".expression-show").hide();
            $(".send-show").hide();
            $(".clearfix").remove();
        }else{
            $(".video").html('<i class="mui-icon mui-icon-plus"></i>');
        }
    })

    $("#mediaPanel").on('click','a',function () {
        var type = $(this).data("type");
        $("#imageHandler").data("type",type);
        if(type=="image"){
            $("#imageHandler").attr("accept","image/*");
            $("#imageHandler").click();
        }else if(type=="video"){
            $("#imageHandler").attr("accept","video/mp4,avi,dat,3gp,mov,rmvb");
            $("#imageHandler").click();
        }else if(type=="location"){
            $(document).trigger('LocationEvent');
        }
        $(".video").click();
    });

    function initEmoji(){
        for(var i=1;i<=14;i++){
            $(".expression-show .show-list ul").append("<li><img data-id='"+i+"' style='width: 30px;height: 30px;' src='/ijob/static/emoji/"+i+".png'></li>");
        }
    }
    initEmoji();
    // 展开表情或上传图片视频时，底部内容遮盖
    function showHeight1() {
        var node =$('.expression-show');
        if(!node.is(':hidden')){
            var he = $(".m-text").height();
            $("#showMsg").after("<div class='clearfix showHeight1' style='clear: both;content: '';'></div>");
            $(".showHeight1").height(he-30);
            $(".showHeight2").remove();
        }else {
            $(".showHeight1").remove();
        }
    }
    showHeight1();
    function showHeight2() {
        var node =$('.send-show');
        if(!node.is(':hidden')){
            var he = $(".m-text").height();
            $("#showMsg").after("<div class='clearfix showHeight2' style='clear: both;content: '';'></div>");
            $(".showHeight2").height(he-30);
            $(".showHeight1").remove();
        }else {
            $(".showHeight2").remove();
        }
    }
    showHeight2();
    $("#imageHandler").on('change',function(){
        chatImage.selectImg();
    });

    //选择表情
    $(".show-list").on('click','img',function(){
        $(".expression-show").toggle();
        request({"type":"Emoji","context":$(this).data("id"),"groupID":groupID,"userID":userID});
        showHeight2();
    });

    $(".show-list").on('click','li',function(){
        $(".clearfix").remove();
    });

    // 判断li长度，小于4时，去除下间距
    if ($(".send-show .show-list li").length <= 4){
        $(".send-show .show-list li").css("margin-bottom","0")
    }
    if ($(".expression-show .show-list li").length <= 7){
        $(".expression-show .show-list li").css("margin-bottom","0px");
    }else if ($(".expression-show .show-list li").length > 7){
        $(".expression-show .show-list li").filter(":lt(7)").show().end().filter(":gt(6)").css("margin-bottom","0");
    }

})