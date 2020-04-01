var websocket;
ijob.storage.set("chat.groupID",null);
ijob.storage.set("chat.positionID",null);
ijob.storage.set("chat.isGroup",null);
//如果浏览器支持WebSocket
// chatIP = "localhost";
if(window.WebSocket){
    websocket = new WebSocket("ws://"+chatIP+":8989/ws");  //获得WebSocket对象
    //当有消息过来的时候触发
    websocket.onmessage = function(event){
        var result = JSON.parse(event.data);
        if(result.type==3){//catalog
            $(document).trigger('CatalogEvent',[result.data]);
        }else if(result.type==2){ //new
            $(document).trigger('NewMessageEvent',[result.data]);
        }else if(result.type==6){ //第一次登陆，是否有未读消息
            $(document).trigger('NoReadEvent',[result.data]);
        }

    }
    //连接打开的时候触发
    websocket.onopen = function(event){
        if(window.WebSocket){
            if(websocket.readyState == WebSocket.OPEN) { //如果WebSocket是打开状态
                var obj = {"type":"Listen","userID":$("#myuserID").val()};
                websocket.send(JSON.stringify(obj)); //send()发送消息

            }
        }else{
            return;
        }
        $(document).trigger('OpenEvent');
    }

    //连接关闭的时候触发
    websocket.onclose = function(event){
        console.log("断开连接");
    }
}else{
    console.log("no webSocket");
}