<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/29
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8"   import="com.yskj.service.base.DictCacheService"%>
<div class="row">
    <div class="col-12">
        <!--账单表格-->
        <div class="table-list">
            <div >
                <table class="table">
                    <thead>
                    <tr>
                        <th>序号</th>
                        <th>批次</th>
                        <th>名称</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                        <script id="inshistory" type="text/html" data-url="/ijob/api/ApiInsuranceUploadController/uploadhistory" data-type="POST" >
                            {{each list as upload index}}
                                <tr class="trbox">
                                    <td>{{index+1}}</td>
                                    <td>{{upload.batch}}</td>
                                    <td>{{upload.name}}</td>
                                    <td>{{upload.status==false?'未上传':'已上传'}}</td>
                                    <td>
                                        <a href="javascript:void(0);" class="continue edit btns delete view" data-id="{{upload.id}}">查看</a>
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

    $("#inshistory").loadData().then(function(result){
        if(result.data&&result.data.list&&result.data.list.length){
            $(".table").on('click',"a[class*='view']",function () {
                loadPageByUrl('guanwang/insuranceList?insupload.id='+$(this).data("id"));
            });
        }else{
            $(".nodata").remove();
        }
    });
</script>