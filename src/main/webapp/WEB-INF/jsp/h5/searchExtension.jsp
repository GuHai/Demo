<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/30
  Time: 11:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>推广职位</title>
    <jsp:include page="qz/base/link.jsp"/>
    <jsp:include page="qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/chooseResume.css?version=4">
</head>
<body>
<div class="wrap">
    <div class="page_searchExtension">
        <%--搜索工作号--%>
        <header class="head">
            <div class="head-lf mui-input-row">
                <i class="mui-icon mui-icon-search"></i>
                <input type="text" id="searchjob" class=" mui-input-clear" placeholder="搜索工作号">
            </div>
            <div class="head-rt"  id="searchBnt">
                <div class="btn">搜索</div>
            </div>
        </header>
        <%--搜索结果--%>
        <div class="search-result-box" style="display: none;">
            <div class="search-list listing-content">
                <div class="mainbox">
                    <p class="tit">搜索结果</p>
                    <ul>
                        <script  type="text/html" id="search"  data-url="/ijob/api/WorkNumberController/searchAttentionList" >
                            {{each list as work }}
                                <li>
                                    <div class="left">
                                        <div class="photo">
                                            <img  src="/ijob/upload/{{work.hdImage | absolutelyPath}}" onerror="this.src='/ijob/static/images/school.jpg';this.onerror=null"/>
                                        </div>
                                        <div class="inform">
                                            <p class="name">{{work.name}}</p>
                                            <p class="fans">
                                                <span class="box1">粉丝 <span class="{{work.id}}fans num">0</span></span>
                                                <span class="box2">职位 <span class="{{work.id}}position num">0</span></span>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="follow  {{work.id}}tel">
                                         <a href="javascript:void(0)" data-id="{{work.id}}" class="{{work.id}}  extensionbtns btns">申请推广</a>
                                    </div>
                                </li>
                            {{/each}}
                        </script>
                    </ul>
                </div>
            </div>
        </div>
         <%--信息列表--%>
        <div class="school-list">
            <div class="listing-content">
                <%--最近推广过的--%>
                <%--附近的：--%>
                <div class="nearby-list mainbox">
                    <p class="tit">附近的：</p>
                    <ul>
                        <script  type="text/html" id="myattached"  data-url="/ijob/api/WorkNumberController/attachedSchoolList" >
                            {{each list as work }}
                                <li>
                                    <div class="left">
                                        <div class="photo">
                                            <img  src="https://gkcx.eol.cn/upload/schoollogo/{{work.badge}}.jpg"  onerror="this.src='/ijob/static/images/school.jpg';this.onerror=null"/>
                                        </div>
                                        <div class="inform">
                                            <p class="name">{{work.name}}</p>
                                            <p class="fans">
                                                <span class="box1">距离 <span class="num">{{work.distance | distance}}</span></span>
                                                <span class="box2">职位 <span class="{{work.workID}}position num">0</span></span>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="follow {{work.workID}}tel">
                                        <a href="javascript:void(0)" class="{{work.workID}} extensionbtns btns" data-id="{{work.workID}}">申请推广</a>
                                    </div>
                                </li>
                            {{/each}}
                        </script>
                    </ul>
                </div>
                <%--我关注的：--%>
                <div class="nearby-list mainbox">
                    <p class="tit">我关注的：</p>
                    <ul>
                        <script  type="text/html" id="myattention"  data-url="/ijob/api/WorkNumberController/myAttentionList" >
                            {{each list as work }}
                                <li>
                                    <div class="left">
                                        <div class="photo">
                                            <img  src="/ijob/upload/{{work.hdImage | absolutelyPath}}" onerror="this.src='/ijob/static/images/school.jpg';this.onerror=null"/>
                                        </div>
                                        <div class="inform">
                                            <p class="name">{{work.name}}</p>
                                            <p class="fans">
                                                <span class="box1">粉丝 <span class="{{work.id}}fans num">0</span></span>
                                                <span class="box2">职位 <span class="{{work.id}}position num">0</span></span>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="follow {{work.id}}tel">
                                        <a href="javascript:void(0)" class="{{work.id}} extensionbtns btns" data-id="{{work.id}}">申请推广</a>
                                    </div>
                                </li>
                            {{/each}}
                        </script>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script>


    $("#myattention").loadData().then(function(result){
        var local = ijob.location.get();
        $("#myattached").loadData({condition:{lat:local.lat,lng:local.lng},pageSize:5,currentPage:1}).then(function(result1){
            getDetailInfo();
        });
    });

    var telmap ={};

    function getDetailInfo(){
        $.getJSON("/ijob/api/WorkNumberController/myapplyPromotionResult/"+ijob.storage.get("position.id"),function(result2){
            for(var i in result2.data.list){
                var wp = result2.data.list[i];
                var id = wp.workID;
                var classname = (wp.status==1?'audit':(wp.status==2?'success':'failed'));
                var textname = (wp.status==1?'审核中':(wp.status==2?'审核通过':'未通过'));
                $("."+id).removeClass("extensionbtns").addClass(classname);
                $("."+id).text(textname);
            }
            $.getJSON("/ijob/api/WorkNumberController/resultlist",function(result3){
                for(var i in result3.data.list){
                    var map = result3.data.list[i];
                    var id = map.workID;
                    $("."+id+"fans").text(map.fans);
                    $("."+id+"position").text(map.position);
                }

                $.getJSON("/ijob/api/WorkNumberController/managerPhoneList",function(result4){
                    for(var i in result4.data.list) {
                        var map = result4.data.list[i];
                        var id = map.workID;
                        telmap[id] = map.personPhoneNumber;
                    }
                    $("div[class$='tel']:not(:contains('申请推广'))").each(function(i,item){
                        if(0==$(item).find(".icon-dianhua").length){
                            var id = $(item).find("a").data("id");
                            $(item).append("<a href=\"tel:"+(telmap[id]||telmap['admin'])+"\" class=\"btns iconbtns\"><span class=\"iconfont icon-dianhua\"></span></a>");
                        }
                    });
                });
            });
        });
    }



    $(".listing-content").on('click','.extensionbtns',function(){
        var _this = $(this);
        var wp= {workID:_this.data("id"),positionID:ijob.storage.get("position.id")};
        _this.btPost("/ijob/api/WorkNumberController/applyPromotion",JSON.stringify(wp),function(result){
            if(result.success==true){
               /* _this.removeClass("extensionbtns").addClass("audit");
                _this.text('审核中');*/

                var tel = telmap[_this.data("id")]||telmap['admin'];
                $("."+_this.data("id")+"tel").find("a").removeClass("extensionbtns").addClass("audit");
                $("."+_this.data("id")+"tel").find("a").text('审核中');
                $("."+_this.data("id")+"tel").append("<a href=\"tel:"+tel+"\" class=\"btns iconbtns\"><span class=\"iconfont icon-dianhua\"></span></a>");
            }else{
                mui.alert(result.msg);
            }
        });
    });
    var search = 0;
    var searchParam = {condition:{keyword:null}};
    $(function () {
        $("#searchjob").on('input',function(){
            var key  = $("#searchjob").val();
            if(key.length==0){
                $(".search-result-box").hide();
                $(".school-list").show();
            }else{
                $(".search-result-box").show();
                $(".school-list").hide();
                clearTimeout(search);
                search  = setTimeout(function(){
                    searchParam = {condition:{name:$("#searchjob").val().trim()},pageSize:100};
                    seachHandler();
                },1000);
            }
        });
    })

    function seachHandler(){
        $("#search").loadData(searchParam).then(function(){
            getDetailInfo();
        });
    }
</script>