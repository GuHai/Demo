<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/8
  Time: 10:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>职位详情</title>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/broker/broker.css?version=4">
</head>
<body>
<div class="wrap">
    <div class="broker-time-detail">
        <script id="getPostForBrokerInfo" type="text/html" data-url="/ijob/api/FullTimeController/getPostForBrokerFullInfo/{postForBroker.id}">
            {{each list as post}}
                <%--佣金详情--%>
                <div class="remuneration-box">
                    <div class="details-box">
                        <div class="title">
                            <span class="txt">佣金金额</span>
                            <span class="money">{{post.commission}}{{post.unit |enums:'UnitType'}}</span>
                        </div>
                        <div class="tips-box">
                            <div class="title">经纪人注意事项：</div>
                            <div class="content" id="attention">
                                <%--{{post.attention}}--%>
                            </div>
                        </div>
                    </div>
                    <div class="warning">以上内容具有一定保密性，经纪人请勿传播给他人！</div>
                </div>
                <%--佣金详情--%>
                <%--职位详情--%>
                <div class="job-list-box">
                    <div class="title">
                        <span class="txt">{{post.post.title}}</span>
                        <span class="num">招聘人数：{{post.post.recruits}}人</span>
                    </div>
                    {{if post.post.maxSalary==post.post.minSalary&&post.post.minSalary==0}}
                    <div class="money">面议</div>
                    {{else}}
                    <div class="money">{{post.post.minSalary}}-{{post.post.maxSalary}}元/月</div>
                    {{/if}}
                    {{if post.post.benefitsLabel != null&&post.post.benefitsLabel != ""}}
                    <div class="treatment taglist">
                        <h3>福利待遇</h3>
                        <div class="list">
                            {{each post.post.postLabelList as label}}
                                {{if label.type==1}}
                                    <span>{{label.name}}</span>
                                {{/if}}
                            {{/each}}
                        </div>
                    </div>
                    {{/if}}
                    <div class="work taglist">
                        <h3>工作标签</h3>
                        <div class="list">
                            <span>{{post.post.minAge}}-{{post.post.maxAge}}岁</span>
                            {{each post.post.postLabelList as label}}
                                {{if label.type<5 && label.type> 1}}
                                <span>{{label.name}}</span>
                                {{/if}}
                            {{/each}}
                        </div>
                    </div>
                    {{if post.post.otherLabel != null&&post.post.otherLabel != ""}}
                    <div class="other taglist">
                        <h3>其它标签</h3>
                        <div class="list">
                            {{each post.post.postLabelList as label}}
                                {{if label.type==5}}
                                <span>{{label.name}}</span>
                                {{/if}}
                            {{/each}}
                        </div>
                    </div>
                    {{/if}}
                </div>
                <%--职位详情--%>
                <div class="full-job-list">
                    <%--工作地址--%>
                    <div class="address-box">
                        <div class="title">工作地址</div>
                        <div class="address">
                            <span class="txt">{{post.post.workPlace.detailedAddress}}</span>
                            <span class="iconfont icon-fujin"></span>
                        </div>
                    </div>
                    <%--职位描述--%>
                    <div class="details-box">
                        <div class="title">职位描述</div>
                        <div class="content" id="positiondesc">
                            <%--{{post.post.descript}}--%>
                        </div>
                    </div>
                    <%--职位描述 end --%>
                    <%--发布对象--%>
                    <%--<div class="company-box">
                        <div class="company-title">发布对象</div>
                        <div class="company-content clearfix">
                            <div class="left">
                                <div class="company-content-img ">
                                    <img src="/ijob/static/images/default.jpg" alt="">
                                </div>
                                <div class="company-content-msg ">
                                    <p class="name">{{post.post.company.company}}</p>
                                    <p class="admin">管理员：方敏</p>
                                </div>
                            </div>
                            <div class="right visit_home">
                                <a href="javascript:void(0);" class="link">访问工作号</a>
                            </div>
                        </div>
                    </div>--%>
                    <%--发布对象 end--%>
                </div>
                <div class="clearfix" style="clear: both;height: 1.8rem;overflow: hidden;content: '';"></div>
                <footer class="bar-footer">
                    <a href="tel:{{post.post.phone}}" class="linkbtns tel"><span class="iconfont icon-dadianhua"></span><span class="txt">联系负责人</span></a>
                    <a href="javascript:void(0);" class="linkbtns recommend" onclick="ijob.gotoPage({path:'/h5/zp/broker/recommend?full.id={{post.post.id}}'})"><span class="postxt">手动推荐</span></a>
                    <a href="javascript:void(0);" class="linkbtns resumes share" data-title="{{post.post.title}}" data-id="{{post.post.id}}" data-company="{{post.post.company.company}}"><span class="postxt">分享二维码</span></a>
                </footer>
                <%--分享二维码--%>
                <div class="share_code_code" style="display: none">
                    <div class="mainlist">
                        <div class="posi_box_list">
                            <div class="areaContent">
                                <h3 class="posi_tit"><span id="positiontitle">扫码即可投简历</span></h3>
                            </div>
                        </div>
                        <div class="code_box">
                            <div class="code_img" id="qrcodeimg" >
                                <img src="/ijob/static/images/ghz.jpg" class="nearby"/>
                            </div>
                            <div class="code_txt">
                                <h3>急招普工</h3>
                                <p class="name"> 湖南一生科技有限公司</p>
                            </div>
                        </div>
                    </div>
                    <div class="down-box" style="display: none">
                        <div class="line"></div>
                        <div class="button">
                            <span class="iconfont icon-shanchu1"></span>
                        </div>
                    </div>
                </div>
                <%-- 分享二维码 end --%>
            {{/each}}
        </script>
    </div>
</div>
</body>
<script src="/ijob/static/js/utf.js"></script>
<script src="/ijob/static/js/qrcode.min.js"></script>
<script src="/ijob/static/js/html2canvas.min.js"></script>
</html>
<script>
    $(function () {
        $("#getPostForBrokerInfo").loadData().then(function (result) {
            console.log(result);
            // 经纪人注意事项换行
            var attention = (result.data.list[0].attention ||"无注意事项").replace(/\n/g,"<br/>");
            $("#attention").html(attention);

            // 职位描述换行
            var content = (result.data.list[0].post.descript ||"无职位描述").replace(/\n/g,"<br/>");
            $("#positiondesc").html(content);

            $(".taglist span").each(function () {
                if ($(this).text().length >= 4){
                    $(this).css("width","1.653rem")
                }
            });

            var slide = null;
            $(".share").click(function () {
                $(".share_code_code").show();
                slide = new Slide($(".wrap"),$(".share_code_code"),".mainlist");
                slide.disTouch();
                initQrcode($(this).data("id"),$(this).data("title"),$(this).data('company'));
            });
            $(".down-box .icon-shanchu1").click(function () {
                $(".share_code_code").hide();
                slide.ableTouch();
            });
            // 点击空白处隐藏选项
            $("body>*").on('click', function (e) {
                if ($(e.target).hasClass('share_code_code')) {
                    $(".share_code_code").hide();
                    slide.ableTouch();
                }
            });
        });



    })

    function initQrcode(postID,title,company){
        $(".mainlist").html("<div class=\"posi_box_list\">\n" +
            "                    <div class=\"areaContent\">\n" +
            "                        <h3 class=\"posi_tit\"><span id=\"positiontitle\">扫码即可投简历</span></h3>\n" +
            "                    </div>\n" +
            "                </div>\n" +
            "                <div class=\"code_box\">\n" +
            "                    <div class=\"code_img\" id=\"qrcodeimg\" >\n" +
            "\n" +
            "                    </div>\n" +
            "                    <div class=\"code_txt\">\n" +
            "                        <h3 id=\"postTitle\"></h3>\n" +
            "                        <p id=\"company\"class=\"name\"> 湖南一生科技有限公司</p>\n" +
            "                    </div>\n" +
            "                </div>");
        mui.toast("生成图片中...");
        $("#postTitle").text(title);
        $("#company").text(company);
        var urlQrcode = "${site}/share/TJ/" + postID +"/"+ijob.storage.get("broker.code");
        console.log(urlQrcode);
        var pw =  $(".code_img").height();
        var width = pw;
        var height = width;
        var qrcode = new QRCode(document.getElementById("qrcodeimg"), {
            text:  urlQrcode,
            width: width, //生成的二维码的宽度
            height: height, //生成的二维码的高度
            colorDark : "#000000", // 生成的二维码的深色部分
            colorLight : "#ffffff", //生成二维码的浅色部分
            correctLevel : QRCode.CorrectLevel.H
        });

        setTimeout(function(){
            code2Image();
        },100);
    }

    function code2Image(){
        html2canvas($(".mainlist")[0], {scale:2,logging:false,useCORS:true}).then(function(canvas) {
            mui.toast("生成图片成功，可以长按转发了");
            var dataUrl = canvas.toDataURL();
            $(".mainlist").html("<img style='width:100%;border-radius:5px;'>");
            $(".mainlist img").attr("src",dataUrl).removeClass("hide");
        });
        $(".down-box").show();
    }
</script>
