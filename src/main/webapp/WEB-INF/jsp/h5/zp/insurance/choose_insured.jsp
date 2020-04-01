<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/1/8
  Time: 16:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>参保记录</title>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/insurance/insurance.css?version=4">
</head>
<body>
<script>
    (function ($) {
        window.addEventListener('pageshow', function (e) {
            // 通过persisted属性判断是否存在 BF Cache
            if (e.persisted) {
                location.reload();
            }
        });
    })(mui);
</script>
<div class="choose_insured">
    <script type="text/html" id="userList" data-url="/ijob/api/InsuranceController/loadInsuredWorkers" data-type="POST">
        <header class="head">
            <div class="head-lf mui-input-row">
                <i class="mui-icon mui-icon-search"></i>
                <input type="text" id="searchInput" class="mui-input-clear" placeholder="搜索求职者"  maxlength="20">
            </div>
            <div class="icon">
                <a  href="javascript:void(0);" id="code"><span class="iconfont icon-erweima"></span></a>
                <a  href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/insurance/add_insurance?data.type=1'})"><span class="iconfont icon--jia"></span></a>
            </div>
        </header>
        <%--帮你投保--%>
        <div class="popup-backdrop" style="display: none">
            <div class="popup-inner">
                <div class="portrait">
                    <div class="pohto">
                        <img id="headImage" src="/ijob/upload/{{list[0].userInfo.attachment.absolutelyPath}}" onerror="this.src='/ijob/static/images/default.jpg';this.error=null">
                    </div>
                    <div class="name">Amin</div>
                </div>
                <div class="popup-title">帮你投保</div>
                <div class="code" id="qrcodeimg">
                </div>
                <div class="popup-txt">扫一扫即可加入保障</div>
                <div class="close" id="close"><span class="iconfont icon-guanbi"></span></div>
            </div>
            <div class="down-box" style="display: none">
                <div class="line"></div>
                <div class="button">
                    <span class="iconfont icon-shanchu1"></span>
                </div>
            </div>
        </div>
        <div class="list-box">
            <%--最近报名的求职者--%>
            <div class="insured-inform">
                <div class="title">
                    <h3>三天内报名的求职者</h3>
                </div>
                <div class="insured-box insured" id="insured">
                    <ul>
                        {{each list[0].loadThreeDays as user}}
                        <li>
                            <div class="pull-left mui-input-row mui-checkbox">
                                <input type="checkbox" name="{{user.cardID}}" class="checkbox" {{#user.isCheck}}/>
                            </div>
                            <div class="pull-right">
                                <div class="flex">
                                    <div class="left">
                                        <span class="name">{{user.name}}</span><span class="sex">{{user.sex |enums:'SexType'}}</span>
                                        <a  href="javascript:void(0);" class="edit" onclick="ijob.gotoPage({path:'/h5/zp/insurance/add_insurance?data.type=2&insPerson.name={{user.name}}&insPerson.cardID={{user.cardID}}&insPerson.sex={{user.sex}}&insPerson.typeName={{user.insProfessionType.name}}&insPerson.value={{user.insProfessionType.id}}'})"><span class="iconfont icon-edit-fill"></span></a>
                                    </div>
                                    <span class="right"><span class="position">{{user.insProfessionType.name}}</span></span>
                                </div>
                                <div class="flex">
                                    <span class="left"><span class="identity">{{user.cardID}}</span></span>
                                    <span class="right"><span class="type {{user.insProfessionType.risk | getRiskClass}}">{{user.insProfessionType.risk | getRiskName}}</span></span>
                                </div>
                            </div>
                        </li>
                        {{/each}}
                    </ul>
                </div>
            </div>
            <%--购买过的名单--%>
            <div class="insured-inform">
                <div class="title">
                    <h3>可参保用户</h3>
                </div>
                <div class="insured-box buglist" id="buglist">
                    <ul id="allList">
                        {{each list[0].loadAllUserInsured as user}}
                        <li>
                            <div class="pull-left mui-input-row mui-checkbox">
                                <input type="checkbox" name="{{user.cardID}}" class="checkbox insPerson" {{#user.isCheck}}/>
                                <form id="{{user.cardID}}">
                                    <input type="hidden" value="{{user.id}}" name="personID">
                                    <input type="hidden" value="{{user.insProfessionType.id}}" name="professionID">
                                    <input type="hidden" value="{{user.cardID}}" name="insPerson.cardID">
                                    <input type="hidden" value="{{user.name}}" name="insPerson.name">
                                </form>
                            </div>
                            <div class="pull-right">
                                <div class="flex">
                                    <div class="left">
                                        <span class="name">{{user.name}}</span><span class="sex">{{user.sex |enums:'SexType'}}</span>
                                        <a  href="javascript:void(0);" class="edit" onclick="ijob.gotoPage({path:'/h5/zp/insurance/add_insurance?data.type=2&insPerson.name={{user.name}}&insPerson.cardID={{user.cardID}}&insPerson.sex={{user.sex}}&insPerson.typeName={{user.insProfessionType.name}}&insPerson.value={{user.insProfessionType.id}}&insPerson.id={{user.id}}'})"><span class="iconfont icon-edit-fill"></span></a>
                                    </div>
                                    <span class="right"><span class="position">{{user.insProfessionType.name}}</span></span>
                                </div>
                                <div class="flex">
                                    <span class="left"><span class="identity">{{user.cardID}}</span></span>
                                    <span class="right"><span class="type {{user.insProfessionType.risk | getRiskClass}}">{{user.insProfessionType.risk | getRiskName}}</span></span>
                                </div>
                            </div>
                        </li>
                        {{/each}}
                    </ul>
                </div>
            </div>
        </div>
        <div class="clearfix" style="clear: both;content: '';height: 1.7rem;"></div>
        <div class="foot-flex">
            <a href="javascript:void(0);" class="rules" data-url="/ijob/api/InsuranceController/saveInsRecordPersonList">返回</a>
        </div>
    </script>

</div>
</body>
</html>
<script type='text/javascript' src='/ijob/static/js/insurance/choose_insured.js'  charset="UTF-8"></script>
<script src="/ijob/static/js/utf.js"></script>
<script src="/ijob/static/js/qrcode.min.js"></script>
<script src="/ijob/static/js/html2canvas.min.js"></script>
<script>
    var url = '';
    var queryParam = {
        condition:{
            "insRecordID":ijob.storage.get("insRecord.id"),
            "insRecordPersonList":ijob.storage.get("insRecordPersonList"),
            "insProfessionType":ijob.storage.get("insProfessionType")
        }
    }
    function init(){
        $("#userList").loadData(queryParam).then(function(result){
            $(".rules").click(function(){
                var insRecordPersonList = ijob.storage.get("insRecordPersonList")||new Array();

                if(insRecordPersonList.length==0){
                    insRecordPersonList = new Array();
                    var obj = {recordID:ijob.storage.get("insRecord.id"),'isNull':true}
                    insRecordPersonList.push(obj);
                }
                $(this).btPost(JSON.stringify({'insRecordPersonList':insRecordPersonList}),function(result1){
                    if(result1.code==200){
                        ijob.gotoPage({path:'/h5/zp/insurance/uploadList'});
                    }else{
                        mui.toast("操作失败...");
                        /*setTimeout(function () {
                            ijob.back();//默认返回页面
                        }, 1000);*/
                    }
                });
            });

            var slide = null;
            // 帮你投保
            $("#code").click(function () {
                $(".popup-backdrop").show();
                slide = new Slide($(".choose_insured"),$(".popup-backdrop"),".popup-inner");
                slide.disTouch();
                initQrcode(result);
            });

            // 判断是否搜素

            $("#searchInput").keyup(function(){
                var len = $(this).val().length;
                if (len>0){
                    $(".head .icon a").remove();
                    $(".head .icon").html("<a href='javascript:void(0);' id='searchbtns' onclick='searchUser()' class='searchbtns'>搜索</a>");
                }else {
                    $(".head .icon").html("<a  href=\"javascript:void(0);\" id=\"code\"><span class=\"iconfont icon-erweima\"></span></a>\n" +
                        "                <a  href=\"javascript:void(0);\" onclick=\"ijob.gotoPage({path:'/h5/zp/insurance/add_insurance?data.type=1'})\"><span class=\"iconfont icon--jia\"></span></a>");
                }
            });
            $("#searchInput").blur(function(){
                var val = $(this).val();
                if (!val){
                    queryParam.condition.name = null;
                    init();
                    $(".head .icon").html("<a  href=\"javascript:void(0);\" id=\"code\"><span class=\"iconfont icon-erweima\"></span></a>\n" +
                        "                <a  href=\"javascript:void(0);\" onclick=\"ijob.gotoPage({path:'/h5/zp/insurance/add_insurance?data.type=1'})\"><span class=\"iconfont icon--jia\"></span></a>");
                }
            });
            $(":checkbox").click(function(e){
                //停止事件冒泡,当点击的是checkbox时,就不执行父div的click
                e.stopPropagation();
            })
            /*点击一行中任意的地方选中*/
            $(".insured-box li").click(function(){
                var name = $(this).find("input").attr("name");
                var _this = $(this).find("input");
                if($(this).find("div").find("input").hasClass("checkbox")){
                    _this = $(this).find("div").find("input");
                }
                var insRecordPersonList = ijob.storage.get("insRecordPersonList")||new Array();
                /*for (var i = 0 ; i <insRecordPersonList.length ;i++){
                    if(name==insRecordPersonList[i].insPerson.cardID){
                        insRecordPersonList.splice(i,1);
                    }
                }*/
                for (var i = 0 ; i <insRecordPersonList.length ;i++){
                    if(name==insRecordPersonList[i].insPerson.cardID){
                        insRecordPersonList.splice(i,1);
                    }
                }
                if(_this.prop("checked")==false){
                    //$(this).find("input").click();//如果没该行，存在点击第二轮，不起作用。
                    if($("input[name="+name+"]").length==2){
                        $($("input[name="+name+"]")[0]).prop("checked",true);
                        $($("input[name="+name+"]")[1]).prop("checked",true);
                    }else{
                        _this.prop("checked",true);
                    }
                    var obj = $("#"+_this.attr("name")).serializeObjectJson();
                    obj.recordID = ijob.storage.get("insRecord.id");
                    insRecordPersonList.push(obj);
                }else{
                    if($("input[name="+name+"]").length>1){
                        $($("input[name="+name+"]")[0]).prop("checked",false);
                        $($("input[name="+name+"]")[1]).prop("checked",false);
                    }else{
                        _this.prop("checked",false);
                    }
                    for (var i = 0 ; i <insRecordPersonList.length ;i++){
                        if(name==insRecordPersonList[i].insPerson.cardID){
                            insRecordPersonList.splice(i,1);
                        }
                    }
                }
                queryParam.condition.insRecordPersonList = insRecordPersonList ;
                ijob.storage.set("insRecordPersonList",insRecordPersonList);
            });
            if(queryParam.condition.name){
                $("#searchInput").val(queryParam.condition.name);
                $(".head .icon a").remove();
                $(".head .icon").html("<a href='javascript:void(0);' id='searchbtns' onclick='searchUser()' class='searchbtns'>搜索</a>");
            }
        });
    }

    init();

    function searchUser() {
        $("#searchInput").val();
        queryParam.condition.name = $("#searchInput").val();
        init();
    }


    function initQrcode(result){
        if(url==''){
            url = $("#headImage").attr("src");
        }
        $(".popup-inner").html("<div class='test' ><div class=\"portrait\">\n" +
            "                    <div class=\"pohto\">\n" +
            "                        <img src=\""+url+"\">\n" +
            "                    </div>\n" +
            "                    <div class=\"name\">"+result.data.list[0].userInfo.mainName+"</div>\n" +
            "                </div>\n" +
            "                <div class=\"popup-title\">帮你投保</div>\n" +
            "                <div class=\"code\" id=\"qrcodeimg\">\n" +
            "                </div>\n" +
            "                <div class=\"popup-txt\">扫一扫即可加入保障</div>" +
            "</div>");
        mui.toast("生成图片中...");
        var urlQrcode = "${site}/share/INS/" + ijob.storage.get("insRecord.id")+"/3";
        var pw =  $("#qrcodeimg").height();
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
        setTimeout(function(){
            code2Image();
        },100);
    }

    function code2Image(){
        html2canvas($(".test")[0], {scale:2,logging:false,useCORS:true}).then(function(canvas) {
            mui.toast("生成图片成功，可以长按转发了");
            var dataUrl = canvas.toDataURL();
            $(".test").html("<img style='width:100%;border-radius:5px;'>");
            $(".popup-inner img").attr("src",dataUrl).removeClass("hide");
        });
        $(".down-box").show();
    }
</script>

<script type="text/javascript">
    $(function() {
        if (window.history && window.history.pushState) {
            $(window).on('popstate', function () {
                window.history.pushState('forward', null, '#');
                window.history.forward(1);
                var insRecordPersonList = ijob.storage.get("insRecordPersonList")||new Array();
                if(insRecordPersonList.length==0){
                    insRecordPersonList = new Array();
                    var obj = {recordID:ijob.storage.get("insRecord.id"),'isNull':true}
                    insRecordPersonList.push(obj);
                }
                $(".rules").btPost(JSON.stringify({'insRecordPersonList':insRecordPersonList}),function(result1){
                    if(result1.code==200){
                        ijob.gotoPage({path:'/h5/zp/insurance/uploadList'});
                    }else{
                        mui.toast("操作失败...");
                    }
                });
            });
        }
        window.history.pushState('forward', null, '#');
        window.history.forward(1);
    })
</script>