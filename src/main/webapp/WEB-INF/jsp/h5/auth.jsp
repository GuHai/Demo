<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/13
  Time: 11:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>授权微信</title>
</head>
<body>
<p id="msg">跳转到微信授权页面</p>
<button onclick="login()">  登录页面  </button>
<script>
    var authData={
         appId:"wx16b6988ce660defc",
         redirect_uri:"https://www.jianzhipt.cn/ijob/api/WeixinController/index",
         response_type:"code",
         scope:"snsapi_userinfo"  //应用授权作用域，snsapi_base （不弹出授权页面，直接跳转，只能获取用户openid），snsapi_userinfo （弹出授权页面，可通过openid拿到昵称、性别、所在地。并且， 即使在未关注的情况下，只要用户授权，也能获取其信息 ）
    }
    authData.redirect_uri = encodeURIComponent(authData.redirect_uri);
    var domain = "https://open.weixin.qq.com/connect/oauth2/authorize?state=ijob";
    var end = "&connect_redirect=1#wechat_redirect";
    var url =  domain ;
    for(var key in authData){
        url +=  ("&"+key +"="+authData[key]);
    }
    url += end;
    document.getElementById("msg").innerText = url;
    function login(){
        window.location.href = url;
    }
</script>
</body>
</html>
