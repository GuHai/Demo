<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/27
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>保证金</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/using_help.css?version=4">
</head>
<body>
<div class="wrap">
    <div class="page_deposit">
        <div class="hd-main">
            <div class="list-box">
                <ul id="bond">
                    <script type="text/html" id="dictTemplate" data-url="/ijob/api/DictController/findList">
                        {{each list as dict}}
                            <li class="load" data-id="{{dict.id}}" data-title="{{dict.title}}" data-content="{{dict.dictContent}}">
                                <span class="txt">{{dict.title}}</span>
                                <span class="iconfont icon-arrow-right"></span>
                            </li>
                        {{/each}}
                    </script>
                </ul>
            </div>
        </div>
    </div>
</div>
<script>
    $("#dictTemplate").loadData({condition:{parentID:ijob.storage.get("data.type")}}).then(function(result){
        $(".load").click(function () {
            ijob.gotoPage({
                path:'/h5/qz/mine/help_details',
                data:{
                    'title':$(this).data("title"),
                    'dictContent':$(this).data("content"),
                    'id':$(this).data("id")
                }
            });
        });
    });
    if(ijob.storage.get("data.type")==1){
        document.title = "保证金";
    }else if(ijob.storage.get("data.type")==2){
        document.title = "提现";
    }else if(ijob.storage.get("data.type")==3){
        document.title = "合伙人";
    }


</script>
</body>
</html>
