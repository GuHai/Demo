<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>合伙人计划</title>
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.picker.min.css">
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/static/css/base.css">
    <link rel="stylesheet" href="/ijob/static/css/mine/partnerPlan.css?version=4">

</head>
<body>
<div class="wrap">
    <%--头部--%>
    <div class="headBox">
        <%--不是会员--%>
        <div class="head-img" style="display: none">
            <img src="/ijob/static/images/copartner.jpg" style="width: 100%;height: 100%"/>
            <%--<div class="img">--%>
                <%--<img sr="/ijob/static/images/copartner-1.png"/>--%>
            <%--</div>--%>
        </div>
        <%--是会员--%>
        <div class="conetent"  style="display: none">
            <div class="left">
                <%--黄金
                <img src="/ijob/static/images/gold.png"/>
                &lt;%&ndash;铂金&ndash;%&gt;
                <img src="/ijob/static/images/platinum.png"/>
                &lt;%&ndash;钻石&ndash;%&gt;
                <img src="/ijob/static/images/diamonds.png"/>--%>
                <img id="mypartner"  style="width: 100%;height: 100%"/>
            </div>
            <div class="right">
                <div class="txt">
                    <div class="flex">
                        <h3>尊敬的<span class="partname">钻石会员</span></h3>
                        <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/qz/mine/reward'})">我的奖励</a>
                    </div>
                    <p>您有<span  class="partname">钻石会员</span>的所有特权</p>
                </div>
                <div class="label">
                    <span class="tel"></span>
                    <a href="javascript:void(0);" class="inviting_code">邀请二维码</a>
                </div>
            </div>
            <div>
                <script type="text/html" id="qrCode" data-url="/ijob/api/InformationController/h5/mine/getQRcode" data-type="POST">
                    <div class="inviting-popup-backdrop" id="inviting-popup-backdrop" style="display: none">
                        <div class="inviting_content">
                            <div class="backImg">
                                <img src="/ijob/static/images/i_code.png">
                            </div>
                            <div class="code_img" id="qrcodeimg">

                            </div>
                        </div>
                    </div>
                </script>
            </div>

        </div>
    </div>
    <%--合伙人级别--%>
    <div class="mainBox">
        <div class="tabList">
            <ul class="list">
                <li class="head-li "><a href="javascript:void(0);">黄金会员</a></li>
                <li class="head-li"><a href="javascript:void(0);">铂金会员</a></li>
                <li class="head-li"><a href="javascript:void(0);">钻石会员</a></li>
            </ul>
        </div>
        <div class="main">
            <div class="mui-content-box gold" style="display: block">

                <div class="partner" style="display: block">
                    <%--黄金合伙人--%>
                    <div class="table-view-cell">
                        <h3>邀请奖励</h3>
                        <table class="table">
                            <tr class="title">
                                <th class="first">奖励类型</th>
                                <th>黄金会员</th>
                                <th>铂金会员</th>
                                <th>钻石会员</th>
                            </tr>
                            <tr>
                                <td class="first">推荐奖</td>
                                <td class="num">39</td>
                                <td class="num">79</td>
                                <td class="num">119</td>
                            </tr>
                            <tr>
                                <td class="first">推广奖</td>
                                <td class="num">13</td>
                                <td class="num">27</td>
                                <td class="num">41</td>
                            </tr>
                            <tr>
                                <td class="first">团队奖</td>
                                <td class="num">5</td>
                                <td class="num">11</td>
                                <td class="num">17</td>
                            </tr>
                        </table>
                        <div class="tips">
                            备注：成为黄金会员后，可以邀请他人加入合伙人计划，邀请成功得到相应的奖励，具体奖励金额如上表。
                            <a href="javascript:void(1);" class="tablebtn" id="g_btns">奖励规则</a>
                            <div class="payment_content">
                                <span class="iconfont icon-shanchu1"></span>
                                <div class="paymain" id="g_content">
                                    <h3>举个例子：</h3>
                                    <div class="txt">
                                        <p style="margin-left: 0;">假设A为黄金会员，以A推广B,B推广C，C推广D的流程为例，A可以推广B为任意会员等级。</p>
                                    </div>

                                    <div class="txt">
                                    <p  style="margin-left: 0;">1.当A推广B加入合伙人计划时，A将获得推荐奖，此时：</p>
                                    <p>如果B成为黄金会员，则A获得39元奖金；</p>
                                    <p>如果B成为铂金会员，则A获得79元奖金；</p>
                                    <p>如果B成为钻石会员，则A获得119元奖金；</p></div>

                                    <div class="txt">
                                    <p   style="margin-left: 0;">2.当B推广C加入合伙人计划时，A将获得推广奖，此时：</p>
                                    <p>如果C成为黄金会员，则A获得13元奖金；</p>
                                    <p> 如果C成为铂金会员，则A获得27元奖金；</p>
                                    <p> 如果C成为钻石会员，则A获得41元奖金；</p></div>

                                     <div class="txt">
                                     <p   style="margin-left: 0;"> 3.当C推广D加入合伙人计划时，A将获得团队奖，此时：</p>
                                    <p>如果D成为黄金会员，则A获得5元奖金；</p>
                                    <p>如果D成为铂金会员，则A获得11元奖金；</p>
                                    <p>如果D成为钻石会员，则A获得17元奖金；</p></div>

                                    <div class="txt"><p>B、C、D获得的奖励如此类推。</p></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="otherList">
                        <h3>其他特权</h3>
                        <div class="taglist">
                            <div class="title">《I Job》VIP金牌特权：</div>
                            <span class="">◆求职免保证金 </span>
                            <span class="">◆简历置顶 </span>
                            <span class="">◆应聘优先 </span>
                            <span class="">◆金牌勋章 </span>
                        </div>
                    </div>
                </div>

                <div class="partner" style="display: none">
                    <%--铂金合伙人--%>
                    <div class="table-view-cell">
                        <h3>邀请奖励</h3>
                        <table class="table">
                            <tr class="title">
                                <th class="first">奖励类型</th>
                                <th>黄金会员</th>
                                <th>铂金会员</th>
                                <th>钻石会员</th>
                            </tr>
                            <tr>
                                <td class="first">推荐奖</td>
                                <td class="num">47</td>
                                <td class="num">95</td>
                                <td class="num">143</td>
                            </tr>
                            <tr>
                                <td class="first">推广奖</td>
                                <td class="num">19</td>
                                <td class="num">39</td>
                                <td class="num">59</td>
                            </tr>
                            <tr>
                                <td class="first">团队奖</td>
                                <td class="num">9</td>
                                <td class="num">19</td>
                                <td class="num">29</td>
                            </tr>
                        </table>
                        <div class="tips">
                            备注：成为铂金会员后，可以邀请他人加入合伙人计划，邀请成功得到相应的奖励，具体奖励金额如上表。
                            <a href="javascript:void(1);" class="tablebtn" id="p_btns">奖励规则</a>
                            <div class="payment_content">
                                <span class="iconfont icon-shanchu1"></span>
                                <div class="paymain"  id="p_content">
                                    <h3>举个例子：</h3>
                                    <div class="txt">
                                        <p style="margin-left: 0;">假设A是铂金会员，以A推广B，B推广C，C推广D的流程为例，A可以推广B为任意会员等级。</p>
                                    </div>
                                    <div class="txt">
                                        <p  style="margin-left: 0;">1.当A推广B加入合伙人计划时，A将获得推荐奖，此时：</p>
                                        <p> 如果B成为黄金会员，则A获得47元奖金；</p>
                                        <p>如果B成为铂金会员，则A获得95元奖金；</p>
                                        <p>如果B成为钻石会员，则A获得143元奖金；</p></div>

                                    <div class="txt">
                                        <p   style="margin-left: 0;">2.当B推广C加入合伙人计划时，A将获得推广奖，此时：</p>
                                        <p>如果C成为黄金会员，则A获得19元奖金；</p>
                                        <p> 如果C成为铂金会员，则A获得39元奖金；</p>
                                        <p> 如果C成为钻石会员，则A获得59元奖金；</p></div>

                                    <div class="txt">
                                        <p   style="margin-left: 0;">3.当C推广D加入合伙人计划时，A将获得团队奖，此时：</p>
                                        <p>如果D成为黄金会员，则A获得9元奖金；</p>
                                        <p>如果D成为铂金会员，则A获得19元奖金；</p>
                                        <p> 如果D成为钻石会员，则A获得29元奖金；</p></div>

                                    <div class="txt"><p> B、C、D获得的奖励如此类推。  </p></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="otherList">
                        <h3>其他特权</h3>
                        <div class="taglist">
                            <div class="title">《I Job》VIP铂金特权：</div>
                            <span class="">◆求职免保证金 </span>
                            <span class="">◆简历置顶 </span>
                            <span class="">◆应聘优先 </span>
                            <span class="">◆铂金勋章 </span>
                        </div>
                        <div class="taglist">
                            <div class="title">免费代理各种产品业务</div>
                            <span class="">
                            业务代理产品包含但不限于（根据公司业务情况及自身能力可增加）：学历自考、兼职招聘等。
                        </span>
                        </div>
                        <%--<div class="taglist">
                            <div class="title">培训课程</div>
                            <span class="">
                                培训内容包含但不限于（新培训课程会不定期增加）：职业规划、
                                口才锻炼、Financial Quotient、创业规划、股权分配等等。
                            </span>
                        </div>--%>
                    </div>
                </div>

                <div class="partner" style="display: none">
                    <%--钻石合伙人--%>
                    <div class="table-view-cell">
                        <h3>邀请奖励</h3>
                        <table class="table">
                            <tr class="title">
                                <th class="first">奖励类型</th>
                                <th>黄金会员</th>
                                <th>铂金会员</th>
                                <th>钻石会员</th>
                            </tr>
                            <tr>
                                <td class="first">推荐奖</td>
                                <td class="num">55</td>
                                <td class="num">111</td>
                                <td class="num">167</td>
                            </tr>
                            <tr>
                                <td class="first">推广奖</td>
                                <td class="num">25</td>
                                <td class="num">51</td>
                                <td class="num">77</td>
                            </tr>
                            <tr>
                                <td class="first">团队奖</td>
                                <td class="num">13</td>
                                <td class="num">27</td>
                                <td class="num">41</td>
                            </tr>
                        </table>
                        <div class="tips">
                            备注：成为钻石会员后，可以邀请他人加入合伙人计划，邀请成功得到相应的奖励，具体奖励金额如上表。
                            <a href="javascript:void(1);" class="tablebtn" id="d_btns">奖励规则</a>
                            <div class="payment_content">
                                <span class="iconfont icon-shanchu1"></span>
                                <div class="paymain"  id="d_content">
                                    <h3>举个例子：</h3>

                                    <div class="txt">
                                        <p style="margin-left: 0;">假设A是钻石会员，以A推广B，B推广C，C推广D的流程为例，A可以推广B为任意会员等级。</p>
                                    </div>
                                    <div class="txt">
                                        <p  style="margin-left: 0;">1.当A推广B加入合伙人计划时，A将获得推荐奖，此时：</p>
                                        <p> 如果B成为黄金会员，则A获得55元奖金；</p>
                                        <p>如果B成为铂金会员，则A获得111元奖金；</p>
                                        <p>如果B成为钻石会员，则A获得167元奖金；</p></div>

                                    <div class="txt">
                                        <p   style="margin-left: 0;">2.当B推广C加入合伙人计划时，A将获得推广奖，此时：</p>
                                        <p>如果C成为黄金会员，则A获得25元奖金；</p>
                                        <p>如果C成为铂金会员，则A获得51元奖金；</p>
                                        <p>如果C成为钻石会员，则A获得77元奖金；</p></div>

                                    <div class="txt">
                                        <p   style="margin-left: 0;">3.当C推广D加入合伙人计划时，A将获得团队奖，此时：</p>
                                        <p>如果D成为黄金会员，则A获得13元奖金；</p>
                                        <p>如果D成为铂金会员，则A获得27元奖金；</p>
                                        <p>如果D成为钻石会员，则A获得41元奖金；</p></div>

                                    <div class="txt"><p> B、C、D获得的奖励如此类推。 </p></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="otherList">
                        <h3>其他特权</h3>
                        <div class="taglist">
                            <div class="title">《I Job》VIP钻石特权：</div>
                            <span class="">◆求职免保证金 </span>
                            <span class="">◆简历置顶 </span>
                            <span class="">◆应聘优先 </span>
                            <span class="">◆钻石勋章 </span>
                        </div>
                        <div class="taglist">
                            <div class="title">免费团队活动1次</div>
                        </div>
                        <div class="taglist">
                            <div class="title">免费代理各种产品业务</div>
                            <span class="">
                                业务代理产品包含但不限于（根据公司业务情况及自身能力可增加）：学历自考、兼职招聘等。
                            </span>
                        </div>
                        <div class="taglist">
                            <div class="title">培训课程</div>
                            <span class="">
                            培训内容包含但不限于（新培训课程会不定期增加）：职业规划、口才锻炼、Financial Quotient、创业规划、股权分配等等。
                        </span>
                        </div>
                        <div class="taglist">
                            <div class="title">创业指导</div>
                            <span>
                            会员有创业想法或者创业项目等情况，公司内部提供相关的支持来推动事业或者项目的发展。
                        </span>
                        </div>
                        <div class="taglist">
                            <div class="flex">
                                <div class="title">可免费申请企业个性文化衫</div>
                                <div class="link"><a href="tel:0731-89566256">联系客服<span class="iconfont icon-arrow-right"></span></a></div>
                            </div>
                        </div>
                        <div class="taglist">
                            <div class="title" style="margin-top: 0;">晋升独家校园合伙人机会</div>
                        </div>
                    </div>
                </div>

                <div style="height: 1.3rem;clear: both;content: '';"></div>
                <footer class="foot" id="partnernamebtn"><a href="javascript:void(0);" id="partnername">成为铂金合伙人</a></footer>
                <div class="payment_content paymentcontent">
                    <div class="paymain">
                        <div class="money"><em>￥</em>399</div>
                        <div class="level">铂金合伙人</div>
                        <div class="input-box"><input type="text" id="ivcode" placeholder="请输入邀请码（选填）"></div>
                        <div id="inviter" class="tips"></div>
                        <div class="btns"  data-url="/ijob/api/PartnerController/add"><a href="javascript:void(0);" >确认</a></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
     <%--邀请合伙人--%>
    <div class="invite-content" style="display: none">
        <div class="popupmain">
            <div class="colsebtns"><span class="iconfont icon-guanbi"></span></div>
            <div class="portrait">
                <div class="head">
                    <img  src=""  onerror="this.src='/ijob/static/images/default.jpg';this.onerror=null"/>
                </div>
                <p class="name"></p>
            </div>
            <div class="txt">邀请你成为合伙人</div>
            <div class="code"></div>
            <div class="qr_code">
                <img src="/ijob/upload/iJob/images/resource/gzh.jpg"/>
            </div>
            <div class="note">长按识别二维码，关注后成为合伙人，得奖励</div>
        </div>
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
</div>
</body>
</html>
<jsp:include page="../../qz/base/resource.jsp"/>
<script src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js" type="text/javascript"></script>
<script src="/ijob/static/js/utf.js"></script>
<script src="/ijob/static/js/qrcode.min.js"></script>

<script>
    var code = ijob.storage.get("partneruser.code")||'${code}';
    var name = ijob.storage.get("partneruser.name")||'${name}';
    var headimg = '${headimg}';
    var partname;
    var moneys ;
    var partID  ;
    var pu ={partID:'${partner.partID}',code:'${partner.code}'};
    var partner = ijob.storage.get("partner")||{partID:0};
    if(partner.partID==0){
        $.ajaxSettings.async = false;
        $.getJSON("/ijob/api/PartnerController/checkExist",function(result){
            if(result.data){
                partner = result.data;
            }
            $.ajaxSettings.async = true;
        });

    }
    if(pu.partID){
        partner = pu;
    }
    //如果分享人不是会员，则code是undifined  如果为这个，则删除code
    if(partner.code=='undefined'){
        partner.code = null;
    }

    //当前身份是合伙人
    if(partner.partID>0){
        $(".conetent").css("display","block");
        var imgsrc = "gold:platinum:diamonds".split(":")[partner.partID-1]+".png";
        $("#mypartner").attr("src","/ijob/static/images/"+imgsrc);
        $(".partname").text("黄金:铂金:钻石".split(":")[partner.partID-1]+"会员");
        $(".tel").text("邀请码："+partner.code);
    }else{
        $(".head-img").css("display","block");
    }
    share();
    function share(){
        var title= "【I Job兼职】邀请您加入合伙人计划";
        var desc="加入合伙人计划\n学习+赚钱+创业\n更好玩的模式 更精彩的生活";
        var link="${site}/share/PN/"+partner.code+"/userID";
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
    }

    function checkSubscribe(){
        $.ajax({
            type: "GET",
            url: '/ijob/api/WeixinController/checkSubscribe',
            cache: false,
            dataType: "json",
            success:function (data) {
                if(data.code == '403'){
                    $(".invite-content").css("display","block");
                }else if(data.code != '200'){

                }
            }
        });
    }




    $(function () {

        var slide = null;

        /*$(".tablebtn").click(function () {
            $(".mui-content-box .tips .payment_content").show();
            $(".share-content").hide();
            slide = new Slide($(".wrap"),$(".payment_content"),".paymain");
            slide.disTouch();
        })*/

        $(".inviting_code").on("click",function () {
            $(".inviting-popup-backdrop").show();
            slide = new Slide($(".wrap"),$(".inviting-popup-backdrop"),".inviting_content");
            slide.disTouch();
        });
        // 点击空白处隐藏选项
        $("body>*").on('click', function (e) {
            if ($(e.target).hasClass('inviting-popup-backdrop')) {
                $(".inviting-popup-backdrop").hide();
                slide.ableTouch();
            }
        });

        $("#g_btns").click(function () {
            $(".mui-content-box .tips .payment_content").show();
            $(".share-content").hide();
            slide = new Slide($(".wrap"),$(".payment_content"),"#g_content");
            slide.disTouch();
        });
        $("#p_btns").click(function () {
            $(".mui-content-box .tips .payment_content").show();
            $(".share-content").hide();
            slide = new Slide($(".wrap"),$(".payment_content"),"#p_content");
            slide.disTouch();
        });
        $("#d_btns").click(function () {
            $(".mui-content-box .tips .payment_content").show();
            $(".share-content").hide();
            slide = new Slide($(".wrap"),$(""),"#d_content");
            slide.disTouch();
        });

        if(code){//如果code不为空，则肯定是通过分享链接进来的，判断是不是已经关注过公众号，如果没有关注，则关注公众号，如果关注了，则直接成为合伙人
            $(".code").text("邀请码："+code);
            $(".name").text(name);
            $("#ivcode").val(code);
            $("#inviter").val("邀请人:"+name);
            $(".head img").attr("src",headimg);
            checkSubscribe();
        }

        $("#ivcode").blur(function(){
           /* var phoneno  = $("#ivcode").val();
            checkNameByPhone(phoneno);*/
        });

        $("#ivcode").on('input',function(){
            var phoneno  = $("#ivcode").val();
            if(phoneno.length==11){
                checkNameByPhone(phoneno);
            }else{
                $("#inviter").text("邀请码不存在");
            }
        });

        function checkNameByPhone(phoneno){
            if(phoneno){
                $.getJSON("/ijob/api/PartnerController/getNameByPhoneNo/"+phoneno,function(result) {
                    if (result.data) {
                        $("#inviter").text("邀请人："+result.data.realName);
                    }else{
                        $("#inviter").text("邀请码不存在");
                    }
                });
            }else{
                $("#inviter").text("邀请码不存在");
            }
        }




        //合伙人切换
        $(".head-li").click(function () {
            $(this).addClass("curr").siblings().removeClass("curr");
            $(".partner").eq($(this).index()).show().siblings(".partner").hide();
            partname = "黄金:铂金:钻石".split(":")[$(this).index()];
            moneys = "199:399:599".split(":")[$(this).index()];
            partID = 1+$(this).index();
            if(partner.partID>=partID){
                $("#partnername").text("邀请加入合伙人计划");
            }else{
                $("#partnername").text("成为"+partname+"会员");
                $(".money").html('<em>￥</em>'+moneys);
                $(".level").html(partname+"会员");
            }
        });

        $(".list li:first").click();

        // 点击空白处隐藏选项
        $("body>*").on('click', function (e) {
            if ($(e.target).hasClass('paymentcontent')) {
                $(".paymentcontent").hide();
                slide.ableTouch();
            }else  if ($(e.target).hasClass('invite-content')) {
                $(".invite-content").hide();
                slide.ableTouch();
            }
        });

        // 关闭举例子
        $(".icon-shanchu1").click(function () {
            $(".payment_content").hide();
            slide.ableTouch();
        })

        // 邀请合伙人
        $(".colsebtns").on("click",function () {
            $(".invite-content").hide();
        });

        // 邀请加入合伙人计划，即分享
        if ($("#partnername").text() == "邀请加入合伙人计划"){
            $("#partnernamebtn").click(function () {
                $(".share-content").show();
                $(".paymentcontent").hide();
                slide = new Slide($(".wrap"),$(".share-content"),".popup-backdrop");
                slide.disTouch();
            });
        }
        // 点击空白处隐藏选项
        $("body>*").on('click', function (e) {
            if ($(e.target).hasClass('share-content')) {
                $(".share-content").hide();
                slide.ableTouch();
            }
        });

        $("#partnernamebtn").on('click',function(){
            if(partner.partID>=partID){ //邀请合伙人 这个按钮无用了

            }else{ //成为合伙人
                $(".paymentcontent").show();
                $(".share-content").hide();
                /*$(".msgedit").focus();
                $(".msgedit").blur();*/
                /*slide = new Slide($(".wrap"),$(".paymentcontent"),".paymain");
                slide.disTouch();*/
            }
        });

        $(".btns").on('click',function(){

            $.getJSON("/ijob/api/PartnerController/checkExist",function(result){
                if(result.data){
                    part  = result.data;
                    if(part.status==true){
                        if(part.partID==partID){
                            mui.alert("您已经是"+partname+"会员");
                        }else if(partID>part.partID){
                            toPartner("您当前为"+("黄金:铂金:钻石".split(":")[part.partID-1])+"合伙人，确定要升级为"+partname+"会员吗？（需要补差价）");
                        }else{
                            mui.alert("您当前是"+("黄金:铂金:钻石".split(":")[part.partID-1])+"合伙人，不能降级");
                        }
                    }else{
                        toPartner("确定要成为"+partname+"会员吗");
                    }
                }else{
                    toPartner("确定要成为"+partname+"会员吗");
                }
            });
        });



        function toPartner(msg) {
            $(".btns").btPost({upgradePartID:partID,tempCode:$("#ivcode").val(),status:false},function(result){
                if(result.success==true){
                    payPartnerFee(result);
                }else{
                    if(result.code=='403'){ //个人实名认证
                        var btn = ['确定','取消'];
                        mui.confirm("跳转到个人实名认证", '提示', btn, function (e1) {
                            if (e1.index == 0) {
                                // ijob.gotoPage({path:"/h5/qz/mine/realName"});
                                ijob.storage.set("personal.needCardID",true);
                                ijob.gotoPage({path:"/h5/qz/index/personalInform"});
                            }
                        });
                    }else{
                        mui.alert(result.msg);
                    }
                }
            });
        }

        function payPartnerFee(result){
            // window.history.replaceState('','', "/ijob/forward?path=/h5/qz/mine/goldMember");
            ijob.url.next.set("/ijob/api/PartnerController/partnerCallback","html");
            ijob.gotoPage({url:'/ijob/api/WeixinController/order',data:{order:{refID:result.data.id,fee:result.data.partner.fee*100,description:partname+'会员费用缴纳'+(result.data.partner.fee)+'元',type:enums.WxOrderType.Partner}}});
        }
    })
    $("#qrCode").loadData().then(function (result) {
        var pw =  $(".inviting_content").height();
        var width = pw;
        var height = width;
        var qrcode = new QRCode(document.getElementById("qrcodeimg"), {
            text:  "${site}/share/PN/"+partner.code+"/userID",
            width: width, //生成的二维码的宽度
            height: height, //生成的二维码的高度
            colorDark : "#006bd9", // 生成的二维码的深色部分
            colorLight : "#ffffff", //生成二维码的浅色部分
            correctLevel : QRCode.CorrectLevel.H
        });
        $(".inviting_content").css("height","auto");
    })
</script>
