<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>填写公司信息</title>
    <script src="/ijob/static/js/map2.js"></script>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/fullTime/fullTime.css?version=4">
</head>
<body style="background: #fff">
    <div class="wrap">
        <div class="full-inform">
            <%--选择信息--%>
            <div class="inform-main">
                <div class="main_box">
                    <div class="row-list">
                        <div class="name-box">
                            <p id="corporate" class="tit">公司名称</p>
                            <div class="input">
                                <input type="text" name="school" placeholder="请填写公司" id="Mycorporate">
                            </div>
                        </div>
                    </div>
                    <div class="row-list mg-top">
                        <div class="address-box">
                            <p id="address" class="tit">公司地址</p>
                            <div class="input">
                                <input type="text" name="school" placeholder="请填写工作所在地址" id="Myaddress">
                            </div>
                        </div>
                    </div>
                </div>
                <%-- 请填写公司/请填写工作所在地址--%>
                <div class="search-list" style="display: none;">
                    <div class="search-main">
                        <ul id="CompanyInfo">
                            <script id="initCompanyInfo" type="text/html" data-url="/ijob/api/FullTimeController/findLikeCompanyList">
                                {{each list as company}}
                                    <li data-value="{{company.id}}">{{#company.company}}</li>
                                {{/each}}
                            </script>
                        </ul>
                        <ul id="LocaltionInfo">
                            <script id="initLocaltionInfo" type="text/html" data-url="/ijob/api/FullTimeController/findLikeAddressList">
                                {{each list as localtioninfo}}
                                <li data-value="{{localtioninfo.id}}">{{#localtioninfo.detailedAddress}}</li>
                                {{/each}}
                            </script>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="button-box">
                <a href="javascript:void(0)" data-url="/ijob/api/FullTimeController/addPost" class="nextbtns">保存</a>
            </div>
        </div>
    </div>
</body>
<script>
    $(function () {
        var slide = null;
        var fullWorkPlace ;
        var latlng = ijob.storage.get("data.latlng");
        if (latlng) {
            key = latlng.key;
            if (key && key == "fullWorkPlace" && latlng.value) {
                fullWorkPlace = {
                    longitude: latlng.value.latlng.lng,
                    latitude: latlng.value.latlng.lat,
                    detailedAddress: latlng.value.poiaddress,
                    name: latlng.value.poiname
                }
                site.region.parse(latlng.value.poiaddress,latlng.value.cityname,function(res){
                    fullWorkPlace.cityID = res.id;
                    fullWorkPlace.cityname = res.cityName;
                });
            }
        }

        var full = ijob.storage.get("full");
        if(full.id!=null||full.id!=""||full.id!=0||full.id!=undefined){
            $(".nextbtns").text('保存并发布');
        }
        if(fullWorkPlace){
            full.workPlace = fullWorkPlace ;
        }
        if(full.workPlace!=null){
            $("#Myaddress").val(full.workPlace.detailedAddress);
        }
        if(full.company!=null){
            $("#Mycorporate").val(full.company.company);
        }
        /*请填写公司*/
        $("#Mycorporate").change(function(){
            if($("#Mycorporate").val() != null ||$("#Mycorporate").val()!=""||$("#Mycorporate").val()!=undefined){
                $(".search-list").show();
                slide = new Slide($(".wrap"),$(".search-list"),".search-main");
                slide.disTouch();
                var dis = $(".search-list").css("display");
                $("#LocaltionInfo").hide();
                $("#CompanyInfo").show();
                $("#initCompanyInfo").loadData({condition:{company:$("#Mycorporate").val()}}).then(function(result){
                    if(result.data==null){
                        $(".nodata").remove();
                    }
                    if(dis == "block"){
                        $(".search-list li").click(function (e) {
                            var _this = $(this);
                            $("#Mycorporate").val(_this.text());
                            full.compID = _this.data("value");
                            var company = {
                                id : _this.data("value"),
                                company : _this.text()
                            }
                            full.company = company ;
                            ijob.storage.set("company",company);
                            ijob.storage.set("full",full);
                            $(".search-list").hide();
                            slide.ableTouch();
                        });
                    }
                });

            }
        });
        /*请填写工作所在地址*/
        $("#Myaddress").change(function(){
            if($("#Myaddress").val() != null ||$("#Myaddress").val()!=""||$("#Myaddress").val()!=undefined){
                $(".search-list").addClass("address-box-list").show();
                slide = new Slide($(".wrap"),$(".search-list"),".search-main");
                slide.disTouch();
                var dis = $(".search-list").css("display");
                $("#CompanyInfo").hide();
                $("#LocaltionInfo").show();
                $("#initLocaltionInfo").loadData({condition:{detailedAddress:$("#Myaddress").val()}}).then(function(result){
                    if(result.data==null){
                        $(".nodata").remove();
                    }
                    if(dis == "block"){
                        $(".search-list li").click(function () {
                            var _this = $(this);
                            if(_this.data("value")==0){
                                ijob.gotoPage({url: "/ijob/api/WeixinController/map", data: {latlng: {key: "fullWorkPlace"}}});
                            }else{
                                $("#Myaddress").val(_this.text());
                                full.addrID = _this.data("value");
                            }
                            $(".search-list").hide();
                            slide.ableTouch();
                        });
                    }

                });
            }
        });



        $(".nextbtns").on("click",function(){
            if($("#Mycorporate").val() == null ||$("#Mycorporate").val() ==""||$("#Mycorporate").val() ==undefined){
                mui.alert("请填写公司");
            }else if($("#Myaddress").val() == null ||$("#Myaddress").val() ==""||$("#Myaddress").val() ==undefined){
                mui.alert("请填写工作所在地址");
            }else {
                var company = ijob.storage.get("company") ;
                if(company){
                    if(company.company == $("#Mycorporate").val()){
                        full.company = company;
                    }else{
                        var temp = {
                            company:$("#Mycorporate").val()
                        }
                        full.company = temp;
                    }
                }else{
                    var temp = {
                        company:$("#Mycorporate").val()
                    }
                    full.company = temp;
                }
                $(this).btPost(JSON.stringify(full),function(result){
                    if(result.code==200){
                        ijob.gotoPage({path:'/h5/zp/fullTime/postSuccess'})
                    }else{
                        mui.toast("操作失败");
                    }
                })
            }
        });

    })

</script>
</html>

