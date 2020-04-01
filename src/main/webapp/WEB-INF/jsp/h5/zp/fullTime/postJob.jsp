<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/11
  Time: 16:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>发布职位</title>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/fullTime/fullTime.css?version=4">
</head>
<body>
<div class="wrap">
    <div class="post-full-job">
        <script id="postJob" type="text/html" data-url="/ijob/api/FullTimeController/postJobInfo/{full.id}">
            {{each list as map }}
                <form id="form">
                    <input type="hidden" name="id" value="{{map.post.id}}">
                    <input type="hidden" name="version" value="{{map.post.version}}">
                    <input type="hidden" name="postType" id="postType" value="{{map.post.postType}}">
                    <%-- hd-main --%>
                    <div class="hd-main">
                        <div class="mui-input-row">
                            <div class="list">
                                <div class="txt">职位名称</div>
                                <div class="input">
                                    <input type="text" name="title" class="posiname inputbox" value="{{map.post.title}}" placeholder="请输入职位名称"/>
                                </div>
                            </div>
                        </div>
                        <div class="mui-input-row">
                            <div class="list">
                                <div class="txt">月薪资</div>
                                <div class="interval salarybox">
                                    <div class="section">
                                        <input type="number" name="minSalary" class="boxinput salary" oninput="if(value.length>7)value=value.slice(0,7)" value="{{map.post.minSalary |ifNull:''}}" id="min" placeholder="最低"/>
                                        <span class="line"></span>
                                        <input type="number" name="maxSalary" class="boxinput salary" oninput="if(value.length>7)value=value.slice(0,7)" value="{{map.post.maxSalary |ifNull:''}}" id="max" placeholder="最高"/>
                                    </div>
                                </div>
                                <div class="mui-checkbox facebox">
                                    {{if map.post.maxSalary==map.post.minSalary && map.post.minSalary == 0}}
                                        <label><input type="checkbox" name="checkbox" checked="checked" class="checkbox"/> 面议</label>
                                    {{else}}
                                        <label><input type="checkbox" name="checkbox" class="checkbox"/> 面议</label>
                                    {{/if}}
                                </div>
                            </div>
                        </div>
                        <div class="mui-input-row">
                            <div class="list">
                                <div class="txt">招聘人数</div>
                                <div class="input">
                                    <input type="number" name="recruits"  class="inputbox" placeholder="请输入招聘人数" value="{{map.post.recruits |ifNull:'1'}}"/>
                                </div>
                            </div>
                        </div>
                        <div class="mui-input-row">
                            <div class="list">
                                <div class="txt">年龄区间</div>
                                <div class="interval agebox">
                                    <div class="section">
                                        <input type="number" name="minAge" class="boxinput age" oninput="if(value.length>2)value=value.slice(0,2)" id="minAge" placeholder="18" value="{{map.post.minAge |ifNull:'18'}}"/>
                                        <span class="line"></span>
                                        <input type="number" name="maxAge" class="boxinput age" id="maxAge" oninput="if(value.length>2)value=value.slice(0,2)" placeholder="55" value="{{map.post.maxAge |ifNull:'55'}}"/>
                                    </div>
                                    <div class="unit">岁</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--hd-main end--%>


                    <%--添加标签--%>
                    <div class="tag-list-box">
                        <div class="tag-btns">
                            <span class="txt">添加标签</span>
                            <span class="right selectTag">选择标签，如包吃包住、长白班等<span class="iconfont icon-arrow-right"></span></span>
                        </div>
                        <%--如果选择标签，则显示--%>
                        <div class="tag-content"  style="display: none;">
                            {{if map.post.postLabelList!=null}}
                                {{each map.post.postLabelList as label}}
                                <span>{{label.name}}</span>
                                {{/each}}
                            {{/if}}
                        </div>
                    </div>
                    <%-- 添加标签 end --%>
                    <%--选择标签--%>
                    <div class="tag_content_list" style="display: none">
                        <div class="taglist">
                            <div class="post-sort">
                                <h3>性别要求</h3>
                                <ul class="chooselist genderlist workList">
                                    {{each list[0].labels as label}}
                                        {{if label.type == 3}}
                                            <li data-value="{{label.code}}">{{label.name}}</li>
                                        {{/if}}
                                    {{/each}}
                                </ul>
                            </div>
                            <div class="post-sort">
                                <h3>职位性质</h3>
                                <ul class="chooselist naturelist workList">
                                    {{each list[0].labels as label}}
                                    {{if label.type == 4}}
                                    <li data-value="{{label.code}}"><span>{{label.name}}</span></li>
                                    {{/if}}
                                    {{/each}}
                                </ul>
                            </div>
                            <div class="post-sort">
                                <h3>工作要求</h3>
                                <ul class="chooselist requirelist workList">
                                    {{each list[0].labels as label}}
                                    {{if label.type == 2}}
                                    <li data-value="{{label.code}}"><span>{{label.name}}</span></li>
                                    {{/if}}
                                    {{/each}}
                                </ul>
                            </div>
                            <div class="post-sort">
                                <h3>福利待遇</h3>
                                <ul class="chooselist welfarelist">
                                    {{each list[0].labels as label}}
                                    {{if label.type == 1}}
                                    <li data-value="{{label.code}}"><span>{{label.name}}</span></li>
                                    {{/if}}
                                    {{/each}}
                                </ul>
                            </div>
                            <div class="post-sort">
                                <h3>自定义标签</h3>
                                <ul class="chooselist customlist">
                                    {{each list[0].labels as label}}
                                    {{if label.type == 5}}
                                    <li data-value="{{label.code}}"><span>{{label.name}}</span></li>
                                    {{/if}}
                                    {{/each}}
                                    <li id="btn1" class="btn1">添加标签</li>
                                </ul>
                            </div>
                            <div class="clearfix" style="content:'';height: 2rem;width: 100%;clear: both;overflow: hidden;"></div>
                            <footer class="nav_footer">
                                <a href="javascript:void(0);" class="resetting" id="resetting">重置</a>
                                <a href="javascript:void(0);" class="confirm" id="confirm">确认</a>
                            </footer>
                        </div>
                    </div>
                    <%--选择标签 end--%>

                    <%--填写职位描述--%>
                    <div class="details-main">
                        <div class="txt">填写职位描述</div>
                        <div class="row-content">
                            <textarea class="textarea" name="descript" id="textarea" ></textarea>
                        </div>
                    </div>
                    <%-- 填写职位描述 end--%>

                    <%--bottom-box--%>
                    <div class="bottom-box">
                        <div class="mui-input-row">
                            <div class="list">
                                <div class="txt">联系人</div>
                                <div class="input">
                                    <input type="text" name="contacts" class="Contacts inputbox" placeholder="请输入姓名" value="{{map.post.contacts}}"/>
                                </div>
                            </div>
                        </div>
                        <div class="mui-input-row">
                            <div class="list">
                                <div class="txt">联系电话</div>
                                <div class="input">
                                    <input type="text" name="phone" class="tel inputbox" id="contactNumber" placeholder="请输入手机号" value="{{map.post.phone}}"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix" style="clear: both;content: '';height: 1.7rem;overflow: hidden"></div>
                    <%--bottom-box end--%>
                    <div class="postjob">
                        <a href="javascript:void(0);" class="postbtns">下一步</a>
                    </div>
                </form>
            {{/each}}
        </script>
    </div>
</div>
</body>
</html>
<script src="/ijob/static/js/fulltime/add_tag.js"></script>
<script>
    $("#postJob").loadData().then(function(result){
        if(ijob.storage.get("full.id")=="0"){
            $("#postType").val(ijob.storage.get("full.type"));
        }
        if(result.data.list[0].post.descript!=null&&result.data.list[0].post.descript!=""&&result.data.list[0].post.descript!=undefined){
            $("#textarea").val(result.data.list[0].post.descript);
        }
        if(result.data.list[0].post.postLabelList!=null){
            $(".tag-content").show();
            $(".taglist li").each(function(){
                for(var i = 0 ;i<result.data.list[0].post.postLabelList.length; i++){
                    if($(this).data("value")==result.data.list[0].post.postLabelList[i].code){
                        $(this).addClass("active");
                    }
                }
            });
            /*控制宽度*/
            $(".tag-list-box .tag-content span").each(function () {
                if ($(this).text().length >= 3){
                    $(this).css("width","1.653rem");
                }
            });
        }
        var slide = null;
        //年龄限制
        $("#minAge").blur(function(){
            if(isNaN(parseFloat($("#minAge").val()))){
                $(this).val(18);
            }
        });
        $("#maxAge").blur(function(){
            if(isNaN(parseFloat($("#maxAge").val()))){
                $(this).val(55);
            }
        });
        //是否面议
        $(".salary").click(function(){
            $(".checkbox").prop("checked",false);
        });

        //下一步按钮点击事件、
        $(".postbtns").click(function () {
            var fuli = "",other = "", work = "";
            var i = 0 ,j=0,k=0;
            $(".customlist li").each(function(){
                if($(this).hasClass('active')){
                    if(i==0){
                        console.log($(this).data("value"));
                        other+=$(this).data("value");
                    }else{
                        console.log($(this).data("value"));
                        other+=","+$(this).data("value");
                    }
                    i++;
                }
            });
            $(".welfarelist li").each(function(){
                if($(this).hasClass('active')){
                    if(j==0){
                        fuli+=$(this).data("value");
                    }else{
                        fuli+=","+$(this).data("value");
                    }
                    j++;
                }
            });
            $(".workList li").each(function(){
                if($(this).hasClass('active')){
                    if(k==0){
                        work+=$(this).data("value");
                    }else{
                        work+=","+$(this).data("value");
                    }
                    k++;
                }
            });
            var phoneReg = /^[1][3,4,5,6,7,8,9][0-9]{9}$/;
            if ((isNaN(parseFloat($("#min").val()))||isNaN(parseFloat($("#max").val()))) && $(".checkbox").prop("checked") == false){
                if (isNaN(parseFloat($("#min").val()))){
                    mui.alert("请填写最低月薪资");
                }else if (isNaN(parseFloat($("#max").val()))){
                    mui.alert("请填写最高月薪资");
                }
                return;
            }else{
                if(parseFloat($("#max").val())<parseFloat($("#min").val())){
                    var temp = $("#max").val();
                    $("#max").val($("#min").val());
                    $("#min").val(temp);
                }
                if(parseFloat($("#min").val())*2<parseFloat($("#max").val())){
                    mui.alert("最高工资不能大于最低工资的两倍");
                    return ;
                }
            }
            if ((isNaN(parseFloat($("#minAge").val()))||isNaN(parseFloat($("#maxAge").val())))){
                if (isNaN(parseFloat($("#minAge").val()))){
                    mui.alert("请填写最低年龄");
                }else if (isNaN(parseFloat($("#maxAge").val()))){
                    mui.alert("请填写最高年龄");
                }
                return ;
            }else{
                if(parseFloat($("#maxAge").val())<parseFloat($("#minAge").val())){
                    var temp = $("#maxAge").val();
                    $("#maxAge").val($("#minAge").val());
                    $("#minAge").val(temp);
                }
            }
            if ($(".posiname").val() == null ||$(".posiname").val() ==""){
                mui.alert("请输入职位名称");
            }else if($(".posiname").val().length >12){
                mui.alert("职位名称不能超过12个字");
            }else if ($(".Contacts").val() == null ||$(".Contacts").val() ==""){
                mui.alert("请输入姓名");
            }else if ($("#contactNumber").val() == null ||$("#contactNumber").val() ==""){
                mui.alert("请输入手机号码");
            }else if(!phoneReg.test($("#contactNumber").val())){
                mui.alert('手机号码格式错误！');
            }else if($('#contactNumber').val().length != 11){
                mui.alert('手机号码不能小于或大于11位数！');
            }else {
                if($(".checkbox").prop("checked")){
                    $("#max").val(0);
                    $("#min").val(0);
                }
                if($("#textarea").val().indexOf("请输入工作要求")==0){
                    $("#textarea").html("");
                }
                if($("#textarea").val().length>600){
                    mui.toast("字数在600字以内，你已超出"+($("#textarea").val().length-600)+"字");
                    return ;
                }
                var full = $("#form").serializeObjectJson();
                full.postType = ijob.storage.get("full.type");
                full.otherLabel = other;
                full.workLabel = work ;
                full.benefitsLabel = fuli ;
                if(ijob.storage.get("full.id")!="0"){
                    full.company = result.data.list[0].post.company ;
                    full.workPlace = result.data.list[0].post.workPlace ;
                }
                ijob.storage.set("full",full);
                ijob.gotoPage({path:'/h5/zp/fullTime/fullInform'});
            }
        });

        // 职位描述
        $("#textarea").each(function() {
            $(this).focus(function() {
                //获得焦点时，如果值为默认值，则设置为空
                if ($("#textarea").val().indexOf("请输入工作要求")==0) {
                    this.value = "";
                }
            });
            $(this).blur(function() {
                //失去焦点时，如果值为空，则设置为默认值
                if (this.value == "") {
                    var placeholder = '请输入工作要求、工作内容、注意事项等，建议使用短句并分条列出，如下：\n岗位职责\n1、负责在规定时间内完成货物的装卸搬运工作。 \n2、负责对获取破损货物进行修复，降低货物破损率 \n 3、...\n面试安排 \n1、周一至周五，上午十点至十一点，下午三点至四点面试\n2、面试时必须携带身份证原件\n 3、...';
                    this.value = placeholder;
                    var content=this.value.replace(/\n/g,"<br/>");
                }
            });
        });

        testabc();



        /*选择标签*/
        $(".tag-list-box").click(function () {
            $(".tag_content_list").show();
            slide = new Slide($(".wrap"),$(".tag_content_list"),".taglist");
            slide.disTouch();
        });

        $(".confirm").click(function () {
            $(".tag-content").html("");
            $(".tag_content_list li").each(function(){
                if($(this).hasClass("active")){
                    $(this).data("value");
                    $(".tag-content").append("<span>"+$(this).text()+"</span>");
                }
            });
            if($(".tag-content span").length==0){
                $(".tag-content").hide();
                $(".tag-btns").show();
            }else{
                $(".tag-content").show();
                /*控制宽度*/
                $(".tag-list-box .tag-content span").each(function () {
                    if ($(this).text().length >= 3){
                        $(this).css("width","1.653rem");
                    }
                });
            }
            $(".tag_content_list").hide();
            slide.ableTouch();
        })
        /*添加其他标签*/
        var del =  '<span class="iconfont icon-shanchu2 del"></span>';
        var tipcon ='<input type="text" class="tagcontent" placeholder="请输入标签内容" name="tag">' ;
        $('#btn1').click(function () {
            $(this).before("<li>"+tipcon+"</li>");
        });

        /*$(".customlist").on('click','span',function(){
            $(this).parent().remove();
        });*/
        $(".customlist").on("blur",'input',function (){

            var title = $(this).val();
            var _this = $(this).parent() ;
            if(title.length>5){
                mui.alert("自定义标签不能超过五个字");
                _this.remove();
                return ;
            }
            $(this).parent().html(title).addClass("active");
            var tag = {
                type:5,
                name: title
            }

            $.ajax({
                url:"/ijob/api/FullTimeController/addPostLabel",
                type:'POST',
                contentType: 'application/json; charset=UTF-8',
                async:false,
                dataType:'json',
                data:JSON.stringify(tag),
                success: function (response) {
                    _this.data("value",response.data.list[0].code);
                    if (title == null || title ==""){
                        var lis = $(".customlist li");
                        for (var i = 0 ;i < lis.length ; i++){
                            if(lis[i].innerText == ""){
                                $(lis[i]).remove();
                            }
                        }
                    }
                }
            })
        });
        $(".customlist").on("click",'li',function(i,item){
            if($(this).find("input").length==0 &&  $(this).text()!= "添加标签"){
                var width = $(this).width();
                var title = $(this).text();
                tagName = title;
                $(this).html(tipcon+del);
                $(".del").click(function(){
                    var li = $(this).parent();
                    /*$(this).parent().remove();*/
                    console.log($(this).parent());
                    $.getJSON("/ijob/api/FullTimeController/deleteUsersLabel/"+li.data("value"),function(result){
                        if(result.code == 200){
                            li.remove();
                        }else {
                            mui.toast("你暂时没有权限删除该标签...")
                        }
                    });
                })
                $(this).find("input").val(title).css("width",width+120);
            }

        });

        $(".customlist").on('click','input',function(){
            $(this).next().remove();
        })
    });

    function testabc(){
        var placeholder = '请输入工作要求、工作内容、注意事项等，建议使用短句并分条列出，如下：\n岗位职责\n1、负责在规定时间内完成货物的装卸搬运工作。 \n2、负责对获取破损货物进行修复，降低货物破损率 \n 3、...\n面试安排 \n1、周一至周五，上午十点至十一点，下午三点至四点面试\n2、面试时必须携带身份证原件\n 3、...';
        $("#textarea").html(placeholder);
        var content=$("#textarea").val().replace(/\n/g,"<br/>");
    }


</script>