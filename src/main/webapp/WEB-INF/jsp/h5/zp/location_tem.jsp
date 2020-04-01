<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>编辑模板</title>
    <jsp:include page="../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/postjob.css">
    <script src="/ijob/static/js/dateRange.js" charset="UTF-8"></script>
    <script src="http://webapi.amap.com/maps?v=1.4.6&key=dfd42cc657511c1daf483e8a46865a16"></script>
    <script src="/ijob/static/js/map2.js"></script>
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
<div class="wrap">
    <script id="postJob2template" type="text/html" data-url="/ijob/api/PositionController/h5/zp/initMyPositionTemp/{positionTemp.id}">
        {{each list as positionTemp }}
        <div class="postjob-content">
            <form name="form" action="" method="post" id="input_example" >
                <input type="hidden" id="workTypeID" name="workTypeID"value="{{positionTemp.position.workTypeID}}">
                <input type="hidden" id="includeBoard" name="includeBoard"value="{{positionTemp.position.includeBoard |ifNull:'0000'}}">
                <input type="hidden" name="id" value="{{positionTemp.position.id}}">
                <input type="hidden" name="version" value="{{positionTemp.position.version}}">
                <input type="hidden" name="salaryType" value="{{positionTemp.position.salaryType}}">
                <div class="mui-input-group">
                    <%--职位类型--%>
                    <div class="mui-input-row">
                        <label>职位类型<i>*</i></label>
                        <div class="mui-input-div release">
                            {{each positionTemp.workType as workTypeObj }}
                                {{if positionTemp.position != null }}
                                    {{if positionTemp.position.workTypeID == workTypeObj.id}}
                                    <a href="javascript:void(0);" data-value="{{workTypeObj.id}}">
                                        {{workTypeObj.name}}
                                    </a>
                                    {{/if}}
                                {{/if}}
                            {{/each}}
                            <i class="iconfont icon-arrow-right"></i>
                        </div>
                        <div class="mui-backdrop cate-content" style="display: none;">
                            <ul class="nav-select">
                                {{each positionTemp.workType as type}}
                                <li data-value="{{type.id}}">{{type.name}}</li>
                                {{/each}}
                            </ul>
                        </div>
                    </div>
                    <%--职位名称    --%>
                    <div class="mui-input-row">
                        <label>职位名称<i>*</i></label>
                        <input type="text" class="mui-input-clear" name="title" maxlength="16" placeholder="请输入职位名称" value="{{positionTemp.position.title |ifNull:''}}">
                    </div>
                    <%--薪资待遇--%>
                    <div class="mui-input-row">
                        <label>薪资待遇<i>*</i></label>
                        <div class="input-money">
                            <input type="number" class="mui-input-clear" name="salary" id="salary" oninput="if(value.length>7)value=value.slice(0,7)" placeholder="请输入金额" value="{{positionTemp.position.salary}}">
                        </div>
                        <div class="date-time">
                            <select id="select">
                                <option value="1">元/小时</option>
                                <option value="2">元/天</option>
                                <option value="3">元/周</option>
                                <option value="4">元/月</option>
                            </select>
                            <i class="iconfont icon-arrow-down1"></i>
                        </div>
                    </div>
                    <%--日薪资    --%>
                    <div class="mui-input-row">
                        <label>日薪资<i>*</i></label>
                        <input type="number" class="mui-input-clear" oninput="if(value.length>7)value=value.slice(0,7)" placeholder="请输入金额" id="dailySalary" name="dailySalary" value="{{positionTemp.position |ifNull:'','dailySalary'}}" oninput="if(value.length>7)value=value.slice(0,7)">
                    </div>
                    <%--招聘人数--%>
                    <div class="mui-input-row">
                        <label>招聘人数<i>*</i></label>
                        <input type="number" class="mui-input-clear" oninput="if(value.length>4)value=value.slice(0,4)" placeholder="请输入招聘人数" id="recruitsSum" name="recruitsSum" value="{{positionTemp.position |ifNull:'1','recruitsSum'}}">
                    </div>
                </div>
                <div class="mui-tips">
                    <p class="tips">违约金不能少于日薪资的25%&nbsp;<span>&times;</span>&nbsp;招聘人数</p>
                </div>
                <%--违约金--%>
                <div class="mui-input-group">
                    <div class="mui-input-row">
                        <label>违约金<i>*</i></label>
                        <input type="text" class="mui-input-clear"oninput="if(value.length>7)value=value.slice(0,7)" placeholder="请填写违约金金额" id="liquidatedDamages" name="liquidatedDamages" value="{{positionTemp.position.liquidatedDamages*positionTemp.position.recruitsSum}}">
                    </div>
                </div>
                <div class="mui-input-group">
                    <%--职位描述--%>
                    <div class="mui-input-row">
                        <label>职位描述</label>
                        <a href="javascript:void(0);" class="mui-input-div" onclick="jumpPagePosition('/h5/zp/job_desc',0)">
                            <span>{{positionTemp.position.jobContent |ifNull:'请填写职位描述'}}</span>
                            <i class="iconfont icon-arrow-right"></i>
                        </a>
                    </div>
                    <%--添加标签--%>
                    <div class="mui-input-row">
                        <div class="tag_add" onclick="jumpPagePosition('/h5/zp/tag_add',1)">
                            <label>添加标签</label>
                            <a href="javascript:void(0);" class="mui-input-div truncation">
                                {{if positionTemp.position.labelList != null || positionTemp.position.labelList.length != 0}}
                                已选择标签
                                {{else}}
                                请选择标签
                                {{/if}}
                                <i class="iconfont icon-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                    <%--是否管饭--%>
                    <div class="mui-input-row">
                        <label>是否管饭</label>
                        <a href="javascript:void(0);" class="mui-input-div truncation meals" id="mealput">
                            {{if positionTemp.position.includeBoard == '' || positionTemp.position.includeBoard == null}}
                            不管饭
                            {{else}}
                            {{positionTemp.position.includeBoard |formatBoard}}
                            {{/if}}
                            <i class="iconfont icon-arrow-right"></i>
                        </a>
                        <!-- 选择是否管饭 -->
                        <div class="cate">
                            <div class="catebox">
                                <div class="cateT">
                                    <div class="mui-input-row mui-checkbox">
                                        <label class="cateTit" style="width: 2.773rem;">不管饭</label>
                                        <input onclick="noIncludeBoardHave(this)" name="noIncludeBoard" class="catePut" type="checkbox"
                                               checked value="0">
                                    </div>
                                </div>
                                <div class="cateD">
                                    <div class="mui-input-row mui-checkbox">
                                        <label class="cateTit" style="width: 2.773rem;">早餐</label>
                                        <input name="isBoard" onclick="includeBoardHave(this)" class="catePut" value="1"
                                               type="checkbox">
                                    </div>
                                </div>
                                <div class="cateD">
                                    <div class="mui-input-row mui-checkbox">
                                        <label class="cateTit" style="width: 2.773rem;">中餐</label>
                                        <input name="isBoard" onclick="includeBoardHave(this)" class="catePut" value="2"
                                               type="checkbox">
                                    </div>
                                </div>
                                <div class="cateD">
                                    <div class="mui-input-row mui-checkbox">
                                        <label class="cateTit" style="width: 2.773rem;">晚餐</label>
                                        <input name="isBoard" onclick="includeBoardHave(this)" class="catePut" value="3"
                                               type="checkbox">
                                    </div>
                                </div>
                                <div class="cateD">
                                    <div class="mui-input-row mui-checkbox">
                                        <label class="cateTit" style="width: 2.773rem;">夜宵</label>
                                        <input name="isBoard" onclick="includeBoardHave(this)" class="catePut" value="4"
                                               type="checkbox">
                                    </div>
                                </div>
                                <div class="cateC">
                                    <a href="javascript:void(0);" class="close">取消</a>
                                    <a href="javascript:void(0);" class="confirm">确定</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="mui-input-group">
                    <%--工作地址--%>
                    <div class="mui-input-row">
                        <label>工作地址<i>*</i></label>
                        <a href="javascript:void(0);" id="workPlace" class="mui-input-div">
                            <span id="workPlaceAddr" class="placeaddr">请选择工作地址</span>
                            <i class="iconfont icon-fujin"></i>
                        </a>
                    </div>
                    <input name="workPalce" value="{{positionTemp.position.workPalce |ifNull:''}}" type="hidden"/>
                    <input name="workPlace.id" value="{{positionTemp.position.workPlace |ifNull:'','id'}}"
                           type="hidden"/>
                    <input name="workPlace.cityID" value="{{positionTemp.position.workPlace |ifNull:'','cityID'}}"
                           type="hidden"/>
                    <input name="workPlace.version" value="{{positionTemp.position.workPlace |ifNull:'','version'}}"
                           type="hidden"/>
                    <input name="workPlace.longitude"
                           value="{{positionTemp.position.workPlace |ifNull:'','longitude'}}"
                           type="hidden"/>
                    <input name="workPlace.latitude"
                           value="{{positionTemp.position.workPlace |ifNull:'','latitude'}}"
                           type="hidden"/>
                    <%--工作时间--%>
                    <div class="mui-input-row">
                        <label>工作日期<i>*</i></label>
                        <a href="javascript:void(0);" class="mui-input-div pop_up">
                                <span class="workDateText">
                                    {{if positionTemp.position.workDate != null || positionTemp.position.workDate != '' }}
                                    已选择工作日期
                                    {{else}}
                                    请选择工作日期
                                    {{/if}}
                                </span>
                            <i class="iconfont icon-arrow-right"></i>
                        </a>
                        <div class="modal-mask">
                            <div class="modal-container">
                                <div class="details-calendar">
                                    <div class="box">
                                        <section class="date" data-editable="true">
                                            <div class="data-head">
                                                <div class="prev mui-icon mui-icon-back"></div>
                                                <div class="tomon"><span class="year">2018</span>年 <span class="month">3</span>&nbsp;&nbsp;&nbsp;&nbsp;月
                                                </div>
                                                <div class="next mui-icon mui-icon-forward"></div>
                                            </div>
                                            <ol>
                                                <li>日</li>
                                                <li>一</li>
                                                <li>二</li>
                                                <li>三</li>
                                                <li>四</li>
                                                <li>五</li>
                                                <li>六</li>
                                            </ol>
                                            <ul id="jobDate">

                                            </ul>
                                        </section>
                                    </div>
                                </div>
                                <input type="hidden" id="workDate" name="workDate" value="{{positionTemp.position.workDate}}">
                                <div class="modal-footer">
                                    <p class="tips">注：以上蓝色区域是你所选择的工作时间</p>
                                    <p><a class="modal-default-button" onclick="close_popUp()">提交</a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="mui-input-row">
                        <label>工作时间<i>*</i></label>
                        <div class="mui-input-div" id="picker" onclick="dateSt($('#dateStH'))" >
                            <input id="dateStH" disabled="disabled" readonly="readonly" maxlength="15"
                                   placeholder="08:00 至 15:00"/>
                            <i class="iconfont icon-arrow-right"></i>
                            <input type="hidden" id="startTime" name="startTime" value="{{positionTemp.position.startTime |ifNull:'480'}}">
                            <input type="hidden" id="endTime" name="endTime" value="{{positionTemp.position.endTime |ifNull:'900'}}">
                        </div>
                    </div>
                    <%--集合地址--%>
                    <div class="mui-input-row">
                        <label>集合地址<i>*</i></label>
                        <a href="javascript:void(0);"  id="gather" class="mui-input-div">
                            <span id="gatherAddr" class="gatherAddr">请选择集合地址</span>
                            <i class="iconfont icon-fujin"></i>
                        </a>

                        <input name="aggregate" value="{{positionTemp.position.aggregate |ifNull:''}}" type="hidden"/>
                        <input name="gather.longitude" value="{{positionTemp.position.gather |ifNull:'','longitude'}}"
                               type="hidden"/>
                        <input name="gather.cityID" value="{{positionTemp.position.gather |ifNull:'','cityID'}}"
                               type="hidden"/>
                        <input name="gather.id" value="{{positionTemp.position.gather |ifNull:'','id'}}" type="hidden"/>
                        <input name="gather.version" value="{{positionTemp.position.gather |ifNull:'','version'}}"
                               type="hidden"/>
                        <input name="gather.latitude" value="{{positionTemp.position.gather |ifNull:'','latitude'}}"
                               type="hidden"/>
                    </div>
                    <%--集合时间--%>
                    <div class="mui-input-row">
                        <label>集合时间<i>*</i></label>
                        <div class="mui-input-div" id="picker">
                            <input id="Dtime" readonly="readonly" placeholder="请选择集合时间" value="{{positionTemp.position.setDate | dateFormat:'yyyy-MM-dd hh:mm:ss'}}"/>
                            <input type="hidden" id="setDate" name="setDateStr" value="{{positionTemp.position.setDate | dateFormat:'yyyy-MM-dd hh:mm:ss'}}">
                            <i class="iconfont icon-arrow-right"></i>
                        </div>
                    </div>
                </div>
                <div class="mui-input-group">
                    <div class="mui-input-row">
                        <label>联系人<i>*</i></label>
                        <input type="text" class="mui-input-clear" maxlength="15" placeholder="请输入姓名" value="{{positionTemp.position |ifNull:'','contacts'}}" name="contacts" id="contacts">
                    </div>
                    <div class="mui-input-row">
                        <label>联系电话<i>*</i></label>
                        <input type="text" class="mui-input-clear" maxlength="15" placeholder="请输入手机号"value="{{positionTemp.position | ifNull:'','contactNumber'}}" id="contactNumber" name="contactNumber">
                    </div>
                </div>
                <div style="content: '';clear: both;height: 1.2rem;"></div>
                <footer class="choose_foot">
                    <a href="javascript:void(0);" id="saveConfigBtn" data-url="/ijob/api/PositionController/savePositionTemp" >
                    <span class="head-lf_span">
                        <%--<i class="iconfont icon-jia" style="font-size:0.480rem;margin-right:0.213rem;"></i>--%>
                        保存
                    </span>
                        <%--<span class="head-rt_span iconfont icon-arrow-right"></span>--%>
                    </a>
                    <a href="javascript:void(0);" id="goConfigBtn" data-url="/ijob/api/PositionController/savePositionTemp">
                        <span class="head-lf_span">
                            去发布
                        </span>
                    </a>
                </footer>
            </form>
        </div>
        <div id="workPlaceBtn" data-url="/ijob/api/PositionController/setToSession" hidden></div>
        <div id="gathereBtn" data-url="/ijob/api/PositionController/setToSession" hidden></div>
        <div id="jumpPagePosition" data-url="/ijob/api/PositionController/setToSession"hidden></div>
        {{/each}}
    </script>
</div>
<script>

    //初始化日期
    var workDateArr = [];

    function jumpPagePosition(_url,type){
        var positionObj = $("#input_example").serializeObjectJson();
        positionObj.liquidatedDamages = positionObj.liquidatedDamages/positionObj.recruitsSum;
        ijob.storage.set("positionObj",positionObj);
        ijob.storage.set("id",positionObj.id);
        ijob.storage.set("isTemp","111");
        $("#jumpPagePosition").btPost(JSON.stringify(positionObj),function(data){
            if(data.code == 200){
                ijob.gotoPage({path:_url});
            }
        });
    }

    function close_popUp(){
        $("#workDate").val(JSON.stringify(ijob.getStrFromList(workDateArr)));
        ijob.storage.set("position.workDateArr", $("#workDate").val());
    }
    $("#postJob2template").loadData().then(function(result){
        console.log(result);
        if($("#setDate").val() == 0 || $("#setDate").val() == "0"){
            $("#setDate").val("");
            $("#Dtime").val("");
        }
        if(result.data.list[0].position.workDate == "" || result.data.list[0].position.workDate == null || result.data.list[0].position.workDate == undefined || result.data.list[0].position.workDate == "{}"){
            $(".workDateText").text("请选择工作日期");
        }

        if(result.code == "501"){
            mui.alert("尚未进行实名认证！",function(){
                ijob.gotoPage({path:"/h5/qz/mine/realName"});
            });
        }
        if(ijob.storage.get("jobContent") == "" || ijob.storage.get("jobContent") == null || ijob.storage.get("jobContent") == undefined ){
            ijob.storage.set("jobContent",result.data.list[0].position.jobContent);
        }
        if(ijob.storage.get("labelList") == "" || ijob.storage.get("labelList") == null || ijob.storage.get("labelList") == undefined ){
            if(result.data.list[0].position.labelList == null){
                ijob.storage.set("labelList",null);
            }else{
                ijob.storage.set("labelList",result.data.list[0].position.labelList);
            }
        }
        $("#select option[value='"+result.data.list[0].position.salaryType+"'] ").attr("selected",true)

        //已内存中的日期为主
        var workDatestr = ijob.storage.get("position.workDateArr");
        if(workDatestr){
            workDateArr = ijob.getDateList(workDatestr);
        }else{
            workDateArr = ijob.getDateList(result.data.list[0].position.workDate);
        }

        $("#workDate").val(JSON.stringify(ijob.getStrFromList(workDateArr)))
        //渲染时间选择框的数据
        $('.date').on('completionEvent', function () {
            $(".date").selectDate(workDateArr);
        });

        //监听工作时间选择框的点击事件
        $(".date").on('dateClickEvent', function (event, state, dr) {
            if (state) {
                $(".workDateText").text("已选择工作日期");
                workDateArr.push(dr);
            } else {
                workDateArr.splice($.inArray(dr, workDateArr), 1);
            }
            if(workDateArr.length == 0){
                $(".workDateText").text("请选择工作日期");
            }else{
                var tempDate = ijob.sortDate(workDateArr)[0];
                var tempStr = $("#setDate").val();
                var tempArr = tempStr.split(" ");
                if (tempStr == null || tempStr == "" || tempStr == undefined){
                    tempStr = tempDate + " 00:00:00";
                }else{
                    tempStr = tempStr.replace(tempArr[0],tempDate);
                }
                $("#setDate").val(tempStr);
                $("#Dtime").val(tempStr);
            }
        });
        dateRenderInit();

        $("#select").change(function(){
            var opt=$("#select").val();
            $("#salaryType").val($("#select").val())
        });
        $(function(){
            var slide = null;
            $(".release").click(function (e) {
                $(".cate-content").show();
                // $(this).parent().siblings().find(".cate-content").hide();
                // $(".cate-content").toggle();
                slide = new Slide($(".wrap"),$(".cate-content"),".nav-select");
                slide.disTouch();
            });
            $(".nav-select li").click(function (e) {
                var _this = $(this);
                $(".release").html(_this.text()+"<i class=\"iconfont icon-arrow-right\"></i>");
                $(".cate-content").toggle();
                $("#workTypeID").val(_this.data("value"))
                slide.ableTouch();
            });
            // 点击空白处隐藏选项
            $("body>*").on('click', function (e) {
                if ($(e.target).hasClass('cate-content')) {
                    $(".cate-content").hide();
                    slide.ableTouch();
                }
            });
            //保证金提示
            $(".tipbtn").click(function(){
                $(".tips-content").show();
                slide = new Slide($(".wrap"),$(".tips-content"),".main-content");
                slide.disTouch();
            })
            $(".closebtn").click(function(){
                $(".tips-content").hide();
                slide.ableTouch();
            });
            // 是否管饭
            $(".meals").click(function(){
                $(".cate").show();
                slide = new Slide($(".wrap"),$(".cate"),".catebox");
                slide.disTouch();
            });
            $(".cateC .close,.cateC .confirm").click(function(){
                $(".cate").hide();
                slide.ableTouch();
            });
            // 点击空白处隐藏选项
            $("body>*").on('click', function (e) {
                if ($(e.target).hasClass('cate')) {
                    $(".cate").hide();
                    slide.ableTouch();
                }
            });
            // 工作日期
            $(".pop_up").click(function(){
                $(".modal-mask").show();
                slide = new Slide($(".wrap"),$(".modal-mask"),".modal-container");
                slide.disTouch();
            });
            $(".modal-default-button").click(function(){
                $(".modal-mask").hide();
                slide.ableTouch();
            });
            // 点击空白处隐藏选项
            $("body>*").on('click', function (e) {
                if ($(e.target).hasClass('modal-mask')) {
                    $(".modal-mask").hide();
                    slide.ableTouch();
                }
            });
        });

        var latlng = ijob.storage.get("data.latlng");
        var key, worklatlng, gatherlatlng;
        if (latlng) {
            key = latlng.key;
            if (key && key == "workPlace" && latlng.value) {

                worklatlng = {
                    lng: latlng.value.latlng.lng,
                    lat: latlng.value.latlng.lat,
                    addr: latlng.value.poiaddress
                    /*cityID: site.region.id(latlng.value.poiaddress),
                    cityname: latlng.value.cityname*/
                }
                site.region.parse(latlng.value.poiaddress,latlng.value.cityname,function(res){
                    worklatlng.cityID = res.id;
                    worklatlng.cityname = res.cityName;
                });
                ijob.storage.set("myjob.workPlace", worklatlng);
            } else if (key && key == "gather" && latlng.value) {
                gatherlatlng = {
                    lng: latlng.value.latlng.lng,
                    lat: latlng.value.latlng.lat,
                    addr: latlng.value.poiaddress
                    /*cityID: site.region.id(latlng.value.poiaddress),
                    cityname: latlng.value.cityname*/
                }
                site.region.parse(latlng.value.poiaddress,latlng.value.cityname,function(res){
                    gatherlatlng.cityID = res.id;
                    gatherlatlng.cityname = res.cityName;
                });
                ijob.storage.set("myjob.gather", gatherlatlng);
            }
            worklatlng = worklatlng || ijob.storage.get("myjob.workPlace");
            gatherlatlng = gatherlatlng || ijob.storage.get("myjob.gather");
        }


        if (worklatlng && worklatlng.cityname) {
            setvalueforworkplace(worklatlng);
        } else {
            /*  site.localtion().then(function () {
                  var workPlace = {
                      lng: site.data.lng,
                      lat: site.data.lat,
                      addr: site.data.addr,
                      cityID: site.region.id(site.data.district || site.data.city),
                      cityname: site.data.district || site.data.city
                  };
                  ijob.storage.set("myjob.workPlace", workPlace);
                  setvalueforworkplace(workPlace);
              });*/
            var mylocaltion = ijob.location.get();
            if (mylocaltion) {
                ijob.storage.set("myjob.workPlace", mylocaltion);
                setvalueforworkplace(mylocaltion);
            }

        }

        if (gatherlatlng && gatherlatlng.cityname) {
            setvalueforgather(gatherlatlng);
        } else {
            /*site.localtion().then(function (loc) {
                var gather = {
                    lng: site.data.lng,
                    lat: site.data.lat,
                    addr: site.data.addr,
                    cityID: site.region.id(site.data.district || site.data.city),
                    cityname: site.data.district || site.data.city
                };
                ijob.storage.set("myjob.gather", gather);
                setvalueforgather(gather);
            });*/
            var mylocaltion = worklatlng||ijob.location.get();
            if (mylocaltion) {
                ijob.storage.set("myjob.gather", mylocaltion);
                setvalueforgather(mylocaltion);
            }
        }

        function setvalueforworkplace(workPlace) {
            /*$("#workPlace").html((workPlace.cityname||workPlace.districtName||workPlace.cityName) + "<i class=\"iconfont icon-fujin\"></i>");*/
            $("#workPlaceAddr").html(workPlace.addr);
            $("input[name='workPlace.longitude']").val(workPlace.lng);
            $("input[name='workPlace.latitude']").val(workPlace.lat);
            $("input[name='workPlace.detailedAddress']").val(workPlace.addr);
            $("input[name='workPlace.cityID']").val(workPlace.districtID||workPlace.cityID);
        }

        function setvalueforgather(gather) {
            // $("#gather").html((gather.cityname||gather.districtName||gather.cityName)  + "<i class=\"iconfont icon-fujin\"></i>");
            $("#gatherAddr").html(gather.addr);
            $("input[name='gather.longitude']").val(gather.lng);
            $("input[name='gather.latitude']").val(gather.lat);
            $("input[name='gather.detailedAddress']").val(gather.addr);
            $("input[name='gather.cityID']").val(gather.districtID||gather.cityID);
        }


        $("#workPlace").click(function () {
            var positionObj = $("#input_example").serializeObjectJson();
            if(positionObj != null || positionObj != undefined){
                positionObj.jobContent = ijob.storage.get("jobContent");
                positionObj.labelList = ijob.storage.get("labelList");
                $("#workPlaceBtn").btPost(JSON.stringify(positionObj),function (data) {
                    ijob.gotoPage({url: "/ijob/api/WeixinController/map", data: {latlng: {key: "workPlace"}}});
                });
            }
        });

        $("#gather").click(function () {
            var positionObj = $("#input_example").serializeObjectJson();
            if(positionObj != null || positionObj != undefined){
                positionObj.jobContent = ijob.storage.get("jobContent");
                positionObj.labelList = ijob.storage.get("labelList");
                $("#gathereBtn").btPost(JSON.stringify(positionObj),function (data) {
                    ijob.gotoPage({url: "/ijob/api/WeixinController/map", data: {latlng: {key: "gather"}}});
                });
            }
        });

        //当点击不管饭的时候
        noIncludeBoardHave = function (arg) {
            if ($(arg).prop("checked")) {
                $("input[name='isBoard']").attr("checked", false);
                $("#includeBoard").val(createIncludeBoardVal(-1, true));
            }
        }

        <%--//当点击管饭的按钮时--%>
        includeBoardHave = function (arg) {
            var index = (parseInt($(arg).val()) - 1);
            if ($(arg).prop("checked")) {
                $("input[name='noIncludeBoard']").prop("checked", false);
                $("#includeBoard").val(createIncludeBoardVal(index, true));
            } else {
                $("#includeBoard").val(createIncludeBoardVal(index, false));
            }
        }

        <%--//初始化管饭的值--%>
        var includeBoardVal = ["0", "0", "0", "0"];

        <%--//修改是否管饭的值--%>
        function createIncludeBoardVal(index, isCheck) {
            var includeBoardValstr;
            if (isCheck) {
                if (index > -1) {
                    includeBoardVal[index] = "1";
                    includeBoardValstr = includeBoardVal[0] + includeBoardVal[1] + includeBoardVal[2] + includeBoardVal[3];
                    $("#mealput").text(updateMealputText());
                } else {
                    includeBoardValstr = "0000";
                    includeBoardVal = ["0", "0", "0", "0"];
                    $("#mealput").text(updateMealputText());
                }
            } else {
                if (index > -1) {
                    includeBoardVal[index] = "0";
                    includeBoardValstr = includeBoardVal[0] + includeBoardVal[1] + includeBoardVal[2] + includeBoardVal[3];
                    $("#mealput").text(updateMealputText());
                } else {
                    includeBoardValstr = "0000";
                    includeBoardVal = ["0", "0", "0", "0"]
                    $("#mealput").text(updateMealputText())
                }
            }
            return includeBoardValstr;
        }

        <%--//管饭的排序--%>
        function updateMealputText() {
            var str = "";
            if (includeBoardVal[0] == "1") {
                str = "早" + str;
            } else {
                str.replace("早")
            }
            if (includeBoardVal[1] == "1") {
                str = str + "中";
            } else {
                str.replace("中")
            }
            if (includeBoardVal[2] == "1") {
                str = str + "晚";
            } else {
                str.replace("晚")
            }
            if (includeBoardVal[3] == "1") {
                str = str + "夜";
            } else {
                str.replace("夜")
            }
            if (includeBoardVal[0] == "0" && includeBoardVal[1] == "0" && includeBoardVal[2] == "0" && includeBoardVal[3] == "0") {
                str = "不管饭"
            }
            return str;

        }

        $("#recruitsSum").blur(function(){
            if(this.value == null || this.value == "" || this.value == undefined){
                this.value = 1;
            }
            if(isNaN(this.value)){
                this.value = 1;
            }

            if($("#recruitsSum").val() < 0){
                $("#recruitsSum").val(0-$("#recruitsSum").val());
            }else if($("#recruitsSum").val() < 1){
                $("#recruitsSum").val(1);
            }
            this.value = parseInt(this.value);
            if($("#dailySalary").val() != null || $("#dailySalary").val() != "" || $("#dailySalary").val() != undefined){
                var liquV = $("#dailySalary").val() * 0.25;
                if(parseInt($("#dailySalary").val() * 0.25) != parseFloat($("#dailySalary").val() * 0.25)){
                    liquV = parseInt($("#dailySalary").val() * 0.25) + 1 ;
                }
                liquV = liquV * $("#recruitsSum").val();
                liquV = liquV + "";
                if (liquV.indexOf(".") != -1){
                    var arr = liquV.split(".");
                    if (arr[1].length > 2){
                        liquV = arr[0] + "." + arr[1].substr(0,2);
                    }
                }
                if($("#liquidatedDamages").val()<liquV){
                    $("#liquidatedDamages").val(parseFloat(liquV));
                    $(".num").text(parseFloat(liquV));
                }
            }
        });

        $("#liquidatedDamages").blur(function(){
            if(isNaN(this.value)){
                this.value = 1;
            }
            var liquV = $("#dailySalary").val() * 0.25;
            if(parseInt($("#dailySalary").val() * 0.25) != parseFloat($("#dailySalary").val() * 0.25)){
                liquV = parseInt($("#dailySalary").val() * 0.25) + 1 ;
            }
            liquV = liquV * $("#recruitsSum").val();
            liquV = liquV + "";
            if (liquV.indexOf(".") != -1){
                var arr = liquV.split(".");
                if (arr[1].length > 2){
                    liquV = arr[0] + "." + arr[1].substr(0,2);
                }
            }
            if($("#liquidatedDamages").val() < 0){
                $("#liquidatedDamages").val(0-$("#liquidatedDamages").val());
            }else if($("#liquidatedDamages").val() < parseInt(liquV)){
                $("#liquidatedDamages").val(parseInt(liquV));
            }
            $(".num").text($(this).val());
        });

        $("#dailySalary").blur(function(){
            if(this.value == null || this.value == "" || this.value == undefined){
                this.value = 1;
            }
            if(isNaN(this.value)){
                this.value = 1;
            }
            if($("#dailySalary").val() < 0){
                $("#dailySalary").val(0-$("#dailySalary").val())
            }else if($("#dailySalary").val() < 1){
                $("#dailySalary").val(1);
            }
            ckeckVal($("#dailySalary"));
            if($("#recruitsSum").val() != null || $("#recruitsSum").val() != "" || $("#recruitsSum").val() != undefined){
                var liquV = $("#dailySalary").val() * 0.25;
                if(parseInt($("#dailySalary").val() * 0.25) != parseFloat($("#dailySalary").val() * 0.25)){
                    liquV = parseInt($("#dailySalary").val() * 0.25) + 1 ;
                }
                liquV = liquV * $("#recruitsSum").val();
                liquV = liquV + "";
                if (liquV.indexOf(".") != -1){
                    var arr = liquV.split(".");
                    if (arr[1].length > 2){
                        liquV = arr[0] + "." + arr[1].substr(0,2);
                    }
                }
                if($("#liquidatedDamages").val()<liquV){
                    $("#liquidatedDamages").val(parseFloat(liquV));
                    $(".num").text(parseFloat(liquV));
                }
            }
        });
        //集合时间
        var jihe = document.getElementById("Dtime");
        jihe.addEventListener('tap', function () {
            var optionsJson = this.getAttribute('datatime-options') || '{}';
            var options = JSON.parse(optionsJson);
            var picker = new mui.DtPicker(options);
            picker.show(function (rs) {
                document.getElementById("Dtime").value = rs.text;
                document.getElementById("setDate").value = rs.text + ":00";
                picker.dispose();
            });
        }, false);
        if (result.data.list[0].position.startTime != null) {
            //数据渲染
            $("#dateStH").prop("placeholder", IntegerToDate(result.data.list[0].position.startTime) + " 至 " + IntegerToDate(result.data.list[0].position.endTime));
        }
        //时间段选择事件
        dateSt = function (obj) {
            var picker = new mui.PopPicker({
                layer: 2
            });
            picker.setData(val);
            var tempStartTime = IntegerToDate(result.data.list[0].position.startTime);
            var tempEndTime = IntegerToDate(result.data.list[0].position.endTime);
            picker.pickers[0].setSelectedIndex(dateTo48(tempStartTime));
            picker.pickers[1].setSelectedIndex(dateTo48(tempEndTime) - dateTo48(tempStartTime) - 1);
            picker.show(function (SelectedItem) {
                $(obj).val(SelectedItem[0].text + ' 至 ' + SelectedItem[1].text);
                dateToInteger(SelectedItem[0].text);
                $("#startTime").val(dateToInteger(SelectedItem[0].text));
                $("#endTime").val(dateToInteger(SelectedItem[1].text));

                //同步集合时间
                var tempStr = $("#setDate").val();
                var tempArr = tempStr.split(" ");
                var temTimeArr = SelectedItem[0].text.split(":");
                var temTime = "";
                if(temTimeArr[0].length == 1){
                    temTime = "0" + temTimeArr[0] + ":" + temTimeArr[1] + ":00";
                }else{
                    temTime = SelectedItem[0].text + ":00";
                }
                var tempDateStr = temTime.split(":");
                if(tempDateStr[1] == "00"){
                    tempDateStr[1] = "30";
                    tempDateStr[0] = parseInt(tempDateStr[0] - 1);
                    if (tempDateStr[0].length == 1){
                        tempDateStr[0] = "0"+tempDateStr[0];
                    }
                }else{
                    tempDateStr[1] = "00";
                }
                temTime = tempDateStr[0] + ":" + tempDateStr[1] + ":" + tempDateStr[2]

                if(SelectedItem[0].text != "0:00"){
                    tempStr = tempStr.replace(tempArr[1],temTime);
                }
                $("#setDate").val(tempStr);
                $("#Dtime").val(tempStr);
            });
        }
        $("#saveConfigBtn").click(function(){
            savePositionTemp(this,12);
        });

        $("#goConfigBtn").click(function(){
            savePositionTemp(this,11);
        });
    });

    //循环出选择的时间
    var val = new Array();
    for (var i = 0; i <= 23; i++) {
        val.push({
            value: '1000' + i,
            text: i + ':00',
            children: timeMax(i, true)
        });
        val.push({
            value: '1000' + i,
            text: i + ':30',
            children: timeMax(i, false)
        });
    }

    function timeMax(i, bool) {
        var tmpa = new Array();
        if (bool) {
            tmpa.push({
                value: '1000' + i + a,
                text: i + ':30',
            });
        }
        for (var a = i + 1; a <= 24; a++) {
            tmpa.push({
                value: '1000' + i + a,
                text: a + ':00',
            });
            if (a != 24) {
                tmpa.push({
                    value: '1000' + i + a,
                    text: a + ':30',
                });
            }
        }
        return tmpa;
    }
    function IntegerToDate(number) {
        var h = "" + number / 60;
        var reg = /.*\..*/;
        if (!reg.test(h)) {
            return h + ":00"
        } else {
            var minuts = h - Math.floor(h);
            return Math.floor(h) + ":" + minuts * 60;
        }
    }

    function dateToInteger(dateStr) {
        var dateArr = dateStr.split(":");
        var myHouer = parseInt(dateArr[0]);
        if (dateArr[1] != "00") {
            myHouer += 0.5;
        }
        return myHouer * 60;
    }

    function timestampToTime(timestamp) {
        var now = new Date(timestamp);
        var year = now.getFullYear();
        var month = now.getMonth() + 1 + "";
        var date = now.getDate() + "";
        var hour = now.getHours() + "";
        var minute = now.getMinutes() + "";
        var second = now.getSeconds() + "";
        if (month.length == 1) {
            month = "0" + month;
        }
        if (date.length == 1) {
            date = "0" + date;
        }
        if (hour.length == 1) {
            hour = "0" + hour;
        }
        if (minute.length == 1) {
            minute = "0" + minute;
        }
        if (second.length == 1) {
            second = "0" + second;
        }
        return year + "-" + month + "-" + date + " " + hour + ":" + minute;
    }

    /*将日期格式转换成该插件的数据格式,方便初始化*/
    function dateTo48(time){
        var arr = time.split(":");
        var timeInt = parseInt(arr[0]);
        if(arr[1] == "00"){
            return timeInt*2;
        }else{
            return timeInt*2 + 1;
        }
    }

    function savePositionTemp(arg,type) {
        var phoneReg = /^[1][3,4,5,7,8][0-9]{9}$/;
        var positionData = $("#input_example").serializeObjectJson();
        positionData.jobContent = ijob.storage.get("jobContent");
        positionData.labelList = ijob.storage.get("labelList");
        if(positionData.title == null || positionData.title == "" || positionData.title == undefined){
            mui.alert("请填写标题！");
        }else if (positionData.workTypeID == null || positionData.workTypeID == "" || positionData.workTypeID == undefined ){
            mui.alert("请选择工作类型！");
        }else if(positionData.salary == null || positionData.salary == "" || positionData.salary == undefined ){
            mui.alert("请输入薪资待遇！");
        }else if(positionData.salaryType == null || positionData.salaryType == "" || positionData.salaryType == undefined ){
            mui.alert("请选择薪资类型！");
        }else if(positionData.dailySalary == null || positionData.dailySalary == "" || positionData.dailySalary == undefined ){
            mui.alert("请输入日薪资！");
        }else if(positionData.recruitsSum == null || positionData.recruitsSum == "" || positionData.recruitsSum == undefined ){
            mui.alert("请输入招聘人数！");
        }else if(positionData.workDate == null || positionData.workDate == "" || positionData.workDate == undefined || positionData.workDate == "{}" ){
            mui.alert("请选择工作日期！");
        }else if (positionData.startTime == null || positionData.startTime == "" || positionData.startTime == undefined ){
            mui.alert("请选择工作时间！");
        }else if(positionData.setDateStr == null || positionData.setDateStr == "" || positionData.setDateStr == undefined || positionData.setDateStr == 0 ){
            mui.alert("请选择集合时间！");
        }else if(positionData.contacts == null || positionData.contacts == "" || positionData.contacts == undefined ){
            mui.alert("请输入联系人！");
        }else if(positionData.contactNumber == null || positionData.contactNumber == "" || positionData.contactNumber == undefined ){
            mui.alert("请输入联系电话！");
        }else if(!phoneReg.test($("#contactNumber").val())){
            mui.alert("请输入正确的联系电话！");
        }else{
            positionData.open = type;
            positionData.liquidatedDamages = positionData.liquidatedDamages/positionData.recruitsSum;
            $(arg).btPost(JSON.stringify(positionData),function(data){
                if (data.code == 200){
                    mui.toast("职位模版操作成功!");
                    ijob.storage.set("positionObj",null);
                    ijob.storage.set("id",null);
                    ijob.storage.set("labelList",null);
                    ijob.storage.set("jobContent",null);
                    ijob.storage.set("position.workDateArr",null);
                    if (type == 11){
                        ijob.gotoPage({path:'/h5/zp/postJob2?positionTemp.id=0'});
                    }else{
                        ijob.gotoPage({path:'/h5/zp/location_add'});
                    }
                }else{
                    mui.toast("服务器繁忙");
                }
            });
        }
    }
</script>

</body>
</html>


