<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/28
  Time: 15:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"   import="com.yskj.service.base.DictCacheService" %>
<script src="/ijob/lib/jquery-2.2.3.min.js?version=<%=DictCacheService.Version%>"  charset="UTF-8"></script>
<script src="/ijob/static/js/ijob.js?version=<%=DictCacheService.Version%>"  charset="UTF-8"></script>
<script src="/ijob/static/js/enums.js?version=<%=DictCacheService.Version%>"  charset="UTF-8"></script>
<html>
<head>
    <title>支付</title>
</head>
<body>

</body>
<script>
    $.getJSON("/ijob/api/ApplySettlementController/getPayParam/${code}",{},function(result1) {
        if (result1.code == 200) {
            ijob.storage.set("tab", "yjs:1");
            var order = {
                order: {
                    refID: result1.data.id,
                    fee: Math.round(result1.data.dailySalary * 100),
                    description: ("薪资总额" + result1.data.dailySalary + "元"),
                    type: enums.WxOrderType.ScanSettle
                }
            };
            ijob.url.next.set("/ijob/api/ApplySettlementController/scanSettleCallback");
            ijob.gotoPage({url: '/ijob/api/WeixinController/order', data: order});
        } else if(result1.code==403) {
            window.location.href = "/indexMain";
        }else {
            alert(result1.msg);
        }
    });



</script>
</html>
