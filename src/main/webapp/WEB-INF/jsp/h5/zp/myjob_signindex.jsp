<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/6/6
  Time: 10:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>签到</title>
    <jsp:include page="../zp/base/resource.jsp"/>
    <style>
        .mui-checkbox, .mui-radio { float: left;width: 0.800rem; height: 0.800rem;margin-top: 0.400rem;}
        .mui-input-row label ~ input, .mui-input-row label ~ select, .mui-input-row label ~ textarea {padding-left: 2px;}
        .JobV {padding-top: 5px;}
        .evLb-man .evLb-mT {padding: 0;}
        .Dman-site {padding: 0;}
        .hev-bise .hev-Br > a {width: 1.333rem;}
        .hev-bise .hev-Br > a.hev-BrSTwo { border: 1px solid #108ee9; color: #108ee9;}
        .JobV > a {height: 1.333rem;}
        .JobV > a > p {margin: 0;color: #666;line-height: 0.560rem;}
        input, select, textarea {font-size: 0.400rem;}
        .classify {position: fixed;z-index: 9;top: 0px;}
        .JobV {position: fixed;z-index: 9;top: 1.08rem;}
        .mui-checkbox.mui-left input[type=checkbox], .mui-radio.mui-left input[type=radio] {left: -3px;}
        .mui-input-row label {line-height: 0px;}
        .evLboxTwo .evLb-man{width: 91%}
    </style>
</head>
<body>
<div class="classify">
    <div class="rx-dateDa">
        <i class="iconfont icon-shizhong"></i>
        <input id="Dtime" style="color:#108ee9;text-align:center;font-size:0.400rem;border:0;background: #fff;line-height: 2.8;"
               data-options='{"type":"date","beginYear":1956,"endYear":2025}' value="1990-10-10" disabled/>
    </div>
</div>
<div id="tabpanel">
    <div>
        <script type="text/html" id="signIndex" data-url="/ijob/api/SigninController/zp/getSigninInfoCount" data-type="POST">
            {{each list as signinAndCount}}
            <div class="JobV JobVtwo" >
                <a href="javascript:void(0);" data-path="/h5/zp/myjob_sign4?id={data.id}" data-index="0"  class="mytap">
                    <p>{{signinAndCount.countMap.noSigninCount}}</p>
                    <p>未签到</p>
                </a>
                <a href="javascript:void(0);"  data-path="/h5/zp/myjob_sign3?id={data.id}"  data-index="1" class="mytap">
                    <p>{{signinAndCount.countMap.signinCountSum}}</p>
                    <p>待确认</p>
                </a>
                <%--<a href="javascript:void(0);"  data-path="/h5/zp/myjob_sign2?id={data.id}"   data-index="2"   class="">
                    <p>{{signinAndCount.countMap.sureCount}}</p>
                    <p>待结束</p>
                </a>--%>
            </div>
            {{/each}}
        </script>
    </div>
    <div id="panel">

    </div>
    <div id="homepage"></div>
</div>

</body>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});

    var  menu = ijob.menu.get("myjob");
    $("#tabpanel").on('click','.mytap',function(){
        $("#tabpanel a").removeClass("JobVon");
        $(this).addClass("JobVon");
        $('#panel').loadPage({path:$(this).data("path")});
        menu = "myjob:1:"+$(this).data("index");
        ijob.menu.set(menu);
    });

    function  clickHandler(){
        console.log(menu);
        if(menu.indexOf(":")!=-1 && menu.split(":").length==3){
            $("#tabpanel a").eq(menu.split(":")[2]).click();
        }else{
            $("#tabpanel a").eq(0).click();
        }

    }

    //全选
    $("#panel").on("change", '.checkbox1',function () {
        $("input[name='checkbox']").prop('checked',$(this).prop('checked'));
    })


    var config = {condition:{
            positionID:ijob.storage.get("position.id")
        }};
    Date.prototype.format = function(fmt) {
        var o = {
            "M+" : this.getMonth()+1,                 //月份
            "d+" : this.getDate(),                    //日
            "h+" : this.getHours(),                   //小时
            "m+" : this.getMinutes(),                 //分
            "s+" : this.getSeconds(),                 //秒
            "q+" : Math.floor((this.getMonth()+3)/3), //季度
            "S"  : this.getMilliseconds()             //毫秒
        };
        if(/(y+)/.test(fmt)) {
            fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
        }
        for(var k in o) {
            if(new RegExp("("+ k +")").test(fmt)){
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
            }
        }
        return fmt;
    }

    $("#signIndex").loadData(config).then(function(result){
        console.log(result);
        var date = new Date().format("yyyy-MM-dd");
        $("#Dtime").val(date);
        clickHandler();
    });
</script>
</html>
