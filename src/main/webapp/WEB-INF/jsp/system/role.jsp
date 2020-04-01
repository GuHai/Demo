<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/19
  Time: 18:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>角色</title>
    <script src="/ijob/lib/mui/js/mui.min.js"></script>
</head>
<body>
<c:if test="${not empty msg}">
    <div class="alert alert-danger">${msg}</div>
</c:if>





<button class="btn btn-default" data-toggle="modal" data-target="#myModal">
    新增权限
</button>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    新增角色
                </h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" method="post" id="permissionForm" action="/roleController/addRole">
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">角色名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="name"  name="name" placeholder="请输入名字">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" id="submit" class="btn btn-primary">
                    提交更改
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>


<table class="table table-bordered">
    <caption>角色列表</caption>
    <thead>
    <tr>
        <th>名称</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${roles.list}" var="role">
        <tr>
            <td>${role.name}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>


<script>
    $("#submit").click(function(){
        $.ajax({    //使用jquery下面的ajax开启网络请求
            type: "POST",   //http请求方式为POST
            url: '/roleController/addRole',  //请求接口的地址
            data: $("#myModal form").serialize(),
            dataType: 'json',   //当这里指定为jsfromon的时候，获取到了数据后会自动解析的，只需要 返回值.字段名称 就能使用了
            cache: false,   //不用缓存
            success: function (data) {  //请求成功，http状态码为200。返回的数据已经打包在data中了。
                if (data.code == '200') {   //获判断json数据中的code是否为1，登录的用户名和密码匹配，通过效验，登陆成功
                   mui.alert(data.msg);
                    $("#myModal").modal("hide");
                } else {    //登录不成功
                   mui.alert(data.msg);
                }
            }
        })
    });
</script>
</body>
</html>
