<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/29
  Time: 16:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8"   import="com.yskj.service.base.DictCacheService"%>
<div class="row">
    <div class="col-12 grid-margin">
        <!--账单表格-->
        <div class="table-list">
            <div class="main-body">
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
                    <tr class="trbox">
                        <td><label><input type="checkbox"  name="checkbox1" class="Check"></label></td>
                        <td>刘某人</td>
                        <td>530401198002276325</td>
                        <td>15574101502</td>
                        <td class="price">200</td>
                    </tr>
                    <tr class="trbox">
                        <td><label><input type="checkbox" name="checkbox1" class="Check"></label></td>
                        <td>刘某人</td>
                        <td>530401198002276325</td>
                        <td>15574101502</td>
                        <td class="price">200</td>
                    </tr>
                    <tr class="trbox">
                        <td><label><input type="checkbox" name="checkbox1" class="Check"></label></td>
                        <td>刘某人</td>
                        <td>530401198002276325</td>
                        <td>15574101502</td>
                        <td class="price">200</td>
                    </tr>
                    <tr class="trbox">
                        <td><label><input type="checkbox" name="checkbox1" class="Check"></label></td>
                        <td>刘某人</td>
                        <td>530401198002276325</td>
                        <td>15574101502</td>
                        <td class="price">200</td>
                    </tr>
                    <tr class="trbox">
                        <td><label><input type="checkbox" name="checkbox1" class="Check"></label></td>
                        <td>刘某人</td>
                        <td>530401198002276325</td>
                        <td>15574101502</td>
                        <td class="price">200</td>
                    </tr>
                    <tr class="trbox">
                        <td><label><input type="checkbox" name="checkbox1" class="Check"></label></td>
                        <td>刘某人</td>
                        <td>530401198002276325</td>
                        <td>15574101502</td>
                        <td class="price">200</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="label-box">
                <label><input type="checkbox" class="checkbox" id="pageCheck"/><span>全选本页</span></label>
            </div>
        </div>
        <!--账单表格 end-->
    </div>
</div>
<div class="row row-bottom">
    <div class="col-12 grid-margin">
        <div class="brokerage">
            <label><input type="checkbox" class="checkbox" /><span>帮员工付提现手续费￥239.36</span></label>
        </div>
        <!-- 总计 -->
        <div class="foot">
            <div class="payment">
                <button type="button" class="paybtns btn btn-info">确认支付</button>
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