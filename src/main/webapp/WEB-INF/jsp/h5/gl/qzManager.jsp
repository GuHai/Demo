<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/9/25
  Time: 11:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>求职者会员管理后台</title>
    <jsp:include page="../qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <link rel="stylesheet" href="/ijob/static/css/base.css">

    <style>
        .message{
            right: 15px;
            position: absolute!important;
            top: 20%;
        }
    </style>
</head>
<body>

<div class="mui-content">
    <div class="mui-card">
        <input id="keyword" type="text" data-input-password="3" placeholder="输入名字或者电话号码" data-url="/UserController/h5/gl/openQzVIP">
        <ul class="mui-table-view">
            <script  type="text/html" id="zptemplate"  data-url="/UserController/h5/gl/qzList">
                {{each list as zp }}
                <li class="mui-table-view-cell mui-collapse" data-check="{{wd.isCheck}}">
                    <a class="mui-navigate-right" href="#">
                        <b>{{zp.mainName | ifNull:'未知姓名'}}</b>
                    </a>
                    <div class="mui-collapse-content">
                        <div class="mui-table-view-cell">
                            <span>电话号码：</span>
                            <a href="tel:{{zp.personPhoneNumber}}"  class="message" style="color:#4599dd">{{zp.personPhoneNumber}}</a>
                        </div>
                        <div class="mui-table-view-cell">
                            <span>合伙人会员：</span>
                            <div class="mui-switch mui-switch-blue {{zp.vip==1?'mui-active':''}}" data-user="{{zp.userID}}" data-number="{{zp.personPhoneNumber}}">
                                <div class="mui-switch-handle"></div>
                            </div>
                        </div>
                        <div class="mui-table-view-cell">
                            <span>会员等级：</span>
                            {{if zp.vip==0}}
                            <a class="message" style="color:#4599dd">尚未开通会员</a>
                            {{else}}
                            <a class="message" style="color:#4599dd">{{zp.partID | enums:'partLevel'}}</a>
                            {{/if}}
                        </div>
                    </div>
                </li>
                {{/each}}
            </script>
        </ul>
    </div>
</div>
</body>

<script>


    var positionparam = {condition:{keyword:null}};
    function loadDataHandler(){
        var page  = {"pageSize": "15", "currentPage": "1"};
        var ijobRefresh = new IJobRefresh({
            container: '.mui-table-view',
            up: function () {
                var obj = $.extend(page, positionparam);
                $("#zptemplate").appendData(obj, ijobRefresh).then(function (result) {
                    page.currentPage =  result.nextPage;
                });
            }
        });
    }
    var search = 0;
    $("#keyword").on('input',function(){
        var keyword  = $("#keyword").val()||null;
        clearTimeout(search);
        search = setTimeout(function(){
            positionparam = {condition:{keyword:keyword}};
            loadDataHandler();
        },1000);

    });

    $(".mui-content").on('click','.mui-switch',function(event){
        if($(this).data('number')!=""&&$(this).data('number')!=null&&$(this).data('number')!=undefined){
            var _this = $(this);
            var flag = _this.hasClass("mui-active");
            var btn = ['黄金', '铂金','钻石','取消'];
            var params = {
                userID:$(this).data('user'),
                code:$(this).data('number'),
                status:true
            }
            if(flag==false){
                mui.confirm('请选择会员等级', '等级选择', btn, function (e) {
                    if (e.index < 3) {
                        params.upgradePartID = e.index + 1;
                        params.partID = e.index + 1;
                        $("#keyword").btPost(params,function (result) {
                            if(result.code == 200||result.code == '200'){
                                _this.addClass("mui-active");
                            }
                            mui.toast(result.msg);
                            loadDataHandler();
                        });
                    }
                });
            }else{
                mui.alert('不能关闭用户VIP ');
            }

        }else{
            mui.alert("请让该用户切换成招聘者，进行实名认证！");
        }

        /*$("body").before(ijob.mask);*/
        /*$.getJSON("/UserController/h5/gl/changeVIP/"+_this.data("user"),function(result){
            if(result.code==200){
                if(flag==true){
                    _this.removeClass("mui-active");
                }else{
                    _this.addClass("mui-active");
                }
            }
            mui.toast(result.msg);
            $("body").prev(".loading").remove();
        });*/

    });

    loadDataHandler();

</script>
</html>
