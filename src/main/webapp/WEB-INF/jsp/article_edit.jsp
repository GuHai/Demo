<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/10
  Time: 11:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" %>
<html>
<head>
    <title>测试Ueditor</title>
    <script type="text/javascript" charset="utf-8" src="/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/ueditor/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="/ueditor/lang/zh-cn/zh-cn.js"></script>
    <style type="text/css">
        /*div{
            width:100%;
        }*/
        .main{
            width: 80%; margin-left: auto; margin-right: auto;
            margin-top: 100px;
        }
        .submit{
            width: 100px;
            height: 34px;
            margin-top: 10px;
            color: #fff;
            letter-spacing: 1px;
            background: #3385ff;
            border-bottom: 1px solid #2d78f4;
            outline: medium;
            -webkit-appearance: none;
            -webkit-border-radius: 0;
            border: 0;
            cursor: pointer;
        }
    </style>
</head>
<body>
   <div >
       <form id="article" class="main" action="/UeditorController/article_add/${article.posi}" method="POST">
           <input name="title" style="margin: 5px 0px;line-height: 16px;width: 1024px;height: 30px;" placeholder="请填写标题"   value="${article.title}">
           <input name="description" style="margin: 5px 0px 10px 0px;line-height: 16px;width: 1024px;height: 30px;" placeholder="请填写描述"  value="${article.description}" >
           <input name="image" style="margin: 5px 0px 10px 0px;line-height: 16px;width: 1024px;height: 30px;" placeholder="远程图片地址"  value="${article.image}" >
           <input name="id" type="hidden"  value="${article.id}">
           <input name="version" type="hidden" value="${article.version}">
           <input name="posi" type="hidden" value="${article.posi}">
           <script id="editor"    type="text/plain"></script>
           <button type="submit" class="submit" >提交</button>
       </form>
    </div>
    <script type="text/javascript">
        document.getElementById("editor").style.width='1024px';
        document.getElementById("editor").style.height='500px';
        var ue = UE.getEditor('editor');


        ue.addListener( 'ready', function( editor ) {
            var doc;
            if (document.all){ // IE
                doc = document.frames["ueditor_0"].document;
            }else{ // 标准
                doc = document.getElementById("ueditor_0").contentDocument;
            }
            doc.body.innerHTML='${article.content}';
        } );

    </script>
</body>
</html>