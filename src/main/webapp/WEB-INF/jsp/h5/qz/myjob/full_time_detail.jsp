<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/31
  Time: 18:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.yskj.utils.DateUtils,com.yskj.utils.IJobUtils" %>
<html>
<head>
    <title>职位详情</title>
    <jsp:include page="../../qz/base/link.jsp"/>
    <jsp:include page="../../qz/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/My_part-time/my_full_time_job.css?version=4">

</head>
<body>
<div class="wrap">
    <div class="full-time-detail">
        <script id="fullJobInfo" type="text/html" data-url="/ijob/api/FullTimeController/fullJobInfo/{full.id}">
            {{each list as post}}
            <div class="hd-list-box">
                <div class="title">
                    <span class="txt">{{post.title}}</span>
                    <span class="num">招聘人数：{{post.recruits}}人</span>
                </div>
                <div class="money">
                    {{if post.minSalary==post.maxSalary&& post.maxSalary==0}}
                    面议
                    {{else}}
                    {{post.minSalary}}-{{post.maxSalary}}元/月
                    {{/if}}
                </div>
                {{if post.benefitsLabel != null&&post.benefitsLabel != ""}}
                <div class="treatment taglist">
                    <h3>福利待遇</h3>
                    <div class="list">
                        {{each post.postLabelList as label}}
                            {{if label.type==1}}
                            <span>{{label.name}}</span>
                            {{/if}}
                        {{/each}}
                    </div>
                </div>
                {{/if}}
                {{if post.workLabel != null&&post.workLabel != ""}}
                <div class="work taglist">
                    <h3>工作标签</h3>
                    <div class="list">
                        <span>{{post.minAge}}-{{post.maxAge}}岁</span>
                        {{each post.postLabelList as label}}
                            {{if label.type<5 && label.type> 1}}
                            <span>{{label.name}}</span>
                            {{/if}}
                        {{/each}}
                    </div>
                </div>
                {{/if}}
                {{if post.otherLabel != null&&post.otherLabel != ""}}
                <div class="other taglist">
                    <h3>其它标签</h3>
                    <div class="list">
                        {{each post.postLabelList as label}}
                            {{if label.type==5}}
                            <span>{{label.name}}</span>
                            {{/if}}
                        {{/each}}
                    </div>
                </div>
                {{/if}}
            </div>
            <div class="full-job-list">
                <%--工作地址--%>
                <div class="address-box">
                    <div class="title">工作地址</div>
                    <div class="address">
                        <span class="txt">{{post.workPlace.detailedAddress}}</span>
                        <span class="iconfont icon-fujin"></span>
                    </div>
                </div>
                <%--职位描述--%>
                {{if post.descript !=null}}
                <div class="details-box">
                    <div class="title">职位描述</div>
                    <div class="content" id="positiondesc">
                        <%--{{post.descript}}--%>
                    </div>
                </div>
                {{/if}}
                <%--职位描述 end --%>
                <%--发布对象--%>
                <div class="company-box">
                    <div class="company-title">发布对象</div>
                    <div class="company-content clearfix">
                        <div class="left">
                            <div class="company-content-img ">
                                <img src="/ijob/upload/{{post.user.attachment.absolutelyPath}}" onerror="this.src='{{post.user.weixin.headimgurl}}';this.onerror=null" alt="">
                            </div>
                            <div class="company-content-msg ">
                                <p class="name">{{post.company.company}}</p>
                                <p class="admin">管理员：{{post.user.realName}}</p>
                            </div>
                        </div>
                        <%--<div class="right visit_home">
                            <a href="javascript:void(0);" class="link">访问工作号</a>
                        </div>--%>
                    </div>
                </div>
                <%--发布对象 end--%>
                <%--该公司其它在招职位--%>
                <div class="mainbox recommend">
                    <div class="title">
                        该公司其它在招职位：
                    </div>
                    <ul>
                        {{each post.otherPostList as other}}
                            {{if other.id!=null}}
                            <li class="ul-li" onclick="ijob.gotoPage({path:'/h5/qz/myjob/full_time_detail?full.id={{other.id}}'})">
                                <div class="title">
                                    <span class="txt">{{other.title}}</span>
                                    {{if other.minSalary==other.maxSalary&& other.maxSalary==0}}
                                    <span class="money">面议</span>
                                    {{else}}
                                    <span class="money">{{other.minSalary}}-{{other.maxSalary}}元/月</span>
                                    {{/if}}
                                </div>
                                <div class="name">{{post.company.company}}·{{other.workPlace.city.cityName}}</div>
                                <div class="tag-list">
                                    {{if other.benefitsLabel != null&&other.benefitsLabel != ""}}
                                    <div class="welfaretag taglist">
                                        <span>福利</span>
                                        {{#other.benefitsLabel |toLabel}}
                                    </div>
                                    {{/if}}
                                    {{if other.workLabel != null&&other.workLabel != ""}}
                                    <div class="requiretag taglist">
                                        <span>工作</span>
                                        <span>{{other.minAge}}-{{other.maxAge}}岁</span>
                                        {{#other.workLabel |toLabel}}
                                    </div>
                                    {{/if}}
                                </div>
                            </li>
                            {{/if}}
                        {{/each}}
                    </ul>
                </div>
                <%--该公司其它在招职位 end--%>
            </div>
            <div class="clearfix" style="clear: both;height: 1.8rem;overflow: hidden;content: '';"></div>
            <footer class="bar-footer">
                <a href="tel:{{post.phone}}" class="linkbtns tel"><span class="iconfont icon-dadianhua"></span><span class="txt">电话</span></a>
                <a href="javascript:void(0);"  onclick="ijob.gotoPage({path:'/h5/information/chat?chat.toUserID={{post.createBy}}'})" class="linkbtns consult"><span class="iconfont icon-zixun"></span><span class="txt">咨询</span></a>
                <a href="javascript:void(0);" class="linkbtns collection" id="collection" data-id="{{post.id}}" data-url="/ijob/api/FullTimeController/collectionPost"><span class="iconfont icon-guanzhu"></span><span class="txt">收藏</span></a>
                <a href="javascript:void(0);" class="linkbtns resumes" data-url="/ijob/api/FullTimeController/workerReport/{{post.id}}/"><span class="postxt">投简历</span></a>
            </footer>
            {{/each}}
        </script>
    </div>
</div>
<div id="homepage"></div>
</body>
<%--<script src="http://webapi.amap.com/maps?v=1.4.6&key=dfd42cc657511c1daf483e8a46865a16"></script>
<script src="/ijob/static/js/map2.js"></script>--%>
<script src="https://res.wx.qq.com/open/js/jweixin-1.2.0.js" type="text/javascript"></script>
<script src="/ijob/static/js/wxlocation.js"></script>
<script>
    $("#homepage").freshPage({path:"/h5/homepage"});
    $("#fullJobInfo").loadData().then(function (result) {
        console.log(result);
        // 职位描述换行
        var content = (result.data.list[0].descript ||"无职位描述").replace(/\n/g,"<br/>");
        $("#positiondesc").html(content);

        if(result.data.list[0].isLike==1){
            $("#collection").children(".iconfont").removeClass("icon-guanzhu").addClass("icon-weibiaoti105");
            $("#collection").children(".txt").html("已收藏");
        }
        // 福利/工作添加样式
        $(".tag-list span").each(function () {
            if ($(this).text() == '福利'){
                $(this).addClass("curr1");
            }else if ($(this).text() == '工作'){
                $(this).addClass("curr2");
            }else if ($(this).text().length >= 4){
                $(this).css("width","1.653rem")
            }
        });
        $(".taglist span").each(function () {
            if ($(this).text().length >= 4){
                $(this).css("width","1.653rem")
            }
        });
        /*收藏*/
        $("#collection").click(function () {
            var postRecommendBroker = {
                postID:$(this).data("id")
            }
            if ($(this).children(".iconfont").hasClass("icon-guanzhu")){
                $(this).children(".iconfont").removeClass("icon-guanzhu").addClass("icon-weibiaoti105");
                $(this).children(".txt").html("已收藏");
                postRecommendBroker.isLike = 1;
            }else {
                $(this).children(".iconfont").removeClass("icon-weibiaoti105").addClass("icon-guanzhu");
                $(this).children(".txt").html("收藏");
                postRecommendBroker.isLike = 0;
            }
            $("#collection").btPost(postRecommendBroker,function (result1) {
                if(result1.code == 200) {
                }else{
                    mui.toast(result.msg);
                }
            })
        });

        $(".resumes").click(function () {
            $.getJSON("/ijob/api/FullTimeController/checkHasResume",function(result){//校验是否实名
                if(result.code!=200){
                    var btnArray = ['填写简历'];
                    mui.confirm('请先填写简历再进行下一步操作。', '', btnArray, function(e) {
                        if (e.index == 0) {
                            ijob.gotoPage({path:"h5/qz/mine/chooseResume_add"});
                        }
                    });
                }else{
                    if(ijob.storage.get("broker.code")){
                        $(".resumes").data("url",$(".resumes").data("url")+ijob.storage.get("broker.code"));
                    }else{
                        $(".resumes").data("url",$(".resumes").data("url")+0);
                    }
                    $(".resumes").btPost(null,function (result) {
                        if(result.code == 200){
                            mui.alert("操作成功");
                        }else if(result.code==501){
                            mui.toast(result.msg);
                        }else{
                            mui.toast("数据异常，请刷新重试")
                        }
                    })
                }
            });
        });
        ijob.persistence.set("from",ijob.persistence.get("from"));
        //分享
        var title= "【I Job兼职】";
        var from1 = ijob.persistence.get("from")||"IJOB";
        if(from1=="QZY"){
            title="【求职云】"
        }
        title = title+result.data.list[0].title;
        var daiyu = "";
        if(result.data.list[0].maxSalary==result.data.list[0].minSalary && result.data.list[0].minSalary==0){
            daiyu = "面议";
        }else{
            daiyu = result.data.list[0].minSalary+"-"+result.data.list[0].maxSalary+"元/月";
        }

        var desc  = "地点："+result.data.list[0].workPlace.city.cityName+"\n"+"待遇："+daiyu;
        var link="${site}/share/Full/"+result.data.list[0].id+"/"+from1 ;
        var imgUrl="${site}/static/images/shareLogo1.png";
        $.getJSON("/ijob/api/WeixinController/getJSAuthSignature?url="+window.location.href,function(data){
            wx.config({
                debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                appId: data.data.appId, // 必填，公众号的唯一标识
                timestamp: data.data.timestamp, // 必填，生成签名的时间戳
                nonceStr: data.data.noncestr, // 必填，生成签名的随机串
                signature: data.data.signature,// 必填，签名
                jsApiList: ["onMenuShareAppMessage","onMenuShareTimeline","onMenuShareQQ","onMenuShareQZone","onMenuShareWeibo"] // 必填，需要使用的JS接口列表
            });
        })

        wx.ready(function () {
            var params = {
                title: title, // 分享标题
                desc: desc, // 分享描述
                link: link, // 分享链接
                imgUrl: imgUrl, // 分享图标
                success: function () {
                    // 用户确认分享后执行的回调函数
                },
                cancel: function () {
                    // 用户取消分享后执行的回调函数
                }
            };

            //获取“分享给朋友”按钮点击状态及自定义分享内容接口
            wx.onMenuShareAppMessage(params);
            //获取“分享到朋友圈”按钮点击状态及自定义分享内容接口
            wx.onMenuShareTimeline(params);
            //分享到QQ
            wx.onMenuShareQQ(params);
            //分享到QQ空间
            wx.onMenuShareQZone(params);
            //分享到腾讯微博
            wx.onMenuShareWeibo(params);
        });
        wx.error(function(res){
            mui.alert("错误信息"+JSON.stringify(res));
        });
    })
</script>
</html>
