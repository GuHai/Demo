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
    <title>在招职位</title>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/broker/broker.css?version=4">
</head>
<body>
<div class="stay-broker-index">
    <header class="head">
        <div class="head-lf mui-input-row">
            <i class="mui-icon mui-icon-search"></i>
            <input type="text" id="searchInput" class="mui-input-clear" placeholder="搜索职位名称/公司名称"  maxlength="20">
        </div>
    </header>
    <%--筛选--%>
    <div class="screen-box-list" style="display: none;">
        <div class="nav-filter">
            <ul>
                <li class="nav-li nav_li_1">
                    <a href="javascript:void(0);" data-value="区域" id="region">
                        区域<span class="iconfont icon-arrow-down1"></span>
                    </a>
                    <div class="filter-list mui-backdrop" style="display: none;">
                        <div class="main-list-box">
                            <ul>
                                <li data-value="天心区">天心区</li>
                                <li data-value="岳麓区">岳麓区</li>
                                <li data-value="雨花区">雨花区</li>
                                <li data-value="开福区">开福区</li>
                                <li data-value="芙蓉区">芙蓉区</li>
                                <li data-value="望城区">望城区</li>
                                <li data-value="长沙县">长沙县</li>
                                <li data-value="宁乡县">宁乡县</li>
                                <li data-value="浏阳市">浏阳市</li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li class="nav-li nav_li_2">
                    <a href="javascript:void(0);" data-value="岗位" id="post">
                        岗位<span class="iconfont icon-arrow-down1"></span>
                    </a>
                    <div class="filter-list mui-backdrop" style="display: none">
                        <div class="main-list-box">
                            <ul>
                                <li data-value="普工">普工</li>
                                <li data-value="装配工">装配工</li>
                                <li data-value="操作工">操作工</li>
                                <li data-value="操作工">操作工</li>
                                <li data-value="分拣员">分拣员</li>
                                <li data-value="扫描员">扫描员</li>
                                <li data-value="打包员">打包员</li>
                                <li data-value="维修员">维修员</li>
                                <li data-value="技工">技工</li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li class="nav-li nav_li_3">
                    <a href="javascript:void(0);" data-value="排序" id="sort">
                        排序<span class="iconfont icon-arrow-down1"></span>
                    </a>
                    <div class="filter-list mui-backdrop" style="display: none">
                        <div class="main-list-box">
                            <ul>
                                <li data-value="最新发布">最新发布</li>
                                <li data-value="薪资从高到低">薪资从高到低</li>
                            </ul>
                        </div>
                    </div>
                </li>
                <li class="nav-li nav_li_4">
                    <a href="javascript:void(0);" data-value="薪资" id="wages">
                        薪资<span class="iconfont icon-arrow-down1"></span>
                    </a>
                    <div class="filter-list mui-backdrop" style="display: none">
                        <div class="main-list-box">
                            <ul>
                                <li data-value="3000元以下">3000元以下</li>
                                <li data-value="3000~5000元">3000~5000元</li>
                                <li data-value="5000~7000元">5000~7000元</li>
                                <li data-value="7000~9000元">7000~9000元</li>
                                <li data-value="9000元以上">9000元以上</li>
                            </ul>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <%--筛选end--%>
    <div class="list-box">
        <%-- index-list --%>
        <div class="index-list">
            <ul id="allList">
                <script id="getPostForBrokerInfo" type="text/html" data-url="/ijob/api/FullTimeController/getPostForBrokerInfoListPage">
                    {{each list as post}}
                        <li class="ul-li">
                            <div onclick="ijob.gotoPage({path:'/h5/zp/broker/broker_job_details?postForBroker.id={{post.id}}'})">
                                <div class="hd-txt">
                                    <div class="name">{{post.post.title}}</div>
                                    <div class="time">{{post.commission}}{{post.unit |enums:'UnitType'}}</div>
                                </div>
                                <div class="company">{{post.post.company.company}}·{{post.post.workPlace.city.cityName}}</div>
                                <div class="lab-box">
                                    {{if post.post.maxSalary==post.post.minSalary&&post.post.minSalary==0}}
                                    <span>面议</span>
                                    {{else}}
                                    <span>{{post.post.minSalary}}-{{post.post.maxSalary}}元/月</span>
                                    {{/if}}
                                    <span>招聘人数：{{post.post.recruits}}人</span>
                                </div>
                            </div>
                            <div class="foot-link">
                                <a href="tel:{{post.post.phone}}" class="contact">联系负责人</a>
                                <a href="javascript:void(0);" class="operation" onclick="ijob.gotoPage({path:'/h5/zp/broker/recommend?full.id={{post.post.id}}'})">手动推荐</a>
                                <a href="javascript:void(0);" class="share" data-title="{{post.post.title}}" data-id="{{post.post.id}}" data-company="{{post.post.company.company}}" >分享二维码</a>
                            </div>
                        </li>
                    {{/each}}
                </script>
            </ul>
        </div>
         <%-- index-list end --%>
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

                    </div>
                    <div class="code_txt">
                        <h3 id="postTitle"></h3>
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
    </div>
</div>
</body>
</html>
<script src="/ijob/static/js/index/fullIndex.js"></script>
<script src="/ijob/static/js/utf.js"></script>
<script src="/ijob/static/js/qrcode.min.js"></script>
<script src="/ijob/static/js/html2canvas.min.js"></script>
<script>

    function initFullJobBroker(){
        var page  = {"pageSize": "10", "currentPage": "1",condition:{company:$("#searchInput").val()}};
        var ijobRefresh = new IJobRefresh({
            container: '#allList',
            up: function () {
                $("#getPostForBrokerInfo").appendData(page, ijobRefresh).then(function (result) {
                    if(result.data.list.length==0){
                        mui.toast("未找到该名称相关的职位");
                    }
                    page.currentPage = result.nextPage;
                    var slide = null;
                    $(".share").click(function () {
                        $(".share_code_code").show();
                        slide = new Slide($(".wrap"),$(".share_code_code"),".mainlist");
                        slide.disTouch();
                        initQrcode($(this).data("id"),$(this).data("title"),$(this).data("company"));
                    });
                    // 点击空白处隐藏选项
                    $("body>*").on('click', function (e) {
                        if ($(e.target).hasClass('share_code_code')) {
                            $(".share_code_code").hide();
                            slide.ableTouch();
                        }
                    });
                    $(".down-box .icon-shanchu1").click(function () {
                        $(".share_code_code").hide();
                        slide.ableTouch();
                    });
                });
            }
        });
    }
    initFullJobBroker();
    $("#searchInput").blur(function(){
        initFullJobBroker();
    });

    function initQrcode(postID,title,company){
        console.log(company)
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
            "                        <p id=\"company\" class=\"name\"> 湖南一生科技有限公司</p>\n" +
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