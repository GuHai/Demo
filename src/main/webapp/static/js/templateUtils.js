try{
    template.data={
        date:{
            date:1,
            time:2,
            scope:3
        },
    }
}catch (err){
    location.reload();
}

template.ifNull = function (data,replaceValue,key) {
    if(data&&key) {
        try{
            data = eval("data."+key);
        }catch (e){
            data = undefined;
        }

    }
    if(data == 0){
        data = undefined ;
    }
    return data||replaceValue||'';
};

template.getTypeColor = function(data){
    var temInt = parseInt(data);
    if (temInt < 6){
        return "#ff943e";
    }else if (temInt < 11){
        return "#108ee9";
    }else if (temInt < 16){
        return "#e8541e";
    }else{
        return "#4ccca0";
    }
}

template.absolutelyPath = function (data,key) {
    data  = template.ifNull(data,'',key);
    if(data)
        return (data.path+"/"+data.datestr+"/"+data.name);
    else
        return "#";
}

template.enums = function(data,type,key){
    if(data=='0')data = '00';
    if(data||data==false){
        try{
            if(key){
                data = eval("enums."+key);
            }
            return  (data&&enums[type][data])||'';
        }catch (e){
            return ''
        }
    }else{
        return '';
    }
}

template.helper('enums', function (data,type,key) {
    if(data=='0')data = '00';
    if(data||data==false){
        try{
            if(key){
                data = eval("enums."+key);
            }
            return  (data&&enums[type][data])||'';
        }catch (e){
            return ''
        }
    }else{
        return '';
    }
});



template.helper('timeRange',function(data,key){
    if(data){
        if(key)data  = eval("data."+key);
        if(data&&data!="{}"){
            var arr =  ijob.getDateList(data);

            var start = arr[0];
            var end = arr[arr.length-1];
            return start+" - "+end;
        }else{
            return '';
        }
    }else{
        return '';
    }
});

//如果不传，默认自动 m分 h时 d天
template.helper('subTime',function(date,type){
    if(date){
        var time = new Date().getTime()-date;
        if(time>3600*24*1000){
            type = "d";
        }else if( time > 3600*1000){
            type = "h";
        }else{
            type = "m";
        }
        if(type=='h'){
            return Math.round(time/3600000)+dict.TemplateDict.H;
        }else if(type =='m'){
            return Math.round(time/60000)+dict.TemplateDict.M;
        }else if(type =='d') {
            return Math.round(time/(3600000*24))+dict.TemplateDict.D;
        }
    }else{
        return "0"+dict.TemplateDict.M;
    }
});




template.helper('absolutelyPath', template.absolutelyPath);

template.helper('userHead',function(data){
    if(data){
        if(data.attahement){
            return ("/ijob/upload/"+data.attahement.path+"/"+data.attahement.datestr+"/"+data.attahement.name);
        }else{
            return  data.weixin.headimgurl;
        }
    }
    return '';
});

template.helper('ifNull', template.ifNull);

template.helper("getTypeColor", template.getTypeColor);

template.formatBoard = function(data){
    if(data){
        if(data === '0000'){
            return dict.TemplateDict.NoMeal;
        }
        var str = dict.TemplateDict.Meal;
        var result = "";
        var ss = data.split("");
        for(var i in ss){
            if(ss[i]=="1"){
                result += str.split(",")[i];
            }
        }
        return result;
    }
    return '';
}

template.helper("formatBoard",template.formatBoard);

template.helper("signState",function(data){
    if(data){
        if (data.signinList[0].state == false || data.signinList[0].state == "false" ){
            return "state7"
        }else {
            if(data.dismiss==true){
                return 'state6';
            }else{
                return "state"+data.state;
            }
        }
    }
    return '';

});

template.helper("scale",template.scale);

template.scale = function (data) {
    if(data){
        return Math.round(data*100)/100;
    }else{
        return '';
    }
};

template.helper("jobStatus",function(data){
    if(data){
        var state = data.state;
        var dismiss = data.dismiss;
        return (enums['BeenStatus'][state]+    (state!=6?(dismiss==true?dict.TemplateDict.Dismiss:(dismiss==false?dict.TemplateDict.DismissSelf:'')):'' )    );
    }else{
        return '';
    }
});

template.helper("signStatus",function(data){
    if(data){
        var showstate = ijob.storage.get("showstate");
        var dismiss = data.dismiss;
        if(data.state==2)showstate = '0';
        return ( (dismiss!=null?'':enums['SigninStatus'][showstate])+  (dismiss==true?dict.TemplateDict.Dismiss:( dismiss==false?dict.TemplateDict.DismissSelf:'')  ))  ;
    }else{
        return '';
    }
});


template.money=function( data,len){
    len = len||2;
    if(data){
        data += 0.00001;
        data  = new String(data);
        if(data.indexOf('.')>-1){
            data = (data+"00");
        }else{
            data = data+".00";
        }
        data = data.substring(0,(data.indexOf(".")+len+1));
        if(data.length>6){ //千分位
            var datalist = data.split('');
            datalist.reverse();
            for(var i=6;i<datalist.length;i++){
                if(i%3==0){
                    datalist.splice(i,1,datalist[i]+',');
                }
            }
            datalist.reverse();
            data = datalist.join("");
        }
        return data;
    }else {
        return '0';
    }
}
template.helper("money",template.money );

template.money2=function( data,len){
    len = len||2;
    if(data){
        data += 0.00001;
        data  = new String(data);
        if(data.indexOf('.')>-1){
            data = (data+"00");
        }else{
            data = data+".00";
        }
        data = data.substring(0,(data.indexOf(".")+len+1));
        return data;
    }else {
        return '0';
    }
}
template.helper("money2",template.money2 );
template.toRad=function(d) {  return d * Math.PI / 180; }
template.helper("getDistance",function (data,len) {
    var radLat1 = toRad(data.latitude);
    var radLat2 = toRad(ijob.location.get().lat);
    var deltaLat = radLat1 - radLat2;
    var deltaLng = toRad(data.longitude) - toRad(ijob.location.get().lng);
    var dis = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(deltaLat / 2), 2) + Math.cos(radLat1) * Math.cos(radLat2) * Math.pow(Math.sin(deltaLng / 2), 2)));
    dis = (dis * 6378137/1000).toFixed(2);
    len = len||2;
    var unit = "km";
    if(dis>1){
        dis  = new String(dis);
    }else if(dis>=0){
        dis = new String(dis*1000);
        unit = "m";
    }

    if(dis.indexOf('.')>-1){
        dis = (dis+"00");
    }else{
        dis = dis+".00";
    }
    dis = dis.substring(0,(dis.indexOf(".")+len+1));
    if(unit=="m"){
        dis = dis.substring(0,dis.indexOf("."));
    }
    return dis+unit;
})

template.helper("distance",function(data,len){
    len = len||2;
    var unit = "km";
        if(data>1){
            data  = new String(data);
        }else if(data>=0){
            data = new String(data*1000);
            unit = "m";
        }

        if(data.indexOf('.')>-1){
            data = (data+"00");
        }else{
            data = data+".00";
        }
        data = data.substring(0,(data.indexOf(".")+len+1));
        if(unit=="m"){
            data = data.substring(0,data.indexOf("."));
        }
        return data+unit;

});

template.substr = function(data,len){
    if(data){
        len = Math.min(data.length,len||4);
        return data.substring(0,len)+(data.length>len?"..":"");
    }else{
        return '';
    }
}
template.helper("substr",template.substr);
template.datestrFormat  =  function (date,format,type){
    var dates = ijob.getDateList(date);
    var str = "";
    for( index in  dates){
        var d = dates[index];
        str += d.replace("-",dict.TemplateDict.Y).replace("-",dict.TemplateDict.m)+dict.TemplateDict.D+" ";
    }
    return str;
};
template.mdstrFormat  =  function (date,format,type){
    var dates = ijob.getDateList(date);
    var str = "";
    for( index in  dates){
        var d = dates[index];
        str += d.split("-")[1]+dict.TemplateDict.m+d.split("-")[2]+dict.TemplateDict.D+" ";
        //str += d.replace("-","年").replace("-","月")+"日 ";
    }
    return str;
};
template.dateFormat = function(date,format,type){
    if(date&&type){
        date = eval("date."+type);
    }
    if(!date)return '';
    var week = dict.TemplateDict.Week;
    if (typeof date === "string") {
        var mts = date.match(/(\/Date(\d+)\/)/);
        if (mts && mts.length >= 3) {
            date = parseInt(mts[2]);
        }
    }
    date = new Date(date);
    if (!date || date.toUTCString() == "Invalid Date") {
        return "";
    }

    var map = {
        "M": date.getMonth() + 1, //月份
        "d": date.getDate(), //日
        "h": date.getHours(), //小时
        "m": date.getMinutes(), //分
        "s": date.getSeconds(), //秒
        "q": Math.floor((date.getMonth() + 3) / 3), //季度
        "S": date.getMilliseconds(), //毫秒
        "W": week[date.getDay()],
        "A": new Date().getFullYear()-date.getFullYear()
    };


    format = format.replace(/([yMdhmsqSWA])+/g, function(all, t){
        var v = map[t];
        if(v !== undefined){
            if(all.length > 1){
                v = '0' + v;
                v = v.substr(v.length-2);
            }
            return v;
        }
        else if(t === 'y'){
            return (date.getFullYear() + '').substr(4 - all.length);
        }
        return all;
    });
    return format;
}

template.helper('datestrFormat',template.datestrFormat);
template.helper('mdstrFormat',template.mdstrFormat);
template.helper('dateFormat',template.dateFormat);

template.dateFormatByMinute = function (num) {
    function fullNum(number){
        number = Math.floor(number);
        return (number<10?"0":"")+number;
    }
    return fullNum(num/60)+":"+fullNum(num%60);
}
template.helper('dateFormatByMinute',template.dateFormatByMinute);

template.helper("rewardType",function(data){
    return data == true ? "mui-active":"";
});

template.helper("billStatus",function(data){


    if(data.btype==="5"||data.btype==="9"){
        if(data.status===0){
            return dict.TemplateDict.Adited;
        }else{
            if(data.btype==="9"){
                return dict.TemplateDict.Remove;
            }else{
                return dict.TemplateDict.Withdraw;
            }

        }
    }else if(data.btype==="13"||data.btype==="18"||data.btype==="19"){
        return dict.TemplateDict.Remove;
    }else if(data.btype==="2"||data.btype==="4"||data.btype==="6"||data.btype==="8"||data.btype==="10"||data.btype==="11"||data.btype==="12"||data.btype==="14"||data.btype==="17"||data.btype==="30"){
        return dict.TemplateDict.Account;
    }else if(data.btype==="01"){
        if(data.status==4){
            return dict.TemplateDict.Trusteeship;
        }else if(data.status==6){
            return dict.TemplateDict.Return;
        }else if(data.status==7){
            return dict.TemplateDict.Indemnity;
        }
    }else if(data.btype==="02"||data.btype==="03"||data.btype==="04"||data.btype==="05"||data.btype==="06"||data.btype==="07"){
        if(data.status==4){
            return dict.TemplateDict.Pay;
        }else if(data.status==6){
            return dict.TemplateDict.Return;
        }
    }else{
        return "";
    }
});

template.helper("nextDate",function (date) {
    var showstate = ijob.storage.get("showstate");
    if(showstate==1)return '';
    var arr  = ijob.getDateList(date);
    var now  = new Date();
    var nextDate = "";
    for(var i in arr){
        var cdate = arr[i];
        if(ijob.abledDate(cdate)){
            nextDate = cdate;
            break;
        }
    }
    return nextDate;
});

template.helper("keyword",function(data,name){
    if(!data){
        return "";
    }
    var str = eval("data."+name);
    if(!str){
        return "";
    }
    var key = data.keyword||"";

    var regExp = new RegExp(key, 'gi');
    return str.replace(regExp,"<span>"+key+"</span>");
});

//用于判断当前是第几次调用该方法， 奇数代表此次调用是初始化工作标签， 偶数代表此次初始化福利标签。
var index = 0 ;

template.toLabel=function (data) {
    if(data){
        var str = data.split(',');
        var htmlStr = '';
        for(var i = 0 ; i < str.length ; i++){
            htmlStr += "<span>"+enums['LabelType'][str[i]]+"</span>";
            if(index%2==0){
                if (i > 2){
                    index++ ;
                    return htmlStr;
                }
            }else{
                if (i > 1){
                    index++ ;
                    return htmlStr;
                }
            }

        }
        index++ ;
        return htmlStr;
    }
    index++ ;
    return '';

}

template.helper("toLabel",template.toLabel);
template.getUserInfo =  function(userID){
    var user =null;
    if(userID){
        var userinfo  = ijob.persistence.get("userinfo")||{};
        user = userinfo[userID];
        if(user==null){
            $.ajax({url: "/ijob/api/ApiNettyController/userInfo/"+userID, async: false,success: function (result) {
                    userinfo[userID] = user = (result.data||{realName:'未知',userimg:"",weixinimg:""});
                    ijob.persistence.set("userinfo",userinfo);
                }});
        }
    }
    return user||{realName:'未知',userimg:"",weixinimg:""};
}
template.getPosition =  function(positionID){
    if(positionID){
        var positioninfo  = ijob.storage.get("positionID")||{};
        var position = positioninfo[positionID];
        if(position==null){
            $.ajax({url: "/ijob/api/PositionController/chatPosition/"+positionID, async: false,success: function (result) {
                positioninfo[positionID] = position =  result;
                ijob.persistence.set("positioninfo",positioninfo);
            }});
        }
        return position;
    }
    return null;
}


template.getUserImg=function (userID,index) {
    index=index||0;
    return template.getUserInfo(userID.split(";")[index]).userimg;
};
template.helper("getUserImg",template.getUserImg);
template.getWeixinImg =function (userID,index) {
    index=index||0;
    return template.getUserInfo(userID.split(";")[index]).weixinimg;
};
template.helper("getWeixinImg",template.getWeixinImg);

template.getRiskClass =  function(data){
    // console.log(data);
    if(data){
        var risk = parseInt(data);
        if(risk>3){
            return "refuse";
        }
    }
    return null;
}
template.helper("getRiskClass",template.getRiskClass);

template.getRiskName =  function(data){
    // console.log(data);
    if(data){
        var risk = parseInt(data);
        if(risk>5){
            return dict.RiskName.one;
        }else if(risk>3){
            return dict.RiskName.two;
        }else if(risk<4){
            return dict.RiskName.three;
        }
    }
    return dict.RiskName.three;
}

template.helper("getRiskName",template.getRiskName);

template.helper("getTypeByCode",function(data){
    if(data){
        if(data.indexOf("B")==0){
            return dict.Temp.B;
        }else if(data.indexOf("S")==0){
            return dict.Temp.S;
        }else if(data.indexOf("P")==0){
            return dict.Temp.P;
        }else if(data.indexOf("R")==0){
            return dict.Temp.R;
        }else if(data.indexOf("Q")==0){
            return dict.Temp.Q;
        }else if(data.indexOf("I")==0){
            return dict.Temp.I;
        }else if(data.indexOf("O")==0){
            return dict.Temp.O;
        }
    }else{
        return dict.Temp.Z;
    }
});