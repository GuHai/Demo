<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/11
  Time: 15:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>分享图片</title>
    <script src="/ijob/static/js/utf.js"></script>
    <script src="/ijob/static/js/qrcode.min.js"></script>
    <script src="/ijob/static/js/html2canvas.min.js"></script>
    <jsp:include page="../zp/base/resource.jsp"/>

    <script>
      function initQrcode(position,type){
            $(".mainlist").html(
                "<div class=\"code_txt\">\n" +
                "            <h3 id=\"typetext\"></h3>\n" +
                "        </div>\n" +
                "        <div class=\"code_box\">\n" +
                "            <div class=\"code_img\" id=\"qrcodeimg\">\n" +
                // "                <img src=\"/ijob/static/images/code.jpg\" />\n" +
                "            </div>\n" +
                "        </div>\n" +
                "        <div class=\"posi_box_list\">\n" +
                "            <div class=\"areaContent\">\n" +
                "                <h3 class=\"posi_tit\"><span id=\"positiontitle\"></span> <%-- <span id=\"dailySalary\"></span>--%></h3>\n" +
                "                <div class=\"flex\">\n" +
                "                    <div class=\"posi_date posi_sub\">\n" +
                "                        <img src=\"/ijob/static/images/date.png\" class=\"date\"/>\n" +
                "                        <span id=\"recruitStartTime\"></span>\n" +
                "                    </div>\n" +
                "                    <div class=\"posi_addr posi_sub\">\n" +
                "                        <img src=\"/ijob/static/images/nearby.png\" class=\"nearby\"/>\n" +
                "                        <span id=\"city\"></span>\n" +
                "                    </div>\n" +
                "                </div>\n" +
                "            </div>\n" +
                "        </div>");
            mui.toast("生成图片中...");
            $("#positiontitle").text(position.title);
            $("#city").text(position.city);
            $("#dailySalary").text(position.dailySalary);
            $("#recruitStartTime").text(position.recruitStartTime);
            $("#recruitsSum").text(position.recruitsSum);
            var content = (position.jobContent||"无职位描述").replace(/\n/g,"<br/>");
            var cs = content.split("<br/>");
            var newcontent = "";
            if(cs.length>=4){
                for(var i in cs){
                    newcontent += cs[i].substring(0,20) +"..."+(i<3?"<br/>":"");
                    if(i==3)break;
                }
            }else{
                var len = 0;
                var i = 0;
                if(cs){
                    while(len<4&&i<cs.length){
                        if(cs[i]){
                            var tp = cs[i].substring(0,Math.min(cs[i].length,20*(5-len-cs.length))  );
                            len = tp.length/20;
                            newcontent += tp +"...<br/>";
                        }
                        i++;
                    }
                }
            }
            $(".posi_detail").html(newcontent);

            var urlQrcode = "";
            if(type == 0){
                $("#typetext").text("扫码即可报名");
                urlQrcode = "${site}/share/BM/" + position.id;
            }else if(type == 1){
                $("#typetext").text("扫码即可签到");
                urlQrcode = "${site}/share/BMRQ/" + position.id;
            }else if(type == 2){
                $("#typetext").text("扫码即可申请结算");
                urlQrcode = "${site}/share/JS/" + position.id;
            }
            var pw =  $(".code_img").height();
            var width = pw;
            var height = width;
            var qrcode = new QRCode(document.getElementById("qrcodeimg"), {
                text:  urlQrcode,
                width: width, //生成的二维码的宽度
                height: height, //生成的二维码的高度
                colorDark : "#000000", // 生成的二维码的深色部分
                colorLight : "#ffffff", //生成二维码的浅色部分
                correctLevel : QRCode.CorrectLevel.H
            });
            if($("#recruitStartTime").html().length <= 7){
                $(".posi_box_list .posi_date").css("margin-left","0")
            }

            setTimeout(function(){
                code2Image();
            },100);

        }


        function code2Image(){
            html2canvas($(".mainlist")[0], {scale:2,logging:false,useCORS:true}).then(function(canvas) {
                mui.toast("生成图片成功，可以长按转发了");
                var dataUrl = canvas.toDataURL();
                $(".mainlist").addClass("codelist").html("<img style='width:100%;'>");
                $(".mainlist img").attr("src",dataUrl).removeClass("hide");
            });
        }

    </script>
</head>
<body>
<div class="share_code_code" style="display: none">
    <div class="mainlist">
        <%--<div class="code_txt">
            <h3 id="typetext">扫码即可报名</h3>
        </div>
        <div class="code_box">
            <div class="code_img" id="qrcodeimg">
                <img src="/ijob/static/images/code.jpg" />
            </div>
        </div>
        <div class="posi_box_list">
            <div class="areaContent">
                <h3 class="posi_tit"><span id="positiontitle">双十一招销售人员</span> &lt;%&ndash; <span id="dailySalary"></span>&ndash;%&gt;</h3>
                <div class="flex">
                    <div class="posi_date posi_sub">
                        <img src="/ijob/static/images/date.png" class="date"/>
                        <span id="recruitStartTime">12月12日-12月15日</span>
                    </div>
                    <div class="posi_addr posi_sub">
                        <img src="/ijob/static/images/nearby.png" class="nearby"/>
                        <span id="city">岳麓区</span>
                    </div>
                </div>
            </div>
        </div>--%>
    </div>
</div>
</body>
<script>
    $(".share_code_code").show();
    var scan = ijob.storage.get("scan");
    initQrcode(scan.position,scan.type);
</script>
</html>
