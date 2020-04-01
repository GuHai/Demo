var filterclicktypename ;
var lastpotin ;
var panel;
$(".nav-box").click(function (e) {
    //首先关闭掉所有的东西

    var _this = $(this);
    filterclicktypename = _this.attr("id");
    var  state = !_this.find("i").hasClass("icon-arrow-up"); //true 为需要打开 false 为需要关闭
    closeOtherFilter(_this);
    if(state){
        disTouch();
        _this.next().css("display","block");
        _this.find("i").addClass("icon-arrow-up").removeClass("icon-arrow-down1");
    }else{
        ableTouch();
        _this.next().css("display","none");
        _this.find("i").removeClass("icon-arrow-up").addClass("icon-arrow-down1");
    }
    e.stopPropagation();

});
function disTouch(){
    if(filterclicktypename=="release"){
        panel = $("#workTypeList");
    }
    $(".wrap").on('touchmove',touchHandler);
    $('.hader-fixed').on('touchend',endHandler);
}

function endHandler(event){
    lastpotin = undefined;
}
function touchHandler(event){
    event.preventDefault();
    if(filterclicktypename=="place" || filterclicktypename=="release" ){
       /* var panel;
        if(filterclicktypename=="place")panel = $("#gradet1");
        else
            panel  = $("#workTypeList");*/
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
    $('.hader-fixed').off('touchend',endHandler);
}

function closeOtherFilter(_that){
    $(".nav-box").each(function(){
        var _this = $(this);
        _this.find("a").removeClass("active");
        _this.find("i").removeClass("icon-arrow-up").addClass("icon-arrow-down1");
        _this.next().css("display","none");
    });
    if(_that)_that.find("a:first").addClass("active");
    ableTouch();
}

function selected(_this){
    _this.siblings().each(function(i,item){
        $(this).css("background","");
        $(this).css("color","");
    });

    _this.css("background","#f2f5f7");
    _this.css("color","#108ee9");
}

var fujin = "<li  data-dist=\"10\">不限</li>\n" +
    "                                <li  data-dist=\"1\">1000m内</li>\n" +
    "                                <li  data-dist=\"3\">3000m内</li>\n" +
    "                                <li  data-dist=\"5\">5000m内</li>";
var quyu = "";
var pointtype = ""
var metroHtml = "";
$("#gradew1").on('click','li',function(e){
    selected($(this));
    $(this).parent().css("width","33.3%");
    $(this).parent().next().css("width","33.3%");
    $(this).parent().next().css("left","33.3%");
    pointtype = $(this).text();
    $("#grades1").html("");
    if($(this).text()=="附近"){
        $("#gradet1").html(fujin);
    }else if($(this).text()=="区域"){
        $("#gradet1").html("");
        var dist = $(this).data("dist");
        if(quyu){
            $("#gradet1").html(quyu);
        }else{
            $.getJSON("/api/CityController/getMyCityRegion/"+localtion.cityID,null,function(result){
                var list = result.data.list;
                for(var index in list){
                    quyu += "<li data-id='"+list[index].id+"'>"+list[index].cityName+"</li>";
                }
                $("#gradet1").html(quyu);
            });
        }
        panel = $("#gradet1");
    }else{

        $("#gradet1").html("");
        if(metroHtml){
            $("#gradet1").html(metroHtml);
        }else{
            $.getJSON("/api/MetroController/getMyCityMetro/"+localtion.cityID,null,function(result){
                var list = result.data.list;
                for(var index in list){
                    metroHtml += "<li data-id='"+list[index].id+"'>"+list[index].name+"</li>";
                }
                $("#gradet1").html(metroHtml);
            });
        }
        panel = $("#grades1");
    }
    e.stopPropagation();
});

$("#gradet1").on('click','li',function(e){
    selected($(this));
    gradetHandler($(this));
    if(pointtype!="地铁"){
        closeOtherFilter($(this).parent().closest("li"));
    }else{
        $(this).parent().next().css("left","66.6%");
    }

    e.stopPropagation();
});

$("#grades1").on('click','li',function(e){
    selected($(this));
    gradesHandler($(this));
    closeOtherFilter($(this).parent().closest("li"));
    e.stopPropagation();
});

$("#workTypeList").on('click','li',function (e) {
    selected($(this));
    closeOtherFilter($(this).parent().closest("li"));
    workTypeHandler($(this));
    e.stopPropagation();
});

$("#publishType").on('click','li',function (e) {
    selected($(this));
    closeOtherFilter($(this).parent().closest("li"));
    publishTypeHandler($(this));
    e.stopPropagation();
});

$("#filterBtn").on('click',function(){
    selected($(this));
    closeOtherFilter($(this).closest("div[class$='nav-content']").parent());
    filterHandler();
});


//点击重置
$("#resetBtn").on("click", function () {
    $(".text_start,.text_end").val("");
    $("[data-id]").attr("id", "");
    $(".mui-active").removeClass("mui-active");
    var arr = $(".filter-gender-msg > li");
    for (var i = 0 ; i < arr.length ; i++){
        $(arr[i]).removeClass("aaa");
        $(arr[i]).css("border-color","");
        $(arr[i]).css("color","");
    }
    arr = $(".filter-js-msg > li");
    for (var i = 0 ; i < arr.length ; i++){
        $(arr[i]).removeClass("aaa");
        $(arr[i]).css("border-color","");
        $(arr[i]).css("color","");
    }
    resetBtnHandler();
});

$("body>*").on('click',function(){
    closeOtherFilter();
});