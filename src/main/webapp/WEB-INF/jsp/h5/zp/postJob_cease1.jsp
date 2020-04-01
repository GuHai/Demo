<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title></title>
    <jsp:include page="../zp/base/resource.jsp"/>
</head>
<body>
<script id="taskOrCommission" type="text/html"
        data-url="/ijob/api/PositionController/h5/zp/getTaskOrCommission/{positionTemp.id}/{data.type}" data-type="POST">
    {{each list as posi}}
    <div class="PostJob">
        <form name="form" action="" method="post" id="input_example">
            <input type="hidden" id="id" name="id" value="{{posi.id}}">
            <input type="hidden" id="version" name="version" value="{{posi.version}}">
            <div class="Hcease">
                {{if posi.type == 0}}
                    {{if posi.baseTask != 0 && posi.baseTask != '' && posi.baseTask != null }}
                    <textarea name="baseTask"  id="baseTask1" placeholder="请输入底薪任务">{{posi.baseTask}}</textarea>
                    {{else}}
                    <textarea name="baseTask"  id="baseTask2" placeholder="请输入底薪任务"></textarea>
                    {{/if}}
                {{else if posi.type == 1}}
                    {{if posi.commission != 0 && posi.commission != '' && posi.commission != null}}
                    <textarea name="commission"  id="commission1" placeholder="请输入绩效提成">{{posi.commission}}</textarea>
                    {{else}}
                    <textarea name="commission"  id="commission2" placeholder="请输入绩效提成"></textarea>
                    {{/if}}
                {{else if posi.type == 2}}
                    {{if posi.matters != 0 && posi.matters != '' && posi.matters != null}}
                    <textarea name="matters"  id="matters1" placeholder="请输入注意事项" >{{posi.matters}}</textarea>
                    {{else}}
                    <textarea name="matters"  id="matters2" placeholder="请输入注意事项"></textarea>
                    {{/if}}
                {{else if posi.type == 7}}
                    {{if posi.jobContent != 0 && posi.jobContent != '' && posi.jobContent != null}}
                    <textarea name="jobContent"  id="jobContent1" placeholder="请输入工作内容">{{posi.jobContent}}</textarea>
                    {{else}}
                    <textarea name="jobContent"  id="jobContent2" placeholder="请输入工作内容"></textarea>
                    {{/if}}
                {{else if posi.type == 6}}
                    {{if posi.jobRequirements != 0 && posi.jobRequirements != '' && posi.jobRequirements != null}}
                    <textarea name="jobRequirements"  id="jobRequirements1" placeholder="请输入工作要求" >{{posi.jobRequirements}}</textarea>
                    {{else}}
                    <textarea name="jobRequirements"  id="jobRequirements2" placeholder="请输入工作要求"></textarea>
                    {{/if}}
                {{else if posi.type == 8}}
                    {{if posi.controlSleep != 0 && posi.controlSleep != '' && posi.controlSleep != null}}
                    <textarea name="controlSleep"  id="controlSleep1" placeholder="请输入住房事项" >{{posi.controlSleep}}</textarea>
                    {{else}}
                    <textarea name="controlSleep"  id="controlSleep2" placeholder="请输入住房事项"></textarea>
                    {{/if}}
                {{/if}}
            </div>
            <p class="Hcease-hine" id="fontSize">0/200</p>
            <div class="hlink">
                <a href="javascript:void(0)"
                   onclick="ijob.gotoPage({path:'/h5/zp/location_tem'})"
                   class="mui-hbut-on">取消</a>
                <a href="javascript:void(0)" data-url="/ijob/api/PositionController/update" id="confirm">确定</a>
            </div>
        </form>
    </div>
    {{/each}}
</script>


<script type="text/javascript">

    $("#taskOrCommission").loadData().then(function (result) {
        $("#fontSize").text($("textarea").val().length + "/200");
    });

    $(document).on("input propertychange", 'textarea', function () {
        var len = $(this).val().length;
        $('#fontSize').text(len + '/200');
        if (len > 200) {
            $("#confirm").css({"background-color":"#999"});
        }else{
            $("#confirm").css({"background-color":""});
        }
    });
    $(document).on("tap", '#confirm', function () {
        if ($("textarea").val().length <= 200) {
            updatePosition();
        }else{
            mui.alert("工作内容过多！");
        }
    });

    function updatePosition() {
        $("#confirm").btPost(JSON.stringify($("#input_example").serializeObjectJson()), function (data) {
            ijob.gotoPage({path:"/h5/zp/location_tem"})
        });
    }

</script>


</body>
</html>


