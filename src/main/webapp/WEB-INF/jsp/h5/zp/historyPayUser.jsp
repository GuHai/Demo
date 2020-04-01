<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/2/18
  Time: 15:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加求职者</title>
    <jsp:include page="../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/insurance/insurance.css?version=4">
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
<div class="choose_insured">
    <div class="list-box" style="margin-top: 7px;">
        <%--最近报名的求职者--%>
        <div class="insured-inform">
            <div class="title">
                <h3>最近结算过的求职者</h3>
            </div>
            <div class="insured-box insured" id="insured">
                <ul>
                    <script type="text/html" id="loadRecentPay" data-url="/ijob/api/ApplySettlementController/loadRecentPay" >
                        {{each list as user }}
                            <li>
                                <div class="pull-left mui-input-row mui-checkbox" style="margin-top: 0.22rem">
                                    {{if user.status == 1}}
                                        <input type="checkbox" data-id="{{user.id}}" class="checkbox" {{#user.isCheck}} disabled="disabled"/>
                                    {{else}}
                                        <input type="checkbox" data-id="{{user.id}}" class="checkbox" {{#user.isCheck}}/>
                                    {{/if}}
                                </div>
                                <div class="pull-right">
                                    <div class="flex">
                                        <div class="left">
                                            <span class="name">{{user.name}}
                                                {{if user.status == 1}}
                                                    <span style="font-size: 0.3rem;margin-left: 5px;color: red">已结算</span>
                                                {{/if}}
                                            </span>
                                        </div>
                                        <span class="right"><span class="position">{{user.phoneNumber}}</span></span>
                                    </div>
                                </div>
                            </li>
                        {{/each}}
                    </script>
                </ul>
            </div>
        </div>
    </div>
    <div class="clearfix" style="clear: both;content: '';height: 1.7rem;"></div>
    <div class="foot-flex">
        <a href="javascript:void(0);" class="rules" data-url="/ijob/api/ApplySettlementController/addRecentSettleUser">完成</a>
    </div>
</div>

<script>
    $("#loadRecentPay").loadData({condition:{'scanID':ijob.storage.get("scanSettle.id")}}).then(function (result) {
        if(result.data == null || result.data.list.length == 0) {
            $("#insured").after("<div class='nodata'  class=\"hd_result\">\n" +
                "            <div class=\"icon\">\n" +
                "                <span style='color: #999;font-size: 100px;line-height: 1;' class=\"iconfont icon-jiarugouwuche00-copy-copy-copy\"></span>\n" +
                "            </div>\n" +
                "            <p  class=\"tips\">正如你所见，里面空空如也</p>\n" +
                "        </div>");
        }
        /**
         * 点击行选中事件
         */
        $("li").click(function () {
            $(this).find(".checkbox").click();
        });
        /**
         * 点击完成事件
         */
        $(".rules").click(function () {
            var list = new Array();
            var tagList = $(".checkbox");
            for (var i = 0 ; i < tagList.length ;i++){
                if($(tagList[i]).prop("checked")==true){
                    var obj = {scanID:ijob.storage.get("scanSettle.id"),salary:ijob.storage.get("scanSettle.salary"),createBy:$(tagList[i]).data("id")}
                    list.push(obj);
                }
            }
            if(list.length>0){
                $(this).btPost(JSON.stringify(list),function (result) {
                    console.log(result);
                    if(result.code == 200){
                        mui.toast("操作成功，正在返回");
                        setInterval(function () {
                            ijob.back();
                        },1000)
                    }
                });
            }else{
                var obj = {scanID:ijob.storage.get("scanSettle.id")}
                list.push(obj);
                $(this).btPost(JSON.stringify(list),function (result) {
                    console.log(result);
                    if(result.code == 200){
                        mui.toast("操作成功，正在返回");
                        setInterval(function () {
                            ijob.back();
                        },1000)
                    }
                });
            }

        });
    });
</script>
</body>
</html>
