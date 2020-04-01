<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/8
  Time: 10:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <title>待结算</title>
    <jsp:include page="../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/part/newAccount.css?version=4">
    <style>
        .wrap .main .accountsList .account-list-ul .posi-list .head-flex .mui-switch.mui-active:before {
            content: '开放中';
            left: 0.133rem;
        }
        .wrap .main .accountsList .account-list-ul .posi-list .head-flex .mui-switch:before{
            content: '关闭';
        }
    </style>
</head>
<body>
<script>
    (function ($) {
        window.addEventListener('pageshow', function (e) {
            // 通过persisted属性判断是否存在 BF Cache
            if (e.persisted) {
                location.reload();
            }
        });
    })(mui);
</script>
<div class=wrap>
    <ul class="tabList" style="display:none">
        <li class="active"><a href="javascript:void(0);">待结算</a></li>
        <li class=""><a href="javascript:void(0);">已结算</a></li>
    </ul>
    <div class="main">
        <div class="datalist">
            <div class="accountsList">
                <%--没有待结算数据--%>
                <div class="nullContent" style="display: none;">
                    <div class="txt">
                        创建领工资二维码后，求职者扫描二维码，招聘者即可在此页面给求职者批量发放工资，赶紧试试吧！
                    </div>
                    <div class="foundbutton">
                        <a href="javascript:void(0);" class="found_btns">创建领工资二维码</a>
                    </div>
                </div>
                 <%--待结算信息列表    --%>
                <div class="account-list-ul wait-list" style="margin-top: 0;">
                    <ul class="clearfix">
                        <script type="text/html" id="djstemplate" data-url="/ijob/api/ApplySettlementController/getQrcodeDJSInfo" >
                            {{each list as posi}}
                            <li class="posi-list">
                                <div class="head-flex">
                                    <div class="title">{{posi.title}}</div>
                                    <div class="mui-switch {{if posi.open == true}} mui-active {{/if}}" data-id="{{posi.id}}" data-version="{{posi.version}}" data-url="/ijob/api/ApplySettlementController/updateScanSettle">
                                        <div class="mui-switch-handle"></div>
                                    </div>
                                </div>
                                    <div class="inform-list">
                                        {{if posi.scanSettleMemberList != null && posi.scanSettleMemberList.length != 0 &&posi.scanSettleMemberList!=[]}}
                                            <ul class="ul-list">
                                                {{each posi.scanSettleMemberList as imgObj}}
                                                    {{if imgObj.id != null}}
                                                        <li>
                                                            {{if imgObj.createBy != null}}
                                                            <img src="/ijob/upload/{{imgObj.user.attachment |absolutelyPath}}"onerror="this.src='{{imgObj.user.weixin.headimgurl}}';this.onerror=null;" >
                                                            {{else}}
                                                            <img src="/ijob/static/images/default.jpg" >
                                                            {{/if}}
                                                        </li>
                                                    {{/if}}
                                                {{/each}}
                                            </ul>
                                        {{/if}}
                                    </div>
                                <div class="edit-btns">
                                    <div class="left" data-url="/ijob/api/ApplySettlementController/deleteScanSettle/{{posi.id}}">
                                        <span class="iconfont icon-shanchu2"></span>
                                        <i>删除</i>
                                    </div>
                                    <div class="right">
                                        <a href="javascript:void(0);" class="addUser" onclick="ijob.gotoPage({path:'/h5/zp/historyPayUser?scanSettle.id={{posi.id}}&scanSettle.salary={{posi.dailySalary}}'})">添加求职者</a>
                                        <a href="javascript:void(0);" class="share-btn" data-code="{{posi.code}}" data-salary="{{posi.dailySalary}}" data-title="{{posi.title}}">分享二维码</a>
                                        {{if  posi.scanSettleMemberList!=null && posi.scanSettleMemberList.length >0 && posi.scanSettleMemberList[0].id!=null}}
                                            <a href="javascript:void(0);" class="salary-btn" onclick="ijob.gotoPage({path:'/h5/zp/Settlement?scanSettle.id={{posi.id}}'})">发工资</a>
                                        {{/if}}
                                    </div>
                                </div>
                            </li>
                            {{/each}}
                            <div class="cleafix" style="overflow: hidden;height: 1.567rem;"></div>
                            <%--底部  创建领工资二维码--%>
                            <footer class="foot_flex">
                                <a href="javascript:void(0);" class="set_up_btns">创建领工资二维码</a>
                            </footer>
                        </script>
                    </ul>
                </div>
            </div>
            <%--已结算数据列表--%>
            <%--<div class="accountsList" style="display: none">
                <div class="account-list-ul">
                    <ul class="clearfix">
                        <script type="text/html" id="yjstemplate" data-url="/ijob/api/ApplySettlementController/getQrcodeYJSInfo" >
                            {{each list as posi}}
                                <li class="posi-list">
                                    <div class="head-flex">
                                        <div class="title">{{posi.title}}</div>
                                        <div class="time">{{posi.updateTime |dateFormat:'yyyy年MM月dd日'}}&nbsp;&nbsp;<span>{{posi.updateTime |dateFormat:'hh:mm'}}</span></div>
                                    </div>
                                    <div class="inform-list">
                                        {{if posi.scanSettleMemberList != null && posi.scanSettleMemberList.length != 0 &&posi.scanSettleMemberList!=[]}}
                                        <ul class="ul-list">
                                            {{each posi.scanSettleMemberList as imgObj}}
                                            <li>
                                                <img src="{{imgObj.user.attachment |absolutelyPath}}"onerror="this.src='{{imgObj.user.weixin.headimgurl}}';this.onerror=null;" >
                                            </li>
                                            {{/each}}
                                        </ul>
                                        {{/if}}
                                    </div>
                                    <div class="edit-btns">
                                        <a href="javascript:void(0);" class="moreview" onclick="ijob.gotoPage({path:'/h5/zp/accounts_end_details?scanSettle.id={{posi.id}}'})">查看详情</a>
                                    </div>
                                </li>
                            {{/each}}
                        </script>
                    </ul>
                </div>
            </div>--%>
        </div>

        <%--创建领工资二维码--%>
        <div class="found_code_content" style="display: none;">
            <div class="code_list">
                <div class="title">创建领工资二维码</div>
                <div class="select_posi">
                    <span class="txt">选择职位</span>
                    <a href="javascript:void(0);" class="now_posi">选择现有职位<span class="iconfont icon-arrow-right"></span></a>
                </div>

                <div class="input-list">
                    <form id="position">
                        <input type="hidden" name="positionID" id="positionID">
                        <div class="row-input">
                            <input type="text" id="posi-name" name="title" placeholder="职位名称">
                        </div>
                        <div class="row-input">
                            <input type="number" id="salary" name="dailySalary" placeholder="预计薪资（元）/人">
                        </div>
                    </form>
                </div>
                <div class="btns">
                    <a href="javascript:void(0);" class="cancel-btn">取消</a>
                    <a href="javascript:void(0);" class="confirm-btn" data-url="/ijob/api/ApplySettlementController/addScanSettle" >确认</a>
                </div>
            </div>
        </div>
        <div class="typediv">
            <div class="posi_box_list" style="display: none;">
                <div class="posi_cocntent">
                    <ul class="ul-select">
                        <script type="text/html" id="jobtemplate"  data-url="/ijob/api/PositionController/h5/mine/findMyPositionList" data-type="GET">
                            {{each list as posi}}
                            <li data-value="{{posi.id}}" data-salary="{{posi.dailySalary}}">{{posi.title}}</li>
                            {{/each}}
                        </script>
                    </ul>
                </div>
            </div>
        </div>
        <%--分享二维码--%>
        <div class="share_code_code" style="display: none">
            <div class="mainlist">
                <div class="posi_box_list">
                    <div class="areaContent">
                        <h3 class="posi_tit"><span id="positiontitle"></span>  <span id="dailySalary"></span></h3>
                        <%--<div class="posi_date posi_sub">工作日期：<span id="recruitStartTime"></span></div>
                        <div class="posi_num posi_sub">招聘人数：<span id="recruitsSum"></span>人/天</div>
                        <div class="posi_addr posi_sub">工作地点：<span id="city"></span></div>--%>
                    </div>
                    <%--<div class="areaContent">
                        <h3 class="posi_depict">职位描述：</h3>
                        <div class="posi_detail">
                            这里是职位描述，多少个字符之后就是省略号！这里是职位描述，多少个字符之后就是省略号！这里是职位描述，多少个字符之后就是省略号！这里是职位描述，多少个字符之后就是省略号...
                        </div>
                    </div>--%>
                </div>
                <div class="code_box">
                    <div class="code_img" id="qrcodeimg" >

                    </div>
                    <div class="code_txt">
                        <h3 id="typetext">扫码即可领工资</h3>
                        <p>长按图片发送给朋友</p>
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
    </div>
    <div id="homepage"></div>
</div>
</body>
<script src="/ijob/static/js/utf.js"></script>
<script src="/ijob/static/js/qrcode.min.js"></script>
<script src="/ijob/static/js/html2canvas.min.js"></script>
<script>

    $("#homepage").freshPage({path:"/h5/homepage"});
ijob.storage.set("isReload",true);
// div切换
$(".tabList>li").on("click", function () {
    var index = $(this).index();
    $(this).addClass("active").siblings().removeClass("active");
    $(".main .datalist>div").eq(index).show().siblings().hide();
    if(index == 0){
        initDjs();
    }else {
        initYjs();
    }
})
function initDjs(){
    $("#djstemplate").loadData().then(function (result) {
        if(!(result.data&&result.data.list&&result.data.list.length > 0)){
            $(".nodata").remove();
        }

        var slide = null;

        /*
        开启或者关闭快捷结算通道
        */
        $(".mui-switch").click(function(){
            var flag = $(this).hasClass('mui-active');
            var scanSettle = {
                version : $(this).data("version"),
                id : $(this).data("id")
            }
            var _this = $(this);
            if(flag==true){
                scanSettle.open = true ;
                $(this).btPost(scanSettle,function(result){
                    if (result.code == 200){
                        // _this.removeClass('mui-active');
                        _this.data("version",result.data.version);
                    }else{
                        _this.toggleClass("mui-active");
                    }
                });
            }else{
                scanSettle.open = false ;
                $(this).btPost(scanSettle,function(result){
                    if (result.code == 200){
                        // _this.addClass('mui-active');
                        _this.data("version",result.data.version);
                    }else{
                        _this.toggleClass("mui-active");
                    }
                });
            }

        });

        /*创建领工资二维码*/
        $(".found_btns,.set_up_btns").click(function (e) {
            $(".found_code_content").show();
            slide = new Slide($(".wrap"),$(".found_code_content"),".code_list");
            slide.disTouch();
        });
        // 取消创建领工资二维码
        $(".cancel-btn").on('click', function (e) {
            $(".found_code_content").hide();
            slide.ableTouch();
        });
        // 点击空白处隐藏选项
        $("body>*").on('click', function (e) {
            if ($(e.target).hasClass('found_code_content')) {
                $(".found_code_content").hide();
                slide.ableTouch();
            }
        });


        // 选择现有职位
        $(".now_posi").click(function (e) {
            $(".posi_box_list").show();
            slide = new Slide($(".wrap"),$(".posi_box_list"),".posi_cocntent");
            slide.disTouch();
            if($(".ul-select li").length==0){
                $("#jobtemplate").loadData();
            }
        });

        $(".ul-select").on('click','li',function(e){
            var _this = $(this);
            $(".now_posi").html(_this.text()+"<span class=\"iconfont icon-arrow-right\"></span>");
            _this.css("color", "#108ee9").siblings().css("color", "#666");
            $("#positionID").val(_this.data("value"));
            $("#posi-name").val(_this.text());
            $("#salary").val(_this.data("salary"));
            $(".posi_box_list").hide();
            slide.ableTouch();
        });

        // 点击空白处隐藏选项
        $("body>*").on('click', function (e) {
            if ($(e.target).hasClass('posi_box_list')) {
                $(".posi_box_list").hide();
                slide.ableTouch();
            }
        });
        // 判断职位名称
        $("#posi-name").keyup(function () {
            var len = $(this).val().length;
            if(len > 15){
                mui.toast("不能超过15字符!");
            }
        });
        var index = 1;
        $(".confirm-btn").on("click", function () {
            var val = $("#posi-name").val();
            var reg = /^(([1-9][0-9]*)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/
            if (val.trim() == ""){
                mui.alert( "职位名称不能为空");
            }else if($("#posi-name").val().length > 15){
                mui.alert( "职位名称太长！不能超过十五个字！");
            }else if(!reg.test($("#salary").val())){
                mui.alert("请填写正确的工资！");
            }else if($("#salary").val().trim() == ""){
                mui.alert( "预计薪资不能为空");
            }else if($("#salary").val().length > 7){
                mui.alert( "预计薪资不能超过七位数！");
            }else {
                if($("#salary").val()<0){
                    $("#salary").val(-$("#salary").val());
                }
                if(index == 1){
                    index++ ;
                    $(this).btPost($("#position").serializeObjectJson(),function (result) {
                        location.reload();
                    })
                }
            }
        });

        //删除职位
        $(".edit-btns .left").click(function(){
            var btnArray = ['否', '是'];
            var _this = $(this);
            mui.confirm('确认删除该职位？', '', btnArray, function (e) {
                if (e.index == 1) {
                    _this.btPost(null,function (result) {
                        mui.alert(result.msg,function () {
                            location.reload();
                        });
                    })
                }
            });
        });

        var slide = null;
        $(".share-btn").click(function () {
            $(".share_code_code").show();
            initQrcode($(this).data("code"),$(this).data("title"),$(this).data("salary"));
            slide = new Slide($(".wrap"),$(".share_code_code"),".mainlist");
            slide.disTouch();
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
        extent();
        length();
    });
}
// 待结算是否有数据存在
function extent() {
    var len = $(".wait-list .posi-list").length;
    // console.log(len);
    if (len == 0 ){
        $(".nullContent").show();
        $(".foot_flex").hide();
    }
}
// 判断求职者头像的长度
function length() {
    var num  = 9;
    $(".inform-list").each(function(i,item){
        if($(this).find(".ul-list li").length>num){
            $(this).find(".ul-list li").eq(num-1).nextAll().remove();
            $(this).find(".ul-list li:last").after("<li  class='ellipsis'>…</li>");
        }else if($(this).find(".ul-list li").length == 0){
            $(this).hide();
            $(".head-flex").css("margin-bottom","0.267rem")
        }
    });
}
/*var menu = ijob.storage.get("tab");
if(menu && menu.indexOf("yjs")!=-1 && menu.indexOf(":")!=-1){
    $(".tabList>li").eq(menu.split(":")[1]).click();
    if(menu.split(":")[1]==1){
        document.title="已结算"
    }
}else{*/
    $(".tabList>li").eq(0).click();
/*}*/


function initQrcode(code,title,salary){
    console.log(salary)
    $(".mainlist").html("<div class=\"code_txt\">\n" +
        "            <h3 id=\"typetext\">扫码即可结算</h3>\n" +
        "        </div>\n" +
        "        <div class=\"code_box\">\n" +
        "            <div class=\"code_img\" id=\"qrcodeimg\">\n" +

        "            </div>\n" +
        "        </div>\n" +
        "        <div class=\"posi_box_list\">\n" +
        "            <div class=\"areaContent\">\n" +
        "                <h3 class=\"posi_tit\"><span id=\"positiontitle\"></span></h3>\n" +
        "            </div>\n" +
        "        </div>");
    mui.toast("生成图片中...");
    $("#positiontitle").text(title);
    var urlQrcode = "${site}/share/JS/" + code;
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

function initYjs(){
    $("#yjstemplate").loadData().then(function (result) {});
}
</script>
</html>
