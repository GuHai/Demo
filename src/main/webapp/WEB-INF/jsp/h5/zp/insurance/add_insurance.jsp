<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/1/9
  Time: 10:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增被保人</title>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/insurance/insurance.css?version=4">
</head>
<body>
<div class="page_add_insurance">
    <div class="inform-list-box">
        <div class="input-row">
            <span class="txt">职业名称</span>
            <a href="javascript:void(0);" class="link occupationName"><span id="selectedSort">请选择所在职业名称</span><span class="iconfont icon-arrow-right"></span></a>
            <%--选择员工所属职业名称--%>
            <div class="popup-backdrop" style="display: none;">
                <div class="popup-inner">
                    <div class="popup-head">
                        <div class="head-lf mui-input-row">
                            <i class="mui-icon mui-icon-search"></i>
                            <input type="text" id="searchInput" class="mui-input" placeholder="搜索职业名称"  maxlength="20">
                        </div>
                        <div class="icon">
                            <a  href="javascript:void(0);" id="close" data-value="2">取消</a>
                        </div>
                    </div>
                    <div class="search-list-box" style="display: none">
                        <ul>
                            <script type="text/html" id="findVocation" data-url="/ijob/api/InsuranceController/findVocation" data-type="POST">
                                {{each list as vocation}}
                                <li data-value="{{vocation.id}}" >{{vocation.name}}</li>
                                {{/each}}
                            </script>
                        </ul>
                    </div>
                    <div class="popup-list screenlist">
                        <ul id="sort1">
                            <script type="text/html" id="firstMenu" data-url="/ijob/api/InsuranceController/findListByLevel" data-type="POST">
                                {{each list as ins i}}
                                <li class="" data-value="{{ins.id}}" data-index="{{i}}"><a href="javascript:void(0)">{{ins.name}}</a></li>
                                {{/each}}
                            </script>
                        </ul>
                        <ul id="sort2" style="display: none">
                            <script type="text/html" id="secondMenu" data-url="/ijob/api/InsuranceController/findListByLevel" data-type="POST">
                                {{each list as ins i}}
                                <li class="" data-value="{{ins.id}}" data-index="{{i}}"><a href="javascript:void(0)">{{ins.name}}</a></li>
                                {{/each}}
                            </script>
                        </ul>
                        <ul id="sort3" style="display: none">
                            <script type="text/html" id="endMenu" data-url="/ijob/api/InsuranceController/loadEndMenu" data-type="POST">
                                {{each list as ins i}}
                                <li class="" data-value="{{ins.id}}" data-index="{{i}}"><a href="javascript:void(0)">{{ins.name}}</a></li>
                                {{/each}}
                            </script>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <form id="form">
            <div class="mg-top">
                <input type="hidden" name="id" id="id">
                <input type="hidden" name="personID" id="personID">
                <input type="hidden" value="" id="professionID" name="professionID">
                <div class="input-row">
                    <span class="txt">被保人</span>
                    <input type="text" class="insuredName" name="name" maxlength="5" placeholder="请输入被保人姓名">
                </div>
                <div class="input-row mui-row-input sex">
                    <span class="txt">性别</span>
                    <div class="mui-radio">
                        <label><input type="radio" name="sex" value="1">男</label>
                        <label><input type="radio" name="sex" value="2">女</label>
                    </div>
                </div>
            </div>
            <div class="mg-top">
                <div class="input-row">
                    <span class="txt">证件号码</span>
                    <input type="text" class="identity" name="cardID" placeholder="请输入身份证号码">
                </div>
            </div>
        </form>
    </div>
    <div class="foot-flex">
        <a href="javascript:void(0);" class="conserve" data-url="/ijob/api/InsuranceController/saveOrUpdatePersonInfo">保存</a>
    </div>
</div>
</body>
</html>
<script type='text/javascript' src='/ijob/static/js/insurance/insurance.js'  charset="UTF-8"></script>
<script>
    if(ijob.storage.get("data.type")==2){
        document.title = "修改被保人信息";
        $(".identity").val(ijob.storage.get("insPerson.cardID"));
        $(".insuredName").val(ijob.storage.get("insPerson.name"));
        if(ijob.storage.get("insPerson.sex")==1){
            $($("input[type=radio]")[0]).prop("checked",true);
        }else{
            $($("input[type=radio]")[1]).prop("checked",true);
        }
        $("#professionID").val(ijob.storage.get("insPerson.value"));
        $("#selectedSort").html(ijob.storage.get("insPerson.typeName"));
        $("input[type=radio]").attr("readonly","readonly");
        $(".identity").attr("readonly","readonly");
        $(".insuredName").attr("readonly","readonly");

    }else if(ijob.storage.get("data.type")==3){
        document.title = "填写个人信息";
    }else if(ijob.storage.get("data.type")==1){
        $("#professionID").val(ijob.storage.get("insProfessionType").id);
        $("#selectedSort").html(ijob.storage.get("insProfessionType").name);
    }

   var arrangement = ijob.storage.get("arrangement")||"" ;
   var first,second,end;

    $("#searchInput").keyup(function () {
        var len = $(this).val().length;
        if (len > 0){
            $(".search-list-box").show();
            slide = new Slide($(".page_add_insurance"),$(".popup-inner"),".search-list-box");
            slide.disTouch();
            $(".screenlist").hide();
            $("#close").text("搜索");
            $("#close").data("value",1);
        }else{
            $("#close").text("取消");
            $("#close").data("value",2);
        }
    });
    $("#close").click(function(){
        if($(this).data("value")==2){
            $(".popup-backdrop").hide();
        }else{
            $("#findVocation").loadData({condition:{"name":$("#searchInput").val().trim()}}).then(function(result){
                $(".search-list-box li").each(function () {
                    var _this = $(this);
                    _this.click(function(){
                        $(".popup-backdrop").hide();
                        $("#professionID").val(_this.data("value"));
                        $("#selectedSort").html(_this.text());
                    });
                });
            });
        }
    });
   //加载一级目录
   $("#firstMenu").loadData({condition:{'firstMenu':'firstMenu'}}).then(function(result){
       // 选择一级目录
       $("#sort1 li").each(function () {
           var _this = $(this);
           _this.click(function (e) {
               $("#sort2").show();
               _this.addClass("active").siblings("li").removeClass("active");
               _this.parents("#sort1").addClass("floating");
               _this.parents("#sort1").siblings("#sort2").addClass("drift");
               if ($(e.target) != _this.index()){
                   _this.parents("#sort1").siblings("#sort2").children("li").removeClass("active");
               }
               slide = new Slide($(".upload-list"),$(".popup-backdrop"),"#sort2");
               slide.disTouch();
           })
       })
       $("#sort1 li").click(function(){
           var _firstThis = $(this);
           first = $(this).data("index");
           if($(this).data('value')==0){
               $("#secondMenu").data('url',"/ijob/api/InsuranceController/shortTimeIndustry");
           }else{
               $("#secondMenu").data('url',"/ijob/api/InsuranceController/findListByLevel");
           }
           //加载二级目录
           $("#secondMenu").loadData({condition:{'parentID':$(this).data('value')}}).then(function(resutl1){
               if(resutl1.data.list.length==0){
                   $(".nodata").remove();
               }
               if(_firstThis.data('value')==0){
                   /*选择三级目录*/
                   $("#sort2 li").each(function () {
                       var _this = $(this);
                       _this.click(function (e) {
                           _this.addClass("active").siblings("li").removeClass("active");
                           _this.parents(".popup-backdrop").hide();
                           $("#selectedSort").html(_this.text());
                           second = $(this).data("index");
                           arrangement = first+':'+second;
                           $("#professionID").val(_this.data("value"));
                       })
                   })
                   if(arrangement.indexOf(":")>-1){
                       var menuArr = arrangement.split(":");
                       if(menuArr.length>1&&menuArr[0]==first){
                           $("#sort3 li")[menuArr[1]].click();
                           $($("#sort3 li")[menuArr[1]]).parents(".popup-backdrop").show();
                       }
                   }
               }else{
                   /*选择二级目录*/
                   $("#sort2 li").each(function () {
                       var _this = $(this);
                       _this.click(function (e) {
                           $("#sort3").show();
                           _this.addClass("active").siblings("li").removeClass("active");
                           _this.parents("#sort2").addClass("floating").removeClass("drift");
                           _this.parents("#sort2").css("width","25%");
                           _this.parents("#sort2").siblings("#sort1").css("width","25%");
                           _this.parents("#sort2").siblings("#sort3").css({"width":"50%","height":"90%"});
                           if ($(e.target) != _this.index()){
                               _this.parents("#sort2").siblings("#sort3").children("li").removeClass("active");
                           }
                           second = $(this).data("index");
                           //加载三级目录
                           $("#endMenu").loadData({condition:{"professionID":_this.data('value')}}).then(function(result2){
                               /*选择三级目录*/
                               $("#sort3 li").each(function () {
                                   var _this = $(this);
                                   _this.click(function (e) {
                                       _this.addClass("active").siblings("li").removeClass("active");
                                       _this.parents(".popup-backdrop").hide();
                                       $("#selectedSort").html(_this.text());
                                       $("#professionID").val(_this.data("value"));
                                       end = $(this).data("index");
                                       arrangement = first+':'+second+':'+end;
                                   })
                               });
                               if(arrangement.indexOf(":")>-1){
                                   var menuArr = arrangement.split(":");
                                   if(menuArr.length>2&&menuArr[1]==second&&menuArr[0]==first){
                                       $("#sort3 li")[menuArr[2]].click();
                                       _this.parents(".popup-backdrop").show();
                                   }
                               }
                           });
                       });
                   });
                   if(arrangement.indexOf(":")>-1){
                       var menuArr = arrangement.split(":");
                       if(menuArr.length>1&&menuArr[0]==first){
                           $("#sort2 li")[menuArr[1]].click();
                       }
                   }
               }
           });
       });
   });

   $(".conserve").click(function(){
       if($("#selectedSort").text() == "统一选择员工所属职业名称"){
           mui.alert("请选择员工所属职业名称");
       }else if($(".insuredName").val() == null || $(".insuredName").val() == ""){
           mui.alert("请输入被保人姓名");
       }else if($('input:radio[name="sex"]:checked').val() == null){
           mui.alert("请选择性别");
       }else if($(".identity").val() == null || $(".identity").val() == ""){
           mui.alert("请输入身份证号码");
       }else if(IdentityCodeValid($(".identity").val())==false){
           return ;
       }else {
           var insPerson = $("#form").serializeObjectJson();
           insPerson.insRecordID = ijob.storage.get("insRecord.id");
           $(this).btPost(insPerson,function(result){
               if(result.code==501){
                    mui.toast(result.msg);
               }else if(result.code==200) {
                   mui.toast("添加成功,正在为你返回...");
                   var recordPersonList = ijob.storage.get("insRecordPersonList");
                   if(ijob.storage.get("data.type")!=3){
                       if(recordPersonList==null){
                           recordPersonList = new Array();
                       }
                       for (var i = 0 ; i <recordPersonList.length ;i++){
                           if(result.data.insPerson.cardID==recordPersonList[i].insPerson.cardID){
                               recordPersonList.splice(i,1);
                           }
                       }
                       recordPersonList.push(result.data);
                       ijob.storage.set("insRecordPersonList",recordPersonList);
                        setTimeout(function(){
                            history.back();
                        },500)
                   }else{
                       ijob.gotoPage({path:"/h5/success"});
                   }
               }
           });
       }
   });

    function IdentityCodeValid(code) {
        code = ( code||"").toUpperCase();
        var city={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外 "};
        var tip = "";
        var pass= true;
        if(!code || !/^\d{6}(18|19|20)?\d{2}(0[1-9]|1[012])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i.test(code)){
            tip = "身份证号格式错误";
            pass = false;
        }
        else if(!city[code.substr(0,2)]){
            tip = "地址编码错误";
            pass = false;
        }
        else{
            //18位身份证需要验证最后一位校验位
            if(code.length == 18){
                code = code.split('');
                //∑(ai×Wi)(mod 11)
                //加权因子
                var factor = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];
                //校验位
                var parity = [ 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 ];
                var sum = 0;
                var ai = 0;
                var wi = 0;
                for (var i = 0; i < 17; i++)
                {
                    ai = code[i];
                    wi = factor[i];
                    sum += ai * wi;
                }
                var last = parity[sum % 11];
                if(parity[sum % 11] != code[17]){
                    tip = "请填写正确的身份证号码！"; //校验位错误
                    pass =false;
                }
            }
        }
        if(!pass) mui.alert(tip);
        return pass;
    }
    $(function() {
        if (window.history && window.history.pushState) {
            $(window).on('popstate', function () {
                if($(".popup-backdrop").is(':hidden')==false){
                    window.history.pushState('forward', null, '#');
                    window.history.forward(1);
                    $(".popup-backdrop").hide();
                }else{
                    window.history.go(-1);
                }
            });
        }
        window.history.pushState('forward', null, '#');
        window.history.forward(1);
    })
</script>