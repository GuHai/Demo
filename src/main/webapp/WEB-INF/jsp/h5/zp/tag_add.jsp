<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/8
  Time: 17:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加标签</title>
    <jsp:include page="../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/mine/postjob.css">
</head>
<body>
    <div class="tag_content_list">
        <div class="post-sort">
            <h3>性别要求</h3>
            <ul class="chooselist genderlist">
                <li data-value="1">仅限男性</li>
                <li data-value="3">仅限女性</li>
                <li data-value="2">不限性别</li>
            </ul>
        </div>
        <div class="post-sort">
            <h3>结算方式</h3>
            <ul class="chooselist accounts">
                <li data-value="1">日结</li>
                <li data-value="2">周结</li>
                <li data-value="3">月结</li>
                <li data-value="4">完工结算</li>
            </ul>
        </div>
        <div class="post-sort">
            <h3>其它标签</h3>
            <ul class="chooselist otherlist">
                <li><span>需要培训</span></li>
                <li><span>需要面试</span></li>
                <li><span>底薪任务</span></li>
                <li><span>绩效提成</span></li>
                <li><span>管住</span></li>
            </ul>
        </div>
        <div class="post-sort">
            <h3>自定义标签</h3>
            <ul class="chooselist customlist">
                <li id="btn1" class="btn1">添加标签</li>
            </ul>
        </div>
        <footer class="nav_footer">
            <a href="javascript:void(0);" class="resetting" id="resetting" data-url="/ijob/api/PositionController/setToSession">重置</a>
            <a href="javascript:void(0);" class="confirm" id="confirm" data-url="/ijob/api/PositionController/setToSession">确认</a>
        </footer>
    </div>
</body>
<script src="/ijob/static/js/index/add_tag.js"></script>
<script>
    var positionObj = ijob.storage.get("positionObj");
    var tagList = ijob.storage.get("labelList");
    if (tagList == null){
        tagList = new Array();
    }
    var tagName = "";
    $(function () {
        var liTagList = $("li");
        for(var i = 0 ;i < liTagList.length ; i++){
            for(var j = 0 ; j < tagList.length; j++){
                if (tagList[j].name == $(liTagList[i]).text() && tagList[j].type == false ){
                    $(liTagList[i]).addClass("active");
                }
                if (i == 0){
                    if(tagList[j].type == true){
                        var liTag = "<li>"+tagList[j].name+"</li>" ;
                        $(".customlist").prepend(liTag);
                    }
                }
            }
        }
        var del =  '<span class="iconfont icon-shanchu2 del"></span>';
        var tipcon ='<input type="text" class="tagcontent" placeholder="请输入标签内容" name="tag">' ;
        $('#btn1').click(function () {
            $(this).before("<li>"+tipcon+"</li>");
        });

        $(".customlist").on("blur",'input',function (){
            var title = $(this).val();
            $(this).parent().html(title).css({"color":"#108ee9","border":"1px solid #108ee9"});
            var tag = {
                type:true,
                name: title
            }
            tagList.push(tag);
            if (title == null || title ==""){
                var lis = $(".customlist li");
                for (var i = 0 ;i < lis.length ; i++){
                    if(lis[i].innerText == ""){
                        $(lis[i]).remove()
                        var tag = {
                            type : true,
                            name : ''
                        }
                        removeTag(tag);
                    }
                }
            }
        });
        $(".customlist").on("click",'li',function(i,item){
            if($(this).find("input").length==0 &&  $(this).text()!= "添加标签"){
                var width = $(this).width();
                var title = $(this).text();
                tagName = title;
                $(this).html(tipcon+del);
                $(this).find("input").val(title).css("width",width+120);
            }

        });

        $(".customlist").on('click','input',function(){
            $(this).next().remove();
        })


        $(".customlist").on('click','span',function(){
            $(this).parent().remove();
            var tag = {
                type : true,
                name : tagName
            }
            removeTag(tag);
        })
    });

    $("#confirm").click(function(){
        if (tagList.length == 0){
            tagList = null;
        }
        ijob.storage.set("labelList",tagList);
        positionObj.jobContent = ijob.storage.get("jobContent");
        positionObj.labelList = tagList;
        $(this).btPost(JSON.stringify(positionObj),function (data) {
            if(data.code == 200){
                if(ijob.storage.get("isTemp")){
                    if (ijob.storage.get("id") == "" || ijob.storage.get("id") == null || ijob.storage.get("id") == undefined ){
                        ijob.gotoPage({path:'/h5/zp/location_tem?positionTemp.id=0'});
                    }else{
                        ijob.gotoPage({path:'/h5/zp/location_tem?positionTemp.id='+ijob.storage.get("id")});
                    }
                    ijob.storage.set("isTemp",null);
                }else{
                    if (ijob.storage.get("id") == "" || ijob.storage.get("id") == null || ijob.storage.get("id") == undefined ){
                        ijob.gotoPage({path:'/h5/zp/postJob2?positionTemp.id=0'});
                    }else{
                        ijob.gotoPage({path:'/h5/zp/postJob2?positionTemp.id='+ijob.storage.get("id")});
                    }
                }
            }
        })
    })


</script>
</html>
