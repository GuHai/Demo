//获得slider插件对象
var gallery = mui('.mui-slider');
gallery.slider({
    interval: 5000//自动轮播周期，若为0则不自动播放，默认为0；
});

/*

var btn = ['取消', '切换'];
$('#prompt').on('click', function (e) {
    mui.confirm('定位为长沙市，是否切换？', '提示', btn, function (e) {
        if (e.index == 0) {

        } else {
            self.location='index/selectarea.html';
        }
    })
});
*/

$(".filter-claim>div:last,.filter-weekend>div:last").on('click', function () {
    if ($(this).hasClass("mui-active")){
        $(this).removeClass("mui-active");
    }else{
        $(this).addClass("mui-active");
    }
    search.condition.settlement = $(this).hasClass("mui-active");
});


function tofilter(){
    $(".filter_main").addClass("filter_active");
    $('body,html').addClass("noscroll");
    $(".select_nav ").removeClass("sfixed");
    if($(".filterbg").length>0){
        $(".filterbg").addClass("bg_active");
    }else{
        $("body").append('<div class="filterbg"></div>');
        $(".filterbg").addClass("bg_active");
    }
    $(".bg_active,.cancel_btn").click(function(){
        $('body,html').removeClass("noscroll");
        $(".filter_main").removeClass("filter_active");
        setTimeout(function(){
            $('body,html').removeClass("noscroll");
            $(".bg_active").removeClass("bg_active");
            $(".filterbg").remove();
        },300);
    })
}
//点击取消、确认
// $("#filterBtn").click(function(){
//     $(".select_nav ").removeClass("sfixed");
// });

$(".filter_main,.nav-selected").on('touchmove',function(e){
    e.preventDefault();  //阻止默认行为
})



