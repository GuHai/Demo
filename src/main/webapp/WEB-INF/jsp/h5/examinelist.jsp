<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>账单</title>
    <jsp:include page="../h5/qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/Bills.css">
</head>
<body>
<div class="wrap">

    <main class="main marTop" style="margin-top: 0rem!important;">
        <ul class="allList">
            <script id="exmainelist"   type="text/html"  data-url="/ijob/api/WorklistController/waitExamine"  >
                {{each list as work }}
                <li>
                    <a href="javascript:void(0);" data-id="{{work.id}}" style="height: 1.0rem!important;">

                        <div class="contenBox">
                            <p class="list-title"  style="width: 300px;font-weight: bold">{{work.title }}</p>
                            <p class="list-time" style="width: 200px" >{{account.createTime | dateFormat:'yyyy-MM-dd hh:mm:ss'}}</p>
                        </div>
                        <div class="fr money">
                            <p>待审核</p>
                        </div>
                    </a>
                </li>
                {{/each}}
            </script>
        </ul>
    </main>
    <div id="homepage"></div>
</div>
</body>
</html>
<jsp:include page="../h5/qz/base/resource.jsp"/>
<script>
    $("#exmainelist").loadData().then(function (result) {
        $(".allList").on('click','a',function () {
            window.location.href = "/share/GDSH/"+$(this).data("id");
        });
    });
</script>