<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>群设置</title>
    <link rel="stylesheet" href="/ijob/static/css/base.css">
    <link rel="stylesheet" href="/ijob/static/iconfont/iconfont.css">
    <link rel="stylesheet" href="/ijob/static/css/infprmation/groupchat.css">
</head>
<jsp:include page="../zp/base/resource.jsp"/>
<body>
<div class="wrap">
    <script  type="text/html" id="getGroupSetting"  data-url="/ijob/api/GrouplistController/getGroupInfo" data-type="POST">
        <div class="page_group_content">
            <div class="group_content">
                <ul class="list">
                    {{each list[0].groupUserList as user}}
                        <li>
                            <div class="picture_box">
                                <img src="{{user.headimgurl}}"/>
                            </div>
                            <div class="name">{{user.userNickName}}</div>
                        </li>
                    {{/each}}
                </ul>
                <div class="moreview">
                    查看更多群成员<span class="iconfont icon-arrow-right"></span>
                </div>
            </div>
            <div class="edit_nick_box">
                <div class="title">我的群昵称</div>
                <div class="nick"><span class="name">{{list[0].nowUser.userNickName}}</span><span class="iconfont icon-arrow-right"></span></div>
            </div>
            <footer class="foot_fixed">
                <a href="javascript:void(0);" class="Signout" id="Signout" data-id="{{list[0].nowUser.id}}" data-groupid="{{list[0].nowUser.groupID}}" data-type="{{list[0].nowUser.userType}}" >退出群聊</a>
                <div class="tip_out_content"></div>
            </footer>
        </div>
        <div class="page_nick_content">
            <div class="edit_box">
                <div class="edit_input">
                    <form action="" id="nickForm">
                        <input type="text" oninput="lengthMax(this)" id="nickName" placeholder="{{list[0].nowUser.userNickName}}"data-id="{{list[0].nowUser.id}}" data-version="{{list[0].nowUser.version}}" >
                        <span class="iconfont icon-shanchu1" id="reset"></span>
                    </form>
                </div>
                <p class="tips">在这里可以设置你在这个群里的昵称。这个昵称只会在此群内显示。</p>
            </div>
            <div class="operation_btn">
                <a href="javascript:void(0);" class="cancel" id="cancel">取消</a>
                <a href="javascript:void(0);" class="confirm" id="confirm">保存</a>
            </div>
        </div>
    </script>
</div>
<div id="homepage"></div>
</body>
</html>
<script src="/ijob/static/js/information/groupSet.js"></script>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});
    function updateBackPage(){
        var state = {
            title: "",
            url: "forward?path=/h5/information/groupSet" // 这个url可以随便填，只是为了不让浏览器显示的url地址发生变化，对页面其实无影响
        };
        window.history.pushState(state, state.title, state.url);
        window.addEventListener("popstate", function(e) {
            ijob.gotoPage({path:"/h5/information/groupchat"});
        }, false);
    }

    updateBackPage();
    function lengthMax(arg) {
        if(arg.value.length>16){
            $(arg).blur();
            mui.alert("字数不能超过16个",function(){
                arg.value=arg.value.slice(0,16);
            })
        }
    }
    var groupID = ijob.storage.get("chat.toUserID");
    $("#getGroupSetting").data("url", $("#getGroupSetting").data("url") + "/" +groupID);
    $("#getGroupSetting").loadData().then(function(result){
        console.log(result);
        $(".foot_fixed .Signout").on("click",function () {
            var msg = '';
            if($("#Signout").data('type') == 1){
                msg = '退出后群会解散';
            }else if($("#Signout").data('type') == 3){
                msg = '退出后不会通知群聊中其他成员，且不会再 接收此群聊消息';
            }
            // 求职者提示
            var btnArray = ['取消','确认'];
            mui.confirm(msg,'提示',btnArray,function(e){
                if(e.index == 1 ){
                    var params = {
                        id:$("#Signout").data('id'),
                        groupID:$("#Signout").data('groupid'),
                        userType:$("#Signout").data('type')
                    }
                    $.post("/ijob/api/GrouplistController/exitGroup",params,function(data){
                        if(data.code == 200){
                            mui.alert("操作成功",function(){
                                ijob.gotoPage({url:"/indexMain"});
                            })
                        }
                    })
                }
            });
        })
        // 人数大于25时显示
        var lengli = $(".group_content .list li").length;
        if(lengli >= 25){
           $(".group_content .moreview").show();
            $('.group_content .list').css('height','7.8rem')
           // 点击查看更多
            $('.group_content .moreview').click(function(){
                if($(this).siblings('.group_content .list').css('overflow')=='hidden'){
                    $(this).siblings('.group_content .list').css({'overflow':'auto','height':'auto'});
                }else{
                    $(this).siblings('.group_content .list').css({'overflow':'hidden','height':'7.8rem'});
                }
            });
        }

        // 修改昵称
        $(".edit_nick_box .nick").on("click",function () {
            $(".page_group_content").hide();
            $(".page_nick_content").show();
        });
        // 取消修改昵称
        $(".operation_btn .cancel").on("click",function () {
            $("#nickName").val("");
            $(".page_group_content").show();
            $(".page_nick_content").hide();
        });
        // 显示
        $("#nickName").change(function() {
            if($("#nickName").val().length > 0){
                $("#reset").show();
            }
        });
        // 重置
        $("#reset").click(function(){
            $(':input','#nickForm').not(':reset').val('');
            $("#reset").hide();
        });
        //确定
        $("#confirm").click(function(){
            if ($("#nickName").val() == ""){
                mui.alert("请输入昵称！");
            }else if ($("#nickName").val().trim() == ""){
                mui.alert("请输入昵称！");
            }else{
                var params = {
                    userNickName:$("#nickName").val(),
                    id:$("#nickName").data('id'),
                    version:$("#nickName").data('version')
                }
                $.post("/ijob/api/GrouplistController/update",params,function(data){
                    if (data.code == 200){
                        location.reload();
                    }
                });
            }
        });
    });
</script>

