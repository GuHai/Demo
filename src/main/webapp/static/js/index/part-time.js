// 地点
$("#place").click(function (e) {
    $(".select_nav ").addClass("sfixed");
    $(this).parent().siblings().find(".nav-content").hide();
    $(".li_1>.nav-content").toggle();
    $("#place>a").toggleClass("active");
    $("#place>i").toggleClass("icon-arrow-down1");
    $("#place>i").toggleClass("icon-arrow-up");
    e.stopPropagation();
    releaseObj();
    filterObj();
    allSort();
    bottomPageRoll();
});
$(".li_1>.nav-content>.nav-selected>li").click(function (e) {
    var _this = $(this);
    $(".place").html(_this.attr('data-value'));
    $(".select_nav ").removeClass("sfixed");
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
    $(".select_nav ").addClass("sfixed");
    $(this).parent().siblings().find(".nav-content").hide();
    $(".li_2>.nav-content").toggle();
    $("#release>a").toggleClass("active");
    $("#release>i").toggleClass("icon-arrow-down1");
    $("#release>i").toggleClass("icon-arrow-up");
    e.stopPropagation();
    allSort();
    // 筛选判断
    filterObj();
    // 地点判断
    place();
    //
    bottomPageRoll();
});
$(".li_2>.nav-content>.nav-selected >li").click(function (e) {
    var _this = $(this);
    $(".release").html(_this.attr('data-value'));
    $(".select_nav ").removeClass("sfixed");
    _this.css("color", "#108ee9").siblings().css("color", "#666");
    $(".li_2>.nav-content").toggle();
    $("#release>a").toggleClass("active");
    $("#release>i").toggleClass("icon-arrow-down1");
    $("#release>i").toggleClass("icon-arrow-up");
    e.stopPropagation();
    bottomPageRoll();
});

// 排序
$("#all-sort").click(function (e) {
    $(".select_nav ").addClass("sfixed");
    $(this).parent().siblings().find(".nav-content").hide();
    // $(this).parent().siblings().find(".nav-box>i").
    $(".li_3>.nav-content").toggle();
    $("#all-sort>a").toggleClass("active");
    $("#all-sort>i").toggleClass("icon-arrow-down1");
    $("#all-sort>i").toggleClass("icon-arrow-up");
    e.stopPropagation();
    releaseObj();
    filterObj();
    place();
    bottomPageRoll();
});
$(".li_3>.nav-content>.nav-selected>li").click(function (e) {
    var _this = $(this);
    $(".all-sort").html(_this.attr('data-value'));
    $(".select_nav ").removeClass("sfixed");
    _this.css("color", "#108ee9").siblings().css("color", "#666");
    $(".li_3>.nav-content").toggle();
    $("#all-sort>a").toggleClass("active");
    $("#all-sort>i").toggleClass("icon-arrow-down1");
    $("#all-sort>i").toggleClass("icon-arrow-up");
    e.stopPropagation();
    bottomPageRoll();
});

// 筛选
$("#filter").click(function (e) {
    $(".select_nav ").addClass("sfixed");
    $(this).parent().siblings().find(".nav-content").hide();
    $(".li_4>.nav-content").toggle();
    $("#filter>a").toggleClass("active");
    $("#filter>i").toggleClass("active1");
    e.stopPropagation();
    // 全部判断
    allSort();
    // 类型判断
    releaseObj();
    // 地点判断
    place();
    bottomPageRoll();
});

// 点击空白处隐藏选项
$("body>*").on('click', function (e) {
    if ($(e.target).hasClass('nav-content')) {
        $(".select_nav ").removeClass("sfixed");
        $(".nav-content").hide();
        // 类型判断
        releaseObj();
        // 筛选判断
        filterObj();
        // 全部判断
        allSort();
        // 地点判断
        place();
        //
        bottomPageRoll();
    }
});

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

// 排序
function allSort() {

    if ($("#all-sort>i").hasClass("icon-arrow-down1")) {

    } else {
        $("#all-sort>i").addClass("icon-arrow-down1").removeClass("icon-arrow-up");
        $("#all-sort>a").removeClass("active");
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

$(document).ready(function(){
    $(".grade-w>li").click(function(){
        $(".grade-t").css("left","33.33%")
    });
});

$(document).ready(function(){
    $(".grade-t>li").click(function(){
        $(".grade-s").css("left","66.96%")
    });
});

//js点击事件监听开始
function grade1(wbj){
    var arr = document.getElementById("gradew").getElementsByTagName("li");
    for (var i = 0; i < arr.length; i++){
        var a = arr[i];
        a.style.background = "";
        a.style.color = "";
    };
    wbj.style.background = "#f2f5f7";
    wbj.style.color = "#108ee9";
    wbj.style.width = "33.3%"
}

function gradet(tbj){
    var arr = document.getElementById("gradet").getElementsByTagName("li");
    for (var i = 0; i < arr.length; i++){
        var a = arr[i];
        a.style.background = "";
        a.style.color = "";
    };
    tbj.style.background = "#f2f5f7";
    tbj.style.color = "#108ee9";
    tbj.style.width = "33.3%"
}

function grades(sbj){
    var arr = document.getElementById("grades").getElementsByTagName("li");
    for (var i = 0; i < arr.length; i++){
        var a = arr[i];
        a.style.background = "";
        a.style.color = "";
    };
    sbj.style.background = "#f2f5f7";
    sbj.style.color = "#108ee9"
}


var filterclicktypename;
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
var panel;
function selectPanel(_panel){
    panel = _panel;
}
function disTouch(){
    if(filterclicktypename=="release" ){
        panel  = $("#publishType");
    }

    $(".wrap").on('touchmove',touchHandler);
    $('.all_content').on('touchend',endHandler);
}
function endHandler(event){
    lastpotin = undefined;
}
function touchHandler(event){
    event.preventDefault();
    if(filterclicktypename=="place" || filterclicktypename=="release" ){
        var _touch = event.originalEvent.targetTouches[0];
        var _y= _touch.pageY;
        if(lastpotin==undefined){
            lastpotin = _y;
        }
        panel.scrollTop(panel.scrollTop()+(lastpotin - _y));
        lastpotin  = _y;
    }
}
function ableTouch(){
    $(".wrap").off('touchmove',touchHandler);
    $('.all_content').off('touchend',endHandler);
}