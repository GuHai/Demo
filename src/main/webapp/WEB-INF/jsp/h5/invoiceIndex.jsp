<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>开具发票</title>
    <jsp:include page="qz/base/resource.jsp"/>
    <jsp:include page="qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/recharge.css?version=4">
</head>
<body>
<div class="wrap">
    <div class="page_invoiceIndex" >
        <script id="voucherListTemplate" type="text/html"  data-url="/ijob/api/RechargeController/getVoucherList">
            {{each list as list}}
                <div class="month-row-list">
                    <p class="month">{{list.tempMonth |dateFormat:'M月'}}</p>
                    {{each list.voucherList as voucher}}
                        <div class="input-row">
                            <div class="table-list">
                                <div class="mui-checkbox mui-left">
                                    {{if voucher.type == true}}
                                        <input type="checkbox" name="checkbox1" class="Check" data-type="1" data-name="{{voucher.remittanceName}}" data-id="{{voucher.recharge.id}}"/>
                                    {{else if voucher.type == false}}
                                        <input type="checkbox"  name="checkbox1" class="Check" data-type="0" data-name="{{voucher.remittanceName}}" data-id="{{voucher.recharge.id}}"/>
                                    {{/if}}
                                </div>
                                <div class="desc-row">
                                    <div class="txt">{{voucher.remittanceName}}</div>
                                    <div class="time">{{voucher.updateTime |dateFormat:'yyyy-MM-dd hh:mm'}}</div>
                                </div>
                            </div>
                            <div class="money">
                                <span class="num reg_num">{{voucher.money}}</span>
                                <span class="yuan">元</span>
                            </div>
                        </div>
                    {{/each}}
                </div>
            {{/each}}
            <div style="clear:both;height: 1.4rem;content: '';"></div>
            <div class="foot_flex">
                <div class="mui-input-row mui-checkbox mui-left">
                    <a href="javascript:void(0);" class="check"><label><input type="checkbox" class="goods-check" id="AllCheck"/><span>全选</span></label></a>
                    <a href="javascript:void(0);" class="btnnext"><span id="AllTotal">0.00</span>元  <span class="next">下一步</span></a>
                </div>
            </div>
        </script>
        <%--3月--%>
        <%--<div class="month-row-list">
            <p class="month">3月</p>
            <div class="input-row">
                <div class="table-list">
                    <div class="mui-checkbox mui-left">
                        <input type="checkbox" name="checkbox1" class="Check"/>
                    </div>
                    <div class="desc-row">
                        <div class="txt">充值</div>
                        <div class="time">2018-03-23 15:32</div>
                    </div>
                </div>
                <div class="money">
                    <span class="num reg_num">20000</span>
                    <span class="yuan">元</span>
                </div>
            </div>
            <div class="input-row">
                <div class="table-list">
                    <div class="mui-checkbox mui-left">
                        <input type="checkbox" name="checkbox1" class="Check"/>
                    </div>
                    <div class="desc-row">
                        <div class="txt">充值</div>
                        <div class="time">2018-03-23 15:32</div>
                    </div>
                </div>
                <div class="money">
                    <span class="num reg_num">20000</span>
                    <span class="yuan">元</span>
                </div>
            </div>
            <div class="input-row">
                <div class="table-list">
                    <div class="mui-checkbox mui-left">
                        <input type="checkbox" name="checkbox1" class="Check"/>
                    </div>
                    <div class="desc-row">
                        <div class="txt">充值</div>
                        <div class="time">2018-03-23 15:32</div>
                    </div>
                </div>
                <div class="money">
                    <span class="num reg_num">20000</span>
                    <span class="yuan">元</span>
                </div>
            </div>
        </div>--%>
        <%--2月--%>
        <%--<div class="month-row-list">
            <p class="month">2月</p>
            <div class="input-row">
                <div class="table-list">
                    <div class="mui-checkbox mui-left">
                        <input type="checkbox" name="checkbox1" class="Check"/>
                    </div>
                    <div class="desc-row">
                        <div class="txt">充值</div>
                        <div class="time">2018-03-23 15:32</div>
                    </div>
                </div>
                <div class="money">
                    <span class="num reg_num">20000</span>
                    <span class="yuan">元</span>
                </div>
            </div>
            <div class="input-row">
                <div class="table-list">
                    <div class="mui-checkbox mui-left">
                        <input type="checkbox" name="checkbox1" class="Check"/>
                    </div>
                    <div class="desc-row">
                        <div class="txt">充值</div>
                        <div class="time">2018-03-23 15:32</div>
                    </div>
                </div>
                <div class="money">
                    <span class="num reg_num">20000</span>
                    <span class="yuan">元</span>
                </div>
            </div>
            <div class="input-row">
                <div class="table-list">
                    <div class="mui-checkbox mui-left">
                        <input type="checkbox" name="checkbox1" class="Check"/>
                    </div>
                    <div class="desc-row">
                        <div class="txt">充值</div>
                        <div class="time">2018-03-23 15:32</div>
                    </div>
                </div>
                <div class="money">
                    <span class="num reg_num">20000</span>
                    <span class="yuan">元</span>
                </div>
            </div>
        </div>--%>
    </div>
</div>
<div id="homepage"></div>
</body>
</html>
<%--<script src="/ijob/static/js/count.js" charset="UTF-8" ></script>--%>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});
    $("#voucherListTemplate").loadData().then(function(result){
        console.log(result);
        if(result.data.list.length == 0){
            $(".page_invoiceIndex").attr("style","text-align: center;padding-top:40%")
        }
        var new_element = document.createElement("script");
        new_element.setAttribute("type", "text/javascript");
        new_element.setAttribute("src", "/ijob/static/js/count.js");
        document.body.appendChild(new_element);
        $(".btnnext").click(function () {
            var isGotoPage = false ;
            var checked=$("input[name='checkbox1']:checked");
            if(checked.length==0) {
                mui.alert("请至少选择一个");
            }else {
                var arry = new Array();
                var leng1 = $("input[name='checkbox1']:checked");
                for(var i = 0 ; i <leng1.length ; i++){
                    if($(leng1[i]).data('type') == 0 || $(leng1[i]).data('type')=='0' ){
                        isGotoPage = false ;
                        mui.alert("暂时不支持个人充值开票！")
                        break;
                    }
                    if(i == 0){
                        var temp = {
                            id:$(leng1[i]).data('id'),
                            remittanceName:$(leng1[i]).data('name')
                        }
                        arry.push(temp);
                        isGotoPage = true;
                    }else {
                        if($(leng1[i]).data('name') != $(leng1[i - 1]).data('name')){
                            mui.alert("抱歉，您选择的开票数据不归属于同一个公司！");
                            isGotoPage = false ;
                            break;
                        }else{
                            var temp = {
                                id:$(leng1[i]).data('id'),
                                remittanceName:$(leng1[i]).data('name')
                            }
                            isGotoPage = true
                            arry.push(temp);
                        }
                    }
                }
                if(isGotoPage==true){
                    var summary = {
                        list:arry,
                        money:$("#AllTotal").text()
                    }
                    ijob.storage.set("summaryVoucher",summary);
                    ijob.gotoPage({path:'/h5/submInvoice'});
                }
            }
        })

    });
</script>
