$(function () {

    /*视频*/
    $("#scan").click(function () {
        $(".scan-box").show();
        $(".partners-box").hide();
        $(".postjob-box").hide();
    })
    $("#partners").click(function () {
        $(".partners-box").show();
        $(".scan-box").hide();
        $(".postjob-box").hide();
    })
    $("#postjob").click(function () {
        $(".postjob-box").show();
        $(".partners-box").hide();
        $(".scan-box").hide();
    })
    $(".retractbtns").click(function () {
        $(".partners-box").hide();
        $(".scan-box").hide();
        $(".postjob-box").hide();
    })
})
