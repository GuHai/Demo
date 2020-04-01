<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/6
  Time: 14:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的结算记录</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/My_part-time/SettlementApplication_annal.css">
    <link rel="stylesheet" href="/ijob/css/mine/chooseResume_add.css">
</head>
<body>
<div class="wrap">
    <div class="head-select">
        <span  id="selectAll">全选</span>
        <span  id="selectZero">反选</span>
    </div>
    <div class="listBox">
        <ul class="annalList">
            <script id="todayJob"   type="text/html"  data-url="/ijob/api/ApplySettlementController/findList/${positionID}"   >
            {{each list as apply index}}
                <li>
                    <a href="javascript:void(0);">
                        <div class="checkboxs mui-input-row mui-checkbox mui-left">
                            <label></label>
                            <input class="checkbox" name="checkbox1" value="Item 1" type="checkbox" data-version="{{apply.version}}" data-id="{{apply.id}}">
                        </div>
                        <div class="list_content" data-index="{{index}}" >
                            <div class="divSpan">
                            <span class="content_while">
                                <span class="content_day">{{apply.createTime | dateFormat:'yyyy年MM月dd日'}}</span>
                                <em class="content_time">{{apply.createTime | dateFormat:'hh-mm-ss'}}</em>
                            </span>
                                <span class="content_money">{{apply.applyPay}}元</span>
                            </div>
                            <div class="divP">
                                <p>{{apply.applyReason}}</p>
                                <p>{{apply.state | enums:'AgreeStatus'}}</p>
                            </div>
                        </div>
                    </a>
                </li>
            {{/each}}
            </script>
        </ul>
    </div>
    <div class="footer_fixed">
        <div class="btnBox1">
        <input type="button" class="btn_remove" value="删除" data-url="/ijob/api/ApplySettlementController/deleteByIds">
        <input type="button" class="btn_appeal" value="申诉">
        </div>
    </div>
</div>
</body>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>
    $("#todayJob").loadData({
        "positionID":"${positionID}"
    }).then(function (result) {
        //申述按钮点击事件
        $(".listBox").on("click",".list_content",function(event){
            var index = $(this).data("index");
            ijob.storage.set("settle",result.data.list[index]);
            ijob.gotoPage({path:'/h5/qz/myjob/settle_detail'});
        });
        $(".btn_appeal").click(function () {
            //选择了才能点击
            var len = $(".annalList").find("input[type='checkbox']:checked").length;
            if(len==0){
                mui.toast("请选择至少一条需要申诉的结算申请项");
            }else{
                window.location.href = '/ijob/api/AppealhandleController/${positionID}';
            }
        });
    });



    $("#selectAll").click(function(){
        $(".annalList").find("input[type='checkbox']").each(function(i,item){
            $(this).prop("checked",true);
        });
    });

    $("#selectZero").click(function(){
        $(".annalList").find("input[type='checkbox']").each(function(i,item){
            $(this).attr("checked", false);
        });
    });


    $(".btn_remove").click(function(){
        var len = $(".annalList").find("input[type='checkbox']:checked").length;
        if(len==0){
            mui.toast("请选择至少一条需要申诉的结算申请项");
        }else{
            var appeals = [];
            $(".annalList").find("input[type='checkbox']:checked").each(function(i,item){
                appeals.push({id:$(this).data("id"),version:$(this).data("version")});
            });
            $(this).btPost(appeals);
        }
    });
</script>
</html>
