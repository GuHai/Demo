<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/5
  Time: 19:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>签到</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <script src="/ijob/static/js/map2.js"></script>
    <link rel="stylesheet" href="/ijob/static/css/My_part-time/signIn.css">
    <script src="/ijob/static/js/ijobbase.js"></script>

    <style>


        .img-box {
            margin-top: 0.267rem;
            //background-color: #fff;
        }
        .z_photo {
            padding: 0.480rem;
        }
        .z_photo .z_file {
            position: relative;
            width: 2.987rem;
            height: 2.987rem;
            background-color: #f2f5f7;
            text-align: center;
            line-height: 2.987rem;
        }
        .z_file .file {
            width: 100%;
            height: 100%;
            opacity: 0;
            position: absolute;
            top: 0px;
            left: 0px;
            z-index: 100;
        }
        .z_photo .up-section {
            position: relative;
            margin-right: 2px;
            margin-bottom: 0.267rem;
        }
        .up-section .close-upimg {
            position: absolute;
            top: 0.160rem;
            right: 0.213rem;
            display: none;
            z-index: 10;
        }
        .up-section .up-span {
            display: block;
            width: 100%;
            height: 100%;
            visibility: hidden;
            position: absolute;
            top: 0px;
            left: 0px;
            z-index: 9;
            background: rgba(0, 0, 0, 0.5);
        }
        .up-section:hover {
            border: 2px solid #f15134;
        }
        .up-section:hover .close-upimg {
            display: block;
        }
        .up-section:hover .up-span {
            visibility: visible;
        }
        .z_photo .up-img {
            display: block;
            width: 100%;
            height: 100%;
        }
        .upimg-div .up-section {
            width: 2.960rem;
            height: 2.987rem;
        }
        .img-box .upimg-div .z_file {
            width: 2.880rem;
            height: 2.880rem;
            margin-right: 0.133rem;
            margin-bottom: 0.133rem;
        }
        .z_file .add-img {
            display: block;
            width: 2.960rem;
            height: 2.987rem;
        }
        .PostJob .btnBox {
            margin-top: 0.533rem;
            width: 100%;
        }
        .PostJob .btnBox .btn_sub {
            display: block;
            width: 9.093rem;
            height: 0.933rem;
            background-color: #108ee9;
            border-radius: 0.453rem;
            color: #fff;
            padding: 0;
            border: none;
            margin: auto;
            text-align: center;
            font-size: 0.400rem;
            line-height: 0.933rem;
            letter-spacing: 0px;
        }
        .wrap .btnBox {
            margin-top: 0;
            width: 100%;
            padding: 0.3rem 0.453rem;
            margin-bottom: 0;
        }
        .wrap .btnBox .btn_sub{
            width: 100%;
        }
        .foot{
            height: 1.6rem;
        }
    </style>
</head>
<body>
<div class="wrap">
    <script id="todayJob"   type="text/html"  data-url="/ijob/api/BeenrecruitedController/get2List/{sign.id}"   data-type="GET" >
        {{each list as been}}
            <div class="head_title">
                <span>{{been.position.title}}</span>
                <span>{{been.state | enums:'BeenStatus'}}</span>
            </div>
            <div class="sign_time">
                <span class="sign_time_year">2017年12月25日<span class="sign_time_week">星期一</span></span>
                <span class="sign_time_minute">当前时间13:11</span>
            </div>
            <div class="sign_address">
                <span class="sign_address_test" ><i class="iconfont icon-test"></i>当前地址</span>
                <span class="sign_address_address" id="sitemap"></span>
            </div>
            <textarea class="textarea" name="text" id="signRemark" cols="30" rows="8" wrap="physical"
                      placeholder="请填写备注"></textarea>
             <p class="tips" id="result">0/200</p>
           <%-- <div class="upload" >
                    <img  id="myhead"  class="attachment" data-name="attachment" data-type="Head" data-id="" src="" alt=""
                  onerror="this.src='/ijob/static/images/a9.png';this.onerror=null">--%>
            <form action="" id="attaform">
                <div class="img-box">
                    <section class=" img-section">
                        <div class="z_photo upimg-div clearfix"  id="photes">
                            <section class="z_file fl">
                                <img data-editable="true" class="attachment up-img" data-name="attachmentList0"
                                     data-type="Photos" data-capture="true"
                                     data-id="" style="height: 100%;width: 100%"
                                     src="#" alt=""
                                     onerror="this.src='/ijob/static/images/a9.png';this.onerror=null"></section>
                        </div>
                    </section>
                </div>
            </form>
            <div style="clear: both;height: 60px;"></div>
            <footer class="foot">
                <div class="btnBox">
                    <input id="signtype" type="button" class="btn_sub" value="签到" data-url="/ijob/api/SigninController/add">
                </div>
            </footer>
        {{/each}}
    </script>
</div>
</body>
<jsp:include page="../../qz/base/resource.jsp"/>
<script src="/ijob/static/js/wxlocation.js"></script>

<script>
    var title = ijob.storage.get("data.sign.title");
    document.title = title;

    $(document).on("input propertychange", '#signRemark', function () {
        var len = $("#signRemark").val().length;
        $('#result').text(len + '/200');
        $(".btn_sub").css({"background-color":""});
        if (len > 200) {
            $(".btn_sub").css({"background-color":"#999"});
        }
    });

    $("#todayJob").loadData().then(
        function(result){

            $("#signtype").val(title);
            var myDate = new Date();
            $(".sign_time_year").html(template.dateFormat(myDate,"yyyy年MM月dd日")+"<span class=\"sign_time_week\">"+template.dateFormat(myDate,"周W")+"</span>")
            $(".sign_time_minute").text("当前时间："+template.dateFormat(myDate,"hh:mm"));

            var index=0;
            $("#photes").attachment();
            $("#photes").on('deleteEvent',function(){
            });
            $("#photes").on("uploadCompletionEvent", function () {
                index++;
                if(index<9) {
                    $(this).prepend("<section  class=\"z_file fl\">\n" +
                        "    <img   data-editable=\"true\" class=\"attachment up-img\" data-name=\"attachmentList" + index + "\" data-type=\"Photos\"\n" +
                        "          data-id=\"\"  data-capture=\"true\" style=\"height: 100%;width: 100%\"\n" +
                        "          src=\"#\" alt=\"\"\n" +
                        "          onerror=\"this.src='/ijob/static/images/a9.png';this.onerror=null\">\n" +
                        "</section>");
                    setTimeout(function () {
                        $("#photes").find("section").eq(0).attachment();
                    }, 100);
                }
            });

            if(title=='签到'){  //如果是签到，则隐藏掉
                $("#signRemark").hide();
                $("#result").hide();
            }




            //查看是不是关注
            ijobbase.checkSubscribe();
            var address  ={
                longitude:'',
                latitude:'',
                detailedAddress:'',
                cityID:''
            };

            var latlng = ijob.storage.get("data.latlng");
            var key,signIn  ;
            if(latlng) {
                key = latlng.key;
                if (key && key == "signIn" && latlng.value) {
                    signIn = {
                        lng: latlng.value.lng,
                        lat: latlng.value.lat,
                        addr: latlng.value.addr
                    }
                    site.region.parse(latlng.value.district||latlng.value.city,'',function(res){
                        signIn.cityID = res.id;
                        signIn.cityname = res.cityName;
                    });

                }
            }
            if(signIn&&signIn.cityname){
                setvalueforworkplace(signIn);
            }else{
                var workPlace = ijob.location.get();
                var myloc = {};
                if(workPlace && workPlace.addr){
                    setvalueforworkplace(workPlace);
                }else{
                    document.title = "获取地理位置中...";
                    wxlocation.location(myloc).then(function(local){
                        document.title = "签到";
                        setvalueforworkplace(local);
                    })
                }

            }

            function setvalueforworkplace(workPlace){

                $("#sitemap").html(workPlace.addr + "<i class=\"iconfont icon-fujin\"></i>");
                address.longitude = workPlace.lng;
                address.latitude = workPlace.lat;
                address.detailedAddress = workPlace.addr;
                address.cityID = workPlace.cityID;

            }


            $(".sign_address").click(function(){
                ijob.gotoPage({url:"/ijob/api/WeixinController/localtion",data:{latlng:{key:"signIn"}}});
            })

            $(".btn_sub").click(function(){

                var obj = $("#attaform").serializeObjectJson();
                obj = ijob.parseFromFormObject(obj, ["attachmentList"]);
                obj  = $.extend(obj, {"title":title,"mark":$("#signRemark").val(),"address":address,"positionID":result.data.list[0].positionID,"signinType":result.data.list[0].state});
                $(this).btPost(obj,function(data){
                    ijob.menu.set("findJob:2");
                    ijob.storage.set("latlng",null);

                    if(data.success){
                        var msg  = title +"成功"+(title=="签到"?"请工作结束后记得签退":"");
                        alert(msg);
                        ijob.back();
                    }else{
                        mui.alert(data.msg);
                    }
                });
            });

            if ($(".sign_address_address").text().length > 18){
                $(".sign_address_address").css("line-height","0.48rem").parents(".sign_address").css({"height":"auto","padding":"0.267rem 0.453rem"});
            }
        }
    );

</script>
</html>
