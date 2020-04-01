<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>开具发票</title>
    <jsp:include page="qz/base/link.jsp"/>
    <jsp:include page="qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/city.css?version=4">
    <link rel="stylesheet" href="/ijob/static/css/mine/recharge.css?version=4">
</head>
<body>
<div class="wrap">

    <script id="invoiceTemplate" type="text/html"  data-url="/ijob/api/RechargeController/getHistoryRechargeInfo">
        {{each list as invoice}}
            <div class="page_submInvoice">
                <div class="input-type-list">
                    <div class="flex_input">
                        <div class="title">抬头类型</div>
                        <div class="select-type">
                            <div class="company mui-input-row mui-checkbox mui-left" style="margin-right: 0;">
                                <label>
                                    <%--<input type="checkbox" checked="checked"  id="select-com"/>&nbsp;--%>
                                    <span class="txt">企业单位</span></label>
                            </div>
                            <%--<div class="personal mui-input-row mui-checkbox mui-left">--%>
                                <%--<label><input type="checkbox" id="select-per"/>&nbsp;<span class="txt">个人/非企业单位</span></label>--%>
                            <%--</div>--%>
                        </div>
                    </div>
                    <%--企业单位--%>
                    <div class="mode">发票详情</div>
                    <div class="type_main_list company_list">
                        <form id="invoiceForm">
                            <div class="mui-input-row">
                                <div class="title">发票抬头</div>
                                <div class="input" id="remittanceName">
                                    默认为上传凭证的公司名称（不可更改）
                                </div>
                            </div>
                            <div class="mui-input-row">
                                <div class="title">税号</div>
                                <div class="input">
                                    <input type="text" placeholder="请填写纳税人识别号" name="paragraph" class="taxNumber"/>
                                </div>
                            </div>
                            <div class="mui-input-row">
                                <div class="title">发票金额</div>
                                <div class="input">
                                    <input type="hidden" name="money" id="sessionMoney">
                                    <span id="money">20000.00</span>元
                                </div>
                            </div>
                            <div class="mui-input-row">
                                <div class="title">发票内容</div>
                                <div class="input">
                                    人力资源服务费*服务费
                                </div>
                            </div>
                        </form>
                        <div class="mui-input-row">
                            <div class="title">更多信息</div>
                            <div class="input right">
                                <a href="javascript:void(0);" class="r_input">
                                    填写备注、地址等（非必填）
                                    <span class="iconfont icon-arrow-right"></span>
                                </a>
                            </div>
                        </div>
                        <div class="mode">接收方式</div>
                        <form id="recipientsForm">
                            <div class="mui-input-row">
                                <div class="title">收件人</div>
                                <div class="input">
                                    <input type="text" placeholder="请填写收件人" name="name" class="b_addressee" />
                                </div>
                            </div>
                            <div class="mui-input-row">
                                <div class="title">联系电话</div>
                                <div class="input">
                                    <input type="number" placeholder="请填写联系电话" name="phoneNumber"  class="b_tel"/>
                                </div>
                            </div>
                            <div class="mui-input-row">
                                <div class="title">所在地区</div>
                                <div class="input right">
                                    <a href="javascript:void(0);" class="reg">
                                        <input type="text" id="picker" placeholder="请选择" readonly="readonly" value="湖南省 长沙市 芙蓉区">
                                        <%--<select id="province" style="width: 70px;display: none" data-url="/ijob/api/CityController/findList">
                                            <option value="0">--请选择--</option>
                                        </select>--%>
                                        <%--<select id="province" style="width: 70px;display: inline" data-url="/ijob/api/CityController/findList">
                                            <option value="0">--请选择--</option>
                                        </select>
                                        <select id="city"style="width: 70px;display: inline">
                                            <option value="0">--请选择--</option>
                                        </select>
                                        <select id="area"style="width: 70px;display: inline">
                                           <option value="0">--请选择--</option>
                                        </select>--%>
                                        <span class="iconfont icon-arrow-right"></span>
                                    </a>
                                </div>
                            </div>
                            <div class="mui-input-row">
                                <div class="title">详细地址</div>
                                <div class="input">
                                    <input type="text" placeholder="请填写详细地址" name="detail" class="b_det_addr"/>
                                </div>
                            </div>
                        </form>
                        <div class="mode">邮费（需支付）</div>
                        <div class="mui-input-row">
                            <div class="title">顺丰快递</div>
                            <div class="input">
                                <span>15</span>元
                            </div>
                        </div>
                        <div class="btnbox">
                            <a href="javascript:void(0)" class="success">提交</a>
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
            <%--更多信息--%>
            <div class="more_info" style="display: none;">
                <form id="invoiceDetailForm">

                    <div class="mui-input-row">
                        <div class="title">备注说明</div>
                        <div class="input">
                            <input type="text" placeholder="请填写备注说明" name="mark" class="remarks"/>
                        </div>
                    </div>
                    <div class="mui-input-row">
                        <div class="title">地址和电话</div>
                        <div class="input">
                            <input type="text" placeholder="请填写地址和电话" name="addrphone" class="telephone"/>
                        </div>
                    </div>
                    <div class="mui-input-row">
                        <div class="title">开户行和账号</div>
                        <div class="input">
                            <input type="text" placeholder="请填写开户行和账号" name="bankaccount" class="bank"/>
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
</html>
<script src="/ijob/static/js/city/ydui.js" charset="UTF-8" ></script>
<script>
    ijob.storage.set("data.type",1);
    //计算用户填写了多少更多信息
    var count = 0 ;
    var province = "",city = "" , area = "";
    var slide = null;

    $("#invoiceTemplate").loadData().then(function(result){

        $('#picker').citySelect();
        $('#picker').on('click', function(event) {
            event.stopPropagation();
            $('#picker').citySelect('open');
            if ($('.m-cityselect').hasClass('brouce-in')){
                slide = new Slide($(".mask-black"),$(".m-cityselect"),".cityselect-content");
                slide.disTouch();
            }else{
                slide.ableTouch();
            }
        });

        $('#picker').on('done.ydui.cityselect', function(ret) {
            $(this).val(ret.provance + ' ' + ret.city + ' ' + ret.area);
        });

        //初始化省市信息
       /* $("#province").btPost(queryParam,function (result) {
            for(var i = 0 ;i < result.data.list.length ;i++){
                var htmlText = "<option value=\""+result.data.list[i].id+"\">"+result.data.list[i].cityName+"</option>"
                $("#province").html($("#province").html()+htmlText);
            }
        });
        //当省市被选中时，自动加载地级市县信息。
        $("#province").change(function () {
            province = this.options[this.selectedIndex].text;
            if($("#province option")[0].value==0){
                this.remove($("#province option")[0]);
            }
            queryParam.condition.parentID = this.value;
            $("#city").html("<option value=\""+0+"\">--请选择--</option>");
            $(this).btPost(queryParam,function (result) {
                for(var i = 0 ;i < result.data.list.length ;i++){
                    var htmlText = "<option  value=\""+result.data.list[i].id+"\">"+result.data.list[i].cityName+"</option>"
                    $("#city").html($("#city").html()+htmlText);
                }
            });
        });

        //当市/县被选中时，自动加载区县信息。 并且保存被选中的值
        $("#city").change(function () {
            //保存被选中的值
            city = this.options[this.selectedIndex].text;
            //移除无用的option 框。"--请选择--"
            if($("#city option")[0].value==0){
                this.remove($("#city option")[0]);
            }
            queryParam.condition.parentID = this.value;
            //为区县选择框添加默认数据。
            $("#area").html("<option value=\""+0+"\">--请选择--</option>");
            //加载区县数据。
            $("#province").btPost(queryParam,function (result) {
                for(var i = 0 ;i < result.data.list.length ;i++){
                    var htmlText = "<option value=\""+result.data.list[i].id+"\">"+result.data.list[i].cityName+"</option>"
                    $("#area").html($("#area").html()+htmlText);
                }
            });
        });

        //当区县被选中时，移除“--请选择--”选择框，并且保存选中的值。
        $("#area").change(function () {
            area = this.options[this.selectedIndex].text;
            if($("#area option")[0].value==0){
                this.remove($("#area option")[0]);
            }
        });*/

        var summary = ijob.storage.get("summaryVoucher");
        $("#money").text(summary.money);
        $("#remittanceName").text(summary.list[0].remittanceName);
        $("#sessionMoney").val(summary.money);

        // 选择其中一个
        $('.mui-checkbox').find('input[type=checkbox]').bind('click', function(){
            $('.mui-checkbox').find('input[type=checkbox]').not(this).attr("checked", false);
        });
        // 类型切换
        $("#select-com").click(function () {
            if($(this).prop("checked") == true){
                $(".personal_list").hide();
                $(".company_list").show();
            }
        })
        $("#select-per").click(function () {
            if($(this).prop("checked") == true){
                $(".personal_list").show();
                $(".company_list").hide();
            }
        })
        $(".company_list .success").click(function () {
            var phoneReg = /^[1][3,4,5,6,7,8,9][0-9]{9}$/;
            if ($(".taxNumber").val().trim() == ''){
                mui.alert("请填写纳税人识别号");
            }else if($(".taxNumber").val().trim().length != 15 && $(".taxNumber").val().trim().length != 18 && $(".taxNumber").val().trim().length != 20 ){
                mui.alert("请填写正确的纳税人识别号");
            }else if ($(".b_addressee").val().trim() == ''){
                mui.alert("请填写收件人");
            }else if ($(".b_addressee").val().trim().length > 5){
                mui.alert("请填写正确的收件人姓名");
            }else if ($(".b_tel").val().trim() == ''){
                mui.alert("请填写联系电话");
            }else if(!phoneReg.test($(".b_tel").val())){
                mui.alert("请填写正确的联系电话");
            }else if($("#picker").val()==null||$("#picker").val()==""||$("#picker").val()==undefined){
                mui.alert("请选择所在地区");
            }else if ($(".b_det_addr").val().trim() == ''){
                mui.alert("请填写详细地址");
            }else if ($(".b_det_addr").val().trim().length > 50){
                mui.alert("请填写正确的详细地址");
            }else if ($(".remarks").val().trim().length > 20){
                mui.alert("备注信息的字数不应超过20个");
            }else if ($(".telephone").val().trim().length > 30){
                mui.alert("地址和电话信息的字数不应超过30个");
            }else if ($(".bank").val().trim().length > 50){
                mui.alert("开户行信息的字数不应超过50个");
            } else{
                var invoice = $("#invoiceForm").serializeObjectJson();
                invoice.recipients = $("#recipientsForm").serializeObjectJson();
                invoice.invoiceDetail = $("#invoiceDetailForm").serializeObjectJson() ;
                invoice.title = summary.list[0].remittanceName ;
                invoice.recipients.localtion = $("#picker").val() ;
                var tempArr = new Array();
                for (var i = 0 ; i < summary.list.length ; i++){
                    tempArr.push(summary.list[i].id);
                }
                invoice.rechargeList = tempArr;
                $(this).data("url",'/ijob/api/RechargeController/addInvoiceInfo')
                $(this).btPost(invoice,function (result) {
                    if(result.code == 200){
                        var order = {order:{refID:result.data.id,fee:15*100,description:('发票邮寄费用：'+Math.round(15*100)/100+"元"),type:enums.WxOrderType.Postage}};
                        payBond(order);
                    }else{
                        mui.alert(result.msg);
                    }
                })
            }
        })
        $(".personal_list .success").click(function () {
            if ($(".p_raised").val() == ''){
                mui.alert("请填写发票抬头");
            }else if ($(".p_addressee").val() == ''){
                mui.alert("请填写收件人");
            }else if ($(".p_tel").val() == ''){
                mui.alert("请填写联系电话");
            }else if ($(".p_det_addr").val() == ''){
                mui.alert("请填写详细地址");
            }else{
                ijob.gotoPage({path:'/h5/success'});
            }
        })

        // 更多信息
        $(".right .r_input").click(function () {
            $(".more_info").show();
            $(".page_submInvoice").hide();
        })
        $(".s_btn").click(function () {
            count = 0 ;
            var text = "填写备注、地址等（非必填）";
            $(".page_submInvoice").show();
            $(".more_info").hide();
            if($(".remarks").val().trim() !='' &&$(".remarks").val()!=null&$(".remarks").val()!=undefined){
                count++ ;
            }
            if($(".telephone").val().trim() !=''&&$(".telephone").val()!=null&&$(".telephone").val()!=undefined){
                count++ ;
            }
            if($(".bank").val().trim() !=''&&$(".bank").val()!=null&&$(".bank").val()!=undefined){
                count++ ;
            }
            if(count > 0){
                $(".r_input").text("共3项，已填写" + count +"项")
            }else{
                $(".r_input").text(text);
            }
        })

    });

    function payBond(order){
        /*window.history.replaceState('','', "forward?path=/h5/zp/index");*/
        ijob.url.next.set("/ijob/api/RechargeController/postageCallback","html");
        ijob.gotoPage({url:'/ijob/api/WeixinController/order',data:order});
    }

    function loadJs(_url){
        var new_element = document.createElement("script");
        new_element.setAttribute("type", "text/javascript");
        new_element.setAttribute("charset", "UTF-8");
        new_element.setAttribute("src", _url);
        document.body.appendChild(new_element);
    }
</script>


