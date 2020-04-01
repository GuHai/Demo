<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>我的关注</title>
    <link rel="stylesheet" href="/ijob/static/css/mine/myFocus.css">
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
</head>
<body>
    <div class="wrap">
        <script id="getMyfocus" type="text/html" data-url="/ijob/api/AttentionController/h5/mine/getFocusList" data-type="POST">
            {{each list as FansList}}
        <ul class="mui-table-view ">
            <li class="mui-table-view-cell mui-media">
                <a onclick="ijob.storage.set('isEdit',false);ijob.gotoPage({url:'/ijob/api/InformationController/h5/mine/examineUserInfo/'+ijob.location.get().lng+'/'+ijob.location.get().lat+'/{{FansList.userID}}' });" id="{{FansList.userID}}">
                   <div class="photo mui-pull-left">
                        <img class="media-object " onerror="this.src='{{FansList.headimgurl}}';this.onerror=null" src="/ijob/upload/{{FansList.headimgurl}}">
                   </div>
                    <div class="mui-media-body mui-pull-left">
                        <div class="leftName">
                            {{if FansList.realName != null &&  FansList.realName != ''}}
                                {{FansList.realName}}
                            {{else if FansList.adminName!= null && FansList.adminName != ''}}
                                {{FansList.adminName}}
                            {{else}}
                                {{FansList.nickName}}
                            {{/if}}
                            {{if FansList.positionSize ==null}}
                                <p class="mui-ellipsis">暂无职位发布</p>
                            {{else}}
                                <p class="mui-ellipsis">正在招聘：{{FansList.positionSize}}个职位</p>
                            {{/if}}
                        </div>
                        <div class="workNum">{{FansList.workNumber}}</div>
                    </div>
                </a>
            </li>
        </ul>
            {{/each}}
        </script>
    </div>
</body>
<script>
    $("#getMyfocus").loadData().then(function (result){
        console.log(result)
        if(result.data.list.length == 0){
            $(".nodata").remove();
            $('.wrap').append("<p style='text-align: center;margin-top: 8rem;'>亲，您还没有关注对象！</p>");
        }
    });
</script>
</html>