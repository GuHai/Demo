<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/19
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<html>
<head>
    <title>兼职详情</title>
    <link rel="stylesheet" href="/ijob/static/css/index/Part-timeDetails.css?version=4">

    <style>
        .details>div{
            word-break:break-all;
        }
        .mui-checkbox input[type=checkbox]:before, .mui-radio input[type=radio]:before{
            font-size: 22px;
        }
    </style>
</head>
<body>

<div class="wrap">
    <input type="hidden" id="shareUser" value="<shiro:principal property="id" />">
    <script id="todayJob"   type="text/html"  data-url="/ijob/api/PositionController/detail/{data.position.id}">
        {{each list as map}}
        <div class="head">
            <div class="list-li">
                <div class="list-container">
                    <div class="list-title">
                        <span class="title-content">{{map.position.title}}</span>
                    </div>
                    <div class="list-content ">
                        <div class="content-tit" style="background:{{map.position.huntingtype.codeGrade |getTypeColor}}!important;">
                            {{map.position.huntingtype | ifNull:'其他','name'}}
                        </div>
                        <div class="content-msg">
                            <div class="content-msg1">
                                            <span class="content-msg1-lf"><i
                                                    class="iconfont icon-shizhong"></i>{{map.position.recruitStartTime | dateFormat:'MM月dd日'}}</span>
                                <span class="content-msg1-rt">{{map.position.dailySalary}}元/天</span>
                            </div>
                            <div class="content-msg2">
                                            <span class="content-msg2-lf">{{map.position.sexRequirements  | enums:'SexRequirements'}}&nbsp;<span
                                                    class="line"></span>&nbsp;{{map.position.workPlace | ifNull:'未知城市','cityName'}}</span>
                                <span class="content-msg2-rt">{{map.position.settlement  | enums:'SettlementType' }}</span>
                            </div>
                            <div class="content-msg3">
                                <span class="content-msg3-lf"><%--已录取<span style="color: #ff3b30">{{map.position.beenRecruitedSum | ifNull:'0'}}</span>人/--%>招聘<span style="color: #ff3b30">{{map.position.personNumDay | ifNull:'0'}}</span>人/天</span>
                                <span class="content-msg3-rt">商家已缴纳保证金 <span style="color: #15bc83">{{map.position.liquidatedDamages*map.position.personNumDay | money}}元</span></span>
                            </div>
                        </div>
                    </div>
                    <div class="details-address" id="gotomap">
                        <em>工作地址</em><span >{{map.position.workPlace | ifNull:'未知地址','detailedAddress'}}</span><i class="iconfont icon-fujin"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="main">
            <!--招聘详情-->
            <div class="details">
                <%--标签内容--%>
                <div class="details-tag">
                    <ul class="taglist tagnull">
                        {{if map.position.includeBoard == null || map.position.includeBoard == ''}}
                        <li>不管饭</li>
                        {{else}}
                        <li>管饭：{{map.position.includeBoard |formatBoard}}</li>
                        {{/if}}
                        {{if map.labelList.length != 0}}
                        {{each map.labelList as label i}}
                        {{if i < 3}}
                        <li>{{label.name}}</li>
                        {{/if}}
                        {{/each}}
                        {{/if}}
                    </ul>
                </div>
                <div class="details-calendar">
                    <div class="box">
                        <section class="date"  data-editable="true">
                            <div class="data-head">
                                <div class="prev mui-icon mui-icon-back"></div>
                                <div class="tomon"><span class="year"></span>年 <span class="month"></span>月</div>
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
                            <ul >
                            </ul>
                        </section>
                    </div>
                </div>
                <div class="details-hours">工作时间<span>{{map.position.startTime | dateFormatByMinute}} - {{map.position.endTime | dateFormatByMinute}}</span></div>
            </div>
            <div class="details margintop">
                <%--<div class="details-hours">工作时间<span>{{map.position.startTime | dateFormatByMinute}} - {{map.position.endTime | dateFormatByMinute}}</span></div>--%>
                <div class="details-desc">
                    <h3>职位描述</h3>
                    <div class="txt"  id="positiondesc">

                    </div>
                </div>
                <div class="details-setTime">集合时间<span>{{map.position.setDate |  dateFormat:'yyyy年MM月dd日 hh:mm'}}</span></div>
                <div class="details-place" id="goviewmap"><em>集合地址</em><span>{{map.position.gather | ifNull:'未知地址','detailedAddress'}}</span><i class="iconfont icon-fujin"></i></div>
            </div>
            <!--发布对象与注意事项-->
            <div class="point">
                <div class="company">
                    <div class="company-title">发布对象</div>
                    <div class="company-content clearfix">
                        <div class="company-content-img ">
                            <a href="javascript:void(0)"><img src="{{map.position.positionUser.imgPath}}" alt=""></a>
                        </div>
                        <div class="company-content-msg ">
                            <p>{{map.position.publish | ifNull:'无工作号','workNumber'}}</p>
                            <p>正在招聘：<em>{{map.count}}</em>个职位</p>
                        </div>
                        <div class="visit_home">
                            <%-- isEdit 是否可编辑 --%>
                            <a href="javascript:void(0);" style="padding-left: 10px;padding-right: 10px;" onclick="ijob.storage.set('isEdit',false);ijob.gotoPage({url:'/ijob/api/InformationController/h5/mine/examineUserInfo/'+ijob.location.get().lng+'/'+ijob.location.get().lat +'/{{map.position.userID}}'});">访问工作号</a>
                        </div>
                    </div>
                </div>
                <div class="warn">
                    <div class="warn-title">注意事项</div>
                    <div class="warn-content">
                        <div class="warn-content-msg">
                            工作期间请注意人身和财产安全，对于商家
                            提出的任何收费一律拒绝，并向平台举报。
                        </div>
                        <div class="warn-content-report" onclick="ijob.gotoPage({path:'/h5/qz/mine/report?data.positionID={{map.position.id}}'})">举报</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="foot_margin"></div>
        {{/each}}
    </script>
</div>
</body>
<script>



    var id = null ,shareUser = $("#shareUser").val();
    $("#todayJob").loadData("该职位已经关闭或删除").then(function(result){
        if(id==null||id==undefined){
            id = result.data.list[0].position.id;
        }
        //判断是招聘者预览还是求职者查看
        if(ijob.storage.get("editInformation")){
            //如果是预览就不要这几个 Dom 数据
            $(".foot-fixed").remove();
        }
        var content = (result.data.list[0].position.jobContent||"无职位描述").replace(/\n/g,"<br/>");
        $("#positiondesc").html(content);
        //判断是招聘者预览还是求职者查看
        if(ijob.storage.get("editInformation")){
            //如果是预览就不要这几个 Dom 数据
            $(".foot-fixed").remove();
        }
        if(ijob.storage.get("shareObj") != null){
            var title= "【I Job兼职】"+ijob.storage.get("shareObj").title+"\t\t\t"+ijob.storage.get("shareObj").salary+"元/天";
            var desc  = "";
            try{
                desc="招聘人数："+result.data.list[0].position.recruitsSum+"人天"+"\n"+"地点："+ijob.storage.get("shareObj").city+"\n时间："+template.dateFormat(result.data.list[0].position.recruitStartTime,'MM/dd')+"-"+template.dateFormat(result.data.list[0].position.recruitEndTime,'MM/dd');
            }catch (err){
                window.location.reload();
            }
            // var link="http://www.jianzhipt.cn";
            var link="${site}/share/PD/"+id + "/"+shareUser;;
            var tempType = result.data.list[0].position.huntingtype.codeGrade;
            var imgUrl="";
            if(tempType=="0016"||tempType=="007"||tempType=="0020"||tempType=="0024"){
                imgUrl="${site}/static/images/shareLogo1.png";
            }else if(tempType=="006"||tempType=="005"||tempType=="0026"){
                imgUrl="${site}/static/images/shareLogo2.png";
            }else if(tempType=="0014"||tempType=="004"){
                imgUrl="${site}/static/images/shareLogo3.png";
            }else if(tempType=="0012"||tempType=="0015"){
                imgUrl="${site}/static/images/shareLogo4.png";
            }else if(tempType=="0010"){
                imgUrl="${site}/static/images/shareLogo5.png";
            }else if(tempType=="008"||tempType=="009"||tempType=="0013"||tempType=="0018"){
                imgUrl="${site}/static/images/shareLogo6.png";
            }else if(tempType=="0025"||tempType=="0021"||tempType=="001"){
                imgUrl="${site}/static/images/shareLogo7.png";
            }else if(tempType=="0017"||tempType=="003"||tempType=="002"||tempType=="0019"){
                imgUrl="${site}/static/images/shareLogo8.png";
            }else if(tempType=="0011"||tempType=="0023"||tempType=="0022"){
                imgUrl="${site}/static/images/shareLogo9.png";
            }else{
                imgUrl="${site}/static/images/sharelogo.png";
            }
        }

        var datetime = result.data.list[0].position.workDate;
        var mydatetime = result.data.list[0].defaultResume&&result.data.list[0].defaultResume.workDate||'';
        var arr = ijob.getDateList(datetime);
        var arrnum = ijob.getDatePersonList(datetime);
        var myarrtemp = ijob.getDateList(mydatetime);
        var myarr = [];
        for(var i in myarrtemp){
            var d = myarrtemp[i];
            if(ijob.abledDate(d)){
                myarr.push(d);
            }
        }
        $('.date').on('completionEvent', function() {
            $(".date").containDate(arr,myarr);
            $(".date").remainder(arrnum);
        });

        dateRenderInit(arr);
    });

</script>
</html>
