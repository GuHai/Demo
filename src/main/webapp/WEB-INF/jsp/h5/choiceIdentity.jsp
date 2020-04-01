<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>选择身份</title>
</head>
<jsp:include page="../h5/zp/base/resource.jsp"/>
<style>
    .wrap .main.seeker_recruit{padding: 0 0.453rem}
    .wrap .main .job_seeker_recruit {text-align:  center;width: 100%;margin:  0 auto;}
    .wrap .main .job_seeker_recruit .s_r_img{text-align: center;margin: 0 auto;width: 4.3rem;}
    .wrap .main .job_seeker_recruit .s_r_img img{width: 100%;height: 100%;display:  block;}
    .wrap .main .job_seeker_recruit .title{color: #108ee9;font-size: 0.48rem;padding-top: 0.4rem;}
    .wrap .main .job_seeker_recruit.paddingtop{padding-top: 1rem;border-top: 1px solid #d7d7d7;}
    .wrap .main .job_seeker_recruit.paddingtop.seeker{border-top: 0;padding-bottom: 1rem;}
    .wrap .main .job_seeker_recruit.paddingtop.recruit{padding-top: 1rem;}
</style>
<body>
<div class="wrap">
    <div class="main seeker_recruit">
        <input type="hidden" id="id" value="${id}"/>
        <input type="hidden" id="version" value="${version}"/>
        <div class="job_seeker_recruit paddingtop seeker" value="1" data-url="/ijob/api/InformationController/update" >
            <div class="s_r_img">
                <img src="/ijob/static/images/seeker.png" class="img"/>
            </div>
            <h1 class="title">我是求职者</h1>
        </div>
        <div class="job_seeker_recruit paddingtop recruit" value="2" data-url="/ijob/api/InformationController/update" >
            <div class="s_r_img">
                <img src="/ijob/static/images/recruit.png" class="img"/>
            </div>
            <h1 class="title">我是招聘者</h1>
        </div>
    </div>
</div>
<script>
$(function () {
    $(".paddingtop").click(function () {
        var obj = {
            "id":$("#id").val(),
            "identityType":$(this).attr("value"),
            "version":$("#version").val()
        };
        $(this).btPost(obj,function(data){
            if(data.code == 200){
                ijob.gotoPage({url:"/indexMain"});
            }
        });
    });
})
</script>
</body>
</html>
