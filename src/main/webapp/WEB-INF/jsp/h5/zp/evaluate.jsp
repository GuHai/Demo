<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/8
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>发表评论</title>
    <jsp:include page="../zp/base/resource.jsp"/>
    <script src="/ijob/static/js/starScore.js"></script>
    <script src="/ijob/static/js/attachment.js"></script>
</head>
<body>
<style>
    .mui-hbutton{position:fixed;bottom:0;z-index:9;}.dantu{width:2.6666666666666665rem;height:2.6666666666666665rem;position:relative;}
    ul, li, ol { list-style: none; }

    /* 重置文本格式元素 */
    a {
        text-decoration: none;
        cursor: pointer;
        color:#333333;
        font-size:0.37333333333333335rem;
    }
    a:hover {
        text-decoration: none;
    }
    .clearfix::after{
        display:block;
        content:'';
        height:0;
        overflow:hidden;
        clear:both;
    }

    /*星星样式*/
    .content{
        width:16rem;
        margin:0 auto;
        padding-top:0.533rem;
    }
    .title{
        font-size:0.373rem;
        background:#dfdfdf;
        padding:0.266rem;
        margin-bottom:0.266rem;
    }
    .block{
        width:100%;
        margin:0 0 0.533rem 0;
        padding-top:0.266rem;
        padding-left:1.333rem;
        line-height:0.56rem;
    }
    .block .star_score{
        float:left;
    }
    .star_list{
        height:0.56rem;
        margin:1.333rem;
        line-height:0.56rem;
    }
    .block p,.block .attitude{
        padding-left:0.533rem;
        line-height:0.56rem;
        display:inline-block;
    }
    .block p span{
        color:#C00;
        font-size:0.426rem;
        font-family:Georgia, "Times New Roman", Times, serif;
    }

    .star_score {
        background:url(/ijob/static/images/stark2.png);
        width:4.266rem;
        height:0.56rem;
        position:relative;
    }

    .star_score a{
        height:0.56rem;
        display:block;
        text-indent:-999em;
        position:absolute;
        left:0;
    }

    .star_score a:hover{
        background:url(/ijob/static/images/stars2.png);
        left:0;
    }

    .star_score a.clibg{
        background:url(/ijob/static/images/stars2.png);
        left:0;
    }

    #starttwo .star_score {
        background:url(/ijob/static/images/starky.png);
    }

    #starttwo .star_score a:hover{
        background:url(/ijob/static/images/starsy.png);
        left:0;
    }

    #starttwo .star_score a.clibg{
        background:url(/ijob/static/images/starsy.png);
        left:0;
    }

    /*星星样式*/

    .show_number{
        padding-left:1.333rem;
        padding-top:0.533rem;
    }

    .show_number li{
        width:6.4rem;
        border:1px solid #ccc;
        padding:0.266rem;
        margin-right:5px;
        margin-bottom:0.533rem;
    }

    .atar_Show{
        background:url(/ijob/static/images/stark2.png);
        width:4.266rem; height:0.56rem;
        position:relative;
        float:left;
    }

    .atar_Show p{
        background:url(/ijob/static/images/stars2.png);
        left:0;
        height:0.56rem;
        width:3.573rem;
    }

    .show_number li span{
        display:inline-block;
        line-height:0.56rem;
    }
</style>

<script type="text/html" id="mypositiontemplate" data-url="/UserController/h5/zp/getEvaluateUserInfo/{been.userID}">
    <div class="PostJob">
        <form name="form" action=""  method="post" id="input_example">
            <input type="hidden" name="id" >
            <input type="hidden" name="version">
            <%--<input type="hidden" name="userID" value="${userID}">
            <input type="hidden" name="positionID" value="${positionID}">
            <input type="hidden" name="state" value="false">
            <input type="hidden" value="" id="evaluateLevel" name="evaluateLevel">
            <input type="hidden" value="${beenrecruitedID}" name="beenrecruitedID">--%>
            <div class="hev">
                {{each list as user }}
                <span>{{user.realName}}</span>
                {{/each}}
            </div>
            <div class="Hcease">
                <textarea name="reply" id="textarea"  placeholder="请输入评价"></textarea>
            </div>
            <p class="Hcease-hine" ><span id="nowSize">0</span>/200</p>
            <div class="Upload">
                <label for="file" id = "result" >
                    <img  id="picture" onclick="uploadImg()" class="attachment" data-name="attachmentEvaluate" data-type="Photos"
                          style="height: 5.333rem;width: 5.333rem;margin-left: 2.667rem;" data-id=""
                          src="" alt=""
                          onerror="this.src='/ijob/static/images/a9.png';this.onerror=null">
                </label>
            </div>
            <div class="content">
                <div id="startone" class="block clearfix" >
                    <div class="star_score"></div>
                    <p style="float:left;">您的评分：<span class="fenshu">0</span> 分</p>
                    <div class="attitude"></div>
                </div>
            </div>
            <div class="mui-hbutton">
                <a href="javascript:void(0);" id="submit1" data-url="/ijob/api/EvaluateController/add">发表评论</a>
            </div>
        </form>
    </div>

</script>
<script>


    function submitMyEvaluate(){
        if($("#textarea").val() == "" || $("#textarea").val() == null){
            mui.alert("请输入评价！")
        }else if($(".fenshu").text() == null || $(".fenshu").text() == "0"){
            mui.alert("请对该员工评分!");
        }else {
            var fenshu = parseInt($(".fenshu").text()) * 2;
            $("#evaluateLevel").val(fenshu);
            $("input[name='id']").val(ijob.storage.get("been.evaluateId"));
            $("input[name='version']").val(ijob.storage.get("been.evaluateVersion"));
            /*$("input[name='beenrecruitedID']").val(ijob.storage.get("been.id"));
            $("input[name='positionID']").val(ijob.storage.get("been.positionID"));
            $("input[name='userID']").val(ijob.storage.get("been.userID"));*/
            $("#submit1").btPost($("#input_example").serializeObjectJson(),function(data){
                ijob.gotoPage({path:"/h5/zp/evaluate_no"});
            })
        }
    }

    $("#mypositiontemplate").loadData().then(function (result) {
        //result 服务器响应过来的数据
        //初始化数据
        $("input[name='id']").val(ijob.storage.get("been.evaluateId"));
        $("input[name='version']").val(ijob.storage.get("been.evaluateVersion"));
        $("input[name='userID']").val(ijob.storage.get("been.userID"));
        $("input[name='positionID']").val(ijob.storage.get("been.positionID"));
        $("input[name='beenrecruitedID']").val(ijob.storage.get("been.id"));


        scoreFun($("#startone"))
        scoreFun($("#starttwo"),{
            fen_d:22,//每一个a的宽度
            ScoreGrade:5//a的个数5
        });
        //显示分数
        $(".show_number li p").each(function(index, element) {
            var num=$(this).attr("tip");
            var www=num*2*16;//
            $(this).css("width",www);
            $(this).parent(".atar_Show").siblings("span").text(num+"分");
        });
        $("#documentImg").on("uploadStart",function(){
            $("#save").attr("disabled","disabled");
        });
        $("#documentImg").on("uploadCompletion",function(){
            $("#save").removeAttr("disabled");
        });
        $("#picture").attachment();


        //显示输入文本数量
        var len = 0;
        $(document).on("input propertychange", '#textarea', function () {
            len = $("#textarea").val().length;
            $("#nowSize").text(len);
            if (len > 200) {
                $(".mui-hbutton").css({"background-color":"#999"});
            }else{
                $(".mui-hbutton").css({"background-color":""});
            }
        });
        $(document).on("click", '#submit1', function () {
            if ($("#textarea").val().length <= 200) {
                    submitMyEvaluate();
            }else{
                mui.toast("内容过多,修改失败！");
            }
        });
    });
</script>
</body>
</html>
