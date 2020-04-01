<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/23
  Time: 10:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新闻</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-size:64px;
        }
        div {
            display: block;
        }
        .rich_media{
            font-family: -apple-system-font,"Helvetica Neue","PingFang SC","Hiragino Sans GB","Microsoft YaHei",sans-serif;
            background-color: #f3f3f3;
            line-height: inherit;
        }
        .rich_media_inner{
            word-wrap: break-word;
            font-size: 17px;
        }
        .rich_media_area_primary{
            position: relative;
            padding: 20px 15px 15px;
            background-color: #fff;
        }
        .rich_media_title {
            margin-bottom: 10px;
            line-height: 1.4;
            font-weight: 400;
            font-size: 56px;
        }
        .h2{
            display: block;
            font-size: 1.5em;
            -webkit-margin-before: 0.83em;
            -webkit-margin-after: 0.83em;
            -webkit-margin-start: 0px;
            -webkit-margin-end: 0px;
            font-weight: bold;
        }
        .rich_media_meta_list{
            margin-bottom: 18px;
            line-height: 20px;
            font-size: 0;
        }
        .meta_original_tag {
            display: inline-block;
            vertical-align: middle;
            padding: 1px .5em;
            border: 1px solid #9e9e9e;
            color: #8c8c8c;
            border-top-left-radius: 20% 50%;
            -moz-border-radius-topleft: 20% 50%;
            -webkit-border-top-left-radius: 20% 50%;
            border-top-right-radius: 20% 50%;
            -moz-border-radius-topright: 20% 50%;
            -webkit-border-top-right-radius: 20% 50%;
            border-bottom-left-radius: 20% 50%;
            -moz-border-radius-bottomleft: 20% 50%;
            -webkit-border-bottom-left-radius: 20% 50%;
            border-bottom-right-radius: 20% 50%;
            -moz-border-radius-bottomright: 20% 50%;
            -webkit-border-bottom-right-radius: 20% 50%;
            font-size: 15px;
            line-height: 1.1;
        }
        .rich_media_meta {
            display: inline-block;
            vertical-align: middle;
            margin-right: 8px;
            margin-bottom: 10px;
            font-size: 36px;
        }
        .rich_media_meta_list em {
            font-style: normal;
        }
        .rich_media_meta_text {
            color: #8c8c8c;
        }
        .rich_media_content {
            overflow: hidden;
            color: #3e3e3e;
            position: relative;
            font-size: 40px;
        }
        .imgBox{
            float: left;
            width: 140px;
            height: 140px;
        }
        .photoImg{
            width: 100%;
            height: 100%;
            border-radius: 50%;
        }
        img{
            width:100%;
            border: none;
            vertical-align: middle;
            cursor: pointer;
        }
        .infoBox{
            float: left;
            height: 140px;
            padding: 10px;
            margin-left:20px ;
        }
        .nameP {
            color: #414141;
            width: 100%;
        }
        .noteP {
            width: 100%;
            color: #999999;
        }
        .btnBox{
            float: left;
            width:140px;
            height: 140px;
            right: 10px;
            margin:auto;
            text-align: center;
        }
        .content{
            -webkit-user-modify: read;
            word-wrap: break-word;
            -webkit-line-break: after-white-space;
            display: block;
            margin: 8px;
            font-family: sans-serif;
            font-size:40px!important;
            width: 90%;
            margin-left: auto;
            margin-right: auto;
            margin-top: 100px;
            max-width: 100%!important;
        }
        .content p,span{
            font-size:40px!important;
            line-height: 46px !important;
        }
    </style>
</head>
<body>
<div class="rich_media">
    <div class="rich_media_inner">
        <div class="rich_media_area_primary">
            <div id="img-content">
                <h2 class="rich_media_title" id="activity-name">${news.title}</h2>
                <span id="copyright_logo" class="rich_media_meta meta_original_tag">版本</span>
                <em class="rich_media_meta rich_media_meta_text">${news.versionNo}</em>
                <div class="rich_media_meta_list">
                    <em id="post-date" class="rich_media_meta rich_media_meta_text">${news.publishTime}</em>
                    <span class="rich_media_meta rich_media_meta_text rich_media_meta_nickname">©2018 湖南一生技术有限公司</span>
                </div>
                <div class="rich_media_content">
                    ${news.description}
                    <div  class="content" id="content" >
                        ${news.content}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
</script>
</html>
