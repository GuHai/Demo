<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/29
  Time: 16:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8"   import="com.yskj.service.base.DictCacheService"%>
<div class="row">
    <div class="col-12">
        <!--账单表格-->
        <div class="table-list"  style="overflow:hidden;max-height:100%">
            <div class="main-body">
                <table class="table">
                    <thead>
                    <tr>
                        <th>订单名称</th>
                        <th>总笔数</th>
                        <th>总金额</th>
                        <th>时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <script id="getMyHistoryPayInfo" type="text/html" data-url="/ijob/api/ApplySettlementController/getMyHistoryPayInfo" data-type="POST" >
                        {{each list as scan}}
                        <tr class="trbox">
                            <td>{{scan.title}}</td>
                            <td>{{scan.count}}</td>
                            <td>{{scan.sum}}</td>
                            <td>{{scan.time}}</td>
                            <td>
                                <a href="javascript:void(0);" style="{{scan.wait==0?'pointer-events:none;background-color:#e0a7a5':''}}"  onclick="loadPageByUrl('guanwang/salary?data.againID={{scan.id}}')" class="continue btns atag" data-id="{{scan.id}}">{{scan.wait==0?'支付完成':'继续支付'}}</a>
                                <a href="javascript:void(0);" onclick="loadPageByUrl('guanwang/view?data.scanID={{scan.id}}')" class="view-details btns atag" data-id="{{scan.id}}">查看详情</a>
                                <a href="javascript:void(0);" class="export btns" data-id="{{scan.id}}"  data-name="{{scan.title}}">导出表格</a>
                                <a href="javascript:void(0);"data-url="/ijob/api/ApplySettlementController/deleteSalaryInfo/{{scan.id}}" class="continue btns delete">删除</a>

                            </td>
                        </tr>
                        {{/each}}
                    </script>
                    </tbody>
                </table>
            </div>
        </div>
        <!--账单表格 end-->
    </div>
</div>
<script>
    function init(){
        $("#getMyHistoryPayInfo").loadData().then(function(result){
            $(".delete").click(function () {
                $(this).btPost(null,function (result) {
                    if(result.code==500){
                        alert(result.msg);
                    }else {
                        init();
                    }
                })
            });
            $(".nodata").remove();
        });
    }

    init()

    /*导出表格*/
    $(".table").on('click','.export',function(){
        window.open("/ijob/api/ApplySettlementController/importPayInfo/"+$(this).data("id")+"/"+$(this).data("name"));
    });
</script>
