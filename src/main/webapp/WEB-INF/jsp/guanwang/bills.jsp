<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/29
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8"   import="com.yskj.service.base.DictCacheService"%>
<!--账单表格-->
<div class="row">
    <div class="col-12 grid-margin">
        <div class="right-button">
            <button type="button" class="btn btn-info Import">导入表格</button>
            <button type="button" class="btn btn-info"><a href="/ijob/static/website/Template/批量发工资制表模板.xlsx" download="批量发工资制表模板.xlsx">下载模板</a></button>
        </div>
    </div>
</div>
<div class="row">
    <!--导入摆个模板-->
    <div class="popup-backdrop" style="display: none;">
        <div class="main-content">
            <a href="javascript:;" class="dialog-close"><i class="iconfont icon-guanbi"></i></a>
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
                    <div class="text"><input type='text' id="PositionName" name="PositionName" placeholder="请输入订单名称（必填）"/></div>
                    <div class="text"><input type='number' id="Number" name="Number" placeholder="请输入总人数（必填）"/></div>
                    <div class="text"><input type='number' id="Total" name="Total" placeholder="请输入总金额（必填）"/></div>
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
    <div class="col-12">
        <!--账单表格-->
        <div class="table-list">
            <div >
                <table class="table">
                    <thead>
                    <tr>
                        <th></th>
                        <th>姓名</th>
                        <th>身份证</th>
                        <th>电话</th>
                        <th>薪资</th>
                    </tr>
                    </thead>
                    <tbody>
                    <script  type="text/html" id="importlist"  data-url="/ijob/api/ApplySettlementController/lastImportRecord">
                        {{each list as scansettle }}
                        <tr class="trbox">
                            <td><label><input type="checkbox"  name="checkbox1" class="Check"></label></td>
                            <td>{{scansettle.realName}}</td>
                            <td>{{scansettle.personIDCard}}</td>
                            <td>{{scansettle.personPhoneNumber}}</td>
                            <td class="price" data-id="{{scansettle.id}}" data-version="{{scansettle.version}}" data-salary="{{scansettle.salary-scansettle.sxf}}">{{scansettle.salary-scansettle.sxf | money}}</td>
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
