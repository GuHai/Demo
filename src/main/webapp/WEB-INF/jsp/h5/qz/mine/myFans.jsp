<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>粉丝</title>
    <link rel="stylesheet" href="/ijob/static/css/mine/myFans.css?version=4">
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
</head>
<body>
    <div class="wrap">
        <script id="getMyfans" type="text/html" data-url="/ijob/api/AttentionController/h5/mine/getFansList" data-type="POST">
            <ul id="refresh" class="mui-table-view ">
                {{each list as myfans}}
                    <li class="mui-table-view-cell mui-media">
                        <a onclick="ijob.storage.set('isEdit',false);ijob.gotoPage({url:'/ijob/api/InformationController/h5/mine/examineUserInfo/'+ijob.location.get().lng+'/'+ijob.location.get().lat +'/{{myfans.concernID}}'});" id="{{myfans.concernID}}">
                            <div class="photo mui-pull-left">
                                <img class="mui-pull-left" onerror="this.src='{{myfans.weiXinHead}}';this.onerror=null" src="/ijob/upload/{{myfans.headimgurl}}">
                            </div>
                            <div class="mui-media-body mui-pull-left disflex">
                                <div class="leftName">
                                    {{if myfans.realName != null &&  myfans.realName != ''}}
                                        {{myfans.realName}}
                                    {{else if myfans.adminName!= null && myfans.adminName != ''}}
                                        {{myfans.adminName}}
                                    {{else}}
                                        {{myfans.nickName}}
                                    {{/if}}
                                    {{if myfans.positionSize ==null}}
                                    <p class="mui-ellipsis">暂无职位发布</p>
                                    {{else}}
                                    <p class="mui-ellipsis">在招职位{{myfans.positionSize}}个</p>
                                    {{/if}}
                                </div>
                                <div class="workNum">{{myfans.workNumber}}</div>
                            </div>
                        </a>
                    </li>
                {{/each}}
            </ul>
        </script>
    </div>
</body>
<script>
    var obj = {condition:{isDeleted:false}}
    if(ijob.storage.get("workID")!=null){
        obj.condition.userID = ijob.storage.get("workID");
    }
    $("#getMyfans").loadData(obj).then(function (result){
        if(result.data.list.length == 0){
            $(".nodata").remove();
            $('.wrap').append("<p style='text-align: center;margin-top: 5rem;'>亲，您还没有粉丝团！</p>");
        }
    });
</script>
</html>
<!--<script>-->
<!--mui.init({-->
<!--pullRefresh: {-->
<!--container: "#refresh",//下拉刷新容器标识，querySelector能定位的css选择器均可，比如：id、.class等-->
<!--down: {-->
<!--style: 'circle',//必选，下拉刷新样式，目前支持原生5+ ‘circle’ 样式-->
<!--color: '#2BD009', //可选，默认“#2BD009” 下拉刷新控件颜色-->
<!--height: '50px',//可选,默认50px.下拉刷新控件的高度,-->
<!--range: '100px', //可选 默认100px,控件可下拉拖拽的范围-->
<!--offset: '0px', //可选 默认0px,下拉刷新控件的起始位置-->
<!--auto: true,//可选,默认false.首次加载自动上拉刷新一次-->
<!--callback: pullfresh //必选，刷新函数，根据具体业务来编写，比如通过ajax从服务器获取新数据；-->
<!--}-->
<!--}-->
<!--});-->

<!--//    function pullfresh() {-->
<!--//        //业务逻辑代码，比如通过ajax从服务器获取新数据；-->
<!--//-->
<!--//        //注意：-->
<!--//        //1、加载完新数据后，必须执行如下代码，true表示没有更多数据了：-->
<!--//        //2、若为ajax请求，则需将如下代码放置在处理完ajax响应数据之后-->
<!--//        this.endPullupToRefresh(true);-->
<!--//    }-->
<!--</script>-->