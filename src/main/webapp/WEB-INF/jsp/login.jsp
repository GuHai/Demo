<%--
  Created by IntelliJ IDEA.
  User: zhouchuang
  Date: 2018/1/15
  Time: 15:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<%-- 上面这两行是java代码的引用 --%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<script type="text/javascript" src="/ijob/static/js/jquery-3.1.1.min.js"></script>
<head>
    <title>IJob后台管理系统→登录</title>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <script type="text/javascript" src="/ijob/static/js/login.js"></script>
    <link href="/ijob/static/css/login2.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript">
        function enterHandler(event){
            if (event.keyCode == 13) {//按键信息对象以参数的形式传递进来了
                webLogin();
            }
        }
        function webLogin() {   //定义一个名为webLogin的js函数（在java中我们称呼函数为方法）
            var loginname = $("#u").val();
            //var是申明一个变量的关键字，loginname为变量名，
            //$("#u")是找到一个标签ID为"u"的标签，.val() 是获取对应ID标签的值
            if ("" == loginname) {  //u标签的值为空
                //只有通过 $("#u") 的形式才能获取一个标签。
                $("#msg").html("<strong>提示!</strong> 用户名不能为空");
                $("#u").focus();    //让u标签获取输入焦点
                return false;   //返回false，打断js的执行
            }

            var loginpwd = $("#p").val();
            if (loginpwd == "") {
                $("#msg").html("<strong>提示!</strong> 密码不能为空");
                $("#p").focus();
                return false;
            }

            /*$.ajax({    //使用jquery下面的ajax开启网络请求
                type: "POST",   //http请求方式为POST
                url: '<%=request.getContextPath()%>/userController/toLogin',  //请求接口的地址
                data: {loginId: loginname, pwd: loginpwd},  //存放的数据，服务器接口字段为loginId和pwd，分别对应用户登录名和密码
                dataType: 'json',   //当这里指定为json的时候，获取到了数据后会自动解析的，只需要 返回值.字段名称 就能使用了
                cache: false,   //不用缓存
                success: function (data) {  //请求成功，http状态码为200。返回的数据已经打包在data中了。
                    if (data.code == 1) {   //获判断json数据中的code是否为1，登录的用户名和密码匹配，通过效验，登陆成功
                        window.location.href = data.data.nextUrl;    //跳转到主页
                    } else {    //登录不成功
                        $("#msg").html("<strong>提示!</strong> "+data.msg);
                        $("#u").focus();
                    }
                }
            });*/
            $("#loginform").submit();
        }
    </script>
</head>
<html>
<body>

<h1>iJob管理系统登陆注册<sup>2018</sup></h1>

<div class="login" style="margin-top:50px;" >
    <div class="alert alert-danger" id="msg"  style="display: block;"  role="alert">
        <strong>提示!</strong> ${result}
    </div>
    <div class="header">
        <div class="switch" id="switch"><a class="switch_btn_focus" id="switch_qlogin" href="javascript:void(0);"
                                           tabindex="7">快速登录</a>
            <a class="switch_btn" id="switch_login" href="javascript:void(0);" tabindex="8">快速注册</a>

            <div class="switch_bottom" id="switch_bottom" style="position: absolute; width: 64px; left: 0px;"></div>
        </div>
    </div>


    <div class="web_qr_login" id="web_qr_login" style="display: block; height: 235px;"  onkeypress="enterHandler(event);">

        <!--登录-->
        <div class="web_login" id="web_login">


            <div class="login-box">


                <div class="login_form">
                    <form id= "loginform"  action="<%=request.getContextPath()%>/UserController/pc/toLogin" name="loginform"
                          accept-charset="utf-8" id="login_form" class="loginForm"
                          method="post"><input type="hidden" name="did" value="0"/>
                        <input type="hidden" name="to" value="log"/>

                        <div class="uinArea" id="uinArea">
                            <label class="input-tips" for="u">帐号：</label>

                            <div class="inputOuter" id="uArea">

                                <input type="text" id="u" name="accountNo" class="inputstyle"/>
                            </div>
                        </div>
                        <div class="pwdArea" id="pwdArea">
                            <label class="input-tips" for="p">密码：</label>

                            <div class="inputOuter" id="pArea">

                                <input type="password" id="p" name="password" class="inputstyle"/>
                            </div>
                        </div>

                        <div style="padding-left:50px;margin-top:20px;">
                            <input type="button"
                                   id="btn_login"
                                   value="登 录"
                                   onclick="webLogin();"
                            style="width:150px;"
                            class="button_blue"/>
                        </div>
                    </form>
                </div>

            </div>

        </div>
        <!--登录end-->
    </div>

    <!--注册-->
    <div class="qlogin" id="qlogin" style="display: none; ">

        <div class="web_login">
            <form name="form2" id="regUser" accept-charset="utf-8" action="<%=request.getContextPath()%>/UserController/toRegister"
                  method="post">
                <input type="hidden" name="to" value="reg"/>
                <input type="hidden" name="did" value="0"/>
                <ul class="reg_form" id="reg-ul">
                    <div id="userCue" class="cue">快速注册请注意格式</div>
                    <li>

                        <label  class="input-tips2">用户名：</label>

                        <div class="inputOuter2">
                            <input type="text" id="username" name="username" maxlength="16" class="inputstyle2"/>
                        </div>

                    </li>
                    <%--<li>

                        <label for="user" class="input-tips2">姓名：</label>

                        <div class="inputOuter2">
                            <input type="text" id="name" name="name" maxlength="16" class="inputstyle2"/>
                        </div>

                    </li>--%>

                    <li>
                        <label for="passwd" class="input-tips2">密码：</label>

                        <div class="inputOuter2">
                            <input type="password" id="passwd" name="password" maxlength="16" class="inputstyle2"/>
                        </div>

                    </li>
                   <%-- <li>
                        <label  class="input-tips2">确认密码：</label>

                        <div class="inputOuter2">
                            <input type="password" id="confirmPassword" name="" maxlength="16" class="inputstyle2"/>
                        </div>

                    </li>--%>

                   <%-- <li>
                        <label for="cellNumber" class="input-tips2">手机号：</label>

                        <div class="inputOuter2">

                            <input type="text" id="cellNumber" name="cellNumber" maxlength="18" class="inputstyle2"/>
                        </div>

                    </li>

                    <li>
                        <label for="sex" class="input-tips2">性别：</label>

                        <div class="inputOuter2">

                            <input type="text" id="sex" name="sex" maxlength="18" class="inputstyle2"/>
                        </div>

                    </li>

                    <li>
                        <label for="age" class="input-tips2">年龄：</label>

                        <div class="inputOuter2">

                            <input type="age" id="age" name="age" maxlength="18" class="inputstyle2"/>
                        </div>

                    </li>--%>

                    <li>
                        <div class="inputArea">
                            <input type="button" id="reg" style="margin-top:10px;margin-left:85px;" class="button_blue"
                                   value="同意协议并注册"/> <a href="javascript:void(0);" class="zcxy" target="_blank">注册协议</a>
                        </div>

                    </li>
                    <div class="cl"></div>
                </ul>
            </form>


        </div>


    </div>
    <!--注册end-->
</div>
<div class="jianyi">*推荐使用ie8或以上版本ie浏览器或Chrome内核浏览器访问本站</div>
<div class="jianyi">© 2017-2018 湖南一生科技 版权所有</div>
</body>
</html>