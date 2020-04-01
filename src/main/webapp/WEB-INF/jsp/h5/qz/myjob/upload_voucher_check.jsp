<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>上传凭证审核</title>
    <link rel="stylesheet" href="/ijob/static/css/mine/recharge.css">
</head>
<body>
<div class="wrap">
    <div class="page_upload_voucher">
        <script  type="text/html" id="jobtemplate"  data-url="/ijob/api/RechargeController/upload_voucher_check/">
            {{each list as voucher}}
                <div class="input-type-list">
                    <div class="flex_input">
                        <div class="title">充值账户类型</div>
                        <div class="select-type">
                            <div class="company mui-input-row mui-radio mui-left">
                                <label><input type="radio" checked="checked" name="checkbox" id="select-com" />&nbsp;<span class="txt">{{if voucher.type == 1}}企业充值{{else}}个人充值{{/if}}</span></label>
                            </div>
                        </div>
                    </div>
                    <%--企业充值--%>
                    <div class="type_main_list company_list">
                        <form id="company">
                            <div class="mui-input-row">
                                <div class="title">已充值金额</div>
                                <div class="input s_input">
                                    {{voucher.money | money}}
                                </div>
                            </div>
                            {{if voucher.type == 1}}
                            <div class="mui-input-row com_name">
                                <div class="title">汇款公司名称</div>
                                <div class="input s_input">
                                    {{voucher.remittanceName}}
                                </div>
                            </div>
                            {{/if}}
                            {{if voucher.type == 0}}
                            <div class="per_list">
                                <div class="mui-input-row">
                                    <div class="title">汇款人姓名</div>
                                    <div class="input s_input">
                                        {{voucher.remittanceName}}
                                    </div>
                                </div>
                                <div class="mui-input-row">
                                    <div class="title">汇款银行卡号</div>
                                    <div class="input s_input">
                                        {{voucher.remittanceBankCard}}
                                    </div>
                                </div>
                            </div>
                            {{/if}}
                            <div class="mui-input-row">
                                <div class="title">真实姓名</div>
                                <div class="input s_input">
                                    {{voucher.mainName |ifNull:'该用户尚未进行实名认证。'}}
                                </div>
                            </div>
                            <a onclick="ijob.gotoPage({url:'/UserController/h5/toLoginByID/{{voucher.wxID}}'})">查看用户</a>
                            <div class="img-box">
                                <p class="tit">上传支付凭证</p>
                                <section class="img-section">
                                    {{each voucher.attachmentList as attachment}}
                                        <a href="/ijob/upload/{{attachment |absolutelyPath}}">
                                            <img src="/ijob/upload/{{attachment |absolutelyPath}}" width="24%">
                                        </a>
                                    {{/each}}
                                </section>
                            </div>
                        </form>
                    </div>
                </div>
            {{/each}}
        </script>
    </div>
</div>
<script>
    $("#jobtemplate").data("url","/ijob/api/RechargeController/upload_voucher_check/"+ijob.storage.get("voucher.id"));
    $("#jobtemplate").loadData().then(function(result){
        console.log(result);
    });
</script>
</body>
</html>
