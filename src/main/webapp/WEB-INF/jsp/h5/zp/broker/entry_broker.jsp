<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/8
  Time: 10:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>已入职</title>
    <jsp:include page="../../zp/base/resource.jsp"/>
    <link rel="stylesheet" href="/ijob/static/css/broker/broker.css?version=4">
</head>
<body>
<div class="entry-broker-index">
    <div class="list-main-box">
        <div class="info-box">
            <ul>
                <script type="text/html" id="template" data-url="/ijob/api/FullTimeController/myBrokerPersonDetail">
                    {{each list as post}}
                        <li class="ul-li">
                            <div onclick="ijob.gotoPage({path:'/h5/zp/broker/broker_job_details?postForBroker.id={{post.post.id}}'})">
                                <div class="hd-txt">
                                    <div class="name">
                                        <span class="call">{{post.recommend.name}}</span>
                                        <span class="sex">{{post.recommend.sex | enums:'SexType'}}</span>
                                        {{if post.recommend.age != null && post.recommend.age !='' && post.recommend.age != 0}}
                                        <span class="age">{{post.recommend.age}}岁</span>
                                        {{/if}}
                                    </div>
                                    <div class="tel">
                                            <span class="iconfont icon-dianhua"></span>
                                            <span class="number">{{post.recommend.phoneNumber}}</span>
                                    </div>
                                </div>
                                <div class="data-list">
                                    <ul>
                                        <li>
                                            <div class="tit">{{post.post.title}}</div>
                                        </li>
                                        <li>
                                            <div class="name">{{post.post.company.company}}</div>
                                        </li>
                                        <li>
                                            <div class="money">{{post.post.postForBroker.commission}}{{post.post.postForBroker.unit |enums:'UnitType'}}</div>
                                            <%--<div class="desc">佣金</div>--%>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="remark">
                                <em>备注：</em>
                                <span class="r_content" data-text="{{post.recommend.mark}}">{{post.recommend.mark}}</span>
                                <span class="icon"><span class="iconfont icon-arrow-down1"></span></span>
                            </div>
                            <div class="time">
                                入职时间：{{post.entry |dateFormat:'yyyy-MM-dd'}}
                            </div>
                        </li>
                    {{/each}}
                </script>
            </ul>
        </div>
    </div>
</div>
<script>
    $("#template").loadData({condition:{type2:1}}).then(function (result) {
        var remarks = $(".remark") ;
        var more = true;
        function conceal() {
            $(".r_content").each(function (i,item) {
                //判断是否有备注，如果没有则隐藏
                var _this = $(this);
                if (_this.text() == "" || _this.text() == null){
                    $(remarks[i]).hide();
                }
                // 字数限制，超过部分...代替，后缀点击展开，点击后展开全文
                var maxheight=20;
                var em = _this.next(".icon");
                if(_this.text().length>maxheight){
                    _this.html(_this.text().substring(0,maxheight));
                    _this.html(_this.html()+'...');
                    more = true;
                    em.html("<span class=\"launch iconfont icon-arrow-down1\"></span>");
                }else {
                    em.hide();
                }
            });
        }
        conceal();
        $('.remark .icon').unbind().click(function(){
            console.log(more)
            if(more){
                $(this).prev().html($(this).prev(".r_content").data("text"));
                $(this).html("<span class=\"retract iconfont icon-arrow-up\"></span>");
                more = false;
            }else{
                conceal();
            }
        });
    });
</script>
</body>
</html>
