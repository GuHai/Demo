<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/7/29
  Time: 9:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>提现列表</title>
    <link rel="stylesheet" href="/ijob/lib/mui/css/mui.min.css">
    <jsp:include page="../qz/base/resource.jsp"/>
    <style>
        .deletetask{
            font-size: 12px;
            padding: 10px 0;
        }
        .detail{
            font-size: 12px;
            padding: 10px 0;
        }
        .txadmin{
            font-size: 12px;
            padding: 10px 0;
        }
    </style>

</head>
<body>
<div class="mui-content">
    <div class="mui-card">
        <ul class="mui-table-view">
            <script  type="text/html" id="zptemplate"  data-url="/ijob/api/AccountController/h5/gl/withdrawlist">
                {{each list as wd }}
                    <li class="mui-table-view-cell mui-collapse" data-check="{{wd.isCheck==true?1:0}}">
                        <a class="mui-navigate-right" href="#">
                            <b>{{wd.name | ifNull:'未知姓名'}}</b>
                            <span style="position:absolute;left: 100px;color:#119824">+{{wd.ina}}</span>
                            <span style="position:absolute;left: 190px;color:#2a3cff">-{{wd.outa}}</span>
                            {{if wd.isCheck==true}}
                            <span style="position:absolute;left: 280px;">{{wd.money}}</span>
                            {{else}}
                            <span style="font-weight:bold;position:absolute;left: 280px;color:#E92216">{{wd.money}}</span>
                            {{/if}}
                        </a>
                        <%--<div class="mui-collapse-content">
                            <p class="msg" style="color:#E92216 ">{{wd.errmsg}}</p>
                            <button class="deletetask mui-btn mui-btn-primary"  type="button" data-url="/ijob/api/AccountController/h5/gl/deleteTxTask/{{wd.id}}" onclick="return false;">拒绝</button>
                        </div>--%>
                        <div class="mui-collapse-content">
                            <p class="msg" style="color:#E92216 ;font-size: 12px;padding: 10px 0;">{{wd.errmsg}}</p>
                            <p><button class="deletetask mui-btn mui-btn-primary mui-btn-block" data-userid="{{wd.userID}}"  type="button"  data-url="/ijob/api/AccountController/h5/gl/deleteTxTask/{{wd.id}}" onclick="return false;">拒绝</button></p>
                            <button  class="detail  mui-btn mui-btn-primary mui-btn-block"  data-url="/ijob/api/AccountController/findPageById/{{wd.id}}"  data-id="{{wd.id}}" >查看收支详情</button>
                            <button  class="txadmin  mui-btn mui-btn-primary mui-btn-block"  data-url="/ijob/api/AccountController/h5/gl/ratificationOne"   data-id="{{wd.id}}" >提现</button>
                            <ul class="mui-table-view">

                            </ul>
                        </div>
                    </li>
                {{/each}}
            </script>
        </ul>
        <div class="mui-input-row mui-password" style="margin-top: 20px;">
            <input id="pw" type="password" class="mui-input-password" data-input-password="3" placeholder="请输入密码"><span class="mui-icon mui-icon-eye"></span>
        </div>
        <button type="button" id="txBtn" class="mui-btn mui-btn-primary mui-btn-block" onclick="return false;"  data-url="/ijob/api/AccountController/h5/gl/ratificationList">提现</button>
        <button type="button" id="refreshBtn" class="mui-btn mui-btn-primary mui-btn-block" onclick="return false;"  data-url="/ijob/api/AccountController/h5/gl/refresh">刷新</button>

    </div>
</div>
</body>
<script>

    function showList(){
        $("#zptemplate").loadData().then(function(result){
            if(result.code!=200){
                mui.alert(result.msg);
            }else{
                var total = 0;
                $.each(result.data.list,function(i,item){
                    total += item.money;
                });
                $("#txBtn").text("提现总金额："+Math.ceil(total*100)/100+"元");
                //详情
                $(".detail").on('click',function(){
                    var _this = $(this);
                    _this.next().empty();
                    var temp = " <li class=\"mui-table-view-cell\">$(title)<span class=\"mui-badge $(status)\">$(money)</span></li>";
                    _this.btPost({},function(result2){
                        $.each(result2.data.list,function(i,item){
                            var str = temp.replace("$(title)",template.enums(item.btype,'AccountType')).replace("$(status)",item.isin==0?(item.btype=='9'?'mui-badge-primary':''):(item.isin==-1?'mui-badge-primary':'mui-badge-success')).replace("$(money)",((item.isin==0?(item.btype=='9'?'-':''):(item.isin==-1?'-':'+'))+item.money));
                            _this.next().append(str);
                        });
                    });
                });
                //删除
                $(".deletetask").on('click',function(){
                    var _this = $(this);
                    var btnArray = ['取消', '拒绝'];
                    mui.prompt('请输入拒绝内容：', '', '拒绝信息', btnArray, function(e) {
                        var msg = e.value;
                        if (e.index == 1) {
                            _this.btPost({msg:msg,userID:_this.data("userid")},function(data){
                                mui.toast(data.msg);
                            })
                        }
                    });

                });

                $("#refreshBtn").click(function(){
                    var _this = $(this);
                    _this.btPost({},function(data){
                        mui.alert(data.msg);
                        if(data.code==200){
                            location.reload();
                        }
                    });
                });

                $("#txBtn").click(function(){
                    var _this = $(this);
                    var isok = true;
                    $("ul li").each(function(i,item) {
                        if($(item).data("check")==0){
                            isok  = false;
                            return false;
                        }
                    });


                    if(isok==false){
                        var btnArray = ['是', '否'];
                        mui.confirm('还有数据异常的提现申请，是否提现所有？', null, btnArray, function(e) {
                            if (e.index == 0) {//点击是
                                tx();
                            }
                        });
                    }else{
                        tx();
                    }

                    function tx(){
                        if($("#pw").val()){
                            _this.btPost({password:$("#pw").val()},function(data){
                                mui.alert(data.msg);
                                if(data.code==200){
                                    location.reload();
                                }
                            });
                        }else{
                            mui.alert("请输入提现密码");
                        }
                    }
                });

                $(".txadmin").click(function () {
                    var _this = $(this);
                    if($("#pw").val()){
                        _this.btPost({password:$("#pw").val(),id:_this.data("id")},function(data){
                            mui.alert(data.msg);
                            if(data.code==200){
                                location.reload();
                            }
                        });
                    }else{
                        mui.alert("请输入提现密码");
                    }
                });
            }
        });
    }

    showList();

</script>
</html>
