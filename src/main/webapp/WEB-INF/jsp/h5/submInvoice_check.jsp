<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>开具发票审核</title>
    <link rel="stylesheet" href="/ijob/static/css/mine/recharge.css?version=4">
</head>
<body>
<div class="wrap">
    <script  type="text/html" id="jobtemplate"  data-url="/ijob/api/RechargeController/submInvoice_check/">
        {{each list as invoice}}
            <div class="page_submInvoice">
                <div class="input-type-list">
                    <div class="flex_input">
                        <div class="title">抬头类型</div>
                        <div class="select-type">
                            <div class="company mui-input-row mui-checkbox mui-left">
                                <label><input type="checkbox" checked="checked"  id="select-com"/>&nbsp;<span class="txt">企业单位</span></label>
                            </div>
                            <%--<div class="personal mui-input-row mui-checkbox mui-left">--%>
                            <%--<label><input type="checkbox" id="select-per"/>&nbsp;<span class="txt">个人/非企业单位</span></label>--%>
                            <%--</div>--%>
                        </div>
                    </div>
                    <%--企业单位--%>
                    <div class="mode">发票详情</div>
                    <div class="type_main_list company_list">
                        <div class="mui-input-row">
                            <div class="title">发票抬头</div>
                            <div class="input">
                                {{invoice.title}}
                            </div>
                        </div>
                        <div class="mui-input-row">
                            <div class="title">税　　号</div>
                            <div class="input s_input">
                                {{invoice.paragraph}}
                            </div>
                        </div>
                        <div class="mui-input-row">
                            <div class="title">发票金额</div>
                            <div class="input s_input">
                                <span>{{invoice.money | money}}</span>元
                            </div>
                        </div>
                        <div class="mui-input-row">
                            <div class="title">更多信息</div>
                            <div class="input right">
                                <a href="javascript:void(0);" class="r_input">
                                    {{if invoice.invoiceDetail.mark == null && invoice.invoiceDetail.addrphone == null &&   invoice.invoiceDetail.bankaccount == null }}
                                        未填写
                                    {{else}}
                                        已填写
                                    {{/if}}
                                    <span class="iconfont icon-arrow-right"></span>
                                </a>
                            </div>
                        </div>
                        <div class="mode">接收方式</div>
                        <div class="mui-input-row">
                            <div class="title">收件人</div>
                            <div class="input s_input">
                                {{invoice.recipients.name}}
                            </div>
                        </div>
                        <div class="mui-input-row">
                            <div class="title">联系电话</div>
                            <div class="input s_input">
                                {{invoice.recipients.phoneNumber}}
                            </div>
                        </div>
                        <div class="mui-input-row">
                            <div class="title">所在地区</div>
                            <div class="input right">
                                <a href="javascript:void(0);" class="reg">
                                    {{invoice.recipients.localtion}}
                                    <span class="iconfont icon-arrow-right"></span>
                                </a>
                            </div>
                        </div>
                        <div class="mui-input-row">
                            <div class="title">详细地址</div>
                            <div class="input s_input">
                                {{invoice.recipients.detail}}
                            </div>
                        </div>
                        <div class="mode">邮费（需支付）</div>
                        <div class="mui-input-row">
                            <div class="title">顺丰快递</div>
                            <div class="input">
                                <span>15</span>元
                            </div>
                        </div>
                    </div>
                    <%--个人/非企业单位--%>
                    <%--<div class="type_main_list personal_list" style="display: none;">
                        <div class="mui-input-row">
                            <div class="title">发票抬头</div>
                            <div class="input">
                                <input type="text" placeholder="请填写发票抬头" name="p_raised" class="p_raised"/>
                            </div>
                        </div>
                        <div class="mui-input-row">
                            <div class="title">发票金额</div>
                            <div class="input">
                                <span>20000.00</span>元
                            </div>
                        </div>
                        <div class="mui-input-row">
                            <div class="title">发票内容</div>
                            <div class="input">
                                代发工资
                            </div>
                        </div>
                        <div class="mui-input-row">
                            <div class="title">更多信息</div>
                            <div class="input right">
                                <a href="javascript:void(0);" class="r_input">
                                    填写备注、地址等（非必填
                                    <span class="iconfont icon-arrow-right"></span>
                                </a>
                            </div>
                        </div>
                        <div class="mode">接收方式</div>
                        <div class="mui-input-row">
                            <div class="title">收件人</div>
                            <div class="input">
                                <input type="text" placeholder="请填写收件人" name="p_addressee"  class="p_addressee"/>
                            </div>
                        </div>
                        <div class="mui-input-row">
                            <div class="title">联系电话</div>
                            <div class="input">
                                <input type="text" placeholder="请填写联系电话" name="p_tel"  class="p_tel"/>
                            </div>
                        </div>
                        <div class="mui-input-row">
                            <div class="title">所在地区</div>
                            <div class="input right">
                                <a href="javascript:void(0);" class="reg">
                                    请选择
                                    <span class="iconfont icon-arrow-right"></span>
                                </a>
                            </div>
                        </div>
                        <div class="mui-input-row">
                            <div class="title">详细地址</div>
                            <div class="input">
                                <input type="text" placeholder="请填写详细地址" name="p_det_addr" class="p_det_addr"/>
                            </div>
                        </div>
                        <div class="mode">邮费（需支付）</div>
                        <div class="mui-input-row">
                            <div class="title">顺丰快递</div>
                            <div class="input">
                                <span>15</span>元
                            </div>
                        </div>
                        <div class="btnbox">
                            <a href="javascript:void(0)" class="success">完成</a>
                        </div>
                    </div>--%>
                </div>
            </div>
            <div class="more_info" style="display: none;">
                <form id="invoiceDetailForm">

                    <div class="mui-input-row">
                        <div class="title">备注说明</div>
                        <div class="input">
                            <input type="text" placeholder="请填写备注说明" readonly="readonly" name="mark" class="remarks" value="{{invoice.invoiceDetail.mark}}"/>
                        </div>
                    </div>
                    <div class="mui-input-row">
                        <div class="title">地址和电话</div>
                        <div class="input">
                            <input type="text" placeholder="请填写地址和电话" readonly="readonly" name="addrphone" class="telephone" value="{{invoice.invoiceDetail.addrphone}}"/>
                        </div>
                    </div>
                    <div class="mui-input-row">
                        <div class="title">开户行和账号</div>
                        <div class="input">
                            <input type="text" placeholder="请填写开户行和账号"readonly="readonly"  name="bankaccount" class="bank" value="{{invoice.invoiceDetail.bankaccount}}"/>
                        </div>
                    </div>
                    <div class="btnbox">
                        <a href="javascript:void(0)" class="s_btn" data-url="/ijob/api/RechargeController/addInvoiceInfo">完成</a>
                    </div>

                </form>
            </div>
        {{/each}}
    </script>
</div>
</body>
<script>
    $("#jobtemplate").data("url","/ijob/api/RechargeController/submInvoice_check/"+ijob.storage.get("invoice.id"));
    $("#jobtemplate").loadData().then(function(result){
        console.log(result);
        // 更多信息
        $(".right .r_input").click(function () {
            $(".more_info").show();
            $(".page_submInvoice").hide();
        })
        $(".s_btn").click(function () {
            $(".page_submInvoice").show();
            $(".more_info").hide();
        })
    });
</script>
</html>


