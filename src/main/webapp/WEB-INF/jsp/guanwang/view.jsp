<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/29
  Time: 16:34
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
                        <th>姓名</th>
                        <th>身份证</th>
                        <th>电话</th>
                        <th>薪资</th>
                        <th>时间</th>
                        <th>状态</th>
                    </tr>
                    </thead>
                    <tbody>
                    <script id="getMyHistoryPayInfoDetails" type="text/html" data-url="/ijob/api/ApplySettlementController/getMyHistoryPayInfoDetails/{data.scanID}" data-type="POST" >
                        {{each list as member1}}
                        <tr class="trbox">
                            <td id="realName{{member1.id}}">{{member1.realName}}</td>
                            <td id="personIDCard{{member1.id}}">{{member1.personIDCard}}</td>
                            <td id="phoneNumber{{member1.id}}">{{member1.phoneNumber}}</td>
                            <td class="price">{{member1.salary}}</td>
                            <td>{{member1.time}}</td>
                            <td id="status" class="colo {{if member1.status == '待结算'}} current {{/if}}">{{member1.status}}</td>
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
    $("#getMyHistoryPayInfoDetails").loadData().then(function(result){
        if(result.data.list && result.data.list.length){
            $.getJSON("/ijob/api/ApplySettlementController/salaryImportList/"+ijob.storage.get("data.scanID"),function(data){
                for(var i in data.data.list){
                    var obj  = data.data.list[i];
                    $("#realName"+obj.scanID).text(obj.realName);
                    $("#personIDCard"+obj.scanID).text(obj.personIDCard);
                    $("#phoneNumber"+obj.scanID).text(obj.personPhoneNumber);
                }
            });
        }else{
            $(".nodata").remove();
        }
    });
</script>