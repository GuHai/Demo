$(function () {
    var slide = null;
    // 帮你投保
    $("#code").click(function () {
        $(".popup-backdrop").show();
        slide = new Slide($(".choose_insured"),$(".popup-backdrop"),".popup-inner");
        slide.disTouch();
    })
    $(".button .icon-shanchu1").click(function () {
        $(".popup-backdrop").hide();
        slide.ableTouch();
    })
    $("body>*").on('click', function (e) {
        if ($(e.target).hasClass('popup-backdrop')) {
            $(".popup-backdrop").hide();
            slide.ableTouch();
        }
    });
})