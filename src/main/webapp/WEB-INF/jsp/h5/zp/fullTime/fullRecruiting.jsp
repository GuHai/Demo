<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/8
  Time: 10:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>在招职位</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/fullTime/fullTime.css?version=4">
    <style>
        .mui-switch{top:0.366rem;}
        .mui-switch.mui-active:before{content: '开放中';font-size:0.266rem;left: 16%;top: -9%;}
        .mui-switch:before{content: '已禁用';font-size:0.266rem;right:4px;}
        .mui-switch{width:1.6rem;height:0.533rem;}
        .mui-switch .mui-switch-handle{width:0.48rem;height:0.48rem;left: 2px}
        .mui-switch:before{top:-0.05rem;}
        .mui-switch{background-color:#d7d7d7;border:2px solid #d7d7d7;}
        .mui-switch-blue.mui-active{background-color:#108ee9;border:2px solid #108ee9;background-clip: border-box;}
    </style>
</head>
<body>
<div class="full-recruiting">
    <div class="list-box">
        <ul>
            <script id="postListManager" type="text/html" data-url="/ijob/api/FullTimeController/postListManager">
                {{each list as post}}
                    <li class="ul-li">
                        <div class="list-title">
                            <div class="left-txt" onclick="ijob.gotoPage({path:'/h5/zp/fullTime/postJob?full.id={{post.id}}'})">
                                <p class="posi_tit">{{post.title}}</p>
                                <p class="times">浏览<span>{{post.browser}}</span>次</p>
                            </div>
                            <div class="mui-switch mui-switch-blue mui-active open" data-id="{{post.id}}" data-url="/ijob/api/FullTimeController/deleteOrClosePost">
                                <div class="mui-switch-handle"></div>
                            </div>
                            <form id="{{post.id}}" style="display: none;">
                                <input type="hidden" name="id" value="{{post.id}}">
                                <input type="hidden" name="version" value="{{post.version}}">
                            </form>
                        </div>
                        <div class="list-content " >
                            <div class="list-cz">
                                <a href="javascript:void(0)" class="delete" data-id="{{post.id}}" data-url="/ijob/api/FullTimeController/deleteOrClosePost">
                                    <i class="iconfont icon-shanchu2"></i>
                                    <span class="del">删除</span>
                                </a>
                            </div>
                            <div class="rewardbtns">
                                <%--<a href="javascript:void(0);" class="extension">职位置顶</a>--%>
                                <a href="javascript:void(0);" class="link" onclick="ijob.gotoPage({path:'/h5/zp/fullTime/brokerSet?post.id={{post.id}}'})">经纪人设置</a>
                            </div>
                        </div>
                    </li>
                {{/each}}
            </script>
        </ul>
    </div>
</div>
<div id="homepage"></div>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});
    function init(){
        $("#postListManager").loadData().then(function (result) {
            $(".open").click(function () {
                var post = $("#"+$(this).data("id")).serializeObjectJson();
                post.status = 0;
                $(this).btPost(post,function (data) {
                    if(data.code == 200){
                        init()
                    }else{
                        mui.toast("请刷新重试");
                    }
                })
            });
            $(".delete").click(function () {
                var post = $("#"+$(this).data("id")).serializeObjectJson();
                post.isDeleted = true;
                $(this).btPost(post,function (data) {
                    if(data.code == 200){
                        init()
                    }else{
                        mui.toast("请刷新重试");
                    }
                })
            });
        });
    }
    init();
</script>
</body>
</html>
