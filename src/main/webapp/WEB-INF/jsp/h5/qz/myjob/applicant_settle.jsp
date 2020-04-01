<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/5
  Time: 15:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>申请结算</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/My_part-time/SettlementApplication.css">
    <style>
        .leisure > h3{
            font-size: 14px;
            font-weight: normal;
            font-stretch: normal;
            letter-spacing: 0px;
            color: #333333;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="wrap">
    <div  style="padding: 0 0.453rem;margin-top: 0.400rem">
        <label for="" class="amount" ><input type="number" id="applyPay" placeholder="请填写需要结算的金额"></label>
        <textarea class="textarea" name="text" id="applyReason" cols="30" rows="7" wrap="physical" maxlength="200"
                  placeholder="请填写缘由"></textarea>
        <p class="tips" id="result">0/200</p>

        <div class="details-calendar">
            <div class="box">
                <section class="date" >
                    <div class="data-head">
                        <div class="prev mui-icon mui-icon-back"></div>
                        <div class="tomon"><span class="year">2018</span>年 <span class="month">1</span>月</div>
                        <div class="next mui-icon mui-icon-forward"></div>
                    </div>
                    <ol>
                        <li>日</li>
                        <li>一</li>
                        <li>二</li>
                        <li>三</li>
                        <li>四</li>
                        <li>五</li>
                        <li>六</li>
                    </ol>
                    <ul>

                    </ul>
                </section>
            </div>
        </div>

        <div class="upload" >
            <img  id="myhead"  class="attachment" style="width: 120px; height: 111.42px" data-name="attachment" data-type="Head"
                  data-id=""
                  src="" alt=""
                  onerror="this.src='/ijob/static/images/a9.png';this.onerror=null">
        </div>

        <div class="footer_fixed">
            <div class="btnBox1">
                <input type="button" class="btn_remove" value="取消" onclick="window.history.go(-1)">
                <input type="button" class="btn_sub" value="提交" data-url="/ijob/api/ApplySettlementController/add">
            </div>
        </div>
    </div>
</div>
</body>
<jsp:include page="../../qz/base/resource.jsp"/>
<script>
    var positionID  =  "${positionID}";
    var datetime = '${workDate}'|| ijob.storage.get("settle.workDate") ;

    $("#myhead").attachment();

    var arr = ijob.getDateList(datetime);
    var myarr = [];
    $('.date').on('completionEvent', function() {
        $(".date").containDate(arr,myarr);
    });

    $(".date").on('dateClickEvent',function(event,state,dr){
        if(state){
            myarr.push(dr);
        }else{
            myarr.splice($.inArray(dr,myarr),1);
        }
    });

    dateRenderInit();

    if(positionID){
        $(".btn_sub").click(function(){
            if(myarr.length==0){
                mui.toast("请选择日期");
            }else{
                $(this).btPost({
                    "positionID":positionID,
                    "applyReason":$("#applyReason").val(),
                    "applyPay":$("#applyPay").val(),
                    "workDate":JSON.stringify(ijob.getStrFromList(myarr)),
                    "state":0,
                    "attachment":{
                        "datestr":$("input[name='attachment.datestr']").val(),
                        "path":$("input[name='attachment.path']").val(),
                        "name":$("input[name='attachment.name']").val(),
                        "type":$("input[name='attachment.type']").val(),
                        "version":$("input[name='attachment.version']").val(),
                        "id":$("input[name='attachment.id']").val(),
                        "isDeleted":$("input[name='attachment.isDeleted']").val()
                    }
                },function(data){
                    ijob.storage.set("settle",data.data);
                    ijob.gotoPage({path:'/h5/qz/myjob/settle_detail'});
                })
            }
        });
    }else{
        $(".footer_fixed").hide();
        var applyReason = '${workDate}'|| ijob.storage.get("settle.applyReason") ;
        var applyPay = '${workDate}'|| ijob.storage.get("settle.applyPay") ;
        $('#applyReason').html(applyReason);
        $("#applyPay").val(applyPay);
    }


    $('#applyReason').bind('input propertychange', function() {
        $('#result').html($(this).val().length + ' /200');
    });

</script>
</html>
