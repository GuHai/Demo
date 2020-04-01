<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/23
  Time: 14:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="qz/base/resource.jsp"/>
    <jsp:include page="qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/examine.css?version=4">
    <title>审核</title>
    <style>
        .urlclick{
            display: block!important;
            margin-top: 5px!important;
            background-color: #f2f5f7!important;
            color: #666!important;
            text-align: right!important;
            font-size: .35rem!important;
            text-decoration: underline!important;
            width: 100%!important;
            border:0!important;
        }
    </style>
</head>
<div class="wrap">
    <input type="hidden" id="status" value="${workList.status}">
    <div class="handle hand-bar" >
        <h4 class="title">${workList.title}</h4>
        <ul class="step">
            <li class="normal current">
                <sub></sub>
                <div class="txt">
                    <p>提交</p>
                    <p>${workList.getCreateTimeLocal()}</p>
                </div>
            </li>
            <li class="normal current">
                <sub></sub>
                <div class="hr"></div>
                <div class="txt">
                    <p>审核<span style="color: ${workList.status==1?'#108ee9':(workList.status==2?'#3bff30':'#ff3b30')}">（${workList.getStatusCN()}）</span></p>
                    <p>${workList.getUpdateTimeLocal()}</p>
                    <p class="reason">${workList.msg}</p>
                </div>
            </li>
        </ul>
    </div>
</div>
<div id="examinepage">
</div>
<div class="btnBox">
    <div class="btn-input-button">
        <input type="button" class="fail"   value="不通过">
        <input type="button" class="pass"   value="通过" data-url="/ijob/api/WorklistController/approval">
    </div>
    <input type="button" id="payAgainBtn" onclick="ijob.gotoPage({path:'/h5/examinelist'})" class="urlclick" value="查看其他待审核记录？" style="display: block;margin-top: 5px;" >

</div>
<body>
<script>
    $(document).ready(function(){
        $("#examinepage").loadPage({'${req}':'${url}'});

        var worklist = {
            id:'${workList.id}',
            version:'${workList.version}',
            refID:'${workList.refID}',
            createBy:'${workList.createBy}'
        };

        $(".pass").on("click",function(){
            var param = $.extend(worklist,{status:2});
            approval(param);
        });

        function approval(obj){
            if($("#status").val()==1){
                $(".pass").btPost(obj,function(result){
                    //执行回调
                    $(".pass").btPost('${workList.callback}',JSON.stringify(obj),function(result1){
                        alert(result1.msg);
                        window.location.reload();
                    });
                });
            }else{
                mui.toast("该订单已经审核过了，请勿重复审核");
            }

        }

        $(".fail").on("click",function () {

            var btnArray = [ '取消','拒绝'];
            mui.prompt('请输入拒绝理由：', '拒绝的原因', '提示信息', btnArray, function(e) {
                var msg = e.value;
                if (e.index == 1) {
                    var param = $.extend(worklist,{msg:msg,status:3});
                    approval(param);
                }
            });
        });
    });

</script>
</body>
</html>
