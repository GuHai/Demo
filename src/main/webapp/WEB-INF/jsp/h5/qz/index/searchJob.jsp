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
    <title>搜索职位</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/index/SearchJob.css">
</head>
<body>
<div class="wrap">
    <header class="head">
        <div class="head-lf mui-input-row">
            <i class="mui-icon mui-icon-search"></i>
            <input type="text" id="position" class=" mui-input-clear" placeholder="搜索职位/公司/工作号" maxlength="10">
        </div>
        <div class="head-rt"  id="searchBnt">
            <div class="btn">搜索</div>
        </div>
    </header>
    <main class="main">
        <div class="main-his">
            <h2>历史搜索</h2>
            <div class="history">
                <ul id="history">

                </ul>
            </div>
        </div>
        <div class="main-pop">
            <h2>热门搜索</h2>
            <div class="popular">
                <ul id="hot">
                </ul>
            </div>
        </div>
    </main>
</div>
<jsp:include page="../../qz/base/resource.jsp"/>
<script type="textml" id="template">
    {{each data as search}}
        <li>{{search.keyword}}</li>
    {{/each}}
</script>
<script type="text/javascript">

    function init() {

        $.ajax({
            url: "/ijob/api/SearchlogController/findList",
            contentType: 'application/json',
            type: 'POST',
            data:JSON.stringify({}),
            dataType: 'json',
            success: function(data) {
                if(data&&data.length>0){
                    var html = template("template", data);
                }else{
                    $("#history").closest(".main-his").remove();
                }
            }
        })

        $.ajax({
            url: "/ijob/api/SearchlogController/findHotList",
            contentType: 'application/json',
            type: 'POST',
            dataType: 'json',
            success: function(data) {
                var html = template("template", data);
                $("#hot").html(html);
            }
        })
    }

   /* $.fn.extend({
        isNull:function(str){
            var reg = /^\s*$/g;
            if(str=="" || reg.test(str)){
                return true;
            }
            return false;
        },
        isNotNull:function(){
            return isNull(str);
        }
    });
*/

    $(".main").on('click','li',function (event) {
        $("#position").val($(this).text());
        $("#searchBnt").trigger("click");
    });

    $("#searchBnt").on('click',function(event){
        if(ijob.isNotNull($("#position").val())){
            window.location.href = "/ijob/api/SearchlogController/result?search="+$("#position").val();
        }else{
            mui.toast("搜索内容不能为空");
        }
    });

    init();

</script>
</body>
</html>
