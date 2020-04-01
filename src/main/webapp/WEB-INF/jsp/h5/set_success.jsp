<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/23
  Time: 14:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="qz/base/resource.jsp"/>
    <jsp:include page="qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/inform.css?version=4">
    <title>设置成功</title>
</head>

<body>
<div class="wrap">
    <div class="page_set_success">
        <div class="set_hd">
            <div class="hd-lilst">
                已默认为您关注工作号：<span class="school">湖南涉外经济学院</span>。此工作号发布职位后，我们将推送给您。
            </div>
        </div>
        <div class="school-list">
            <div class="mainbox">
                <p class="tit">附近的校园工作号：</p>
                <ul>
                    <script  type="text/html" id="schooltemp"  data-url="/ijob/api/WorkNumberController/attachedSchoolList" >
                        {{each list as school }}
                            <li>
                                <div class="left">
                                    <div class="photo">
                                        <img  src="https://gkcx.eol.cn/upload/schoollogo/{{school.badge}}.jpg"  onerror="this.src='/ijob/static/images/school.jpg';this.onerror=null"/>
                                    </div>
                                    <div class="inform">
                                        <p class="name">{{school.name}}</p>
                                        <p class="fans">距离<span class="num">{{school.distance | distance}}</span></p>
                                    </div>
                                </div>
                                <div class="follow">
                                    <a href="javascript:void(0)" data-id="{{school.id}}" class="attention btns" >关注</a>
                                </div>
                            </li>
                        {{/each}}
                    </script>
                </ul>
            </div>
        </div>
        <div class="setbox">
            <a href="javascript:void(0)" class="nextbtns gotohome">完成</a>
        </div>
    </div>
</div>
</body>
<script>
    var local = ijob.location.get();
    var myschool = ijob.storage.get("myschool");
    $(".school").text(myschool.name);
    $("#schooltemp").loadData({condition:{name:myschool.name,lat:local.lat,lng:local.lng},pageSize:5,currentPage:1}).then(function(result){
        // $(".school-list .attention").click();
    });

    $(".school-list").on("click",".attention",function(){
        var _this = $(this);
        _this.btPost("/ijob/api/WorkNumberController/attention/"+$(this).data("id"),{},function(result){
             if(result.success==true){
                 if(result.data==true){
                     _this.addClass("Alreadybtns");
                     _this.text("已关注");
                 }else {
                     _this.removeClass("Alreadybtns");
                     _this.text("关注");
                 }
             }else{
                 mui.toast(result.msg);
             }
         });
    });
    /*$(".button").click(function(){
        $(".inform .name").each(function() {
            // console.log($(this).text());
            var maxwidth = 15;
            if($(this).text().length > maxwidth) {
                $(this).text($(this).text().substring(0, maxwidth));
                $(this).html($(this).html() + "...");
            }
        });
    });*/


</script>
</html>
<script src="/ijob/static/js/index/setting.js" charset="UTF-8" ></script>