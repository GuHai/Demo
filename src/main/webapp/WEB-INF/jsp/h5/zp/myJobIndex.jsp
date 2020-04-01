<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/29
  Time: 17:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>我的招聘</title>
    <%--<jsp:include page="../zp/base/resource.jsp"/>--%>
    <link rel="stylesheet" href="/ijob/static/css/index/index.css">
</head>
<body>

<style>
    .h-bghue{width:100%;height:auto;overflow:hidden;background:#f2f5f7;/*margin-bottom: 0.267rem*/}
    .post>a span{margin-left:5px;}
</style>

<div class="h-bghue">
    <div class="post">
        <a href="javascript:void(0);" data-index="0" onclick="ijob.gotoPage({path:'/h5/zp/postJob2?positionTemp.id=0'})">
            <i class="iconfont icon-fabu2"></i><span>发布职位</span>
        </a>
        <a href="javascript:void(0);" data-index="1" onclick="ijob.gotoPage({path:'/h5/zp/mine/positionManage'})">
            <i class="iconfont icon-guanlikehu"></i><span>职位管理</span>
        </a>
    </div>
    <div id="urllist" class="JobV JobVtwo JobV-tit">
        <%--<a href="javascript:void(0);" data-path="/h5/zp/myjob" class="hhh JobVon">全部</a>--%>
        <a href="javascript:void(0);" data-path="/h5/zp/myjob_enroll" class="hhh" data-index="0">待录取</a>
        <a href="javascript:void(0);" data-path="/h5/zp/myjob_duty"  class="hhh"  data-index="1">已录取</a>
        <a href="javascript:void(0);" data-path="/h5/zp/myjob_close" class="hhh" data-index="2">待结算</a>
        <a href="javascript:void(0);" data-path="/h5/zp/myjob_end" class="hhh" data-index="3">已结算</a>
        <%--<a href="javascript:void(0);" data-path="/h5/zp/myjob_ev" class="hhh">待评价</a>--%>
    </div>
</div>
<div id="wrap" class="wrap">
</div>
<div class="share_code_code" style="display: none">
    <div class="mainlist">
        <div class="posi_box_list">
            <div class="areaContent">
                <h3 class="posi_tit"><span id="positiontitle"></span>  <span id="dailySalary"></span></h3>
                <div class="posi_date posi_sub">工作日期：<span id="recruitStartTime"></span></div>
                <div class="posi_num posi_sub">招聘人数：<span id="recruitsSum"></span>人/天</div>
                <div class="posi_addr posi_sub">工作地点：<span id="city"></span></div>
            </div>
            <div class="areaContent">
                <h3 class="posi_depict">职位描述：</h3>
                <div class="posi_detail">
                    这里是职位描述，多少个字符之后就是省略号！这里是职位描述，多少个字符之后就是省略号！这里是职位描述，多少个字符之后就是省略号！这里是职位描述，多少个字符之后就是省略号...
                </div>
            </div>
        </div>
        <div class="code_box">
            <div class="code_img" id="qrcodeimg">
                <%--<img src="/ijob/static/images/code.jpg" />--%>
            </div>
            <div class="code_txt">
                <h3 id="typetext">扫码即可报名</h3>
                <p>长按图片发送给朋友</p>
            </div>
        </div>
    </div>
</div>
</body>

<script>
    var menu = ijob.menu.get();
    $("#urllist").unbind().on('click','a',function(){
       menu = "myjob:"+$(this).data("index");
       ijob.menu.set(menu);
       $('#wrap').loadPage({path:$(this).data("path")});
   });

   function clickHandler() {
       if(menu.indexOf(":")!=-1){
           $("#urllist a").eq(menu.split(":")[1]).click();
       }else{
           $("#urllist a").eq(0).click();
       }
   }

   $(".hhh").click(function () {
       $(".hhh").removeClass("JobVon");
       $(this).addClass("JobVon");
   });
   $(window).scroll(function() {
       var win_top = $(this).scrollTop();
       if (win_top >= 170) {
           $(".JobVtwo ").addClass("sfixed");
       }else if (win_top < 170) {
           $(".JobVtwo ").removeClass("sfixed");
       }
   })

   clickHandler();

</script>
</html>
