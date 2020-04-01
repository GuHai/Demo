<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>合伙人计划</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/switchIdentity_personal.css">

</head>
<style>
    .wrap .main .btnBox{text-align: center}
    .wrap .main .pic_logo{/* background: #108ee9; */margin: 0 auto;width: 50%;padding-top: 0.533rem;text-align: center;height:  auto;}
    .wrap .main .btnBox .tips{font-size: 0.45rem;margin-bottom: 0.35rem}
    .wrap .main .btnBox a{line-height: 1.067rem}
    .wrap .main .btnBox a.btnBalck{background: none}
    body{background-color:#fff;}
</style>
<body>
<div class="wrap">
    <div class="main">
        <div class="pic_logo">
            <img src="/ijob/static/images/${partner.img}.png"/>
        </div>
        <h1 id="diamonds" class="title">恭喜你，已成为${partner.name}！</h1>

        <div class="btnBox">
            <div class="tips">邀请朋友加入，获得奖励</div>
            <a href="javascript:void(0);" class="btnCutover">马上邀请</a>
            <a href="javascript:void(0);" class="btnBalck" onclick="ijob.gotoPage({url:'/ijob/api/PartnerController/partnerPlan'})">返回</a>
        </div>
        <%--分享--%>
        <div class="share-content">
            <div class="popup-backdrop">
                <div class="descript"><span class="rotate"><span class="iconfont icon-dianji1"></span></span>点击进行分享</div>
                <div class="arrowhead">
                    <img src="/ijob/static/images/arrowhead.png"/>
                </div>
            </div>
        </div>
        <%--<div class="share_content">
            <div class="mainpopup">
                <ul>
                    <li>
                        <a href="javascript:void(0);">
                            <span class="iconfont icon-weixinhaoyou"></span>
                            <span class="name">微信好友</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:void(0);">
                            &lt;%&ndash;<span class="iconfont icon-pengyouquan"></span>&ndash;%&gt;
                            <div class="circle">
                                <img src="/ijob/static/images/Circle.png"/>
                            </div>
                            <span class="name">朋友圈</span>
                        </a>
                    </li>
                </ul>
                <div class="cancel">
                    <a href="javascript:void(0);">取消</a>
                </div>
            </div>
        </div>--%>
    </div>
</div>
<jsp:include page="../../qz/base/resource.jsp"/>
<script src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js" type="text/javascript"></script>
</body>
</html>
<script>


    var title= "【I Job兼职】邀请您加入合伙人计划";
    var desc="加入合伙人计划\n学习+赚钱+创业\n更好玩的模式 更精彩的生活";
    var link="${site}/share/PN/${code}/userID";
    var imgUrl="${site}/static/images/partnership.png";
    $.getJSON("/ijob/api/WeixinController/getJSAuthSignature?url="+window.location.href,function(data){
        wx.config({
            debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
            appId: data.data.appId, // 必填，公众号的唯一标识
            timestamp: data.data.timestamp, // 必填，生成签名的时间戳
            nonceStr: data.data.noncestr, // 必填，生成签名的随机串
            signature: data.data.signature,// 必填，签名
            jsApiList: ["onMenuShareAppMessage","onMenuShareTimeline","onMenuShareQQ","onMenuShareQZone","onMenuShareWeibo"] // 必填，需要使用的JS接口列表
        });
    })

    wx.ready(function () {

        var params = {
            title: title, // 分享标题
            desc: desc, // 分享描述
            link: link, // 分享链接
            imgUrl: imgUrl, // 分享图标
            success: function () {
                // 用户确认分享后执行的回调函数
            },
            cancel: function () {
                // 用户取消分享后执行的回调函数
            }
        };

        //获取“分享给朋友”按钮点击状态及自定义分享内容接口
        wx.onMenuShareAppMessage(params);
        //获取“分享到朋友圈”按钮点击状态及自定义分享内容接口
        wx.onMenuShareTimeline(params);
        //分享到QQ
        wx.onMenuShareQQ(params);
        //分享到QQ空间
        wx.onMenuShareQZone(params);
        //分享到腾讯微博
        wx.onMenuShareWeibo(params);
    });
    wx.error(function(res){
        mui.alert("错误信息"+JSON.stringify(res));
    });


    $(function () {

        var slide = null;

        // 分享
        $(".btnCutover").click(function(){
            $(".share-content").show();
            slide = new Slide($(".wrap"),$(".share-content"),".popup-backdrop");
            slide.disTouch();
        });
        /*$(".share_content .cancel a").click(function(){
            $(".share_content").hide();
            slide.ableTouch();
        });*/
        // 点击空白处隐藏选项
        $("body>*").on('click', function (e) {
            if ($(e.target).hasClass('share-content')) {
                $(".share-content" ).hide();
                slide.ableTouch();
            }
        });
    })
</script>