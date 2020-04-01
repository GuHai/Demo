<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/23
  Time: 14:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="qz/base/resource.jsp"/>
    <jsp:include page="qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/inform.css?version=4">
    <title>设置求职意向</title>
</head>
<div class="wrap">
    <div class="page_job_intension">
        <script id="myIntention"   type="text/html"  data-url="/ijob/api/BeenrecruitedController/intention">
        {{each list as map}}
            <div class="type-list posi_list">
                <h3>职位类别（可多选）</h3>
                <ul class="sortList clearfix">
                    <li onclick="allChecked1(this)" id="alltype">全部</li>
                    {{each map.workTypeList as type index}}
                        <li class="type" onclick="disAllChecked1(this)" data-htid="{{type.id}}" data-refid="{{type.refId}}">{{type.name}}</li>
                    {{/each}}
                    <li class="type morebtns">更多<span class="iconfont icon-arrow-down1"></span></li>
                </ul>
            </div>
            <div class="type-list area_list">
                <div class="flex">
                    <h3>工作区域（可多选）</h3>
                    <a href="javascript:void(0)" class="region">长沙<span class="iconfont icon-fujin"></span></a>
                </div>
                <ul class="sortList clearfix">

                    {{each map.cityList as city index}}
                    {{if index==0}}
                    <li onclick="allChecked2(this)" id="allreg">全部</li>
                    {{else}}
                    <li onclick="disAllChecked2(this)" class="reg" data-cityid="{{city.id}}"  data-refid="{{city.refId}}">{{city.cityName}}</li>
                    {{/if}}
                    {{/each}}
                </ul>
            </div>
            <div class="button-box">
                <a href="javascript:void(0)" class="nextbtns" data-url="/ijob/api/BeenrecruitedController/addIntention">下一步</a>
                <a href="javascript:void(0)" class="skip" onclick="ijob.gotoPage({path:'/h5/set_success'})">
                    跳过
                    <span class="arrow-1"><em></em><i></i></span>
                    <span class="arrow-2"><em></em><i></i></span>
                </a>
            </div>
        {{/each}}
        </script>
    </div>
</div>
<body>
<script>
    $("#myIntention").loadData().then(function (result) {
        console.log(result);
        $(".posi_list li,.area_list li").click( function () {
            if ($(this).is('.curr')){
                $(this).removeClass("curr");
            }else{
                $(this).addClass("curr");
            }
        });

        var obj = {
            intentionaddresses:[],
            intentiontypes:[],
            intentiondate:{/*id:result.data.list[0].intentionDate.id,version:result.data.list[0].intentionDate.version,*/userID:result.data.list[0].userID,myDate:null}
        };
        if(result.data.list[0].intentionDate!=null){
            obj.intentiondate.id = result.data.list[0].intentionDate.id ;
            obj.intentiondate.version = result.data.list[0].intentionDate.version ;
        }
        $(".nextbtns").click(function () {
            var typeList = $(".posi_list .curr");
            var regList = $('.area_list .curr');

            var typeResult = new Array();
            var regResult = new Array();
            for(var a = 0;a<typeList.length;a++){
                if($(typeList[a]).data("htid")!=null||$(typeList[a]).data("htid")!=undefined) {
                    typeResult.push({
                        userID: result.data.list[0].userID,
                        id: $(typeList[a]).data("refid"),
                        "htID": $(typeList[a]).data("htid")
                    });
                }
            }
            for(var a = 0;a<regList.length;a++){
                if($(regList[a]).data("cityid")!=null||$(regList[a]).data("cityid")!=undefined){
                    regResult.push({userID:result.data.list[0].userID,id:$(regList[a]).data("refid"),"cityID":$(regList[a]).data("cityid")});
                }
            }
            obj.intentionaddresses = regResult ;
            obj.intentiontypes = typeResult ;
            $(this).btPost(obj,function (result1) {
                console.log(result1);
                if(result1.code == 200){
                    ijob.gotoPage({path:'/h5/set_success'})
                }else {
                    mui.alert("数据错误！");
                }
            })
            //
        });
        /*更多*/
        var len = 7;
        $ (".posi_list .sortList li").filter("li:gt(" + (len - 1) + ")").hide().filter(":last").show().click(function (){
            $ (this).siblings ("li:gt(" + (len - 1) + ")").toggle ();
            $ (".posi_list .sortList li").filter(":last").removeClass("curr");
        });

    })

    var alltype = $(".type");
    var allreg = $(".reg");
    // 全选
    function allChecked1(arg){
        if (!$(arg).hasClass("curr"))
            $(".type").addClass("curr");
        else
            $(".type").removeClass("curr");
    }
    // 取消一个则取消全部
    function disAllChecked1(arg){
        var allCheck = 0;
        for (var i = 0 ;i< alltype.length; i++){
            if ($(alltype[i]).hasClass("curr")&&$(alltype[i]).attr("value") != $(arg).attr("value"))
                allCheck++;
        }
        if (allCheck == alltype.length-1)
            $("#alltype").addClass("curr");
        if ($(arg).hasClass("curr") || allCheck == alltype.length)
            $("#alltype").removeClass("curr");
    }

    function allChecked2(arg){
        if (!$(arg).hasClass("curr"))
            $(".reg").addClass("curr");
        else
            $(".reg").removeClass("curr");
    }
    // 取消一个则取消全部
    function disAllChecked2(arg){
        var allCheck = 0;
        for (var i = 0 ;i< allreg.length; i++){
            if ($(allreg[i]).hasClass("curr")&&$(allreg[i]).attr("value") != $(arg).attr("value"))
                allCheck++;
        }
        if (allCheck == allreg.length-1){
            $("#allreg").addClass("curr");
        }else if ($(arg).hasClass("curr") || allCheck == allreg.length-0){
            $("#allreg").removeClass("curr");
        }
    }

</script>
</body>
</html>
