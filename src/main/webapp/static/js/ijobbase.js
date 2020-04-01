
var ijobbase={
    checkIndemnity:function(){
        var obj  ;
        $.ajax({
            type: "GET",
            url: '/ijob/api/PositionController/h5/qz/checkIndemnity',
            cache: false,
            async:false,
            dataType: "json",
            success:function (result) {
                if(result.code=='200'){
                    if(result.data){
                        obj = result.data;
                    }
                }
            }
        });
        return obj;
    },
    toPayIndemnity:function(indemnity,url){
        url = url||"forward?path=/h5/qz/index";
        window.history.replaceState('','', url);
        ijob.url.next.set("/api/PositionController/indemnityCallback");
        ijob.gotoPage({url:'/api/WeixinController/order',data:{order:{refID:indemnity.id,fee:indemnity.money*100,description:'违约保证金'+(indemnity.money)+'元',type:enums.WxOrderType.Indemnity}}});
    },
    checkAndToPay:function(url){
        var obj = ijobbase.checkIndemnity();
        if(obj){
            ijobbase.confirmPay(obj,url);
        }
    },
    confirmPay:function (obj,url) {
        var btnArray = ['以后再说','去支付'];
        mui.confirm('您有一笔违约金未结清', '提示', btnArray, function(e) {
            if (e.index == 1) {
                ijobbase.toPayIndemnity(obj,url);
            }
        });
        $(".mui-popup").css("text-align","center");
        $(".mui-popup-title").css("text-align","center");
    },
    checkSubscribe:function(){
        $.ajax({
            type: "GET",
            url: '/ijob/api/WeixinController/checkSubscribe',
            cache: false,
            dataType: "json",
            success:function (data) {
                if(data.code == 403){
                    $(".wrap").prepend("<div id=\"maskpanel\" ></div>");
                    $("#maskpanel").loadPage({path:"/h5/qz/base/gzh"});
                }else if(data.code == 404){ //选择学校
                    //ijob.gotoPage({path:'/h5/perfect_inform'});
                }else if(data.code != 200){
                    //mui.toast(data.msg);
                }
            }
        });
    },
    randomString:function(len) {
        len = len || 32;
        var $chars = 'ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz2345678';    /****默认去掉了容易混淆的字符oOLl,9gq,Vv,Uu,I1****/
        var maxPos = $chars.length;
        var pwd = '';
        for (i = 0; i < len; i++) {
            pwd += $chars.charAt(Math.floor(Math.random() * maxPos));
        }
        return pwd;
    },
    hashCode:function(str){
        var hash = 0;
        if (str.length == 0) return hash;
        for (i = 0; i < str.length; i++) {
            char = str.charCodeAt(i);
            hash = ((hash<<5)-hash)+char;
            hash = hash & hash; // Convert to 32bit integer
        }
        return hash;
    },
    toChat:function (obj) {
         if(!obj.toUserID  &&  !obj.groupID){
             mui.toast("对象不存在");
         }else{
             var chat = {};
             chat.toUserID = obj.toUserID;
             chat.positionName = obj.positionName;
             chat.positionID = obj.positionID;
             chat.groupID = obj.groupID;
             chat.title = obj.title;
             ijob.storage.seto("chat",chat);
             ijob.gotoPage({path:'/h5/information/chat'});
         }
    }

}

