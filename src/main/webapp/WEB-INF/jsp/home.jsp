<%--
  Created by IntelliJ IDEA.
  User: zhouchuang
  Date: 2018/1/20
  Time: 21:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="/ijob/lib/mui/js/mui.min.js"></script>
    <script>
        var fileName;
        <!--文件上传这里加入了js插件：jquery.ajaxfileupload.js-->
        function uploadFile() {
            //这里应该加入Loading 窗口开启
            fileName = document.getElementById('changeHeadPic').value;
            $.ajaxFileUpload({
                url: "<%=request.getContextPath()%>/fileUpload/uploadHeadPic",
                secureuri: false, //是否需要安全协议，一般设置为false
                fileElementId: 'changeHeadPic', //文件上传域的ID
                dataType: 'json', //返回值类型 一般设置为json
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                success: function (data) {
                   mui.alert(data.msg);
                    //先根据返回的code确定文件是否上传成功
                    //文件上传失败，直接弹出错误提示，根据错误进行相应的事物处理（关闭Loading窗口，弹出提示对话框）
                    //文件上传成功后，继续现实loading窗口，接着执行上传表单信息等事物
                }

            });
        }
    </script>
</head>
<body>
<div class="alert alert-success"  style="display: block;"  role="alert">
    <strong>提示!</strong> ${result}登录成功！这里是首页
    <div class="am-modal am-modal-prompt" tabindex="-1" id="my-prompt">
        <div class="am-modal-dialog">
            <hr>
            <div class="am-modal-hd">测试文件上传</div>
            <div class="am-modal-bd">
                <form enctype="multipart/form-data" accept-charset="UTF-8" class="loginForm">
                    <div class="uinArea" >
                        <label class="input-tips" >姓名：</label>

                        <div class="inputOuter" id="uArea">
                            <input type="text"  id="changeName" class="inputstyle">
                        </div>
                    </div>


                    <div class="uinArea" >
                        <label class="input-tips" >头像：</label>

                        <div class="inputOuter" >
                            <input type="file" name="file"
                                   id="changeHeadPic" size="28"/>
                        </div>
                    </div>
                </form>
            </div>
            <div class="am-modal-footer">
                <span class="am-modal-btn" data-am-modal-cancel>取消</span>
                <span class="am-modal-btn" data-am-modal-confirm  onclick="uploadFile();">上传</span>
            </div>
        </div>
    </div>
</div>
</body>
</html>
