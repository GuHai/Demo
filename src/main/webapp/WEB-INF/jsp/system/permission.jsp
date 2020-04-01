<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/1/19
  Time: 18:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html  lang="zh-CN">
<head>
    <title>权限</title>

</head>
<body >

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
                    新增权限
                </h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form" action="/permissionController/addPermission" id="permissionForm">
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">权限名称</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="name" name="name" placeholder="请输入名字">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="alias" class="col-sm-2 control-label">权限别名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="alias" name="alias" placeholder="请输入别名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="url" class="col-sm-2 control-label">请求地址</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="url" name="url" placeholder="请输入路径">
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">权限类型</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="type"  value="1" checked> 菜单
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="type"   value="2"> 按钮
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label  class="col-sm-2 control-label">平台类型</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="platform"  value="1" checked> PC
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="platform"   value="2"> H5
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="url" class="col-sm-2 control-label">父级菜单</label>
                        <div class="col-sm-10">
                            <select name="parentId" class="selectpicker show-tick form-control">
                                <option value="0" >一级主菜单</option>
                                <c:forEach items="${permissionfirst}" var="permission">
                                    <option value="${permission.id}">${permission.name}</option>
                                </c:forEach>
                            </select>
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
    <caption>权限列表</caption>
    <thead>
    <tr>
        <th>名称</th>
        <th>别名</th>
        <th>地址</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${permissions.list}" var="permission">
        <tr>
            <td>${permission.name}</td>
            <td>${permission.alias}</td>
            <td>${permission.url}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
total:${permissions.totalCount}
pageSize:${permissions.pageSize}
currentPage:${permissions.currentPage}
<ul class="pagination">
    <li><a href="javascript:void(0);">&laquo;</a></li>
    <li><a href="javascript:void(0);">1</a></li>
    <li><a href="javascript:void(0);">2</a></li>
    <li><a href="javascript:void(0);">3</a></li>
    <li><a href="javascript:void(0);">4</a></li>
    <li><a href="javascript:void(0);">5</a></li>
    <li><a href="javascript:void(0);">&raquo;</a></li>
</ul>
<script>

   /* 显示：$('#myModal').modal('show');

    隐藏：$('#myModal').modal('hide');

    开关：$('#myModal').modal('toogle');

    事件:   $('#myModal').on('hidden', function () {// do something…});*/
    $("#submit").click(function(){
        $.ajax({    //使用jquery下面的ajax开启网络请求
            type: "POST",   //http请求方式为POST
            url: '/permissionController/addPermission',  //请求接口的地址
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