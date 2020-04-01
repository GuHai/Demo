<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/29
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8"   import="com.yskj.service.base.DictCacheService"%>
<div id="msg" style="display: none" class="alert alert-warning" role="alert">文件上传中，请稍后...</div>
<!--账单表格-->
<div class="row">
    <div class="col-12 grid-margin">
        <div class="right-button">
            <div class="fileinput">
                <span class="fileinput-button">
                    <span>导入表格</span>
                      <form action="/ijob/api/ApiInsuranceUploadController/insuranceUpload" class="myFrom" method="post" enctype="multipart/form-data">
                            <input type="file" id="fileId" name="file" onchange="isValidateFile(this)"   />
                      </form>
                </span>
            </div>
            <button type="button" class="btn btn-info"><a href="/ijob/static/website/Template/保险上传模板（天）.xlsx" download="保险上传模板（天）.xlsx">下载模板</a></button>
            <button type="button" class="btn btn-info"><a href="/ijob/static/website/Template/职业类型.xlsx" download="职业类型.xlsx">下载职业类型</a></button>
            <button type="button" class="btn btn-info testpush" id="testpush" data-url="/ijob/api/ApiInsuranceUploadController/testpush" >测试下午4点推送</button>

        </div>
    </div>
</div>

<div class="row">
    <div class="col-12">
        <!--账单表格-->
        <div class="table-list">
            <div >
                <table class="table">
                    <thead>
                    <tr>
                        <th>序号</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>身份证号码</th>
                        <th>职业名称</th>
                        <th>企业全称</th>
                        <th>参保时间（年月日）</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <script id="inslist" type="text/html" data-url="/ijob/api/ApiInsuranceUploadController/waituploadlist" data-type="POST" >
                        {{each list as day index}}
                            <tr class="trbox">
                                <td>{{index+1}}</td>
                                <td>{{day.name}}</td>
                                <td>{{day.sex==0?'女':'男'}}</td>
                                <td>{{day.cardID}}</td>
                                <td>{{day.professor}}</td>
                                <td>{{day.enterprise}}</td>
                                <td>{{day.date  | dateFormat:'yyyy-MM-dd'}}</td>
                                <td>
                                    <a href="javascript:void(0);"  data-id="{{day.id}}"class="continue edit btns delete">删除</a>
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
<div class="row row-bottom">
    <div class="col-12 grid-margin">
        <div class="foot">
            <div class="payment">
                <button type="button" id="uploadinsurance" data-url="/ijob/api/ApiInsuranceUploadController/uploadInsurance" class="uploadbtns btn btn-info">上传</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="/ijob/static/js/jquery.from.min.js"></script>
<script>

    var insuploadid = ijob.storage.get("insupload.id");
    if(insuploadid){
        $("#inslist").data("url","/ijob/api/ApiInsuranceUploadController/uploadhistorydetail/"+insuploadid);
    }else{
        $("#inslist").data("url","/ijob/api/ApiInsuranceUploadController/waituploadlist");
    }
    $("#inslist").loadData().then(function(result){
        if(result.data&&result.data.list&&result.data.list.length){
            var insupload = result.infodata;
            $("#uploadinsurance").text(insupload.status==false?'上传':'已上传');
            if(insupload.status==false){
                $("#uploadinsurance").click(function(){
                    $("#uploadinsurance").btPost(insupload,function(){
                        if(result.code==200){
                            ijob.storage.pop("insupload.id");
                            loadPageByUrl('guanwang/insuranceList');
                        }else{
                            alert(result.msg);
                        }
                    });
                });
            }


            $(".table").on('click','.delete',function(){
                if(insupload.status==false){
                    var mymessage=confirm("确定要删除吗");
                    if(mymessage==true){
                        $(this).btPost("/ijob/api/ApiInsuranceUploadController/deleteInsuranceDay/"+$(this).data("id"),{},function(result){
                            if(result.code==200){
                                loadPageByUrl('guanwang/insuranceList');
                            }else{
                                showMsg(result.msg);
                            }
                        });
                    }
                }else{
                    alert("该人员已经成功上传，不能删除");
                }
            });

        }else{
            $(".nodata").remove();
        }
    });



    function isValidateFile(obj){
        var extend = obj.value.substring(obj.value.lastIndexOf(".")+1);
        if(!(extend=="xls"||extend=="xlsx")){
            alert("请上传后缀名为xls或xlsx的文件!");
            var nf = obj.cloneNode(true);
            nf.value='';
            obj.parentNode.replaceChild(nf, obj);
        }else{
            showMsg("文件上传中，请稍后...");
            $(".myFrom").ajaxSubmit(function (result) {
                if(result.code==200){
                    loadPageByUrl('guanwang/insuranceList');
                }else{
                    alert(result.msg);
                    loadPageByUrl('guanwang/insuranceList');
                }
            });
        }
    }
    $(".edit").click(function () {
        $(".popup-backdrop").show();
    })
    $(".dialog-close").click(function () {
        $(".popup-backdrop").hide();
    })

    $("#testpush").click(function(){
        $(this).btPost({},function(result){
            showMsg("测试成功");
        })
    });

    function showMsg(msg){
        $("#msg").text(msg);
        $("#msg").show();
    }
</script>