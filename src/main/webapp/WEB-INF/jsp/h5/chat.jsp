<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/21
  Time: 9:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>测试语音</title>
    <script type="text/javascript" src="/ijob/lib/jquery-2.2.3.min.js" ></script>
    <script src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js" type="text/javascript"></script>
</head>
<body>

<button id="record">录音</button>
<button id="stop">停止</button>
<button id="play">播放</button>
</body>
<script>
    $.getJSON("/ijob/api/WeixinController/getJSAuthSignature?url="+window.location.href,function(data){
        wx.config({
            debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
            appId: data.data.appId, // 必填，公众号的唯一标识
            timestamp: data.data.timestamp, // 必填，生成签名的时间戳
            nonceStr: data.data.noncestr, // 必填，生成签名的随机串
            signature: data.data.signature,// 必填，签名
            jsApiList: ["startRecord","stopRecord","onVoiceRecordEnd","playVoice","pauseVoice","stopVoice","onVoicePlayEnd","uploadVoice"] // 必填，需要使用的JS接口列表
        });
    })

    var localId ;
    wx.ready(function () {
        $("#record").click(function(){
            wx.startRecord();
        });
        $("#stop").click(function(){
            wx.stopRecord({
                success: function (res) {
                    localId = res.localId;
                }
            });
        });
        $("#play").click(function(){
            wx.playVoice({
                localId: localId // 需要播放的音频的本地ID，由stopRecord接口获得
            });
        });
    });
    wx.error(function(res){
        mui.alert("错误信息"+JSON.stringify(res));
    });

</script>
</html>
