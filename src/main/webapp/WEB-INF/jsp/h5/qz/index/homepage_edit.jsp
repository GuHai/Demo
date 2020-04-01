<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>我的工作号</title>
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/static/css/base.css">
    <link rel="stylesheet" href="/ijob/static/css/index/homepage_private.css">
    <link rel="stylesheet" href="/ijob/css/mine/chooseResume_add.css">
    <script src="/ijob/lib/jquery-2.2.3.js"></script>
    <script src="/ijob/lib/mui/js/mui.min.js"></script>
    <script src="/ijob/lib//lib-flexible.js"></script>
    <script src="/ijob/static/js/ijob.js"></script>
    <jsp:include page="../../qz/base/resource.jsp"/>
</head>
<body>
<div class="wrap">
    <div class="cut_bg">
        <div class="pic_box">

            <img  id="myhead"  class="attachment" data-name="bgp" data-type="Head"
                  data-id="${OtherUserInfomation.bgpID}" style="height: 160px;width: 400px"
                  src="/ijob/upload/${OtherUserInfomation.bgp.absolutelyPath}" alt=""
                  onerror="this.src='/ijob/static/images/xuex.png';this.onerror=null">

        </div>
        <div class="btns"><a href="javascript:void(0);" onclick="changePicHandler();">点击更换背景<i class="iconfont icon-arrow-right"></i></a></div>
    </div>
    <div class="contentBox">
        <img class="pic_toux" src="${OtherUser.imgPath}" alt="">
        <div class="contentRight">
            <div class="con_div1">
                <span>工作号：</span>
                <span>${OtherUserInfomation.workNumber==null?'无工作号':OtherUserInfomation.workNumber}</span>
            </div>
            <div class="con_div2">
                <span>昵称：</span>
                <span id="nickName">${OtherUser.nickName}</span>
            </div>
            <p class="con_p">${OtherUserEducational.schoolName==null?'未知学校':OtherUserEducational.schoolName}<i></i><span>${OtherUserEducational.education==null?'未知学历':OtherUserEducational.education}</span></p>
            <div class="edit_btns" >
                编辑
            </div>
        </div>
    </div>
    <ul class="tabList">
        <li><span class="active">招聘</span></li>
        <li><span>简介</span></li>
    </ul>

    <div class="tabContent">
        <div class="tab_job">
            <c:if test="${empty OtherUserPosition}">
                <div class="list-none">
                    <p class="con_p"> 暂未发布其他职位信息</p>
                </div>
            </c:if>
            <c:forEach items="${OtherUserPosition}" var="position">
                <div class="list-container"   onclick="ijob.gotoPage({path:'/h5/qz/index/part_time_detail?data.position.id=${position.id}'})">
                    <div class="list-title">
                        <span class="title-content">${position.title}</span>
                        <span class="titel-note"></span>
                    </div>
                    <div class="list-content">
                        <div class="content-tit" style="background: ${position.huntingtype.codeGrade}">${position.huntingtype.name}</div>
                        <div class="content-msg">
                            <div class="content-msg1">
                                    <span class="content-msg1-lf"><i
                                            class="iconfont icon-shizhong"></i><fmt:formatDate value="${position.recruitStartTime}" pattern="MM月dd日" /> - <fmt:formatDate value="${position.recruitEndTime}" pattern="MM月dd日" /></span>
                                <span class="content-msg1-rt"><fmt:formatNumber type="number" value="${position.dailySalary}" maxFractionDigits="0"/>元/天</span>
                            </div>
                            <div class="content-msg2">
                                    <span class="content-msg2-lf">
                                        <c:choose>
                                            <c:when test="${position.sexRequirements == 0}">
                                            只限女生
                                            </c:when>
                                            <c:when test="${position.sexRequirements == 1}">
                                            只限男生
                                            </c:when>
                                            <c:when test="${position.sexRequirements == 2}">
                                            男女不限
                                            </c:when>
                                        </c:choose>
                                        &nbsp;<span
                                            class="line"></span>&nbsp;${position.beenRecruitedSum}/${position.recruitsSum}人</span>
                                <span class="content-msg2-rt">
                                    <c:choose>
                                        <c:when test="${position.settlement == 1}">
                                            日结
                                        </c:when>
                                        <c:when test="${position.settlement == 2}">
                                            周结
                                        </c:when>
                                        <c:when test="${position.settlement == 3}">
                                            月结
                                        </c:when>
                                        <c:when test="${position.settlement == 4}">
                                            完工结算
                                        </c:when>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="content-msg3">
                                <span class="content-msg3-lf">${position.workPlace == null ? '未知':position.workPlace.city.cityName}&nbsp; 0.37km</span>
                                <span class="content-msg3-rt">${OtherUserInfomation.workNumber!=null?OtherUserInfomation.workNumber:OtherUser.nickName}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="text_resume" style="display: none">
            <textarea class="textarea" id="brief" onfocus="if(value=='请填写简介……'){value=''}" onblur="if (value ==''){value='请填写简介……'}">${OtherUserInfomation.brief}</textarea>
            <div class="private_footer_fixed">
                <a href="javascript:void(0);">
                    <div class="btn" onclick="saveBirf(this)" data-id="${OtherUserInfomation.id}" data-version="${OtherUserInfomation.version}" data-url="/ijob/api/InformationController/update">保存</div>
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script>

    function saveBirf(arg){
        var brief = $("#brief").val();
        if(brief != "" && brief != null && brief.indexOf("请填写简介") == -1 ){
            var params = {
                "id":$(arg).data("id"),
                "version":$(arg).data("version"),
                "brief":$("#brief").val()
            };
            $(arg).btPost(params,function(data){
                var version = parseInt($(arg).data("version"));
                $(arg).data("version",version + 1);
            });
        }
    }

    $(function(){

        $("#myhead").attachment();

        $("#myhead").on("uploadCompletionEvent", function () {
            var attachment = {
                "datestr":$("input[name='bgp.datestr']").val(),
                "path":$("input[name='bgp.path']").val(),
                "name":$("input[name='bgp.name']").val(),
                "type":$("input[name='bgp.type']").val(),
                "version":$("input[name='bgp.version']").val(),
                "id":$("input[name='bgp.id']").val(),
                "isDeleted":$("input[name='bgp.isDeleted']").val()
            };
            var obj = {"bgp":attachment,"id":"${OtherUserInfomation.id}","version":"${OtherUserInfomation.version}"};
            $.ajax({
                url: "/ijob/api/InformationController/changeBgp",
                type: "POST",
                dataType: 'json',
                async: false,
                contentType: 'application/json',
                data: JSON.stringify(obj),
                success: function (data) {
                    mui.toast("保存背景图片成功");
                },
                error: function (e) {
                   mui.toast("保存图片错误");
                },
                complete: function () {

                }
           });
        });

        $(".edit_btns").click(function(){
            window.location.href = "/ijob/api/InformationController/h5/mine/basicInfo";
        });
        //隐藏多余的字
        var nickname = $('#nickName').text();
        if(nickname.length>12){
            $("#nickName").text(nickname.substring(0,12)+"...");
        }
        //加载完成后，根据是否已关注设置属性 data-url 的值
        var isAttention = '${isAttention}';
        if (isAttention == "true"){
            $("#follow").text("已关注");
            //$("#follow").data("url","/ijob/api/AttentionController/delete")
        }else{
            $("#follow").text("关注");
            //$("#follow").data("url","/ijob/api/AttentionController/update")
        }


        $("#follow").click(function (){
                var userID = '${OtherUser.id}';
                var text = $.trim($("#follow").text());
                if (text == "已关注"){
                    var btnArray = ['否','是'];
                    mui.confirm('确认取消关注？', '', btnArray, function(e) {
                        if (e.index == 1) {
                            var params = {
                                // "version":$(arg).attr("name"),
                                "userID":userID,
                                // "deleted":false
                            };
                            $("#follow").btPost(params,function(){
                                $("#follow").text("关注").data("url","/ijob/api/AttentionController/update");
                            });
                        }
                    });
                }else {
                    var params = {
                        // "version":$(arg).attr("name"),
                        "userID":userID,
                        // "deleted":true
                    };
                    $("#follow").btPost(params,function(){
                        //$("#follow").text("已关注").data("url","/ijob/api/AttentionController/delete");
                    });
                }

            });
    });


    $(".tabList>li").on("click",function () {
        var nub=$(this).index();
        $(this).children().addClass("active").parent().siblings("li").children().removeClass("active");
        $(".tabContent>div").eq(nub).show().siblings().hide();
    });

    function changePicHandler() {
        $("#myhead").trigger('click');
    }

    <%--var id = "${OtherUser.id}";--%>
    <%--var type = "${type}";--%>
    <%--$("#follow").click(function(id,type) {--%>
        <%--var _this = $(this);--%>
        <%--var flag = true;--%>
        <%--if (type == "1") {--%>
            <%--flag = false;--%>
            <%--var btn = ['取消', '确定'];--%>
            <%--mui.confirm('确定要取消关注吗？', '提示', btn, function (e) {--%>
                <%--flag = true;--%>
            <%--});--%>
        <%--}--%>

        <%--if (flag) {--%>
            <%--type = (type=='1'?'0':'1');--%>
            <%--_this.btPost({--%>
                <%--'userID': '${OtherUser.id}',--%>
                <%--'isDeleted': type=='1'?false:true--%>
            <%--}, function (data) {--%>
                <%--if(_this.text()=="关注"){--%>
                    <%--_this.text("已关注");--%>
                <%--}else{--%>
                    <%--_this.text("关注");--%>
                <%--}--%>
            <%--});--%>
        <%--}--%>
    <%--});--%>



</script>










