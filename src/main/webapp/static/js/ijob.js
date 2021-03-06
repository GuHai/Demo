﻿var ijob = {

    mask: "<div class=\"loading\">\n" +
    "        <div class=\"spinner\">\n" +
    "            <div class=\"spinner-container container1\">\n" +
    "                <div class=\"circle1\"></div>\n" +
    "                <div class=\"circle2\"></div>\n" +
    "                <div class=\"circle3\"></div>\n" +
    "                <div class=\"circle4\"></div>\n" +
    "            </div>\n" +
    "            <div class=\"spinner-container container2\">\n" +
    "                <div class=\"circle1\"></div>\n" +
    "                <div class=\"circle2\"></div>\n" +
    "                <div class=\"circle3\"></div>\n" +
    "                <div class=\"circle4\"></div>\n" +
    "            </div>\n" +
    "            <div class=\"spinner-container container3\">\n" +
    "                <div class=\"circle1\"></div>\n" +
    "                <div class=\"circle2\"></div>\n" +
    "                <div class=\"circle3\"></div>\n" +
    "                <div class=\"circle4\"></div>\n" +
    "            </div>\n" +
    "        </div>\n" +
    "    </div>",
    isNull: function (s) {
        if(s){
            if (typeof(str) == "string"){
                var reg = /^\s*$/g;
                if (str == "" || reg.test(str)) {
                    return true;
                }
                return false;
            }else if(typeof(str) == "object"){
                var flag = true;
                for(var key in str){
                    if(str[key]){
                        flag = false;
                        break;
                    }
                }
                return flag;
            }
        }else{
            return true;
        }

    },
    isNotNull: function (str) {
        return !this.isNull(str);
    },
    getDateByTime:function(times){
        var d = new Date(times);
        return d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
    },
    getDateList: function (datetime) {
        var arr = [];
        if (datetime) {
            var datetime = JSON.parse(datetime);
            for (var key in datetime) {
                var year = datetime[key];
                for (var mkey in year) {
                    var month = year[mkey];
                    for (var dkey in month) {
                        arr.push(key + "-" + mkey + "-" + dkey);
                    }
                }
            }
        }
        return arr;
    },
    getDatePersonList: function (datetime) {
        var arr = [];
        if (datetime) {
            var datetime = JSON.parse(datetime);
            for (var key in datetime) {
                var year = datetime[key];
                for (var mkey in year) {
                    var month = year[mkey];
                    for (var dkey in month) {
                        arr.push({date:(key + "-" + mkey + "-" + dkey),num:month[dkey]});
                    }
                }
            }
        }
        return arr;
    },
    abledDate:function(date){
        var year = parseInt(date.split('-')[0]);
        var month = parseInt(date.split('-')[1]);
        var day = parseInt(date.split('-')[2]);
        var ndate = new Date();
        var nyear = ndate.getFullYear();
        var nmonth = ndate.getMonth()+1;
        var nday = ndate.getDate();
        if (year>nyear||(year==nyear&&month>nmonth)||(year==nyear&&month==nmonth&&day>=nday)) {
            return true;
        }else{
            return false;
        }
    },
    isToday:function(dates){
        var now = new Date().toISOString().slice(0,10);
        var datelist = this.getDateList(dates);
        for(var i in datelist){
            var date = datelist[0];
            var year = date.split('-')[0];
            var month = date.split('-')[1].length>1?date.split('-')[1]:("0"+date.split('-')[1]);
            var day = date.split('-')[2].length>1?date.split('-')[2]:("0"+date.split('-')[2]);
            if(now===year+"-"+month+"-"+day){
                return true;
            }
        }
        return false;
    },
    sortDate:function(arr){

        var i = arr.length, j;
        var tempExchangVal;
        while (i > 0) {
            for (j = 0; j < i - 1; j++) {

                var date = arr[j];
                var year = parseInt(date.split('-')[0]);
                var month = parseInt(date.split('-')[1]);
                var day = parseInt(date.split('-')[2]);
                var ndate = arr[j+1];
                var nyear = parseInt(ndate.split('-')[0]);
                var nmonth = parseInt(ndate.split('-')[1]);
                var nday = parseInt(ndate.split('-')[2]);

                if (year>nyear||(year==nyear&&month>nmonth)||(year==nyear&&month==nmonth&&day>nday)) {
                    tempExchangVal = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = tempExchangVal;
                }
            }
            i--;
        }
        return arr;
    },
    getStrFromList: function (arr) {
        var datejson = {};
        for (i in arr) {
            var date = arr[i];
            var year = date.split('-')[0];
            var month = date.split('-')[1];
            var day = date.split('-')[2];
            if (!datejson.hasOwnProperty(year)) {
                datejson[year] = {};
            }
            if (!datejson[year].hasOwnProperty(month)) {
                datejson[year][month] = {};
            }
            datejson[year][month][day] = true;
        }
        return datejson;
    },
    getDateFromString: function (date) {
        var year = date.toString().split("-")[0];
        var month = date.toString().split("-")[1];
        var day = date.toString().split("-")[2];
        return new Date(year, month, day);
    },
    setCookie: function (name, value, times) {    //封装一个设置cookie的函数

        times = times||24*3600*1000*30; //默认为一个月
        var oDate = new Date();
        oDate.setTime(oDate.getTime() + times);   //days为保存时间长度
        document.cookie = name + '=' + encodeURIComponent(value) + ';expires=' + oDate.toGMTString();
    },
    getCookie: function (name) {
        var arr = document.cookie.split(';');
        for (var i = 0; i < arr.length; i++) {
            var arr2 = arr[i].split('=');
            if (arr2[0] == name) {
                return decodeURIComponent(arr2[1]);  //找到所需要的信息返回出来
            }
        }
        return '';        //找不到就返回空字符串
    },
    getBaseConfig: function (name) {
        //读取
        str = sessionStorage.obj;
        //如果不存在，则主动请求获取
        if (str == undefined) {
            htmlobj = $.ajax({url: "/getBaseConfig", async: false});
            this.setBaseConfig(htmlobj.data);
            str = sessionStorage.obj;
        }
        //重新转换为对象
        obj = JSON.parse(str);
        return obj[name];

    },
    setBaseConfig: function (obj) {
        var str = JSON.stringify(obj);
        //存入
        sessionStorage.obj = str;
    },
    dateFormat: function (date, format) {
        if(!date)return '';
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
            "S": date.getMilliseconds() //毫秒
        };


        format = format.replace(/([yMdhmsqS])+/g, function (all, t) {
            var v = map[t];
            if (v !== undefined) {
                if (all.length > 1) {
                    v = '0' + v;
                    v = v.substr(v.length - 2);
                }
                return v;
            }
            else if (t === 'y') {
                return (date.getFullYear() + '').substr(4 - all.length);
            }
            return all;
        });
        return format;
    },
    goPreAndRefresh: function (msg) {
        mui.toast(msg || dict.IjobDict.OperOk);
        setTimeout(function () {
            ijob.back();//默认返回页面
        }, 1000);
    },
    database:{
        me:{
            set:function (isArray,key,item,value){
                var collects =  ijob.database.collect(key)||(isArray?[]:{});
                if(isArray){
                    if(ijob.isNull(value)){
                        if (item instanceof Array) {
                            collects = item;
                        }else{
                            if(ijob.isNull(item)){
                                collects =  {};
                            }else{
                                collects.push(item);
                            }
                        }
                    }else{
                        if(collects.length>0) {
                            var first = collects[0];
                            if (typeof first === "object") {
                                var iscontains = false;
                                for(var i in collects){
                                    var o = collects[i];
                                    if (o[item.split(":")[0]] && o[item.split(":")[0]] == item.split(":")[1]) {
                                        collects[i] = value;
                                        iscontains = true;
                                        break ;
                                    }
                                }
                                if(iscontains==false){
                                    collects.push(value);
                                }
                            }else {
                                if(collects[item]){
                                    collects[item] = value;
                                }else{
                                    collects.push(value);
                                }
                            }
                        }else{
                            collects.push(value);
                        }
                    }
                    collects = collects.filter( function(it){return ijob.isNotNull(it) });
                }else{
                    if(ijob.isNull(value)){
                        collects = item;
                    }else{
                        if(ijob.isNull(value)){
                            delete collects[item];
                        }else{
                            collects[item] = value;
                        }
                    }
                }
                localStorage.setItem(key, JSON.stringify(collects));
                return collects;
            }
        },
        collect:function (key) {
            return JSON.parse(localStorage.getItem(key));
        },
        get:function (key,item){
            var collects =  ijob.database.collect(key);
            if(ijob.isNotNull(item)){
                if(ijob.isNotNull(collects)){
                    if(collects  instanceof Array){
                        if(collects.length>0){
                            var first = collects[0];
                            if ( typeof first === "object" ) {
                                for(var i in collects){
                                    var o = collects[i];
                                    if(o && o.hasOwnProperty(item.key)&&o[item.key]==item.value){
                                        return o;
                                    }
                                }
                            }else{
                                return collects[item];
                            }
                        }else{
                            return null;
                        }
                    }else{
                        return collects[item];
                    }
                }else{
                    return null;
                }
            }
            return collects;
        },
        map: function (key,item,value) {
            return ijob.database.me.set(false,key,item,value);
        },
        list: function (key,item,value) {
            return ijob.database.me.set(true,key,item,value);
        },
        clear:function (key,version) {
            var v = ijob.database.get("config","version");
            if(ijob.isNotNull(v)&&v!=version){ //清楚掉所有html
                ijob.database.map(key,{});
            }
            ijob.database.map("config","version",version);

        }
    },
    persistence:{
        set:function (key,value) {
            ijob.storage.set(key,value,'store');
        },
        get:function(key){
            return  ijob.storage.get(key,'store');
        }
    },
    storage:{
        me:{
            write: function (data,key) {
                data = data || {data: {}};
                sessionStorage.setItem( key||"param", JSON.stringify(data));
            },
            read: function (key) {
                var objs = sessionStorage.getItem(key||"param") || JSON.stringify({data: {}});
                return JSON.parse(objs);
            },
            setObjByDepth: function (param, keys, value) {
                function setObj(obj, key) {
                    if (!obj.hasOwnProperty(key)) {
                        obj [key] = {};
                    }
                }

                if (keys.length == 1) {
                    param.data[keys[0]] = value;
                }
                if (keys.length == 2) {
                    setObj(param.data, keys[0]);
                    param.data[keys[0]][keys[1]] = value;
                }
                if (keys.length == 3) {
                    setObj(param.data, keys[0]);
                    setObj(param.data[keys[0]], keys[1]);
                    param.data[keys[0]][keys[1]][keys[2]] = value;
                }
            }
        },
        merge: function (data) {
            if (!data.hasOwnProperty("data")) {
                data = {data: data};
            }
            var obj = ijob.storage.me.read();
            if (!(obj && obj.hasOwnProperty("data"))) {
                obj = {data: {}};
            }
            var temp = $.extend(obj.data, data.data);
            obj.data = temp;
            if (data.path) obj.path = data.path;
            if (data.url) obj.url = data.url;
            ijob.storage.me.write(obj);
        },
        remove:function(key){
            if (key.indexOf("data") == 0) {
                key = key.replace("data.", "");
            }
            var obj = ijob.storage.me.read();
            delete obj.data[key];
            ijob.storage.me.write(obj);
        },
        seto:function (key, value,path) {
           ijob.storage.remove(key)  ;
           ijob.storage.set(key,value,path);
        },
        set: function (key, value,path) {
            if (key.indexOf("data") == 0) {
                key = key.replace("data.", "");
            }
            var obj = ijob.storage.me.read(path);
            var keys = key.split(".");
            ijob.storage.me.setObjByDepth(obj, keys, value);
            sessionStorage.setItem(path||'param', JSON.stringify(obj));
        },
        get: function (key,path) {
            var index = -1;
            if(key.indexOf("[")!=-1){
                var indexstr = key.substring(key.indexOf("["),key.indexOf("]")+1);
                key = key.replace(indexstr,"");
                index = parseInt(indexstr.substring(1,indexstr.length-1));
            }
            if (key.indexOf("data") == 0) {
                key = key.replace("data.", "");
            }
            var keys = key.split(".");
            var obj = ijob.storage.me.read(path).data;
            for (var i in keys) {
                if (obj.hasOwnProperty(keys[i])) {
                    obj = obj[keys[i]];
                } else {
                    return null;
                }
            }
            if(index>-1){
                return obj[index];
            }else{
                return obj;
            }

        },
        pop:function(key){
            var val = ijob.storage.get(key);
            ijob.storage.set(key,null);
            return val;
        },
        data: function () {
            return ijob.storage.me.read();
        },
        clear: function (name) {
            if(name){
                ijob.storage.set(name,null); //只有是待缓存的才会记录下来
            }else{
                var cache = ijob.persistence.get("cache");
                var chat = ijob.storage.get("chat");
                sessionStorage.setItem("param","");
                ijob.storage.set("chat",chat);
                if(cache){
                    for(var key in cache){
                        var obj = cache[key];
                        if(obj.cache==null||obj.cache==false){
                            delete cache[key]; //删除这个缓存
                        }
                    }
                    if(cache){
                        ijob.persistence.set("cache",cache); //只有是待缓存的才会记录下来
                    }
                }
            }

        }
    },
    callbackfunc:{
        set:function(func){
            var obj = ijob.storage.me.read();
            obj.callback = {};
            obj.callback.name = func.name;
            obj.callback.args = func.args;
            obj.callback.value = func.value;
            ijob.storage.me.write(obj);
        },
        get:function(){
            var obj = ijob.storage.me.read();
            if(obj.callback){
                return new Function("\""+obj.callback.args+"\"",obj.callback.name+"("+obj.callback.args+")");
            }else{
                return null;
            }
        },
        call:function () {
            var obj1 = ijob.storage.me.read();
            var f;
            if(obj1.callback){
                f =  new Function(obj1.callback.args,obj1.callback.name+"("+obj1.callback.args+")");
            }
            if(f){
                try{
                    var val = obj1.callback.value;
                    obj1.callback = null;
                    ijob.storage.me.write(obj1);
                    f(val);
                }catch (err){}

            }
        }
    },
    url: {
        me: {
            gotoPage: function (param, div, callback) {
                ijob.url.me.page(true,param, div, callback);
            },
            page:function (usecache,param, div, callback) {
                if (param.path) {
                    if (div) {
                        ijob.url.history.record(param.path);
                        if(window.location.href.indexOf("jianzhipt")>-1 && usecache==true){
                            var html = ijob.database.get("html",param.path);
                            if(html==null){
                                div.load("/ijob/forward?path=" + param.path, callback||function (context) {
                                    setTimeout(function () {
                                        ijob.database.map("html",param.path,context);
                                    },1000);
                                });
                            }else{
                                div.html(html);
                            }
                        }else{
                            div.load("/ijob/forward?path=" + param.path, callback);
                        }
                    } else {
                        /*  sessionStorage.setItem("path",param.path);
                          window.location.href = "/ijob/forward?path=/h5/main";*/
                        window.location.href = "/ijob/forward?path=" + param.path;
                    }
                } else if (param.url) {
                    if (div) {
                        ijob.url.history.record(param.url);
                        div.load(param.url, callback);
                    } else {
                        window.location.href = param.url;
                    }
                }
            },
            freshPage:function (param,div,callback) {
                ijob.url.me.page(false,param, div, callback);
            }
        },
        next: {
            call: function (id) {
                var m = ijob.storage.me.read().next;
                var url = m.url+"/"+id;
                var type  = m.type;
                var func = m.name;
                if (url) {
                    ijob.url.next.clear();
                    $("body").before(ijob.mask);
                    if("json"==type){
                        $.getJSON(url, function (data) {
                            if(func){
                                ijob.callbackfunc.set({args:"data",name:func,value:data});
                            }
                            ijob.goPreAndRefresh();
                        });
                    }else{
                        ijob.gotoPage({"url":url});
                    }
                }
            },
            set: function (url,type,func) {  //json html
                var obj = ijob.storage.me.read();
               /* obj.next = url;
                obj.type = type||'json';*/
                obj.next ={url:url,type:type||'json'};
                if(func){
                    obj.next.name=func.name;
                }
                ijob.storage.me.write(obj);
            },
            clear: function () {
                ijob.url.next.set(null);
            }
        },
        back:{
            replace:function () {
                var obj = ijob.storage.me.read();
                if(obj.back){
                    window.history.replaceState('','', url);
                    ijob.url.back.set("");
                }
            },
            set: function (url) {
                var obj = ijob.storage.me.read();
                obj.back = url;
                ijob.storage.me.write(obj);
            }
        },
        to: function (param) {
            var url = param.url || param.path;
            if (url.indexOf("{") != -1) {
                url = ijob.url.from(url);
                if (param.url && param.url!='' ) {
                    param.url = url;
                } else {
                    param.path = url;
                }
            }
            if (url.indexOf("?") != -1) {
                var paramstr = url.substring(url.indexOf("?") + 1, url.length);
                var paramarr = paramstr.split("&");
                for (var i in paramarr) {
                    var obj = paramarr[i].split("=");
                    ijob.storage.set(obj[0], obj[1]);
                }
                if (param.url) {
                    param.url = url.split("?")[0];
                } else {
                    param.path = url.split("?")[0];
                }
            }
            if (!param.hasOwnProperty("data")) {
                param.data = {};
            }
            ijob.storage.merge(param);
            return param;
        },
        from: function (url) {
            try{
                while (url.indexOf("{") != -1) {
                    var keystr = url.substring(url.indexOf("{") + 1, url.indexOf("}"));
                    var flag = false;
                    if (keystr.indexOf("data") == 0) {
                        flag = true;
                        keystr = keystr.replace("data.", "");
                    }
                    var value = ijob.storage.get(keystr);
                    url = url.replace((flag ? "{data." : "{") + keystr + "}", value);
                }
            }catch (err){
            }

            return url;
        },
        history:{
            urls:[],
            href:'',
            back:function(panel){
                panel.loadPage({path:this.next()})
            },
            record:function (url) {
                this.href = url;
                this.urls.push(url);
            },
            next:function(){
                var url  = this.urls.pop();
                if(!url){
                    throw new Error("没有历史了");
                }
                if(url==this.href){
                    return this.next();
                }else{
                    return url;
                }
            }
        }
    },
    menu:{
        set:function (value) {
            var menu = ijob.persistence.get("menu");
            if(menu==null){
                menu =  {main:'',map:{}};
                ijob.persistence.set("menu",menu);
            }
            menu.main = value.split(":")[0];
            var map = menu.map||{};
            var val = map[menu.main];
            if(val && val.indexOf(value)>-1){
                ijob.persistence.set("menu",menu);
                return val;
            }else{
                map[menu.main] = value;
                menu.map = map;
                ijob.persistence.set("menu",menu);
                return value;
            }

        },
        get:function (key) {
            var menu = ijob.persistence.get("menu");
            if(menu==null){
                menu =  {main:'',map:{}};
                ijob.persistence.set("menu",menu);
            }
            if(menu.map.hasOwnProperty(key||menu.main)){
                return menu.map[key||menu.main]||ijob.menu.set(key);
            }else{
                return null;
            }
        },
        parse:function(key){
            var menu = ijob.persistence.get("menu");
            if(menu==null){
                ijob.persistence.set("menu",{main:'',map:{}});
            }
            if(key=="qz"){
                var findjob = ijob.menu.get("findJob");
                if(findjob==null)ijob.menu.set("findJob:1");
                return ijob.menu.get("findJob");
            }else if(key=="broker") {
                var preson = ijob.menu.get("personal");
                if (preson == null) ijob.menu.set("personal", "personal");
                return ijob.menu.get("personal");
            }else{
                var m  = ijob.menu.get(key);
                if(m==null){
                    return ijob.menu.set("findJob");
                }else{
                    return m;
                }
            }
        }
    },
    location:{
        set:function(latlng){
            var localtion = {
                lng: latlng.lng,
                lat: latlng.lat,
                addr: latlng.addr,
                cityID: latlng.cityID||site.region.id(latlng.district || latlng.city),
                cityname: latlng.district || latlng.city,
                district:latlng.district,
                city:latlng.city
            };
            ijob.persistence.set("mylocaltion",localtion);
            localStorage.setItem("mylocaltion",JSON.stringify(localtion));
        },
        set2:function(loc){
            loc.city = loc.cityName||loc.districtName;
            ijob.persistence.set("mylocaltion",loc);
            localStorage.setItem("mylocaltion",JSON.stringify(loc));
        },
        set3:function(loc){
            var localtion = {
                lng:loc.result.location.lng,
                lat:loc.result.location.lat,
                cityID:'',
                cityName:loc.result.address_component.city,
                addr:loc.result.formatted_addresses.recommend,
                districtID:"",
                districtName:loc.result.address_component.district,
                city:loc.result.address_component.city
            };
            var curr = ijob.location.get();
            ijob.location.set2(localtion);
            if(curr==null ||  curr.city==localtion.cityName){ //如果是同一个市，才允许精确定位
                $.getJSON("/api/CityController/add",localtion,function(result){
                    localtion.cityID = result.data.mylocaltion.cityID;
                    localtion.districtID = result.data.mylocaltion.districtID;
                    ijob.location.set2(localtion);
                });
            }
        },
        get:function(){
            return ijob.persistence.get("mylocaltion");
            //return JSON.parse(localStorage.getItem("mylocaltion")||"{}");
        },
        getLocal:function(){
            return JSON.parse(localStorage.getItem("mylocaltion")||"{}");
        }
    },
    gotoPage: function (param, event) {
        if (event) {
            event.preventDefault();
        }
        ijob.url.me.gotoPage(ijob.url.to(param));
    },
    freshPage: function (param, event) {
        if (event) {
            event.preventDefault();
        }
        ijob.url.me.freshPage(ijob.url.to(param));
    },
    loadPage:function(param,event){
        $("#warp").loadPage(param);
    },
    delayGotoPage: function (param, msg,time) {
        time = time || 2;
        var shows  = msg||(time + dict.IjobDict.JumpDelay);
        mui.toast(shows);
        var intervalnum = setInterval(function () {
            --time;
            shows  = msg||(time + enums.IjobDict.JumpDelay);
            mui.toast(shows);
            if (time <= 0) {
                clearInterval(intervalnum);
                ijob.gotoPage(param);
            }
        }, 1000);
    },
    back:function(){
        window.history.go(-1);
    },
    reback:function(msg){
        mui.toast(msg || dict.IjobDict.OperOk);
        setTimeout(function () {
            // self.location=document.referrer;
            window.history.go(-1);
        }, 1000);
    },
    rebackpage:function(msg,time,delay){
        delay = delay||1000;
        mui.toast(msg || dict.IjobDict.OperOk);
        setTimeout(function () {
            window.history.go(time||-1);
        }, delay);
    },

    parseFromFormObject:function(obj,keys){
        for(i in keys){
            var key = keys[i];
            obj[key] = [];
            for(objkey in obj){
                var reg  = new RegExp("^"+ key + "\\d$");
                if(reg.test(objkey)){
                    obj[key].push(obj[objkey]);
                    delete obj[objkey];
                }
            }
        }
        return obj;

    },
    showProcess:function(id,arr,title){
        var canvas=document.getElementById(id);
        canvas.width = 750;
        canvas.height = 200;
        var ctx=canvas.getContext('2d');
        ctx.scale(2,2);
        var width = $("#"+id).width()/2;
        var height = $("#"+id).height()/2;
        var k = 1.6;
        var top = 10;
        if(title){
            ctx.fillStyle="#000";
            ctx.textAlign="left";
            ctx.font  = "12px Arial";
            ctx.fillText(title,10,top+10);
        }
        var r = 12;
        ctx.lineWidth=5;
        for(var i=1;i<arr.length;i++){
            var obj = arr[i];
            if(obj.state==1)
                ctx.strokeStyle="#108EE9";
            else
                ctx.strokeStyle="#999";
            ctx.beginPath();
            ctx.moveTo(width*0.1+width*0.8/2*(i-1),height/5*k+top);
            ctx.lineTo(width*0.1+width*0.8/2*(i),height/5*k+top);
            ctx.stroke();
        }
        for(var  i  in  arr){
            var obj = arr[i];
            if(obj.state==1)
                ctx.fillStyle="#108EE9";
            else
                ctx.fillStyle="#999";
            ctx.beginPath();
            ctx.arc(width*0.1+width*0.8/2*i,height*1/5*k+top,r,0*Math.PI,2*Math.PI);
            ctx.fill();
            ctx.textAlign="center";
            ctx.font = "10px Arial";
            ctx.fillText(obj.name,width*0.1+width*0.8/2*i,height*2/5*k+top);
            if(obj.state==1)ctx.fillText(obj.time,width*0.1+width*0.8/2*i,height/2*k+top);
        }

    },
    showPoint:function(workPlace){
        var center = workPlace.latitude+","+workPlace.longitude;
        var addr = workPlace.detailedAddress;
        window.location.href='http://apis.map.qq.com/tools/poimarker?type=0&marker=coord:'+center+';title:'+dict.IjobDict.WorkAddr+';addr:'+addr+'&key=OB4BZ-D4W3U-B7VVO-4PJWW-6TKDJ-WPB77&referer=myapp';
    },
    require:function(file,callback){
        var script = document.getElementsByTagName("script")[0];
        var newjs = document.createElement("script");

        newjs.onload = function(){
            callback();
        };

        newjs.src = file;
        script.parentNode.insertBefore(newjs,script);
    }

};


//ijob的一些插件实现

try{
    (function ($) {
        //优化多选框  超过10个隐藏起来
        $.fn.showSelect = function () {

            var _this = $(this);
            if (_this.get(0).tagName != "UL") {
                _this = _this.find("ul:first");
            }

            //监听点击事件，如果遇到全部，则选择全部，否则取消全部
            _this.on('click', 'li', function () {
                $(this).toggleClass('active');
                if ($(this).data("id") == "") {
                    if ($(this).hasClass("active")) {
                        _this.find("li").addClass("active");
                    } else {
                        _this.find("li").removeClass("active");
                    }
                } else {
                    if (!$(this).hasClass("active")) {
                        _this.find("li").eq(0).removeClass("active");
                    }
                    var num  = 0;
                    _this.children(":not(':first,:last')").each(function(i,item){
                        if($(this).hasClass("active"))num++;
                    });
                    if(num==(_this.find("li").length-2)){
                        _this.find("li").eq(0).addClass("active");
                    }
                }
            });

            var len = _this.find("li").length;
            if (len > 9) {
                _this.find("li:nth-child(9)").nextAll().each(function (i, item) {
                    $(item).hide();
                });
                _this.on('showAllEvent', function () {
                    _this.find("li:nth-child(9)").nextAll().each(function (i, item) {
                        $(item).show();
                    });
                });
                _this.append("<li style='color: #108EE9;'>"+dict.IjobDict.More+"</li>");
                _this.on('click','li:last',function(){
                    var text = $(this).text();
                    if(text.indexOf(dict.IjobDict.More)==0){
                        $(this).remove();
                        _this.find("li:nth-child(9)").nextAll().each(function (i, item) {
                            $(item).show();
                        });
                        _this.append("<li style='color: #108EE9;'>"+dict.IjobDict.Fold+"</li>");
                    }else{
                        $(this).remove();
                        _this.find("li:nth-child(9)").nextAll().each(function (i, item) {
                            $(item).hide();
                        });
                        _this.append("<li style='color: #108EE9;'>"+dict.IjobDict.More+"</li>");
                    }
                });
            }


        }
        $.fn.serializeObjectJson = function () {
            var serializeObj = {};
            var currentObj = {};
            var seg = ".";
            $(this.serializeArray()).each(function () {
                var thisName = this.name;
                currentObj = serializeObj;//每次循环都定位到最开始位置
                while (thisName.indexOf(seg) != -1) { //如果有点 则需要分解这个对象
                    var key = thisName.substring(0, thisName.indexOf(seg)); //获取这个key
                    if (!currentObj.hasOwnProperty(key)) {  //然后判断当前对象中是否有这个key ，如果没有这个key 则加上这个属性
                        currentObj[key] = {};
                    }
                    currentObj = currentObj[key];  //赋值给当前对象
                    thisName = thisName.substr(thisName.indexOf(seg) + 1); //当前的名字减少前面那节
                }
                currentObj[thisName] = this.value;
            });
            return serializeObj;
        };

        $.fn.appendData = function (config,ijobRefresh,beforeCallback) {
            var temp = $(this);
            // temp.before(ijob.mask);
            var result;
            var url = temp.data("url");
            var res = temp.data("res");
            // url = ijob.matchParamWithUrl(url);
            url = ijob.url.from(url);
            return new Promise(function (callback) {
              /*  setTimeout(function () {
                    callback(config, beforeCallback);
                }, 1);*/
                callback(config, beforeCallback);
            }).then(function (config, beforeCallback) {
                //如果第一个参数是方法，则赋给beforeCallback
                if (typeof config == 'function') {
                    beforeCallback = config;
                    config = {};
                }
                temp.hide();
                //提交方式 ，默认为 Post提交
                var submitType = temp.data("type") || "POST";
                // temp.nextAll().remove();
                var obj = $.extend({"pageSize": "10", "currentPage": "1"}, config);
                var param = {
                    url: url,
                    type: submitType,
                    dataType: 'json',
                    async: false,
                    success: function (data) {
                        if(data.data){
                            var html = template(temp.attr("id"), data.data, beforeCallback);
                            temp.before(html);
                        }else{
                            // temp.after("<p style='text-align: center;margin-top: 6rem;'>没有查询到内容 <a href='#' onclick='ijob.back()'>点击返回</a></p>");
                        }
                        result = data;

                        if(res && res.toUpperCase()=="CACHE"){
                            var cachedata = ijob.persistence.get("cache."+url)||{data:{list:[]}};
                            cachedata.param = obj;
                            if(cachedata.data.list.length<100){
                                cachedata.data.list=cachedata.data.list.concat(data.data.list);
                                ijob.persistence.set("cache."+url,cachedata);
                            }

                        }
                    },
                    error: function (e) {
                        //mui.toast("网络异常");
                    },
                    complete: function () {

                    }
                };
                if (submitType == "POST") {
                    param = $.extend(param, {
                        contentType: 'application/json',
                        data: JSON.stringify(obj)
                    })
                }
                if (res && res.toUpperCase() == "LOCAL") {  //取本地
                    var data = {
                        data: {
                            list: []
                        }
                    };
                    data.data.list.push(ijob.storage.get(url));
                    var html = template(temp.attr("id"), data.data, beforeCallback);
                    temp.after(html);
                    result = data;
                }else {  //取网络或者缓存
                    if(res && res.toUpperCase()=="CACHE"){  //如果是可以使用緩存的話
                        var cachedata = ijob.persistence.get("cache."+url);
                        if( cachedata && cachedata.cache == true ){ //如果是有缓存，并且缓存的开关为true
                            if(cachedata.data.list){
                                var html = template(temp.attr("id"), cachedata.data, beforeCallback);
                                temp.before(html);
                            }else{
                                // temp.after("<p style='text-align: center;margin-top: 6rem;'>没有查询到内容 <a href='#' onclick='ijob.back()'>点击返回</a></p>");
                            }
                            result = cachedata;
                        }else{
                            $.ajax(param);
                        }
                    }else{
                        $.ajax(param);
                    }
                }
                // temp.parent().find(".loading").remove();
                return result;
            }).then(function(result){
                if(result)
                    ijobRefresh.endPullupToRefresh(result.nextPage>result.totalPage);
                else{
                    ijobRefresh.endPullupToRefresh(true);
                }
                return result||{nextPage:0};
            });
        };


        $.fn.loadData = function (config, beforeCallback,msg) {
            var temp = $(this);
            temp.before(ijob.mask);
            var result;
            var url = temp.data("url");
            var res = temp.data("res");
            // url = ijob.matchParamWithUrl(url);
            url = ijob.url.from(url);
            return new Promise(function (callback) {
                /*setTimeout(function () {
                    callback(config, beforeCallback,msg);
                }, 1);*/
                callback(config, beforeCallback,msg);

            }).then(function (config, beforeCallback,msg) {
                //如果第一个参数是方法，则赋给beforeCallback
                if (typeof config == 'function') {
                    beforeCallback = config;
                    config = {};
                }
                if(typeof config == "string"){
                    msg= config;
                    config = {};
                }
                temp.hide();
                //提交方式 ，默认为 Post提交
                var submitType = temp.data("type") || "POST";
                temp.nextAll().remove();
                var obj = $.extend({"pageSize": "10", "currentPage": "1"}, config);
                var param = {
                    url: url,
                    type: submitType,
                    dataType: 'json',
                    async: false,
                    cache:false,
                    success: function (data) {
                        if(data.data && data.data.list && data.data.list.length){
                            var html = template(temp.attr("id"), data.data, beforeCallback);
                            temp.after(html);
                        }else{
                            temp.after("<div class='nodata'  class=\"hd_result\">\n" +
                                "            <div class=\"icon\">\n" +
                                "                <span style='color: #999;font-size: 100px;line-height: 1;' class=\"iconfont icon-jiarugouwuche00-copy-copy-copy\"></span>\n" +
                                "            </div>\n" +
                                "            <p  class=\"tips\">"+(msg||dict.IjobDict.NoDataMsg)+"</p>\n" +
                                "        </div>");
                            //temp.after("<p class='nodata' style='text-align: center;margin-top: 2.5rem;'>"+(msg||dict.IjobDict.NoDataMsg)+"</p>");
                        }

                        if(res && res.toUpperCase()=="CACHE"){
                            var cachedata = ijob.persistence.get("cache."+url)||{data:{list:[]}};
                            cachedata.param = obj;
                            if(cachedata.data.list.length<100){  //最多100个
                                cachedata.data.list=cachedata.data.list.concat(data.data.list);
                                cachedata.cache = true;
                                ijob.persistence.set("cache."+url,cachedata);
                            }
                        }
                        result = data;
                    },
                    error: function (e) {
                        //mui.toast("网络异常");
                    },
                    complete: function () {

                    }
                };
                if (submitType == "POST") {
                    param = $.extend(param, {
                        contentType: 'application/json',
                        data: JSON.stringify(obj)
                    })
                }
                if (res && res.toUpperCase() == "LOCAL") {
                    var data = {
                        data: {
                            list: []
                        }
                    };
                    data.data.list.push(ijob.storage.get(url));
                    var html = template(temp.attr("id"), data.data, beforeCallback);
                    temp.after(html);
                    result = data;
                }else {  //取网络或者缓存
                    if(res && res.toUpperCase()=="CACHE"){  //如果是可以使用緩存的話
                        var cachedata = ijob.persistence.get("cache."+url);
                        if( cachedata ){ //如果是有缓存，并且缓存的开关为true
                            if(cachedata.data.list){
                                var html = template(temp.attr("id"), cachedata.data, beforeCallback);
                                temp.before(html);
                            }else{
                                // temp.after("<p style='text-align: center;margin-top: 6rem;'>没有查询到内容 <a href='#' onclick='ijob.back()'>点击返回</a></p>");
                            }
                            result = cachedata;
                        }else{
                            $.ajax(param);
                        }
                    }else{
                        $.ajax(param);
                    }
                }
                temp.prevAll(".loading").remove();
                return result;
            });
        };

        $.fn.btPost = function (data, success, error) {
            var _this = $(this) ;
            var  url ;
            //如果是对象 则转出json字符串
            if (typeof data == "object") {
                data = JSON.stringify(data);
            }else if(typeof data == "string"){
                if(data.indexOf("/")==0){
                    url = data;
                    data = success;
                    success = error;
                    if (typeof data == "object") {
                        data = JSON.stringify(data);
                    }
                }
            }
            _this.attr("disabled", "disabled");
            $("body").before(ijob.mask);
            $.ajax({
                url: url||ijob.url.from($(this).data("url")),
                contentType: 'application/json',
                type: 'POST',
                data: data,
                dataType: 'json',
                success: function (data) {
                    if (success) {
                        success(data);
                    } else {
                        mui.toast(data.msg);
                        setTimeout(function () {
                            window.location.reload();
                        }, 1500);
                    }
                },
                error: function (e) {
                    //mui.toast("网络异常");
                },
                complete: function () {
                    _this.removeAttr("disabled");
                    $("body").prev(".loading").remove();

                }
            })
        };

        $.fn.loadPage = function (param, callback) {
            var _this = $(this);
            ijob.url.me.gotoPage(ijob.url.to(param), _this, callback);
        };

        $.fn.freshPage = function (param, callback) {
            var _this = $(this);
            ijob.url.me.freshPage(ijob.url.to(param), _this, callback);
        };

        // 下拉刷新
        $.fn.pulldownRefresh = function () {
            mui.init({
                pullRefresh: {
                    container: "#refreshContainer",//下拉刷新容器标识，querySelector能定位的css选择器均可，比如：id、.class等
                    down: {
                        style: 'circle',//必选，下拉刷新样式，目前支持原生5+ ‘circle’ 样式
                        color: '#2BD009', //可选，默认“#2BD009” 下拉刷新控件颜色
                        height: '50px',//可选,默认50px.下拉刷新控件的高度,
                        range: '100px', //可选 默认100px,控件可下拉拖拽的范围
                        offset: '0px', //可选 默认0px,下拉刷新控件的起始位置
                        auto: true,//可选,默认false.首次加载自动上拉刷新一次
                        callback: pulldown //必选，刷新函数，根据具体业务来编写，比如通过ajax从服务器获取新数据；
                    }
                }
            });

            // 下拉刷新具体业务实现

            function pulldownRefresh() {
                setTimeout(function () {
                    var table = document.body.querySelector('.mui-table-view');
                    var cells = document.body.querySelectorAll('.mui-table-view-cell');
                    for (var i = cells.length, len = i + 3; i < len; i++) {
                        var li = document.createElement('li');
                        li.className = 'mui-table-view-cell';
                        li.innerHTML = '<a class="mui-navigate-right">Item ' + (i + 1) + '</a>';
                        //下拉刷新，新纪录插到最前面；
                        table.insertBefore(li, table.firstChild);
                    }
                    mui('#pullrefresh').pullRefresh().endPulldownToRefresh(); //refresh completed
                }, 1000);
            };

        };



    })(jQuery);
}catch(e){
    location.reload();
}




