<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/31
  Time: 18:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.yskj.utils.DateUtils,com.yskj.utils.IJobUtils" %>
<html>
<head>
    <title>我的兼职</title>
    <%--<jsp:include page="../../qz/base/link.jsp"/>--%>
    <%--<jsp:include page="../../qz/base/resource.jsp"/>--%>
    <link rel="stylesheet" href="/ijob/static/css/My_part-time/My_part-time_job.css">
    <script src="/ijob/static/js/ijobbase.js?version=5"></script>
    <style>
        .foot_flex {position: fixed;width: 100%;height: 55px;z-index: 99;left: 0px;bottom: 0;background-color: #fff;text-align: center;padding: 0 0.453rem;}
        .foot_flex .set_up_btns{width: 100%;background-color: #108ee9;color: #fff;font-size: 0.48rem;height: 40px;margin: 0.213rem 0;border-radius: 0.533rem;line-height: 40px;display: block;text-align: center;}
    </style>
</head>
<body>

<div class="wrap">

    <div class="main">

        <div class="partTime" style="display: block;">

            <div class="partTime_content">

                <div class="allJob">

                    <div class="allJob_workList" style="margin-top: 0;margin-bottom: 0.267rem">
                        <script id="scanTemplate" type="text/html" data-url="/ijob/api/ApplySettlementController/findWaitRushList" data-type="POST">
                            {{each list as posi}}
                            <div class="list-container">

                                <div class="list-title">

                                    <span class="title-content">{{posi.title}}</span>

                                </div>

                                <div class="btnBox">

                                    <a href="tel:{{posi.phoneNumber}}"><input type="button" value="联系商家" class="btn_contact"></a>

                                    <input type="button" value="咨询" class="btn_advisory" onclick="ijobbase.toChat({toUserID:'{{posi.createBy}}'})">

                                    <input type="button" value="催结算" class="btn_status" data-id="{{posi.id}}" data-version="{{posi.version}}" data-url="/ijob/api/ApplySettlementController/rushSettlement">

                                </div>

                            </div>
                            {{/each}}
                        </script>

                    </div>

                </div>

            </div>

        </div>

    </div>
</div>

<footer class="foot_flex">
    <a href="javascript:void(0);" class="set_up_btns">扫码领工资</a>
</footer>
</body>
<script src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js" type="text/javascript"></script>
<script>
    $("#scanTemplate").loadData().then(function (result) {

        if(result.data == null || result.data.list.length == 0){
            $(".nodata").remove();
            $(".allJob").attr("style","height:70%");
            $(".allJob").after("<div class='nodata'  class=\"hd_result\">\n" +
                "            <div class=\"icon\">\n" +
                "                <span style='color: #999;font-size: 100px;line-height: 1;' class=\"iconfont icon-jiarugouwuche00-copy-copy-copy\"></span>\n" +
                "            </div>\n" +
                "            <p  class=\"tips\">正如你所见，里面空空如也</p>\n" +
                "        </div>");
        }
        $(".btn_status").on("click",function () {
            var obj = {
                id:$(this).data("id"),
                version:$(this).data("version"),
                isRush:true
            }
            $(this).btPost(obj,function (result) {
                if(result.code==200){
                    mui.alert("已催结算！");
                }else {
                    mui.alert(result.msg);
                }
            });
        });
        $(".set_up_btns").unbind().click(function(){
            $.getJSON("/ijob/api/WeixinController/getJSAuthSignature?url="+window.location.href,function(data){
                wx.config({
                    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                    appId: data.data.appId, // 必填，公众号的唯一标识
                    timestamp: data.data.timestamp, // 必填，生成签名的时间戳
                    nonceStr: data.data.noncestr, // 必填，生成签名的随机串
                    signature: data.data.signature,// 必填，签名
                    jsApiList: ["scanQRCode"] // 必填，需要使用的JS接口列表
                });
            })

            wx.ready(function () {
                wx.scanQRCode({
                    needResult: 0, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
                    scanType: ["qrCode","barCode"], // 可以指定扫二维码还是一维码，默认二者都有
                    success: function (res) {
                        var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                    }
                });
            });


        });
    });
</script>

</html>
