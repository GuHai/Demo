
var filterclicktypename ;
// 地点
$("#place").click(function (e) {
    filterclicktypename = "类别"
    $(this).parent().siblings().find(".nav-content").hide();
    $(".li_1>.nav-content").toggle();
    $("#place>a").toggleClass("active");
    $("#place>i").toggleClass("icon-arrow-down1");
    $("#place>i").toggleClass("icon-arrow-up");
    e.stopPropagation();
    releaseObj();
    filterObj();
    bottomPageRoll();
});
$(".li_1>.nav-content>.nav-selected>li").click(function (e) {
    var _this = $(this);
    $(".place").html(_this.attr('data-value'));
    _this.css("color", "#108ee9").siblings().css("color", "#666");
    $(".li_1>.nav-content").toggle();
    $("#place>a").toggleClass("active");
    $("#place>i").toggleClass("icon-arrow-down1");
    $("#place>i").toggleClass("icon-arrow-up");
    e.stopPropagation();
    bottomPageRoll();
});

// 类型
$("#release").click(function (e) {

    filterclicktypename = "地区"
    $(this).parent().siblings().find(".nav-content").hide();
    $(".li_2>.nav-content").toggle();
    $("#release>a").toggleClass("active");
    $("#release>i").toggleClass("icon-arrow-down1");
    $("#release>i").toggleClass("icon-arrow-up");
    e.stopPropagation();
    // 筛选判断
    filterObj();
    // 地点判断
    place();
    bottomPageRoll();
});
// 筛选
$("#filter").click(function (e) {
    filterclicktypename = "";
    $(this).parent().siblings().find(".nav-content").hide();
    $(".li_3>.nav-content").toggle();
    $("#filter>a").toggleClass("active");
    $("#filter>i").toggleClass("active1");
    e.stopPropagation();
    // 类型判断
    releaseObj();
    // 地点判断
    place();
    bottomPageRoll();
});

// 点击空白处隐藏选项
$("body>*").on('click', function (e) {
    if (e.target !== $(".nav-selected,.region,.nav_row")) {
        $(".nav-content").hide();
        // 类型判断
        releaseObj();
        // 筛选判断
        filterObj();
        // 地点判断
        place();
        bottomPageRoll();
    }
});
// 阻止事件冒泡
$('.nav-selected,.region,.nav_row').on('click', function (e) {
    e.stopPropagation();
});
//点击取消、确认
$(".close,.affirm").click(function(){
    $(".nav-content").hide();
    // 类型判断
    releaseObj();
    // 筛选判断
    filterObj();
    // 地点判断
    place();
    bottomPageRoll();
})
// 类型
function place() {
    if ($("#place>i").hasClass("icon-arrow-down1")) {

    } else {
        $("#place>i").addClass("icon-arrow-down1").removeClass("icon-arrow-up");
        $("#place>a").removeClass("active");
    }
}
// 类型
function releaseObj() {
    if ($("#release>i").hasClass("icon-arrow-down1")) {

    } else {
        $("#release>i").addClass("icon-arrow-down1").removeClass("icon-arrow-up");
        $("#release>a").removeClass("active");
    }
}
// 筛选
function filterObj() {
    if ($("#filter>i").hasClass("active1")) {
        $("#filter>i").removeClass("active1");
        $("#filter>a").removeClass("active");
    } else {

    }
}
/**
 * 全选事件
 * @param arg Dom节点对象
 */
function allChecked(arg){
    if (!$(arg).hasClass("hulhue"))
        $(".son").addClass("hulhue");
    else
        $(".son").removeClass("hulhue");
}

/**
 * 取消全选事件
 * @param arg Dom 节点对象
 */
function disAllChecked(arg){
    var allCheck = 0;
    for (var i = 0 ;i< all.length; i++){
        if ($(all[i]).hasClass("hulhue")&&$(all[i]).attr("value") != $(arg).attr("value"))
            allCheck++;
    }
    if (allCheck == 8)
        $("#all").addClass("hulhue");
    if ($(arg).hasClass("hulhue") || allCheck == 9)
        $("#all").removeClass("hulhue");
}
//地址集合
var addrList = new Array();

//地区多选
$(".hulbox li").click( function () {
    if ($(this).is('.hulhue')){
        $(this).removeClass("hulhue");
    }else{
        $(this).addClass("hulhue");
    }
});
function bottomPageRoll(){
// 禁止蒙层底部页面跟随滚动
//     alert($('body,html').css('position')=='fixed');
// 是否有显示遮罩层
    var flag = false;
    $('.nav-content').each(function(index,element){
        if($(element).css("display") != 'none'){
            filterclicktypename = $(this).prev().attr("id");
            flag = true;
            return;
        }
    });
    //flag ? $('body,html').css('overflow','hidden').css('height','100%') : $('body,html').css('overflow','').css('height','');
    if(flag)
        disTouch();
    else
        ableTouch();
}


var lastpotin ;
function disTouch(){
    $("html,body").on('touchmove',touchHandler);
    $('.wrap').on('touchend',endHandler);
}
function endHandler(event){
    lastpotin = undefined;
}
function touchHandler(event){
    event.preventDefault();
    // if(filterclicktypename=="地区" || filterclicktypename=="类别" ){

        var panel =  $(".filter_nav li a[class*='active']").parent().next().children("ul:first");

        // else
        //     panel  = $("#allplace");
        var _touch = event.originalEvent.targetTouches[0];
        var _y= _touch.pageY;
        if(lastpotin==undefined){
            lastpotin = _y;
        }
            panel.scrollTop(panel.scrollTop()+(lastpotin - _y));
        lastpotin  = _y;
    // }
    /*var _touch = event.originalEvent.targetTouches[0];
    var _y= _touch.pageY;
    document.title = _y;*/
}
function ableTouch(){
    $("html,body").off('touchmove',touchHandler);
    $('.wrap').off('touchend',endHandler);
}