<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/13
  Time: 11:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>经纪人设置</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/fullTime/fullTime.css?version=4">
</head>
<body>
<div class="full-broker-set">
    <script id="postForBroker" type="text/html" data-url="/ijob/api/FullTimeController/getPostForBrokerInfo/{post.id}">
        <div class="input-row">
            <div class="txt">佣金金额</div>
            <div class="input">
                <input type="number" class="money" name="money"oninput="if(value.length>7)value=value.slice(0,7)" placeholder="请输入金额" value="{{list[0].commission}}">
            </div>
            <div class="time" id="time">
            <span class="education1">
                <span id="xueli">{{list[0].unit |enums:'UnitType'}}</span>
                <i class="iconfont icon-arrow-right"></i>
            </span>
            </div>
        </div>
        <input type="hidden" value="{{list[0].unit}}" id="unit">
        <div class="details-main">
            <div class="txt">经纪人注意事项</div>
            <div class="row-content">
                <textarea class="textarea" name="textarea" id="textarea"></textarea>
            </div>
        </div>
        <div class="footbox">
            <a href="javascript:void(0);" class="btns" data-url="/ijob/api/FullTimeController/updatePostForBrokerInfo">完成</a>
        </div>
    </script>
</div>
</body>
</html>
<script>
    $("#postForBroker").loadData().then(function (result) {

        if(result.data.list[0].attention!=null&&result.data.list[0].attention!=""&&result.data.list[0].attention!=undefined){
            $("#textarea").val(result.data.list[0].attention);
        }

        $("#textarea").each(function() {
            $(this).focus(function() {
                //获得焦点时，如果值为默认值，则设置为空
                if ($("#textarea").val().indexOf("请输入经纪人注意事项")==0) {
                    this.value = "";
                }
            });
            $(this).blur(function() {
                //失去焦点时，如果值为空，则设置为默认值
                if (this.value == "") {
                    var placeholder = '请输入经纪人注意事项，建议使用短句并分条列出，如下： \n佣金结算:\n1，推荐的员工工作满7天后开始结算 \n2，结算6个月 \n3，每月20日结算上个月的费用。 \n4，......';
                    $("#textarea").html(placeholder);
                    var content=$("#textarea").val().replace(/\n/g,"<br/>");
                }
            });
        });
        testabc();

        //选择类型
        var picker1 = new mui.PopPicker();
        picker1.pickers[0].setSelectedIndex(result.data.list[0].unit-1);
        picker1.setData([{
            text: '元/小时',
            value: '1'
        }, {
            text: '元/月',
            value: '2'
        }, {
            text: '元/人',
            value: '3'
        }]);
        $(document).on('tap', "#time", function (event) {
            picker1.show(function (items) {
                $("#xueli").html(items[0].text);
                $("#unit").val(items[0].value);
            });
        });

        $(".footbox .btns").click(function () {
            var postForBroker = {
                commission:$(".money").val(),
                unit:$("#unit").val(),
                postID:ijob.storage.get("post.id")
            }
            if($("#textarea").val().trim(" ")!=""&&$("#textarea").val()!=null){
                postForBroker.attention = $("#textarea").val().trim(" ");
            }
            if ($(".money").val() == null ||$(".money").val() ==""||$(".money").val() == undefined){
                mui.alert("请输入金额");
            }else {
                $(".btns").btPost(postForBroker,function (result) {
                    if(result.code==200){
                        mui.toast("操作成功,正在返回...");
                        setTimeout(function(){
                            ijob.gotoPage({path:'/h5/zp/fullTime/fullRecruiting'});
                        },1000);
                    }else{
                        mui.toast("服务器繁忙");
                    }
                })

            }
        })
    });
    function testabc(){
        var placeholder = '请输入经纪人注意事项，建议使用短句并分条列出，如下： \n佣金结算:\n1，推荐的员工工作满7天后开始结算 \n2，结算6个月 \n3，每月20日结算上个月的费用。 \n4，......';
        $("#textarea").html(placeholder);
        var content=$("#textarea").val().replace(/\n/g,"<br/>");
    }
</script>