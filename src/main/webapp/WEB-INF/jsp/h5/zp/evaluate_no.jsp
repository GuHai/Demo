<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/8
  Time: 16:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>未评价</title>
    <jsp:include page="../zp/base/resource.jsp"/>
</head>
<body>
<style>
    .mui-checkbox, .mui-radio {
        float: left;
        width: 0.8rem;
        height: 0.8rem;
        margin-top: 0.666rem;
    }

    .mui-input-row label ~ input, .mui-input-row label ~ select, .mui-input-row label ~ textarea {
        padding-left: 2px;
    }

    .JobV {
        position: fixed;
        z-index: 9;
        top:0;
    }

    .hev-bise .hev-Br > a {
        width: 1.733rem;
    }
</style>


    <div class="JobV JobVtwo">
        <a href="javascript:void(0)" onclick="ijob.gotoPage({path:'/h5/zp/evaluate_no?id={data.id}'})" class="Job-i Job-iOn">未评价<i></i></a>
        <a href="javascript:void(0)" onclick="ijob.gotoPage({path:'/h5/zp/evaluate_yes?id={data.id}'})" class="Job-i">已评价<i></i></a>
    </div>
    <div class="evList">
        <script type="text/html" id="mypositiontemplate" data-url="/ijob/api/PositionController/zp/getUserPositionWaitEvaluateInfo/{data.id}/isnull">
        {{each list as beenrecruited}}
            <a href="javascript:void(0)"class="evLbox">
                <div class="mui-input-row mui-checkbox mui-left">
                    <label></label>
                    <input name="checkbox" value="Item 1" type="checkbox">
                </div>
                <div class="evLb-man">
                    <div class="evLb-mT">
                        <div class="evLb-qq">
                            <div class="qqbox">
                                <img src="/ijob/upload/{{beenrecruited.evaluate.user.attachment | absolutelyPath}}" onerror="this.src='{{beenrecruited.evaluate.user.weixin.headimgurl}}';this.onerror=null;" />
                            </div>
                            <div class="tbox">
                                <p class="tboxS">{{beenrecruited.evaluate.user.realName}}</p>
                                <p>交易完成</p>
                            </div>
                        </div>
                        <span class="evLb-link">
                           <%-- {{beenrecruited.evaluate.reply!=null?'已评价':'待评价'}}--%>
                            {{if beenrecruited.evaluate.reply!=null && beenrecruited.evaluate.reply!=''}}
                                已评价
                            {{else}}
                                <span onclick="ijob.gotoPage({path:'/h5/zp/evaluate?been.id={{beenrecruited.id}}&been.positionID={{beenrecruited.positionID}}&been.userID={{beenrecruited.evaluate.userID}}&been.evaluateId={{beenrecruited.evaluate.id}}&been.evaluateVersion={{beenrecruited.evaluate.version}}'})" >待评价</span>
                            {{/if}}
                        </span>
                    </div>
                    <div class="evLb-mp" >{{beenrecruited.evaluate.evaluateContent | substr:'20'}}</div>
                </div>
            </a>
        {{/each}}
        </script>
    </div>
    <div class="hev-bise">
        <div class="hev-BL" id="boxId">
            <div class="mui-input-row mui-checkbox mui-left" style="margin-top:-5px;width:2.133rem;">
                <label style="width:100%;">&nbsp;&nbsp;全选</label>
                <input name="checkbox1" class="checkbox1" value="Item 1" type="checkbox" style="top:0.267rem;">
            </div>
        </div>
        <div class="hev-Br">
            <a href="javascript:void(0);">删除</a>
        </div>
    </div>

</body>
</html>
<script>
    $("#mypositiontemplate").loadData().then(function (result) {
        //result 服务器响应过来的数据
        //全选
        $(".checkbox1:first").on("click", function () {
            var flag = $(this).prop('checked');
            $(".evList input[name='checkbox']").each(function(i,item){
                $(item).prop("checked", flag);
            });
        })
    });
</script>
