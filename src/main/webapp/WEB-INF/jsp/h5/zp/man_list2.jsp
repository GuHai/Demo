<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/8
  Time: 17:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>人才列表</title>
    <jsp:include page="../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/index/SearchJob.css">
    <link rel="stylesheet" href="/ijob/static/css/index/part-time.css">
    <link rel="stylesheet" href="/ijob/static/css/mine/add_preview.css">
</head>
<body>

<style>
    .wrap .head{position:fixed;top:0;z-index:9;height:1.200rem;overflow:hidden;background:#fff;width:100%}
    .wrap .hader-fixed{top:1.2rem;border-top:1px solid #cccfd0;}
    .wrap{background-color: #f2f5f7;}
    .wrap .summary{padding:0.266rem;/*background-color: #fff;*/height:auto;width:100%;margin:0 auto 0.266rem auto;}
    .wrap .summary ul li{display: block;background-color: #fff;margin-bottom: 10px;padding: 0.5rem 0.2rem;padding-bottom: 0;overflow: hidden;}
    .wrap .head .head-lf>input{height:0.693rem;overflow:hidden;font-size:0.32rem;}
    .wrap .head .head-rt>.btn{font-size:0.4rem;color:#333;text-align:center;height:1.2rem;line-height:1.2rem;}
    .wrap .head .head-lf>i{font-size:0.48rem;top:0.373rem;}
    .H-contP{border-top:1px solid #d7d7d7;padding: 0.267rem 0;}
    .contentBox{padding-bottom:0.213rem;}
    .wrap .hader-fixed .nav .nav-li .nav-select{font-size:0.373rem;}
    .wrap .head .mui-input-row .mui-input-clear~.mui-icon-clear{top:0.32rem;}
    .summary:first-child{margin-top: 2.666rem}
    .headerImg1{border-radius: 50%;}
</style>

<div class="wrap">
    <header class="head" >
        <div class="head-lf mui-input-row">
            <i class="mui-icon mui-icon-search"></i>
            <input type="text" class="mui-input-clear" id="searchInput" placeholder="搜索求职者">
        </div>
        <div class="head-rt">
            <div class="btn" id="searchBtn">搜索</div>
        </div>
    </header>
    <header class="hader-fixed">
        <ul class="nav filter_nav">
            <li class="nav-li li_1">
                <div class="nav-box" id="place">
                    <a data-value="全部类别" id="muisot" class="place nav-select" href="javascript:void(0);">
                        全部类别
                    </a>
                    <i class="iconfont icon-arrow-down1"></i>
                </div>
                <div class="mui-backdrop nav-content">
                    <ul class="nav-selected" id="alltype">
                        <script id="workTypeTemplate" type="text/html" data-url="/ijob/api/HuntingtypeController/findListOfListData" data-type="POST">
                            <li data-value="全部类别">全部类别</li>
                            {{each list as workType}}
                                <li data-value="全部类别" id="{{workType.id}}" onclick="checkWorkType(this)">{{workType.name}}</li>
                                <%--<li class="mui-table-view-cell">
                                    <a class="mui-navigate-right" id="{{workType.id}}" onclick="checkWorkType(this)">{{workType.name}}</a>
                                </li>--%>
                            {{/each}}
                        </script>
                    </ul>
                </div>
            </li>
            <li class="nav-li line"></li>
            <li class=" nav-li li_2">
                <div class="nav-box" id="release">
                    <a data-value="地区" class="release nav-select" href="javascript:void(0);">地区</a>
                     <i class="iconfont icon-arrow-down1"></i>
                </div>
                <div class="mui-backdrop nav-content">
                    <div class="region"  id="allplace">
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
                        <div class="btns">
                            <a href="javascript:void(0);" class="close">取消</a>
                            <a href="javascript:void(0);" id="addressBtn" class="affirm">确定</a>
                        </div>
                    </div>
                </div>
            </li>
            <li class="nav-li line"></li>
            <li class="nav-li li_3">
                <div class="nav-box" id="filter">
                    <a class="filter nav-select" href="javascript:void(0);">筛选</a>
                    <i class="iconfont icon-shaixuan" id="icon-shaixuan"></i>
                </div>
                <div class="mui-backdrop nav-content">
                    <ul class="nav_row">
                        <li>
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
                        </li>
                        <li>
                            <%--<div class="mui-input-row select_education" id="educationSelect1">--%>
                                <%--<span class="msg1">最低学历</span>--%>
                                <%--<input type="hidden" name="educationLeavl" id="education1" />--%>
                                <%--<span  class="education1">--%>
                                    <%--<span class="xueli" id="xueli">选择学历</span>--%>
                                    <%--<i class="iconfont icon-arrow-right"></i>--%>
                                <%--</span>--%>
                            <%--</div>--%>
                            <div class="mui-input-row">
                                <label>最低学历</label>
                                <div class="edu-select">
                                    <select>
                                        <option value="1" >小学</option>
                                        <option value="2">初中</option>
                                        <option value="3">高中</option>
                                        <option value="4">中专</option>
                                        <option value="5">大专</option>
                                        <option value="6">本科</option>
                                        <option value="7">研究生</option>
                                        <option value="8">博士</option>
                                    </select>
                                    <span class="iconfont icon-arrow-right"></span>
                                </div>
                            </div>
                        </li>
                        <%--<li id="Demo">
                            <p class="txt"  style="font-size:0.373rem;color:#333;padding:5px 0px 5px 0.453rem;">空闲时间</p>
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
                        </li>--%>
                        <li>
                            <a href="javascript:void(0);" class="close">取消</a>
                            <a href="javascript:void(0);" id="ortherBtn" class="affirm">确定</a>
                        </li>
                    </ul>
                </div>
            </li>
        </ul>
    </header>
    <div class="summary" style="margin-top: 2.26rem">
        <ul class="tempUl">
        <script id="resumetemplate" type="text/html" data-url="/ijob/api/ResumeController/h5/zp/searchPersonResumePage" data-type="POST">
            {{each list as resume}}
            <li>
                <a href="/ijob/api/ResumeController/h5/zp/index/previewOtherUserResume/{{resume.id}}">
                    <div class="headerImg" style="margin-bottom: 0.266rem">
                        {{if resume.user.attachment != null }}
                        <img style="border-radius: 50%" class="headerImg headerImg1" src="/ijob/upload/{{resume.user.attachment |absolutelyPath}}" onerror="this.src='{{resume.user.weixin.headimgurl}}';this.onerror=null;" alt="">
                        {{else}}
                        <img style="border-radius: 50%" class="headerImg headerImg1" src="{{resume.user.weixin.headimgurl}}" alt="" onerror="this.src='{{resume.user.weixin.headimgurl}}';this.onerror=null;" >
                        {{/if}}
                    </div>
                        <div class="contentBox">
                            <p>
                            {{resume.resumeName |ifNull:'保密'}}
                            <span>
                                {{if resume.educationalList.length > 0}}
                                {{resume.educationalList[0].education}}
                                {{else}}
                                保密
                                {{/if}}
                            </span>
                        </p>
                        <p class="posiType">
                            {{each resume.intentiontypeList as intentiontype index}}
                            {{if index==0}}
                            {{intentiontype.huntingtype |ifNull:'其他','name'}}&nbsp;&nbsp;&nbsp;&nbsp;
                            {{else}}
                            |{{intentiontype.huntingtype |ifNull:'其他','name'}}&nbsp;&nbsp;
                            {{/if}}
                            {{/each}}
                        </p>
                    </div>
                    <div class="H-contP">
                        <p>
                            {{if resume.user.birthday != null }}
                            今年{{resume.user.birthday | dateFormat:'AA'}}岁，
                            {{/if}}
                            {{if resume.height != null }}
                            身高{{resume.height}}CM，
                            {{/if}}
                            {{if resume.weight != null }}
                            体重{{resume.weight}}公斤,
                            {{/if}}
                            {{resume.evaluation | substr:'36'}}
                        </p>
                    </div>
                </a>
            </li>
            {{/each}}
        </script>
        </ul>
    </div>

</div>
<script src="/ijob/static/js/man_list.js"></script>

<script type="text/javascript">
    dateRenderInit();
    var all = $(".son");
    var condition = ijob.storage.get("condition");
    function checkWorkType(arg){
        condition.workTypeID = $(arg).attr("id") ;
        $("#workTypeID").val($(arg).attr("id"));
        $("#muisot").text($(arg).text());
        $(".nav-content").hide();
        // 类型判断
        place();
    }
    function appendText() {
        $(".posiType").each(function(){
            if($(this).text().trim(" ")==""||$(this).text()==null||$(this).text()==undefined)
                $(this).text("暂未设置求职意向")
        });
        $(".H-contP").each(function(){
            if($(this).find("p").text().trim(" ")==""||$(this).find("p").text()==null||$(this).find("p").text()==undefined)
                $(this).find("p").text("暂未填写信息")
        })
    }


    $("#workTypeTemplate").loadData().then(function (result) {
        for (var i = 0 ; i < result.data.list.length ;i++ ){
            if (result.data.list[i].id == condition.workTypeID ){
                $("#muisot").text(result.data.list[i].name);
            }
        }
    });

    function initManList(){
        var page  = {"pageSize": "10", "currentPage": "1"};
        page.condition = condition ;
        var ijobRefresh = new IJobRefresh({
            container: '.tempUl',
            up: function() {
                $("#resumetemplate").appendData(page,ijobRefresh).then(function (result) {
                    /*if (result.data.list.length == 0){
                        $('.wrap').after("<p style='text-align: center;margin-top: 3rem;'>暂无符合条件的求职者！</p>");
                    }*/
                    page.currentPage =  result.nextPage;
                    /*$(window).scroll(function() {
                        var win_top = $(this).scrollTop();
                        if (win_top >= 170) {
                            $(".JobVtwo ").addClass("sfixed");
                        }else if (win_top < 170) {
                            $(".JobVtwo ").removeClass("sfixed");
                        }
                    })*/
                    appendText()
                });
            }
        });
    }

   initManList();

    $("#searchBtn").click(function () {
        for (var i = 0 ;i< all.length; i++){
            if ($(all[i]).hasClass("hulhue"))
                addrList.push($(all[i]).attr("value"));
        }

        console.log(condition)

        condition.addrList = addrList;
        condition.sexRequirements = $("input:checked").val();
        condition.education = $("select option:selected").val();
        if($("#searchInput").val()){
            condition.search = $("#searchInput").val();
        }else{
            condition.search = null;
        }
        initManList();

    });

</script>

</body>
</html>

