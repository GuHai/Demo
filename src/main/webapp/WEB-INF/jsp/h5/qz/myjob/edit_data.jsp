<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/4
  Time: 11:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改工作日期</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/index/Part-timeDetails.css?version=4">
</head>
<body>

<div class="wrap">
    <div class="main">
        <div class="dataList">
            <div class="title">
                <div class="txt">工作日期</div>
                <div class="tips">
                    <span class="selectable">可选</span>
                    <span class="selected">已选</span>
                </div>
            </div>
            <div class="details-calendar">
                <div class="box">
                    <section class="date" data-editable="true">
                        <div class="data-head">
                            <div class="prev mui-icon mui-icon-back"></div>
                            <div class="tomon"><span class="year"></span>年 <span class="month"></span>月</div>
                            <div class="next mui-icon mui-icon-forward"></div>
                        </div>
                        <ol>
                            <li>周日</li>
                            <li>周一</li>
                            <li>周二</li>
                            <li>周三</li>
                            <li>周四</li>
                            <li>周五</li>
                            <li>周六</li>
                        </ol>
                        <ul >
                        </ul>
                    </section>
                </div>
            </div>
        </div>
        <div class="edit_foot foot">
            <a href="javscript:void(0);" onclick="ijob.reback('返回');" class="cancel">取消</a>
            <a href="javscript:void(0);" class="confirm" data-url="/ijob/api/BeenrecruitedController/updateWorkDate">确认修改</a>
        </div>
    </div>
</div>
</body>
<jsp:include page="../../qz/base/resource.jsp"/>

</html>
<script>

    var id = ijob.storage.get("been.id");
    var version = ijob.storage.get("been.version");
    var positionID = ijob.storage.get("been.positionID");
    $.getJSON("/ijob/api/BeenrecruitedController/get?id="+id,function (result){
        var datetime = result.data.workDate;
        var alldatetime = result.data.position.workDate;
        var myarr = ijob.getDateList(datetime);
        var arr = ijob.getDateList(alldatetime);
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
        dateRenderInit(arr);


        $(".confirm").unbind();
        $(".confirm").click(function(){
            var _this  = $(this);
            var validarr= [];
            for(var i in myarr){
                var d = myarr[i];
                if(ijob.abledDate(d)){
                    validarr.push(d);
                }
            }
            if(validarr.length>0){
                _this.btPost({positionID:positionID,id:id,version:version,workDate:JSON.stringify(ijob.getStrFromList(validarr))},function(result2){
                    ijob.reback(result2.msg);
                });
            }else{
                mui.toast("请选择有效的工作日期");
            }

        });
    });

</script>
