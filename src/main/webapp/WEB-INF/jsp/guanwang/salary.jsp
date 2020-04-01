<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/29
  Time: 16:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8"   import="com.yskj.service.base.DictCacheService"%>
<!--账单表格-->
<div class="row" >
    <div class="col-12">
        <div class="hd-box">
            <div class="right-button" id="uploadFlag">
                <button type="button" class="btn btn-info Import">导入表格</button>
                <button type="button" class="btn btn-info"><a href="/ijob/static/website/Template/批量发工资制表模板.xlsx" download="批量发工资制表模板.xlsx">下载模板</a></button>
            </div>
            <div class="left-txt" id="positionTitle">

            </div>
        </div>
    </div>
</div>
<div class="row">
    <!--导入摆个模板-->
    <div class="popup-backdrop" style="display: none;">
        <div class="main-content">
            <a href="javascript:void(0);" class="dialog-close"><i class="iconfont icon-guanbi"></i></a>
            <p id="errmsg" style="color: #ff3b30"></p>
            <form action="/ijob/api/ApplySettlementController/scanSettleUpload" class="myFrom" method="post" enctype="multipart/form-data">
                <div class="blockquote">
                    <p>批量上传支付数据表需要严格按照表格模板样式进行上传，否则无法正常识别您的数据。
                        <a href="/ijob/static/website/Template/批量发工资制表模板.xlsx" download="批量发工资制表模板.xlsx">点击下载模板</a></p>
                </div>
                <div class="upload-form">
                    <input type='text' name='textfield' id='textfield' class='txt' disabled/>
                    <input type='button' class='btn' value='上传'/>
                    <input type="file" name="file" class="file" id="fileField" onchange="isValidateFile(this);"/>
                </div>
                <div class="input">
                    <div class="text"><input type='text'   id="PositionName" name="PositionName" placeholder="请输入订单名称（必填）"/></div>
                    <div class="text"><input type='number' id="Number" name="Number" placeholder="请输入总人数（必填）"/></div>
                    <div class="text"><input type='number' id="Total" name="Total" placeholder="请输入总金额（必填）"/></div>
                    <div class="text">
                        <label id="label">
                            <input style="width:13px;height: 13px;" type='checkbox' id="isEdit" value="false"/>
                            <span class="tipstxt"> 需要进行后期修改<i>（请使用手机端进行修改）</i>
                            <em>大批量发工资不建议勾选此项，以避免出错</em></span>
                            <input type="hidden" name="isEdit" id="isEditVal">
                        </label>
                    </div>
                </div>
                <div class="foot">
                    <button type="button"  class="btn btn-default closebtns">取消</button>
                    <button type="button" id="submitBtn" class="btn btn-info confirmbtns">确认</button>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="row">
    <div class="col-12 grid-margin">
        <!--账单表格-->
        <div class="table-list" style="overflow:auto">
            <div >
                <table class="table">
                    <thead>
                    <tr>
                        <th></th>
                        <th>姓名</th>
                        <th>身份证</th>
                        <th>电话</th>
                        <th>薪资</th>
                        <th>状态</th>
                    </tr>
                    </thead>
                    <tbody>
                    <script  type="text/html" id="importlist"  data-url="/ijob/api/ApplySettlementController/lastImportRecord">
                        {{each list as scansettle }}
                        <tr class="trbox">
                            <td><label><input type="checkbox"  name="checkbox1" class="Check" disabled="{{scansettle.status==0?'disabled':'false'}}"></label></td>
                            <td>{{scansettle.realName}}</td>
                            <td>{{scansettle.personIDCard}}</td>
                            <td>{{scansettle.personPhoneNumber}}</td>
                            <td class="price" data-id="{{scansettle.id}}" data-version="{{scansettle.version}}" data-salary="{{scansettle.salary-scansettle.sxf}}">{{scansettle.salary-scansettle.sxf | money}}</td>
                            <td><a href="javascript:void(0);" data-toggle="tooltip" data-placement="left" title="{{scansettle.status ==0?'请让该用户先去平台进行实名认证':''}}" style="color: {{scansettle.status ==0?'#ff0000':'#198ae3'}}">{{scansettle.status ==0?'未实名':'可支付'}}</a></td>
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
    <div class="col-12 fixed-box">
        <div class="brokerage" style="color:#ff3b30;">
            <label><span id="paymsg"></span></label>
        </div>
        <div class="brokerage">
            <label><input type="checkbox" id="sxfbtn" class="checkbox" /><span>帮员工付提现手续费￥</span><span id="sxfmsg">0</span></label>
        </div>
        <!-- 总计 -->
        <div class="foot">
            <div class="payment">
                <button type="button" class="paybtns btn btn-info" data-url="/ijob/api/ApplySettlementController/toScanSettlementBySite">确认支付</button>
            </div>
            <div class="all-total">
                <label><input type="checkbox" class="checkbox" id="AllCheck"> &nbsp;<i>全选所有</i> </label>
                <span id="num" style="margin: 0 10px;"></span>
                <span class="sum">合计：￥<span class="total-amount" id="AllTotal">0</span></span>
            </div>
        </div>
        <div class="tips">本单位保证严格遵守支付结算业务的相关法律法规，并对支付款项事由的真实性、合法性负责。</div>
    </div>
</div>
<script type="text/javascript" src="/ijob/static/js/jquery.from.min.js"></script>
<script type="text/javascript" src="/ijob/static/website/js/Admin/total.js"></script>
<script type="text/javascript" src="/ijob/static/website/js/Admin/bill.js"></script>
<script type="text/javascript" src="/ijob/static/website/js/Admin/member.js"></script>
<script>
    var againID = ijob.storage.get("data.againID");
    if(againID!='all'){
        $("#uploadFlag").hide();
        $("#importlist").data("url","/ijob/api/ApplySettlementController/toPayAgain/"+againID);
    }
    $("#importlist").loadData().then(function(result){
        if(result.data.list&&result.data.list.length){
            ijob.storage.set("scanSettle.id",result.data.list[0].scanID);
            $("#positionTitle").text("订单名称："+result.data.list[0].title);
        }else{
            $(".nodata").remove();
        }

        $(".table .Check[disabled='false']").removeAttr("disabled");
        $(".table .Check[disabled='disabled']").remove();
    });
</script>