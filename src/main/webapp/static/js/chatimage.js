/**
 * Created by zhouchuang on 2019/1/1.
 */
var chatImage={

    selectImg:function () {
        form = new FormData();//通过HTML表单创建FormData对象
        var files = document.getElementById("imageHandler").files;
        var type = $("#imageHandler").data("type");
        if(files.length == 0){
            return;
        }
        var file = files[0];
        //video/mp4 image/jpg
        //把上传的图片显示出来
        if(type=="image"){
            var reader = new FileReader();
            // 将文件以Data URL形式进行读入页面
            reader.readAsBinaryString(file);
            reader.onload = function(e) {
                chatImage.compress(file, {quality: 0.5}, function (imgBase64) {
                    var compfile = chatImage.convertBase64UrlToBlob(imgBase64);
                    form.append('file', compfile, new Date().getTime() + ".jpg");
                    form.append("type", "9");
                    form.append("path", "iJob/images/chat");
                    $.ajax({
                        url: 'http://'+chatIP+':8091/fileUpload/uploadChatImage',
                        type: "post",
                        data: form,
                        processData: false,
                        contentType: false,
                        success: function (data) {
                            mui.toast(dict.Photo.UploadOver);
                            if (data.data) {
                                $("#imageHandler").trigger("ImageUploadOverEvent", [data.data, type]);
                            }
                        },
                        beforeSend: function () {
                            mui.toast("Uploading...");
                        },
                        complete: function () {
                            //mui.toast("Over...");
                        }
                    });
                });
            }
        }else if(type=="video"){
            if(file.size>2*1024 * 1024){
                mui.toast(dict.Photo.SizeLimit.replace("@{size}","2"));
            }else{
                form.append("file", file);//将文件添加到表单数据中
                form.append("type","10");
                form.append("path","iJob/video/chat");
                /*var xhr = new  chatImage.getHttpObj();
                xhr.upload.addEventListener("progress", chatImage.uploadProgress, false);//监听上传进度
                xhr.addEventListener("load", chatImage.uploadComplete, false);
                xhr.addEventListener("error", chatImage.uploadFailed, false);
                xhr.open("POST", "http://localhost:8091/fileUpload/uploadChatImage",true);
                xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest"); //请求头部，需要服务端同时设置
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;");//缺少这句，后台无法获取参数
                xhr.send(form);*/
                $.ajax({
                    url: 'http://'+chatIP+':8091/fileUpload/uploadChatImage',
                    type: "post",
                    data: form,
                    processData: false,
                    contentType: false,
                    /*xhr: function() { //获取ajaxSettings中的xhr对象，为它的upload属性绑定progress事件的处理函数
                        myXhr = $.ajaxSettings.xhr();
                        if (myXhr.upload) { //检查upload属性是否存在
                            myXhr.upload.addEventListener('progress', chatImage.uploadProgress, false);
                        }
                    },*/
                    success: function (data) {
                        mui.toast(dict.Photo.UploadOver);
                        if(data.data){
                            $("#imageHandler").trigger("ImageUploadOverEvent", [data.data, type]);
                        }
                    },
                    beforeSend: function () {
                        mui.toast("Uploading...");
                    },
                    complete: function (err) {
                        //mui.toast("Over...");
                    }
                });
            }
        }
    },


    getHttpObj:function() {
        if(typeof XMLHttpRequest != "undefined"){
            return new XMLHttpRequest();
        }else if(typeof ActiveXObject != "undefined"){
            if(typeof arguments.callee.activeXString != "string"){
                var versions = ["MSXML2.XMLHttp.6.0", "MSXML2.XMLHttp.3.0", "MSXML2.XMLHttp"];

                for(var i=0, len=versions.length;i < len; i++){
                    try{
                        var xhr = new ActiveXObject(versions[i]);
                        arguments.callee.activeXString = versions[i];
                        return xhr;
                    }catch(ex){
                        //跳过
                    }
                }
            }
            return new ActiveXObject(arguments.callee.activeXString);
        }else{
            throw new Error("NO XHR object available");
        }
    },
    uploadProgress:function(evt) {
        if (evt.lengthComputable) {
            var percentComplete = Math.round(evt.loaded * 100 / evt.total);
            mui.toast(percentComplete+"%");
        }
    },
    uploadComplete:function (evt) {
        var data = JSON.parse(evt.target.responseText);
        if(data.data){
            $("#imageHandler").trigger("ImageUploadOverEvent", [data.data, "audio"]);
        }
    },
    convertBase64UrlToBlob:function (dataURI){

        var byteString = atob(dataURI.split(',')[1]);
        var mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0];
        var ab = new ArrayBuffer(byteString.length);
        var ia = new Uint8Array(ab);
        for (var i = 0; i < byteString.length; i++) {
            ia[i] = byteString.charCodeAt(i);
        }
        return new Blob([ab], {type: mimeString});
    },
    uploadFailed:function (err) {
        console.log(err);
    },
    compress:function (fileObj,obj, callback) {

        var ready=new FileReader();
        /*开始读取指定的Blob对象或File对象中的内容. 当读取操作完成时,readyState属性的值会成为DONE,如果设置了onloadend事件处理程序,则调用之.同时,result属性中将包含一个data: URL格式的字符串以表示所读取文件的内容.*/
        ready.readAsDataURL(fileObj);
        ready.onload=function(){
            var re=this.result;
            var img = new Image();
            img.src = re;
            img.onload = function(){
                var that = this;
                // 默认按比例压缩
                var w = that.width,
                    h = that.height,
                    scale = w / h;
                w = obj.width || w;
                h = obj.height || (w / scale);
                var quality = 0.7;  // 默认图片质量为0.7
                //生成canvas
                var canvas = document.createElement('canvas');
                var ctx = canvas.getContext('2d');
                // 创建属性节点
                var anw = document.createAttribute("width");
                anw.nodeValue = 667;
                var anh = document.createAttribute("height");
                anh.nodeValue = 667/scale;
                canvas.setAttributeNode(anw);
                canvas.setAttributeNode(anh);
                ctx.drawImage(that, 0, 0, 667, 667/scale);

                // 图像质量
                if(obj.quality && obj.quality <= 1 && obj.quality > 0){
                    quality = obj.quality;
                }
                // quality值越小，所绘制出的图像越模糊
                var base64 = canvas.toDataURL('image/jpeg', quality);
                // 回调函数返回base64的值
                callback(base64);
            }
        }
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
}

