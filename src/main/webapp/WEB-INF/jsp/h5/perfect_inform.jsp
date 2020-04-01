<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>完善个人信息</title>
    <link rel="stylesheet" href="/ijob/static/css/inform.css?version=4">
    <script src="/ijob/static/js/map2.js"></script>
    <jsp:include page="qz/base/link.jsp"/>
    <jsp:include page="qz/base/resource.jsp"/>
</head>
<body style="background: #fff">
    <div class="wrap">
        <div class="page_perfect_inform">
            <%--用户信息--%>
            <div class="pf_hd">
                <div class="hd-main">
                    <div class="photo">
                        <img src="<shiro:principal property="imgPath"/>" onerror="this.src='/ijob/static/images/default.jpg'";/>
                    </div>
                    <div class="name"><shiro:principal property="nickName"/></div>
                </div>
            </div>
            <%--选择信息--%>
            <div class="pf_main">
                <div class="row-list">
                    <p class="tit">*选择身份</p>
                    <div class="select-type">
                        <div class="st_radio mui-input-row mui-radio mui-left">
                            <label><input type="radio" checked="checked" name="radio" id="st_radio"/>&nbsp;<span class="txt">在校生</span></label>
                        </div>
                        <div class="so_radio mui-input-row mui-radio mui-left">
                            <label><input type="radio"  name="radio" id="so_radio"/>&nbsp;<span class="txt">非学生</span></label>
                        </div>
                    </div>
                </div>
                <div class="school-content">
                    <div class="s_main_box">
                        <div class="st_type_list row-list mg-top">
                            <p id="schoolName" class="tit">*学校</p>
                            <div class="input">
                                <input type="text" name="school" placeholder="请输入学校名称" id="Myschool">
                            </div>
                        </div>
                        <%--<div class="so_type_list row-list mg-top" style="display: none">
                            <p class="tit">*母校/附近学校</p>
                            <div class="input">
                                <input type="text" name="school" placeholder="请输入学校名称" id="NearSchool">
                            </div>
                        </div>--%>
                    </div>
                    <%-- 学校搜索显示信息选择--%>
                    <div class="search-list" style="display: none;">
                        <div class="search-main">
                            <ul>
                                <script id="schooltemp"   type="text/html"  data-url="/ijob/api/WorkNumberController/getSchoolList/">
                                    {{each list as school index}}
                                        <li data-value="{{school.name}}" data-id="{{school.id}}">{{#school | keyword:'name'}}</li>
                                    {{/each}}
                                </script>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="button-box">
                <a href="javascript:void(0)" class="nextbtns"  data-url="/ijob/api/WorkNumberController/bindingSchool">下一步</a>
            </div>
        </div>
    </div>
</body>
<script>
    var keyword = "";
    var search = 0;
    var isStudents = true;
    var school ;



    // 选择身份
    $("#st_radio").click(function () {
        if ($(this).is(':checked')) {
            $("#schoolName").text("*学校");
            isStudents = true;
            $("#schooltemp").data("url","/ijob/api/WorkNumberController/getSchoolList");
        }
    });
    $("#so_radio").click(function () {
        if ($(this).is(':checked')) {
            $("#schoolName").text("*推荐附近学校");
            isStudents = false;
            $("#schooltemp").data("url","/ijob/api/WorkNumberController/attachedSchoolList");
            var local = ijob.location.get();
            $("#schooltemp").loadData({condition:{lat:local.lat,lng:local.lng},pageSize:5,currentPage:1}).then(function(result){
                $(".search-list").show();
            });
        }
    });


    $("#Myschool").on('input',function(){
        $(".search-list").show();
        keyword  = $("#Myschool").val()||null;
        clearTimeout(search);
        search = setTimeout(function(){
            searchSchool();
        },1000);
    });
    function searchSchool(){
        $("#schooltemp").data("url","/ijob/api/WorkNumberController/getSchoolList/"+(keyword||"all"));
        $("#schooltemp").loadData().then(function(result){
            if(result.data.list.length==0){
                $(".nodata").remove();
                $("#schooltemp").after("<li class='tosearch'  style='text-decoration: underline;color:#108ee9'>没有你的学校？</li>");
            }
        });
    }

    var latlng = ijob.storage.get("data.latlng");
    if (latlng) {
        key = latlng.key;
        if (key && key == "schoolPlace" && latlng.value) {
            var schoolPlace = {
                longitude: latlng.value.latlng.lng,
                latitude: latlng.value.latlng.lat,
                detailedAddress: latlng.value.poiaddress,
                name: latlng.value.poiname
            }
            site.region.parse(latlng.value.poiaddress,latlng.value.cityname,function(res){
                schoolPlace.cityID = res.id;
                schoolPlace.cityname = res.cityName;
            });
            //ijob.storage.set("worknumber.schoolPlace", schoolPlace);
            mui.confirm("是否添加\“"+schoolPlace.name+"\”","添加学校",["是","否"],function(e){
                if (e.index == 0) {//点击是
                    var schoolobj  = {
                        schoolAddr:schoolPlace,
                        name:schoolPlace.name
                    };
                    $(this).btPost("/ijob/api/WorkNumberController/addSchool",JSON.stringify(schoolobj),function(result){
                        if(result.success){ //成功后刷新页面
                            $("#Myschool").val(schoolobj.name);
                            school = {
                                name: result.data.name,
                                id: result.data.id,
                                isStudents: isStudents
                            };
                            ijob.storage.set("data.latlng",null);
                        }else{
                            mui.alert(result.msg);
                        }
                    });
                }
            });
        }
    }
    $(".search-list").on('click','.tosearch',function(){
        ijob.gotoPage({url: "/ijob/api/WeixinController/map", data: {latlng: {key: "schoolPlace"}}});
    });

    $(".search-list").on('click','li:not(.tosearch)',function(){
        school = {
            name: $(this).data("value"),
            id: $(this).data("id"),
            isStudents: isStudents
        };
        $("#Myschool").val(school.name);
        $(".search-list").hide();
    });

    $(".nextbtns").on("click",function(){
        if(school){
            $(this).btPost(school,function(data){
                mui.toast(data.msg);
                if(data.success==true){
                    ijob.storage.set("myschool",school);
                    ijob.gotoPage({path:'/h5/job_intension'})
                }
            })
        }else{
            mui.alert("请选择已存在的学校");
        }
    });



</script>
</html>
<script src="/ijob/static/js/index/setting.js" charset="UTF-8" ></script>

