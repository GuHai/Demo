<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/8
  Time: 10:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <title>实名认证审核</title>
    <link rel="stylesheet" href="/ijob/static/css/mine/realName.css">
</head>
<body>
<div class=wrap>
    <div class="main">
        <script  type="text/html" id="jobtemplate"  data-url="/ijob/api/InformationController/myRealName_check/">
            {{each list as map}}
            <input type="hidden" id="identityType" value="{{map.identityType}}">
            <div class="main1">
                <div class="realName" style="display: block!important;">
                    <div class="realText">
                        <p class="selfName"> 姓　名：{{map.Personalauthen.realName}}</p>
                        <p class="selfCard">身份证：{{map.Personalauthen.personIDCard}}</p>
                        <p class="selfPhone">手机号：{{map.Personalauthen.personPhoneNumber}}</p>
                        <p class="selfPhone">状　态：{{map.Personalauthen.status==0?'待审核':(map.Personalauthen.status==1?'审核通过':'审核不通过')}}</p>
                    </div>
                    <div class="realImg">
                        <img  class="img_zm" src="/ijob/upload/{{map.Personalauthen.gzAttachment | absolutelyPath }}"
                              onerror="this.src='/ijob/static/images/sfz.png';this.onerror=null">
                        <img  class="img_fm" src="/ijob/upload/{{map.Personalauthen.gfAttachment | absolutelyPath }}"
                              onerror="this.src='/ijob/static/images/sfz.png';this.onerror=null">
                    </div>
                </div>

            </div>
            <div class="main2">
                <div class="realFirm">
                    <div class="info1">
                        <h2>企业信息</h2>
                        <p>公司名称：{{map.Enterpriseauthen.enterpriseName}}</p>
                        <%--<p>社会信用代码：{{map.Enterpriseauthen.creditCode}}</p>--%>
                        <img  src="/ijob/upload/{{map.Enterpriseauthen.yyAttachment | absolutelyPath }}"
                              onerror="this.src='/ijob/static/images/sfz.png';this.onerror=null">
                    </div>
                    <%--<div class="info2">
                        <h2>法人信息</h2>
                        <p>法人姓名：{{map.Enterpriseauthen.legalName}}</p>
                        <p>身份证号：{{map.Enterpriseauthen.legalIDCard}}</p>
                        <img src="/ijob/upload/{{map.Enterpriseauthen.fzAttachment | absolutelyPath }}"
                              onerror="this.src='/ijob/static/images/sfz.png';this.onerror=null">
                        <img src="/ijob/upload/{{map.Enterpriseauthen.ffAttachment | absolutelyPath }}"
                              onerror="this.src='/ijob/static/images/sfz.png';this.onerror=null">
                    </div>--%>
                    <div class="info3">
                        <h2>管理员信息</h2>
                        <p>姓名：{{map.Enterpriseauthen.adminName}}</p>
                        <p>身份证号码：{{map.Enterpriseauthen.adminIDCard}}</p>
                        <p>手机号：{{map.Enterpriseauthen.adminPhoneNumber}}</p>
                        <img  src="/ijob/upload/{{map.Enterpriseauthen.azAttachment | absolutelyPath }}"
                              onerror="this.src='/ijob/static/images/sfz.png';this.onerror=null">
                        <img src="/ijob/upload/{{map.Enterpriseauthen.afAttachment | absolutelyPath }}"
                              onerror="this.src='/ijob/static/images/sfz.png';this.onerror=null">
                    </div>

                </div>
            </div>
            {{/each}}
        </script>
    </div>
    </div>
</body>
<script>

    $("#jobtemplate").data("url","/ijob/api/InformationController/myRealName_check/"+ijob.storage.get("smrz.userID"));
    $("#jobtemplate").loadData().then(
        function(result){

            $(".wrap .main .main1").css("margin-top","0")
            $(".realName").show();
            $(".realFirm").show();
        });

</script>
</html>
