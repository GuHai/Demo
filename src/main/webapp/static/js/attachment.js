/**
 * Created by zhouchuang on 2018/2/12.
 */

document.write("<style>.close-upimg {\n" +
    "    display: none;\n" +
    "    position: absolute;\n" +
    "    top: 6px;\n" +
    "    right: 8px;\n" +
    "    z-index: 10;\n" +
    "}\n" +
    ".up-span {\n" +
    "    display: none;\n" +
    "    width: 100%;\n" +
    "    height: 100%;\n" +
    "    position: absolute;\n" +
    "    top: 0px;\n" +
    "    left: 0px;\n" +
    "    z-index: 9;\n" +
    "    background: rgba(0, 0, 0, 0.5);\n" +
    "}</style>")
var attachment  = {
    mask:"<div class=\"loading\">\n" +
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
    form:{},
    Type:{
        'Head':'1','Certificate':'2','Photos':'3'
    },
    Path:{
        'Head':'iJob/images/head','Certificate':'iJob/images/certi','Photos':'iJob/images/photos'
    },
    Able:["upload","delete","change"],
    clickhandler:function(event){
        event.preventDefault();
        $(event.target).next().click();
    },
    deleteImage:function(event){
        $(event.target).parent().parent().trigger('deleteEvent');
        $(event.target).parent().remove();

    },


    compress:function(fileObj,obj,type, callback) {

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


                if(type=="Certificate"){
                    ctx.font="60px arial,sans-serif";
                    ctx.fillStyle = "rgba(102,102,102,0.6)";
                    ctx.fillText(dict.Photo.Mark,100,230);
                }

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
    selectImage:function(name,refid,type,editable){
        form = new FormData();//通过HTML表单创建FormData对象
        var files = document.getElementById('pic_'+name).files;
        if(files.length == 0){
            return;
        }
        var file = files[0];
        //把上传的图片显示出来
        var reader = new FileReader();
        // 将文件以Data URL形式进行读入页面
        reader.readAsBinaryString(file);
        reader.onload = function(e){
            var data = e.target.result;
            var src = "data:" + file.type + ";base64," + window.btoa( data);
            //result.innerHTML = '<img src ="'+src+'"/>';
            $("[data-name='"+name+"']:first").attr('src',src);
            $("body").before(attachment.mask);

            if($(".photo-mask").length){
                $("[data-name='"+name+"']:first").on('cutOverEvent',function(event,_cropCanvas){
                    var srcbase64 = _cropCanvas.toDataURL("image/png");
                    $(this).attr("src",srcbase64);
                    $(this).height($(this).width());
                    file = attachment.convertBase64UrlToBlob(srcbase64);
                    form.append('file',file,new Date().getTime()+".png");
                    attachment.uploadFileBatch(name,refid,type,editable);
                });

                $(".photo-mask").css("display","flex");
                $("#cutimg").trigger('loadCompletionEvent',["[data-name='"+name+"']:first"]);
                $("#cutimg").attr("src",src);


            }else{

                attachment.compress(file,{quality: 0.5},type,function(imgBase64){
                    $("[data-name='"+name+"']:first").attr('src',imgBase64);
                    var compfile = attachment.convertBase64UrlToBlob(imgBase64);
                    form.append('file',compfile,new Date().getTime()+".png");
                    attachment.uploadFileBatch(name,refid,type,editable);
                });
            }
        }


        // document.getElementById("submitBtn").removeAttribute("hidden");
        //这里需要阻止一下，弹出遮罩层
        /*if($(".photo-mask")){
            $(".photo-mask").css("display","flex");
            $("#bigimg").attr("src",$("[data-name='"+name+"']:first").attr("src"));
        }else{
            attachment.uploadFileBatch(name,refid,type);
        }*/

    },


    uploadFileBatch:function(name,refid,type,editable){
        attachment.uploadFile(name,refid,type);
        //如果是可编辑 ，则可以让删除
        if(editable=="true"){
            $("[data-name='"+name+"']:first").unbind();
            $("[data-name='"+name+"']").parent().on('click',function(){
                var displayCss = "block";
                if($(this).find(".up-span:first").css("display")=="block"){
                    displayCss  = "none";
                }
                $(this).find(".up-span:first").css("display",displayCss);
                $(this).find(".close-upimg:first").css("display",displayCss);
            });
        }
    },



    uploadFile:function(name,refid,type){
        $("[data-name='"+name+"']:first").parent().find("div[name='resultDiv']").remove();
        if(type=="Head"){
            form.append("type",attachment.Type.Head);
            form.append("path",attachment.Path.Head)
        }else if(type=="Certificate"){
            form.append("type",attachment.Type.Certificate);
            form.append("path",attachment.Path.Certificate)
        }else if(type=="Photos"){
            form.append("type",attachment.Type.Photos);
            form.append("path",attachment.Path.Photos)
        }
        form.append("id",refid);
        $.ajax({
            url: '/ijob/fileUpload/uploadImage',
            type: "post",
            data: form,
            processData: false,
            contentType: false,
            success: function (data) {
                mui.toast(dict.Photo.UploadOver);
                var temp = "<input name='${name}' value='${value}' type='hidden'  />";
                var attaHtml  = "";
                for( key in data){
                    attaHtml  += temp.replace("${name}",name+"."+key).replace("${value}",data[key]);
                }
                $("input[id='pic_"+name+"']").after("<div name='resultDiv'>"+attaHtml+"</div>");
            },
            beforeSend: function(){
                $("[data-name='"+name+"']:first").trigger('uploadStartEvent');
            },
            complete: function(){
                $("[data-name='"+name+"']:first").trigger('uploadCompletionEvent');
                $("body").prev().remove();
            }
        });
    }
};


(function($){
    $.fn.attachment  = function(){
        var _this = $(this);
        if(_this.hasClass("attachment")){
            render(0,_this);
        }else{
            _this.find(".attachment").each(function(i,item){
                render(i,item);
            });
        }
        function render(i,item){
            if($(item).get(0).tagName == 'IMG'){
                var name = $(item).data("name");
                var refid = $(item).data("id");
                var type = $(item).data("type");
                var capture=$(item).data("capture");
                var editable = $(item).data("editable");
                var cut = $(item).data("cut")||false;
                $(item).on('click',attachment.clickhandler);//绑定事件 <button onclick = 'uploadFile()' hidden='hidden' id='submitBtn'>提交</button>
                if(editable)$(item).before("<span class=\"up-span\"></span><img class=\"close-upimg\" onclick='attachment.deleteImage(event)' src=\"/static/images/a7.png\">");
                if(capture==true){
                    $(item).after("<input id='pic_"+name+"' type='file' name = 'pic' accept = 'image/*' capture='camera' onchange = \"attachment.selectImage(\'"+name+"\',\'"+refid+"\',\'"+type+"\',\'"+editable+"\')\" hidden='hidden'/>");
                }else{
                    $(item).after("<input id='pic_"+name+"' type='file' name = 'pic' accept = 'image/*' onchange = \"attachment.selectImage(\'"+name+"\',\'"+refid+"\',\'"+type+"\',\'"+editable+"\')\" hidden='hidden'/>");
                }

                if(cut==true){
                    new CutPhoto();
                }

            }else if($(item).get(0).tagName == 'INPUT'){

            }
        }
    }
})(jQuery);

    /*$(".attachment").each(function(i,item){
        if($(item).get(0).tagName == 'IMG'){
            var name = $(item).data("name");
            var refid = $(item).data("id");
            var type = $(item).data("type");
            $(item).on('click',attachment.clickhandler);//绑定事件 <button onclick = 'uploadFile()' hidden='hidden' id='submitBtn'>提交</button>
            $(item).after("<input id='pic_"+name+"' type='file' name = 'pic' accept = 'image/!*' onchange = \"attachment.selectImage(\'"+name+"\',\'"+refid+"\',\'"+type+"\')\" hidden='hidden'/>");
        }else if($(item).get(0).tagName == 'INPUT'){

        }
    });*/

