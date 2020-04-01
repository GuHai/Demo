var filtertypename ;
var lastclickpotin ;
var panelclick;
var condition = ijob.persistence.get("fullCondition")||{};
$(".a_filter").click(function (e) {
    //首先关闭掉所有的东西
    var _this = $(this);
    filtertypename = _this.attr("id");

    var  state = !_this.find(".iconfont").hasClass("icon-arrow-up"); //true 为需要打开 false 为需要关闭
    closeOtherFilter(_this);
    if(state){
        disTouchslide();
        _this.next().css("display","block");
        _this.parents(".screen-box-list").addClass("sfixed");
        _this.find(".iconfont").addClass("icon-arrow-up").removeClass("icon-arrow-down1");
    }else{
        ableTouchslide();
        _this.next().css("display","none");
        _this.parents(".screen-box-list").removeClass("sfixed");
        _this.find(".iconfont").removeClass("icon-arrow-up").addClass("icon-arrow-down1");
    }
    e.stopPropagation();

});
function disTouchslide(){
    if(filtertypename=="quarters"){
        panelclick = $("#publishPostdiv");
    }
    $(".wrap").on('touchmove',touchHandlerslide);
    $('.screen-box-list').on('touchend',endHandlerslide);
}

function endHandlerslide(event){
    lastclickpotin = undefined;
}
function touchHandlerslide(event){
    event.preventDefault();
    if(filtertypename=="quarters" ){
        var _touch = event.originalEvent.targetTouches[0];
        var _y= _touch.pageY;
        if(lastclickpotin==undefined){
            lastclickpotin = _y;
        }
        panelclick.scrollTop(panelclick.scrollTop()+(lastclickpotin - _y));
        lastclickpotin  = _y;
    }
}
function ableTouchslide(){
    $(".wrap").off('touchmove',touchHandlerslide);
    $('.screen-box-list').off('touchend',endHandlerslide);
}

function closeOtherFilter(_that){
    $(".a_filter").each(function(){
        var _this = $(this);
        _this.find("a").removeClass("active");
        _this.find(".iconfont").removeClass("icon-arrow-up").addClass("icon-arrow-down1");
        _this.next().css("display","none");
        _this.parents(".screen-box-list").removeClass("sfixed");
    });
    if(_that)_that.find("a:first").addClass("active");
    ableTouchslide();
}

function selected(_this){
    _this.siblings().each(function(i,item){
        $(this).css("color","");
    });
    _this.css("color","#108ee9");
}
// 地区
$("#regiondiv").on('click','li',function (e) {
    selected($(this));
    closeOtherFilter($(this).parent().closest("li"));
    workTypeHandler($(this));
    condition.cityType = $(this).data("value");
    ijob.persistence.set("fullCondition",condition);
    loadFullJob();
    e.stopPropagation();
});

// 岗位
$("#publishPostdiv").on('click','li',function (e) {
    selected($(this));
    closeOtherFilter($(this).parent().closest("li"));
    publishTypeHandler($(this));
    condition.fullType = $(this).data("value");
    ijob.persistence.set("fullCondition",condition);
    loadFullJob();
    e.stopPropagation();
});

// 排序
$("#sortdiv").on('click','li',function (e) {
    selected($(this));
    closeOtherFilter($(this).parent().closest("li"));
    sortTypeHandler($(this));
    condition.orderBy = $(this).data("value");
    ijob.persistence.set("fullCondition",condition);
    loadFullJob();
    e.stopPropagation();
});

// 薪资
$("#wagesdiv").on('click','li',function (e) {
    selected($(this));
    closeOtherFilter($(this).parent().closest("li"));
    wagesTypeHandler($(this));
    condition.salaryOrder = $(this).data("value");
    ijob.persistence.set("fullCondition",condition);
    loadFullJob();
    e.stopPropagation();
});

function workTypeHandler(_this){
    $("#region").text(_this.text());
}
function publishTypeHandler(_this) {
    $("#post").text(_this.text());
}
function sortTypeHandler(_this) {
    $("#sort").text(_this.text());
}
function wagesTypeHandler(_this) {
    $("#wages").text(_this.text());
}

$("body>*").on('click',function(){
    closeOtherFilter();
});