<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/26
  Time: 10:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>招聘者管理后台</title>
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
<%--<div class="main">
    <div >
        <input id="keyword" type="text" class="mui-input-password" data-input-password="3" placeholder="输入名字或者电话号码">

        <ul>
            <script  type="text/html" id="zptemplate"  data-url="/UserController/h5/gl/zpList">
                {{each list as zp }}
                <li data-value="{{zp.mainName}}" data-id="{{zp.id}}">
                    <b>{{zp.mainName}}</b>
                    <a href="tel:{{zp.personPhoneNumber}}"  style="position:absolute;left: 100px;color:#dd524d">{{zp.personPhoneNumber}}</a>
                    <span style="position:absolute;left: 280px;"><span class="mui-icon mui-icon-compose" style="color: #007aff;"></span>{{zp.num}}</span>
                    <a href="/UserController/h5/toLoginByID/{{zp.id}}"><i style="float: right" class="iconfont icon-arrow-right"></i></a>
                </li>
                {{/each}}
            </script>
        </ul>
    </div>
</div>--%>

<div class="mui-content">
    <div class="mui-card">
        <input id="keyword" type="text" data-input-password="3" placeholder="输入名字或者电话号码或者角色名称">
        <ul class="mui-table-view">
            <script  type="text/html" id="zptemplate"  data-url="/UserController/h5/gl/zpList">
                {{each list as zp }}
                <li class="mui-table-view-cell mui-collapse" data-check="{{wd.isCheck}}">
                    <a class="mui-navigate-right" href="#">
                        <b>{{zp.mainName | ifNull:'未知姓名'}}</b>
                    </a>
                    <div class="mui-collapse-content">

                        <div class="mui-table-view-cell">
                            <span>职位数量：</span>
                            <span class="mui-badge mui-badge-primary">{{zp.num}}</span>
                        </div>
                        <div class="mui-table-view-cell">
                            <span>电话号码：</span>
                            <a href="tel:{{zp.personPhoneNumber}}"  class="message" style="color:#4599dd">{{zp.personPhoneNumber}}</a>
                        </div>
                        <div class="mui-table-view-cell">
                            <span>可用状态：</span>
                            <div class="status mui-switch mui-switch-blue {{zp.locked==0?'mui-active':''}}" data-user="{{zp.userID}}">
                                <div class="mui-switch-handle"></div>
                            </div>
                        </div>
                        <div class="mui-table-view-cell">
                            <span>企业VIP ：</span>
                            <div class="vip mui-switch mui-switch-blue {{zp.vip==1?'mui-active':''}}" data-user="{{zp.userID}}">
                                <div class="mui-switch-handle"></div>
                            </div>
                        </div>
                        <div class="mui-table-view-cell">
                            <span>警告提醒：</span>
                            <span class="alert mui-badge {{zp.userSig=='添加'?'mui-badge-primary':'mui-badge-danger'}}"  data-phone="{{zp.personPhoneNumber}}"  data-user="{{zp.userID}}">{{zp.userSig}}</span>
                        </div>
                        <p><button class="deletetask mui-btn mui-btn-primary mui-btn-block"  type="button"  onclick="ijob.gotoPage({url:'/UserController/h5/toLoginByID/{{zp.id}}'})">登录</button></p>
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
        /*$("#zptemplate").loadData(obj).then(function(result){

        });*/

        if(positionparam.condition.keyword){
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
    $(".mui-content").on('click','.alert',function(event){
        var _this = $(this);
        var btnArray = ['添加', '删除'];
        mui.prompt('请输入警告内容：', '某某职位，某某关键字', '警告信息', btnArray, function(e) {
            var msg = e.value;
            if (e.index ==1) {
                msg = "  ";
            }
            $.getJSON("/UserController/h5/gl/addAlert/"+msg+"/"+_this.data("user")+"/"+_this.data("phone"),function(result){
                if(result.code==200){
                    _this.text(result.data.userSig);
                    if(_this.text()=="添加"){
                        _this.addClass("mui-badge-primary").removeClass("mui-badge-danger");
                    }else{
                        _this.addClass("mui-badge-danger").removeClass("mui-badge-primary");
                    }
                }else{
                    mui.toast(result.msg);
                }

            });
        });

    });
    $(".mui-content").on('click','.vip,.status',function(event){
        var _this = $(this);
        var flag = _this.hasClass("mui-active");
        $("body").before(ijob.mask);
        var classes = _this.attr("class");
        var url = "/UserController/h5/gl/changeVIP/";
        if(classes.indexOf("status")!=-1){
            url = "/UserController/h5/gl/changeStatus/";
        }
        $.getJSON(url+_this.data("user"),function(result){
            if(result.code==200){
                if(flag==true){
                    _this.removeClass("mui-active");
                }else{
                    _this.addClass("mui-active");
                }
            }
            mui.toast(result.msg);
           $("body").prev(".loading").remove();
        });

    });

    loadDataHandler();

</script>
</html>
