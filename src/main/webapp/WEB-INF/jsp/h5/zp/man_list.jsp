<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/8
  Time: 17:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>搜索人才</title>
    <jsp:include page="../zp/base/resource.jsp"/>
    <script src="/ijob/lib/zpz/dateRange.js"></script>
    <link rel="stylesheet" href="/ijob/static/css/index/SearchJob.css">
</head>
<body>

<style>

    .wrap .details{padding:0;}
    .wrap .main .details{background-color:#f2f5f7;}
    .box{background-color:#fff;}
    .date>ol{background:#fff;}
    .date>ul{background:#fff;}
    .mui-checkbox input[type=checkbox], .mui-radio input[type=radio]{top:0.266rem;}
    .wrap .main .main-pop .popular>ul li{border-radius:25px;font-size:0.346rem;color:#666;padding:0.16rem 0.533rem;border:1px solid #fff;margin-bottom: 0;}
    .mui-input-group .mui-input-row:after{background-color:#fff;}
    .wrap .main .main-pop .popular>ul .hulhue{border:1px solid #108ee9;color:#108ee9;}
    .wrap .head .mui-input-row .mui-input-clear~.mui-icon-clear{top:0.4rem;right:5px;}
    .mui-input-group .mui-input-row{border-bottom:1px solid #efeff4;height:0.96rem;}
    .mui-input-group .mui-input-row:last-child{border-bottom: 0;}
    .mui-radio span{position:relative;}
    .wrap .head .head-rt > .btn2 {/*width: 1.226667rem;*/height: 1.333333rem;line-height: 1.333333rem;font-size: 0.426667rem;font-weight: normal;font-stretch: normal;color: #333333;}
</style>


<div class="wrap">
    <header class="head" style="position:fixed;z-index:9;top:0;background:#fff;width:100%;display:  flex;overflow:  hidden;padding:  0 0.453rem;justify-content: space-between;align-items: center;">
        <div class="head-lf mui-input-row">
            <i class="mui-icon mui-icon-search"></i>
            <input type="text" id="searchInput" class=" mui-input-clear" placeholder="搜索人才"  maxlength="20">
        </div>
        <div class="head-rt">
            <div class="btn2" onclick="searchPerson()">搜索</div>
        </div>
    </header>
    <div class="mui-input-group" style="margin-top:1.733rem;">
        <div class="mui-input-row select_education" id="educationSelect1">
            <span class="msg1">最低学历</span>
            <input type="hidden" name="educationLeavl" id="education2" />
            <span  class="education1">
                <span class="xueli" id="xueli">选择学历</span>
                <i class="iconfont icon-arrow-right"></i>
            </span>
        </div>
        <div class="mui-input-row">
            <label>性别</label>
            <div style="float:right;">
                <div class="mui-Hc mui-checkbox mui-left mui-radio" style="width:2.4rem;">
                    <input name="sex" value="2" type="radio" checked>
                    <span>男女不限</span>
                </div>
                <div class="mui-Hc mui-checkbox mui-left mui-radio">
                    <input name="sex" value="1" type="radio">
                    <span>男</span>
                </div>
                <div class="mui-Hc mui-checkbox mui-left mui-radio">
                    <input name="sex" value="0" type="radio">
                    <span>女</span>
                </div>
            </div>
        </div>
        <div class="mui-input-row">
            <label>类别</label>
            <input type="hidden" name="type" id="workTypeID" value="" />
            <div class="mui-input-div" onclick="muisor();"><span class="muisot mr2">尚未选择</span><i class="iconfont icon-arrow-right"></i></div>
        </div>
    </div>
    <%--<div id="Demo">
        <p style="font-size:0.373rem;color:#333;padding:5px 0px 5px 0.453rem;">空闲时间</p>
        <div class="details-calendar">
            <div class="box">
                <section class="date" data-editable="true">
                    <div class="data-head">
                        <div class="prev mui-icon mui-icon-back"></div>
                        <div class="tomon"><span class="year">2018</span>年 <span class="month">3</span>&nbsp;&nbsp;&nbsp;&nbsp;月</div>
                        <div class="next mui-icon mui-icon-forward"></div>
                    </div>
                    <ol>
                        <li>周日</li>
                        <li>周一</li>
                        <li>周二</li>
                        <li>周三</li>
                        <li>周四</li>
                        <li>周五</li>
                        <li>周六</li>
                    </ol>
                    <ul id="jobDate">

                    </ul>
                </section>
            </div>
        </div>
    </div>--%>
    <input id="personFreeDate" type="hidden">
    <main class="main" style="margin-bottom:1.067rem;">
        <div class="main-pop">
            <div class="popular">
                <p style="font-size:0.373rem;color:#333;">地区</p>
                <ul class="hulbox">
                    <li id="all" onclick="allChecked(this)">全部</li>
                    <li class="son" onclick="disAllChecked(this)" value="430102">芙蓉区</li>
                    <li class="son" onclick="disAllChecked(this)" value="430103">天心区</li>
                    <li class="son" onclick="disAllChecked(this)" value="430104">岳麓区</li>
                    <li class="son" onclick="disAllChecked(this)" value="430105">开福区</li>
                    <li class="son" onclick="disAllChecked(this)" value="430111">雨花区</li>
                    <li class="son" onclick="disAllChecked(this)" value="430112">望城区</li>
                    <li class="son" onclick="disAllChecked(this)" value="430121">长沙县</li>
                    <li class="son" onclick="disAllChecked(this)" value="430124">宁乡县</li>
                    <li class="son" onclick="disAllChecked(this)" value="430181">浏阳市</li>
                </ul>
            </div>
        </div>
    </main>

    <!-- 选择类别弹框 -->
    <div class="Hsort"  style="overflow-y:auto;">
        <ul class="mui-table-view mui-table-view-radio HsortBox">
            <script id="workTypeTemplate" type="text/html" data-url="/ijob/api/HuntingtypeController/findListOfListData" data-type="POST">
                {{each list as workType}}
                    <li class="mui-table-view-cell">
                        <a class="mui-navigate-right" id="{{workType.id}}" onclick="checkWorkType(this)">{{workType.name}}</a>
                    </li>
                {{/each}}
            </script>
        </ul>
    </div>

</div>
</body>
</html>
<script>
    dateRenderInit();
    var all = $(".son");
    function checkWorkType(arg){
        $("#workTypeID").val($(arg).attr("id"));
        $(".muisot").text($(arg).text());
    }
    /**
     * 全选事件
     * @param arg Dom节点对象
     */
    function allChecked(arg){
        if (!$(arg).hasClass("hulhue"))
            $(".son").addClass("hulhue");
        else
            $(".son").removeClass("hulhue");
    }

    /**
     * 取消全选事件
     * @param arg Dom 节点对象
     */
    function disAllChecked(arg){
        var allCheck = 0;
        for (var i = 0 ;i< all.length; i++){
            if ($(all[i]).hasClass("hulhue")&&$(all[i]).attr("value") != $(arg).attr("value"))
                allCheck++;
        }
        if (allCheck == 8)
            $("#all").addClass("hulhue");
        if ($(arg).hasClass("hulhue") || allCheck == 9)
            $("#all").removeClass("hulhue");
    }
    //地址集合
    var addrList = new Array();

    /**
     * 搜索事件
     */
    function searchPerson(){
        for (var i = 0 ;i< all.length; i++){
            if ($(all[i]).hasClass("hulhue"))
                addrList.push($(all[i]).attr("value"));
        }
        var condition = {};
        condition.search = $("#searchInput").val()//搜索框值
        condition.education = $("#education2").val()//最低学历要求
        condition.workTypeID = $("#workTypeID").val()//工作类型
        condition.sexRequirements = $("input:checked").val()//性别
        if(addrList.length==0){
            condition.addrList = null ;
        }else{
            condition.addrList = addrList//选中的工作地区
        }

        condition.personFreeDate = $("#personFreeDate").val()//工作日期
        ijob.storage.set("condition",condition);
        ijob.gotoPage({path:'/h5/zp/man_list2'});
    }
</script>

<script type="text/javascript">

    $("#workTypeTemplate").loadData().then(function(result){
    });

    $(function(){

        var slide = null;

        $('.date').selectDate()
        var workDateArr = new Array();
        //渲染时间选择框的数据
        $('.date').on('completionEvent', function () {
            $(".date").selectDate(workDateArr);
        });

        //监听工作时间选择框的点击事件
        $(".date").on('dateClickEvent', function (event, state, dr) {
            if (state) {
                workDateArr.push(dr);
            } else {
                workDateArr.splice($.inArray('b', workDateArr), 1);
            }
            //为工作日期input 框赋值
            $("#personFreeDate").val(JSON.stringify(ijob.getStrFromList(workDateArr)));
        });
    })
    //选择模板类型
    function muisor(){
        $(".Hsort").show();
        slide = new Slide($(".wrap"),$(".Hsort"),".mui-table-view");
        slide.disTouch();

    }
    $(".mui-table-view li a").click(function(){
        $('input[name="type"]').attr('value' , $(this).attr('data-id') );
        $(".muisot").text( $(this).text() ) ;
        $(".Hsort").hide();
        slide.ableTouch();
    })
     //点击空白返回
    $(".Hsort").on('click', function (e) {
        if (e.target !== $(".HsortBox")) {
                $(".Hsort").hide();
            slide.ableTouch();
        }
    });
    //日期多选
    $(".item a").click( function () {
        if ($(this).is('.hcur')){
            $(this).removeClass("hcur");
        }else{
            $(this).addClass("hcur");
        }
    });
    //地区多选
    $(".hulbox li").click( function () {
        if ($(this).is('.hulhue')){
            $(this).removeClass("hulhue");
        }else{
            $(this).addClass("hulhue");
        }
    });


    //选择学历
            //学历 1,小学,2,初中,3,高中,4,中专,5,大专,6,本科,7,研究生,8博士
        var picker = new mui.PopPicker();
        picker.setData([{
            text: '小学',
            value:'1'
        }, {
            text: '初中',
            value:'2'
        }, {
            text: '高中',
            value:'3'
        }, {
            text: '中专',
            value:'4'
        }, {
            text: '大专',
            value:'5'
        }, {
            text: '本科',
            value:'6'
        }, {
            text: '研究生',
            value:'7'
        }, {
            text: '博士',
            value:'8'
        }]);
        $("#educationSelect1").on('tap', function (event) {
            picker.show(function (items) {
                $("#xueli").html(items[0].text);
                $("#education1").val(items[0].value);
                $("#education2").val(items[0].value);
                //返回 false 可以阻止选择框的关闭
                //return false;
            });
        });
</script>

<script src="../../../ijob/lib/jquery.range.js"></script>


