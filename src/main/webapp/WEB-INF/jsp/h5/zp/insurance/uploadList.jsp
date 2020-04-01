<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/1/8
  Time: 17:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>上传名单</title>
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
<div class="upload-list">
    <div class="input-list-box">
        <div class="input-row">
            <span class="txt">保障金额</span>
            <a href="javascript:void(0);" class="money link"><span id="money">请选择保额</span><span class="iconfont icon-arrow-right"></span></a>
        </div>
        <div class="input-row">
            <span class="txt">生效月份</span>
            <a href="javascript:void(0);" class="time link"><input type="text" readonly="readonly" id="time" data-options='{"type":"month"}' value="请选择时间" /><span class="iconfont icon-arrow-right"></span></a>
        </div>
        <div class="input-row">
            <span class="txt">企业全称</span>
            <input type="text" class="enterpriseName" placeholder="请输入企业全称">
        </div>
        <div class="input-row posiName">
            <span class="txt">职业名称</span>
            <a href="javascript:void(0);" class="occupationName link"><span id="selectedSort">统一选择员工所属职业名称</span><span class="iconfont icon-arrow-right"></span></a>
            <%--选择员工所属职业名称--%>
            <div class="popup-backdrop" style="display: none;">
                <div class="popup-inner" >
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
        <div class="row-inform">
            <h3>被保人信息</h3>
            <div class="insured-box">
                <ul id="insPerson">

                </ul>
            </div>
        </div>
        <div class="add_inform">
            <a href="javascript:void(0);" class="addInsPerson"><span class="iconfont icon-jia"></span>添加被保人</a>
        </div>
    </div>
    <div class="clearfix" style="height: 70px;"></div>
    <div class="foot-flex">
        <a href="javascript:void(0);" class="uploadbtns">立即上传</a>
    </div>
    <a id="saveRecord" data-url="/ijob/api/InsuranceController/saveRecord"></a>
    <form id="form">
        <input type="hidden" id="id" name="id">
        <input type="hidden" id="version" name="version">
    </form>
</div>
</body>
</html>
<script type='text/javascript' src='/ijob/static/js/insurance/insurance.js'  charset="UTF-8"></script>
<script>
    var param = {
        "condition":{
            'status':ijob.storage.get("insured.type")
        }
    }
    $.ajax({
        type: "POST",
        url: "/ijob/api/InsuranceController/loadInsInfo",
        data:JSON.stringify(param),
        cache:false,
        contentType: 'application/json',
        async:false,
        dataType: 'json',
        success: function(result){
            $("#id").val(result.data.id);
            $("#version").val(result.data.version);
            if(result.data.insProfessionType){
                $("#selectedSort").text(result.data.insProfessionType.name);
            }
            $(".enterpriseName").val(result.data.enterpriseName);
            if(result.data.insFee){
                $("#money").text(result.data.insFee.insuredAmount+"万");
            }
            if(result.data.date){
                $("#time").val(template.dateFormat(result.data.date,"yyyy-MM"));
            }
            if(result.data.insRecordPersonList!=null){
                if(result.data.insRecordPersonList.length>0){
                    var sumHtml = "";
                    for (var i = 0 ; i < result.data.insRecordPersonList.length;i++){
                        var insProfessionType ;
                        if(result.data.insRecordPersonList[i].insProfessionType){
                            insProfessionType = result.data.insRecordPersonList[i].insProfessionType;
                        }else{
                            insProfessionType = result.data.insProfessionType
                        }
                        var html = "<li>\n" +
                            "                        <div class=\"flex\">\n" +
                            "                            <span class=\"left\"><span class=\"name\">"+result.data.insRecordPersonList[i].insPerson.name+"</span><span class=\"sex\">"+template.enums(result.data.insRecordPersonList[i].insPerson.sex,"SexType")+"</span></span>\n" +
                            "                            <span class=\"right\"><span class=\"position\">"+insProfessionType.name+"</span></span>\n" +
                            "                        </div>\n" +
                            "                        <div class=\"flex\">\n" +
                            "                            <span class=\"left\"><span class=\"identity\">"+result.data.insRecordPersonList[i].insPerson.cardID+"</span></span>\n" +
                            "                            <span class=\"right\"><span class=\"type "+template.getRiskClass(insProfessionType.risk)+"\">"+template.getRiskName(insProfessionType.risk)+"</span></span>\n" +
                            "                        </div>\n" +
                            "                    </li>";
                        sumHtml += html ;
                    }
                    $("#insPerson").html(sumHtml);
                }
            }
            ijob.storage.set("insRecordPersonList",result.data.insRecordPersonList);
            ijob.storage.set("insProfessionType",result.data.insProfessionType);
            ijob.storage.set("insRecord.id",result.data.id);
        }
    });
    //保障金额
    var picker = new mui.PopPicker();
    picker.setData([{
        text: '80万',
        value: '1'
    }, {
        text: '30万',
        value: '2'
    }]);
    $(document).on('tap', "#money", function (event) {
        picker.show(function (items) {
            $("#money").html(items[0].text);
            var insRecord = $("#form").serializeObjectJson();
            insRecord.feeID = items[0].value;
            $("#saveRecord").btPost(insRecord,function(result){
                $("#version").val(result.data.version);
            });
        });
    });
    //生效月份
    var jihe = document.getElementById("time");
    jihe.addEventListener('tap', function () {
        var optionsJson = this.getAttribute('data-options') || '{}';
        var options = JSON.parse(optionsJson);
        var picker1 = new mui.DtPicker(options);
        picker1.show(function (rs) {
            document.getElementById("time").value = rs.text;
            var insRecord = $("#form").serializeObjectJson();
            insRecord.date = rs.text+"-01";
            $("#saveRecord").btPost(insRecord,function(result){
                $("#version").val(result.data.version);
            });
            picker1.dispose();
        });
    }, false);
    $("#searchInput").keyup(function () {
        var len = $(this).val().length;
        if (len > 0){
            $(".search-list-box").show();
            slide = new Slide($(".upload-list"),$(".popup-inner"),".search-list-box");
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
                console.log(result);
                $(".search-list-box li").each(function () {
                    var _this = $(this);
                    _this.click(function(){
                        console.log(_this.data("value"));
                        var insRecord = $("#form").serializeObjectJson();
                        insRecord.professionID = _this.data("value");
                        $("#saveRecord").btPost(insRecord,function(result){
                            if(result.code==200){
                                ijob.storage.set("insProfessionType",result.data.insProfessionType);
                                $(".popup-backdrop").hide();
                                $("#selectedSort").text(_this.text());
                            }
                            $("#version").val(result.data.version);
                        });
                    });
                });
            });
        }
    });
    var arrangement = ijob.storage.get("arrangement")||"" ;
    var first,second,end;
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
                    /*选择二级目录*/
                    $("#sort3").hide();
                    $("#sort2 li").each(function () {
                        var _this = $(this);
                        _this.click(function (e) {
                            _this.addClass("active").siblings("li").removeClass("active");
                            _this.parents(".popup-backdrop").hide();
                            $("#selectedSort").html(_this.text());
                            second = $(this).data("index");
                            arrangement = first+':'+second;
                            var insRecord = $("#form").serializeObjectJson();
                            insRecord.professionID = _this.data("value");
                            $("#saveRecord").btPost(insRecord,function(result){
                                if(result.code==200){
                                    ijob.storage.set("insProfessionType",result.data.insProfessionType);
                                }
                                $("#version").val(result.data.version);
                            });
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
                    /*选择三级目录*/
                    $("#sort2 li").each(function () {
                        var _this = $(this);
                        _this.click(function (e) {
                            if (!$(e.target).hasClass("active")){
                                $("#sort3").show();
                            }
                            _this.addClass("active").siblings("li").removeClass("active");
                            _this.parents("#sort2").addClass("floating").removeClass("drift");
                            if ($(e.target) != _this.index()){
                                _this.parents("#sort2").siblings("#sort3").children("li").removeClass("active");
                            }
                            slide = new Slide($(".upload-list"),$(".popup-backdrop"),"#sort3");
                            slide.disTouch();
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
                                        end = $(this).data("index");
                                        arrangement = first+':'+second+':'+end;
                                        var insRecord = $("#form").serializeObjectJson();
                                        insRecord.professionID = _this.data("value");
                                        $("#saveRecord").btPost(insRecord,function(result){
                                            if(result.code==200){
                                                ijob.storage.set("insProfessionType",result.data.insProfessionType);
                                            }
                                            $("#version").val(result.data.version);
                                        });
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
    $(".enterpriseName").blur(function(){
        var insRecord = $("#form").serializeObjectJson();
        insRecord.enterpriseName = $(this).val();
        $("#saveRecord").btPost(insRecord,function(result){
            $("#version").val(result.data.version);
        });
    });

    $(".addInsPerson").click(function(){
        if($("#selectedSort").text()!="统一选择员工所属职业名称"&&$("#selectedSort").text()!=""){
            ijob.storage.set('arrangement',first+':'+second+':'+end);
            ijob.gotoPage({path:'/h5/zp/insurance/choose_insured'});
        }else {
            mui.toast("请先选择参保职业名称...");
        }
    });

    // 立即上传
    $(".uploadbtns").click(function () {
        if($(".enterpriseName").val() == null || $(".enterpriseName").val() == "" ){
            mui.alert("请输入企业全称");
        }else if($("#money").text() == "请选择保额"){
            mui.alert("请选择保额");
        }else if($("#selectedSort").text() == "统一选择员工所属职业名称"||$("#selectedSort").text()==""){
            mui.alert("请选择员工所属职业名称");
        }else if($(".insured-box li").length == 0){
            mui.alert("至少要添加一个被保人");
            $(".insured-box").remove();
        }else if($("#time").val() == "请选择时间"){
            mui.alert("请选择保险生效时间");
        }else {
            var insRecord = $("#form").serializeObjectJson();
            insRecord.status = 1;
            $("#saveRecord").btPost(insRecord,function(result){
                if(result.code==200){
                    ijob.gotoPage({path:'/h5/zp/insurance/prompt'});
                }else{
                    mui.toast('上传失败...');
                }
            });
        }
    });

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
