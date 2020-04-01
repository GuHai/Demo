<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/8
  Time: 16:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>已评价</title>
    <jsp:include page="../zp/base/resource.jsp"/>
</head>
<body>
<style>
    .mui-checkbox, .mui-radio{float:left;width:0.8rem;height:0.8rem;margin-top:0.666rem;}
    .mui-input-row label~input, .mui-input-row label~select, .mui-input-row label~textarea{padding-left:2px;}
    .JobV{position:fixed;z-index:9;top:0;}
    .hev-bise .hev-Br>a{width:1.733rem;}
</style>




<script type="text/html" id="mypositiontemplate" data-url="/ijob/api/PositionController/zp/getUserPositionWaitEvaluateInfo/{data.id}/isnotnull">
    <div class="JobV JobVtwo">
        <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/evaluate_no?id={data.id}'})" class="Job-i">未评价<i></i></a>
        <a href="javascript:void(0)"onclick="ijob.gotoPage({path:'/h5/zp/evaluate_yes?id={data.id}'})" class="Job-i Job-iOn">已评价<i></i></a>
    </div>
    <div class="evList">
        {{each list as been}}
            <div class="mui-input-row mui-checkbox mui-left" style="left: 0.267rem;">
                <label></label>
                <input name="checkbox" onclick="selectInfo(this)" value="{{been.evaluate.id}}" version="{{been.evaluate.version}}" type="checkbox">
            </div>
            <a onclick="ijob.gotoPage({path:'/h5/zp/evaluate_det?evaluate.id={{been.evaluate.id}}'})" class="evLbox">
                <div class="evLb-man">
                    <div class="evLb-mT">
                        <div class="evLb-qq">
                            <div class="qqbox">
                                <img src="/ijob/upload/{{been.evaluate.user.attachment | absolutelyPath}}" onerror="this.src='{{been.evaluate.user.weixin.headimgurl}}';this.onerror=null;" />
                            </div>
                            <div class="tbox">
                                <p class="tboxS">{{been.evaluate.user.realName}}</p>
                                <p>交易完成</p>
                            </div>
                        </div>
                    </div>
                    <div class="evLb-mp">{{been.evaluate.reply}}</div>
                </div>
            </a>
        {{/each}}
    </div>
    <div class="hev-bise">
        <div class="hev-BL" id="boxId">
            <div class="mui-input-row mui-checkbox mui-left" style="margin-top:-5px;width:2.133rem;">
                <label style="width:100%;">&nbsp;&nbsp;全选</label>
                <input name="checkbox1" class="checkbox1" value="Item 1" type="checkbox" style="top:0.267rem;">
            </div>
        </div>
        <div class="hev-Br">
            <a href="javascript:void(0);" onclick="deleteEvaluate(this)" data-url="/ijob/api/EvaluateController/h5/zp/deleteListEvaluate">删除</a>
        </div>
    </div>
</script>

<script>
    $("#mypositiontemplate").loadData().then(function (result) {
        //result 服务器响应过来的数据
        //全选
        $(".checkbox1").on("change", function () {
            $("input[name='checkbox']").prop('checked',$(this).prop('checked'));
        })
    });

    /**
     * 多条数据删除或者单条数据删除
     * @param arg
     */
    function deleteEvaluate(arg){
        //获得被选中的数据
        var list = $("input[name='checkbox']");
        //创建集合对象
        var array = new Array();
        //循环被选中的数据，将数据添加到集合中
        for (var i = 0 ; i < list.length;i++){
            var checked = $(list[i]);
            if(checked.prop('checked')){
                var param = {
                    "id" : checked.val(),
                    "version" : checked.attr("version")
                }
                array.push(param);
            }
        }
        //判断是否是否有选中数据
        if (array.length != 0){
            $(arg).btPost(array,function(){
                $("#mypositiontemplate").loadData().then(function (result) {
                    //result 服务器响应过来的数据
                    //全选
                    $(".checkbox1").on("change", function () {
                        $("input[name='checkbox']").prop('checked',$(this).prop('checked'));
                    })
                });
            });
        }else{
           mui.alert("当前未选中数据!");
        }
    }

</script>
</body>
</html>
