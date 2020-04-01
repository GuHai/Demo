<%@ page contentType="text/html;charset=UTF-8" language="java"  import="com.yskj.service.base.DictCacheService"  %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>职位管理</title>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/chooseResume.css?version=4">
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
<body>

<style>
#chooseResume .main .resumeList > li .list-title>span{float:right;font-size:0.346rem;color:#666;}
#chooseResume .head > a .head-lf_span{font-size:0.4rem !important;}
.mui-switch{top:0.366rem;}
.mui-switch.mui-active:before{content: '开放中';font-size:0.266rem;left:5px;top: -3px}
.mui-switch:before{content: '已禁用';font-size:0.266rem;right:4px;}

.mui-switch{width:1.6rem;height:0.533rem;}
.mui-switch .mui-switch-handle{width:0.48rem;height:0.48rem;left: 2px}
.mui-switch:before{top:-0.05rem;}
#chooseResume .main .resumeList > li .list-title>p{font-size:0.4rem;color:#333;}
.mui-switch{background-color:#d7d7d7;border:2px solid #d7d7d7;}
.mui-switch-blue.mui-active{background-color:#108ee9;border:2px solid #108ee9;background-clip: border-box;}
</style>

<div id="chooseResume" class="wrap">
    <div class="main">
        <div class="scroll-list">
            <ul class="line">
                <li style="margin-top: 0px; ">悬赏职位让代理帮招人，可以更快的招到求职者哦~</li>
                <li style="margin-top: 0px; ">推广到其它工作号，审核通过后可以让更多的求职者看到</li>
            </ul>
        </div>
        <ul class="resumeList">
            <script type="text/html" id="jobtemplate"   data-url="/ijob/api/PositionController/h5/mine/findMyPositionList" data-type="GET">
                {{each list as posi}}
                <li>
                    <%--data.position.isPreview=true 用来判断是否是发布者预览 --%>
                    <%--<div class="list-title"  onclick="ijob.gotoPage({path:'/h5/qz/index/part_time_detail?data.position.id={{posi.id}}&data.position.isPreview=true'})">--%>
                    <div class="list-title">
                        <div class="left-txt">
                            <p  id="title{{posi.id}}" onclick="readyUpdatePosition('{{posi.id}}')" class="posi_tit">{{ posi.title }}</p>
                            <p class="times">浏览<span>{{posi.browser}}</span>次</p>
                        </div>
                        <div id="class{{posi.id}}" data-id="{{posi.id}}" data-open="{{posi.open}}" data-version="{{posi.version}}" data-url="/ijob/api/PositionController/update"  class="mui-switch mui-switch-blue ">
                           <div class='mui-switch-handle'></div>
                        </div>
                    </div>
                    <div class="list-content " id="div{{posi.id}}">
                        <div class="list-cz">
                            <%--<a href="javascript:void(0)" onclick="ijob.gotoPage({path:'/h5/zp/postJob2?positionTemp.id={{posi.id}}'})" class="edit"><i class="iconfont icon-edit-fill"></i>编辑</a>--%>
                            <a href="javascript:void(0)" data-url="/ijob/api/PositionController/delete" onclick="deletePositionTemplate(this,'{{posi.id}}','{{posi.version}}')" class="delete"><i class="iconfont icon-shanchu2"></i><span class="del">删除</span></a>
                        </div>
                        <%--<div id="class{{posi.id}}" name="{{posi.version}}" data-url="/ijob/api/PositionController/update" ></div>--%>
                    </div>
                </li>
                {{/each}}
            </script>
        </ul>
    </div>
    <div style="clear:both;content:'';height:1.6rem;overflow:hidden;"></div>
    <footer class="choose_foot" >
        <a href="javascript:void(0);" onclick="ijob.gotoPage({path:'/h5/zp/postJob2?positionTemp.id=0'})">
            <span class="head-lf_span">
                <%--<i class="iconfont icon-jia" style="font-size:18px;margin-right:8px;"></i>--%>
                发布职位
            </span>
            <%--<span class="head-rt_span iconfont icon-arrow-right"></span>--%>
        </a>
    </footer>
    <div id="homepage"></div>
</div>
<script>

    $("#homepage").freshPage({path:"/h5/homepage"});

    ijob.storage.clear();
    ijob.storage.set("positionObj",null);
    ijob.storage.set("id",null);
    ijob.storage.set("labelList",null);
    ijob.storage.set("jobContent",null);
    // var cachedata = ijob.persistence.get("cache./ijob/api/PositionController/h5/mine/findMyPositionList");

    $("#jobtemplate").loadData().then(
        function(result){
            // if(cachedata&&cachedata.cache&&cachedata.cache.stop){
            //     $(window).scrollTop(cachedata.anchors.stop);
            //     cachedata.cache = false;  //缓存开关关闭
            //     ijob.persistence.set("cache./ijob/api/PositionController/h5/mine/findMyPositionList",cachedata);
            // }


            if(result.data.list[0] != undefined){
                //  将用来判断是否是发布者预览的字段重置为 false
                ijob.storage.set("data.position.isPreview",false);
                forEachPositionList(result);
            }else {
                $(".nodata").remove();
                $("#jobtemplate").after("<p style='text-align: center;margin-top:5rem;'>您还没有发布职位哦！ </p>");
            }
        }

    );


    function remarkAnchors(){  //记录当前位置，设置为待缓存所有
        // cachedata = ijob.persistence.get("cache./ijob/api/PositionController/h5/mine/findMyPositionList");
        // if(cachedata){
        //     cachedata.anchors = {stop:$(window).scrollTop()};
        //     cachedata.cache = true;
        //     ijob.persistence.set("cache./ijob/api/PositionController/h5/mine/findMyPositionList",cachedata);
        // }

    }



    /*顶部滚动*/
    function AutoScroll(obj) {
        $(obj).find(".line").animate({
                marginTop: "-30px"
            },
            500,
            function() {
                $(this).css({
                    marginTop: "0px"
                }).find("li:first").appendTo(this);
            });
    }
    $(document).ready(function() {
        setInterval('AutoScroll(".scroll-list")', 4000)
    });


    $("#chooseResume").on('click','.mui-switch',function(event){
        var _this = $(this);
        changeOpenType(_this);
    });

    function changeOpenType(event) {
        var position = {};
        //在点击开放按钮之前，输入框并未拥有mui-active 类名
        // if (!$("#class"+event.data.id).hasClass("mui-active")){
        if(event.data("open")!=2){
            position = {
                "id" : event.data("id"),
                "version" : event.data("version"),
                "open" : 2
            }
        }else{
            position = {
                "id" : event.data("id"),
                "version" : event.data("version"),
                "open" : 3
            }
        }
        function changeHandler(id){
            event.btPost(JSON.stringify(position),function(data){
                console.log(position);
                event.data("version",(data.data&&data.data.version)||1);
                if (position.open == 2){
                    event.addClass("mui-active");
                    event.data("open",2);
                    var divStr = "<div class=\"rewardbtns\">\n" +
                        "                                    <a href=\"javascript:void(0);\" class=\"extension\" onclick=\"remarkAnchors();ijob.gotoPage({path:'/h5/searchExtension?data.position.id='+id})\">推广</a>\n" +
                        "                                    <a href=\"javascript:void(0);\" class=\"link\" onclick=\"remarkAnchors();ijob.gotoPage({path:'/h5/zp/offerReward?position.id="+id+"'})\">悬赏</a>\n" +
                        "                                </div>"
                    // $("#div"+id).html($("#div"+id).html() + divStr);

                    $("#div"+id).find(".rewardbtns:first").remove();
                    $("#div"+id).html($("#div"+id).html() + divStr);
                }else if(position.open == 3){
                    $("#div"+id).find(".rewardbtns:first").remove();
                    event.removeClass("mui-active");
                    event.data("open",3);
                }else{
                    event.remove();
                    $("#div"+id).find(".rewardbtns:first").remove();
                }
            },function (data) {
                // event.data("version",(data.data&&data.data.version)||1);
            });
        }
        if(position.open == 2){
            changeHandler(event.data("id"));
        }else {
            var btn = ['禁用', '关闭','返回'];
            mui.confirm('确定要关闭职位吗？<br>（关闭职位后保证金退回，并且职位不能再次开启）', '提示', btn, function (e) {
                if(e.index<2){
                    //不管暂时还是彻底都需要检查是否有人在报名未退款状态，或者在未结算状态
                    $.getJSON("/ijob/api/PositionController/checkClose/"+position.id+"/"+position.open,null,function(result) {
                        if (result.code == "200") {
                            position.open = (3+e.index);
                            changeHandler(event.data("id"));
                        }else{
                            mui.alert(result.msg);
                            event.toggleClass("mui-active");
                            event.attr("style","");
                            event.find("div:first").attr("style","");
                        }

                    });
                }else{
                    event.toggleClass("mui-active");
                    event.attr("style","");
                    event.find("div:first").attr("style","");
                }

            });
        }

        /*$.getJSON("/ijob/api/PositionController/checkClose/"+position.id+"/"+position.open,null,function(result){
            if(result.code=="200"){
                $("#class"+event.data.id).btPost(JSON.stringify(position),function(data){
                    $("#class"+event.data.id).attr("name",(parseInt($("#class"+event.data.id).attr("name"))+1));
                    if (position.open == 2){
                        $("#class"+event.data.id).addClass("mui-active");
                        $("#span"+event.data.id).text("开放中");
                    }else{
                        $("#class"+event.data.id).removeClass("mui-active");
                        $("#span"+event.data.id).text("已关闭");
                    }
                },function (data) {
                    $("#class"+event.data.id).attr("name",(parseInt($("#class"+event.data.id).attr("name"))));
                });
            }else{
                mui.alert(result.msg);
            }
        })*/

    }

    /**
     * 判断招聘方是否能够修改职位
     * @param _id 职位ID
     */
    function readyUpdatePosition(_id){
        /*$.getJSON("/ijob/api/PositionController/checkClose/"+_id+"/"+3,null,function(result){
            if(result.code=="200"){

            }else{
                if(result.msg=="网路错误"){
                    mui.alert("服务器繁忙");
                }else{
                    mui.alert("该职位下有求职者还未结算，不可以修改！");
                }
            }
        })*/
        ijob.gotoPage({path:'/h5/zp/postJob2?positionTemp.id='+_id});
    }

    function deletePositionTemplate(arg,positionTempID,version){
        var btn = ['取消', '确定'];
        mui.confirm('确定要删除职位吗？', '提示', btn, function (e) {
            if (e.index == 1) {

                $.getJSON("/ijob/api/PositionController/checkClose/"+positionTempID+"/"+3,null,function(result){
                    if(result.code=="200"){
                        $(arg).btPost({"id":positionTempID,"version":version},function(data){
                            if (data.code == "200"){
                                mui.toast("删除成功！");
                                $("#jobtemplate").loadData().then(function (result) {
                                    forEachPositionList(result);
                                });
                            }else{
                                mui.toast("删除失败！");
                            }
                        });
                    }else{
                        mui.alert(result.msg);
                    }
                })


            }
        });

    }

    function forEachPositionList(result){
        for (var i = 0;i<result.data.list.length;i++){
            if (result.data.list[i].open == 1){
                var  positionID = result.data.list[i].id;
                var  feestr = result.data.list[i].personNumDay*result.data.list[i].liquidatedDamages;
                var  order = {order:{refID:result.data.list[i].id,fee:feestr*100,description:('招聘人员保证金'+feestr+"元"),type:enums.WxOrderType.Bond}};
                $("#class"+result.data.list[i].id).removeClass("mui-switch mui-switch-blue").addClass("default");
                $("#class"+result.data.list[i].id).text("去支付");
                var _this = $("#class"+result.data.list[i].id);
                (function(order,id,_this){
                    _this.click(function(){
                        ijob.url.next.set("/ijob/api/PositionController/bondCallback");
                        ijob.gotoPage({url:'/ijob/api/WeixinController/order',data:order});
                    });
                })(order,positionID,_this);
            }else if(result.data.list[i].open == 2){
                $("#class"+result.data.list[i].id).addClass("mui-active").data("open",2);
                $("#class"+result.data.list[i].id).data("id",result.data.list[i].id);
                var divStr = "<div class=\"rewardbtns\">\n" +
                    "                                    <a href=\"javascript:void(0);\" class=\"extension\" onclick=\"remarkAnchors();ijob.gotoPage({path:'/h5/searchExtension?data.position.id="+result.data.list[i].id+"'})\">推广</a>\n" +
                    "                                    <a href=\"javascript:void(0);\" class=\"link\" onclick=\"remarkAnchors();ijob.gotoPage({path:'/h5/zp/offerReward?position.id="+result.data.list[i].id+"'})\">悬赏</a>\n" +
                    "                                </div>"
                $("#div"+result.data.list[i].id).html($("#div"+result.data.list[i].id).html() + divStr);
            }else if(result.data.list[i].open == 3){
                $("#class"+result.data.list[i].id).removeClass("mui-active").data("open",3);
                $("#class"+result.data.list[i].id).data("id",result.data.list[i].id);
            }else{
                $("#class"+result.data.list[i].id).remove();
            }
        }
    }
</script>
</body>
</html>