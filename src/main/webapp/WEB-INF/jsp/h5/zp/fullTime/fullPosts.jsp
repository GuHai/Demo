<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/11
  Time: 16:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>选择岗位</title>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/fullTime/fullTime.css?version=4">
</head>
<body>
<div class="wrap">
    <div class="full-Posts">
        <div class="list-box">
            <ul>
                <script id="postType" type="text/html" data-url="/ijob/api/FullTimeController/getPostType"  >
                    {{each list as type}}
                        <li class="ul-li" onclick="ijob.gotoPage({path:'/h5/zp/fullTime/postJob?full.type={{type.value}}'})">{{type.name}}</li>
                    {{/each}}
                </script>
            </ul>
        </div>
    </div>
</div>
</body>
</html>
<script>
    $(function () {
        $("#postType").loadData().then(function (result) {
            /*岗位名称较长*/
            $(".list-box .ul-li").each(function(){
                if ($(this).text().length >= 6){
                    $(this).addClass("curr");
                }else if($(this).text() == '装卸员' || $(this).text() == '保洁员' || $(this).text() == '实习生'){
                    $(this).css("margin-left","0");
                }else if($(this).text() == '驾驶员' || $(this).text() == '服务员'){
                    $(this).css("margin-left","0.373rem")
                }
            });
        })
    })
</script>
