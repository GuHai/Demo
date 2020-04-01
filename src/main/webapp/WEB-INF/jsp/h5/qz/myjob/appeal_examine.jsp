<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/6
  Time: 15:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>申诉</title>
    <style>
        .jesuan {
            margin-top: .267rem;
            padding: 0 .453rem;
            height: 1.067rem;
            background-color: #fff;
            border-bottom: 1px solid #f2f5f7;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .jesuan .jesuan_lf {
            font-size: .400rem;
            font-weight: normal;
            font-stretch: normal;
            letter-spacing: 0;
            color: #333;
        }
        .jesuan .jesuan_rt {
            font-size: .320rem;
            font-weight: normal;
            font-stretch: normal;
            letter-spacing: 0;
            color: #999;
        }
        .text{
            margin-top: .267rem;
            background-color: #fff;
            padding: 15px;
        }

    </style>
    <link rel="stylesheet" href="/ijob/static/css/mine/report.css">

</head>
<body>
<div class="row">
    <script id="todayJob"   type="text/html"  data-url="/ijob/api/AppealhandleController/get/{data.appeal.id}"  data-type="POST" >
        {{each list as appeal}}
            <div class="jesuan">
                <span class="jesuan_lf">原告联系方式</span>
                <span class="jesuan_rt">{{appeal.appealName}}  <a href="tel:{{appeal.appealTel}}">{{appeal.appealTel}}</a></span>
            </div>
            <div class="jesuan">
                <span class="jesuan_lf">被告联系方式</span>
                <span class="jesuan_rt">{{appeal.positionName}}  <a href="tel:{{appeal.positionTel}}">{{appeal.positionTel}}</a></span>
            </div>
            <div class="jesuan">
                <span class="jesuan_lf">职位名称</span>
                <span class="jesuan_rt"><span  onclick="ijob.gotoPage({path:'/h5/qz/index/part_time_detail?data.position.id={{appeal.positionID}}'})" >{{appeal.positionTitle}}</span><i class="iconfont icon-arrow-right"></i></span>
            </div>
            <div class="jesuan">
                <span class="jesuan_lf">申诉类型</span>
                <span class="jesuan_rt"><span id="userResult">{{appeal.appealType | enums:'AppealType'}}</span></span>
            </div>
            <div class="text">
                <p>{{appeal.appealReason}}</p>
            </div>
            <div class="img-box">
                <section class=" img-section">
                    <div class="z_photo upimg-div clearfix"  id="photes">
                        {{each appeal.attachmentList as atta}}
                        <section  class="z_file fl">
                            <img  data-editable="true" class="attachment up-img" data-name="attachmentList0" data-type="Photos"
                                  style="height: 100%;width: 100%"
                                  src="/ijob/upload/{{atta | absolutelyPath }}" alt=""
                                  onerror="this.src='/ijob/static/images/a11.png';this.onerror=null">
                        </section>
                        {{/each}}
                    </div>
                </section>
            </div>
        {{/each}}
    </script>

</div>
</body>
<script>
    $("#todayJob").loadData().then(function(result){

    });
</script>
</html>
