<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/9
  Time: 9:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"    import="com.yskj.service.base.DictCacheService"  %>
<html>
<head>
    <title>扫描选择日期</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <style>
        .modal-container{padding: 0 0.453rem;}
        .modal-container .flex_list{display: flex;justify-content: space-between; padding: 0.267rem 0;}
        .modal-container .flex_list .title{color: #333;font-size: 13px;}
        .modal-container .flex_list .icon span{color: #666;font-size: 11px; position: relative;width: 58px;display: inline-block;text-align: center;}
        .modal-container .flex_list .icon span:before{position: absolute;content: '';width: 15px;height: 15px;border-radius: 100%;left: 0;top: 2px;}
        .modal-container .flex_list .icon .noselect:before{ background-color: #addeff;}
        .modal-container .flex_list .icon .selected:before{ background-color: #108ee9; }
        .modal-container .date>ol{background: #fff;}
        .modal-container .date>ul{background: #fff;}
        .modal-container .data-head .prev{text-align: left;}
        .modal-container .data-head .next{text-align: right;}
        .modal-container .date>ul>li em {position: absolute;top: -0.2rem;color: #ff3b30;right: -10px;font-size: 0.32rem;}
        #submitBtn{ position: fixed;bottom: 0;background-color: #108ee9;font-size: 18px;color: #fff;text-align: center;width: 100%;display: inline-block;border: 0;height: 50px;}
        .details-calendar .date>ol{background-color: #fff}
        .details-calendar .date>ul{background-color: #fff}
        .details-calendar .date>ul>.act_wk{color: #333}
        .date>ul>.act_wk.act_date{color:#fff}
    </style>
</head>
<body>
<div class="wrap">
    <div class="modal-container">
        <div class="flex_list">
            <div class="title">工作日期</div>
            <div class="icon">
                <span class="noselect">可选</span>
                <span class="selected">已选</span>
            </div>
        </div>
        <div class="details-calendar">
            <div class="box">
                <section class="date" data-editable="true">
                    <div class="data-head">
                        <div class="prev mui-icon mui-icon-back"></div>
                        <div class="tomon"><span class="year">2018</span>年 <span class="month">3</span>&nbsp;&nbsp;&nbsp;&nbsp;月
                        </div>
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
                    <ul id="jobDate">

                    </ul>
                </section>
            </div>
        </div>
    </div>
<button id="submitBtn" data-url="/ijob/api/PositionController/addJump">提交</button>
</div>
</body>
<jsp:include page="../../qz/base/resource.jsp"/>
<script src="/ijob/static/js/ijobbase.js"></script>
<script>
    ijobbase.checkSubscribe();
    var positionID = ijob.storage.get("position.id")||"bfc1c67ffd0146e7b1453b7b42ac558d";
    jQuery.getJSON("/ijob/api/PositionController/getSimple/"+positionID,function(result){
        var datetime = result.data.workDate;
        var mydatetime = '';
        var arr = ijob.getDateList(datetime);
        var arrnum = ijob.getDatePersonList(datetime);
        var myarrtemp = ijob.getDateList(mydatetime);
        var myarr = [];
        var validarr = [];
        for(var i in myarrtemp){
            var d = myarrtemp[i];
            if(ijob.abledDate(d)){
                myarr.push(d);
            }
        }
        $('.date').on('completionEvent', function() {
            $(".date").containDate(arr,myarr);
            $(".date").remainder(arrnum);
        });

        $(".date").on('dateClickEvent',function(event,state,dr){
            if(state){
                myarr.push(dr);
            }else{
                myarr.splice($.inArray(dr,myarr),1);
            }
        });
        dateRenderInit(arr);
        $("#submitBtn").click(function(){
            if(checkSignUp()){
                var obj  = {
                    positionID:positionID,
                    workDate:JSON.stringify(ijob.getStrFromList(myarr))
                };
                $(this).btPost({type:"01",json:JSON.stringify(obj)},function(result){
                    ijob.gotoPage({url:'${site}/share/QD/'+result.data.id});
                });
            }
        });

        function checkSignUp() {
            var str = "";
            validarr = [];
            for (var i in myarr) {
                var d = myarr[i];
                if (ijob.abledDate(d)) {
                    validarr.push(d);
                }
            }
            if (validarr.length == 0) str += "请选择有效的工作日期<br>";
            if (str) {
                mui.toast(str);
                return false;
            }
            return true;
        }
    });
    $(".modal-mask").show();



</script>
</html>
