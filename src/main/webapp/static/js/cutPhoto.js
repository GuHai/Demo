/**
 * Created by zhouchuang on 2018/6/30.
 */
(function CutPhoto(win,$) {
    var CutPhoto = function () {
        var _self = this;
        $("body").append("<div class='photo-mask' style='display: none;" +
            "               flex-direction: column;" +
            "            align-items:center;position: fixed;top: 0;left: 0; z-index: 99; width: 100%;height: 100%;background: rgba(0, 0, 0, .5);'>" +
            "  <div style='    position: absolute;width: 100%;height: 100%;background: #eeeeee;display: flex;justify-content: center; align-items: center;'>"+
            "        <div id='overlayInner'style='  width: 400px; height: 400px; border-right: 50px; border-left: 50px;  border-style:solid; border-color:black; opacity: 0.8;z-index: 100;'></div>" +
            "        <img  id='cutimg' width='100%' style='    border: none;outline: none;position: absolute;' />" +
            "  </div>" +
            "  <div id='imgpanel' style='width: 100%;display: flex;justify-content: center; align-items: center;    margin-bottom: 16px;z-index: 101;'>" +
            "     <div id='btns' style='display: flex; justify-content: center; align-items: center;width: 100%;'>" +
            /*
                        "       <button id='leftbtn'>左转</button> <button id='upimgbtn'>"+dict.Photo.Add+"</button> <button id='downimgbtn'>"+dict.Photo.Reduce+"</button><button id='cutimgbtn'>"+dict.Photo.Cut+"</button> <button id='rightbtn'>右转</button> " +
            */
            /* "<div style='width: 100%;height:50px ;background: #eeeeee;z-index: 102 '></div>    " +*/
            // "<button id='cutimgbtn' style='dis position: fixed; right: 5%;top:10px; width: 20%;height: 30px; background: #eeeeee ; z-index: 103; border-radius: 5px ;' >"+dict.Photo.Cut+"</button> " +
            "<div id='do_finish' style='position: fixed; bottom: 50px;right: 15%;color: #ffffff;font-size: 17px;'>完成</div>" +
            "<div id='do_cancle' style='position: fixed; bottom: 50px;left: 15%;color: #ffffff;font-size: 17px;'>取消</div>" +
            "</div>" +
            "  </div>"+
            "  </div>");

        this.resizeValue=0 ;
        this.avatorImg ;
        this.targetImg;
        this.rotateValue=0;
        this.whRate = 1;
        this.initLength  = {
            width:0,
            height:0
        };
        this.realLength = {
            width:0,
            height:0
        };
        this.currLength = {
            width:0,
            height:0
        };
        this.init=function(){

            $("#cutimg").on('loadCompletionEvent',_self.readImg);
            $("#cutimg").on('load',_self.readSize);
            $("#do_finish").on('click',_self.cutImg);
            $("#do_cancle").on('click',_self.do_cancle);

        };

        this.do_cancle=function () {
            window.location.href="/ijob/UserController/h5/myHead";

        }


        //读取图片尺寸
        this.readSize = function () {
            var natural = document.getElementById("cutimg");
            if(window.naturalWidth && window.naturalHeight) {
                var  naturalW  = natural.naturalWidth;
            } else {   // 兼容IE8及以下版本
                var image = new Image();
                image.src = natural.src;
                var  w = image.width;
                var  h = image.height;
                var mw = document.documentElement.clientWidth || document.body.clientWidth;
                var mh = document.documentElement.clientHeight || document.body.clientHeight;
                _self.initLength  = {
                    width:_self.avatorImg.offsetWidth,
                    height:_self.avatorImg.offsetHeight
                }
                _self.realLength  = {
                    width:w,
                    height:h
                }
                _self.currLength  = {
                    width:_self.avatorImg.offsetWidth,
                    height:_self.avatorImg.offsetHeight
                }
                _self.avatorImg.style.width= _self.initLength.width;
                _self.avatorImg.style.height= _self.initLength.height;
                _self.whRate = w/h;
                var pw = 50;
                var cw = mw-pw*2;
                $("#btns").css("display","block");

                var picture = document.body;
                var px ,py;
                var start = [  ];
                var end = [];
                var isTouch = false;
                picture.addEventListener("touchstart",function(e){
                    var p,f1,f2;
                    if(e.touches.length>=2){
                        start = e.touches; //得到第一组两个点
                    }


                    //由于触屏的坐标是个数组，所以取出这个数组的第一个元素
                    e=e.touches[0];
                    //保存picture和开始触屏时的坐标差
                    var point={
                        x:_self.avatorImg.offsetLeft-e.clientX,
                        y:_self.avatorImg.offsetTop-e.clientY
                    };






                    //添加触屏移动事件
                    document.addEventListener("touchmove",f2=function(e){
                        //阻止默认事件
                        e.preventDefault();
                        if (e.touches.length == 1 ) { //移動
                            //获取保触屏坐标的对象
                            var t=e.touches[0];
                            //把picture移动到初始计算的位置加上当前触屏位置
                            px = point.x+t.clientX;
                            py = point.y+t.clientY;
                            _self.avatorImg.style.left=px+"px";
                            _self.avatorImg.style.top=py+"px";
                        }else  if (e.touches.length >= 2 ) { //縮放
                            end = e.touches;
                            //得到第二组两个点
                            //var now = e.touches;
                            //得到缩放比例， getDistance 是勾股定理的一个方法
                            //var scale = (getDistance(now[0], now[1]) / getDistance(start[0], start[1]));
                            // 对缩放 比例 取整
                            /*   e.scale = scale.toFixed(2);
                               // 执行目标元素的缩放操作
                               e.target.style.transform = "scale(" + scale + ")";*/
                            // _self.resizeValue *= scale;
                            // _self.resize();
                            // mui.toast(scale);
                        }


                    },false);
                    //添加触屏结束事件
                    document.addEventListener("touchend",f1=function(e){
                        if (end.length && start.length ) { //縮放
                            var scale = (getDistance(end[0], end[1]) / getDistance(start[0], start[1]));
                            end=start=[];
                            _self.resizeValue = _self.resizeValue+  20*(scale>1?scale:-1/scale);
                            _self.resize();
                        }else{
                            if(px>pw){
                                _self.avatorImg.style.left=pw+"px";
                            }
                            if(px< mw-pw-_self.currLength.width){
                                _self.avatorImg.style.left=mw-pw-_self.currLength.width+"px";
                            }
                            if(py>(mh-cw)/2){
                                _self.avatorImg.style.top=(mh-cw)/2+"px";
                            }
                            if(py< (mh+mw)/2-pw-_self.currLength.height){
                                _self.avatorImg.style.top =(mh+mw)/2-pw-_self.currLength.height+"px";
                            }
                        }
                        //移除在document上添加的两个事件
                        document.removeEventListener("touchend",f1);
                        document.removeEventListener("touchmove",f2);
                    },false);
                },false);
            }
        }
        //读取回调对象并且保存
        this.readImg = function (event,tar){
            _self.targetImg = tar;
            _self.avatorImg = document.querySelector("#cutimg");

            var overlay   = document.querySelector("#overlayInner");
            var w = document.documentElement.clientWidth || document.body.clientWidth;
            var h = document.documentElement.clientHeight || document.body.clientHeight;
            overlay.style.width= w+"px";
            overlay.style.height= h+"px";
            var wh1=(h-(w-100))/2;
            overlay.style.borderTop=wh1+"px solid black";
            overlay.style.borderBottom=wh1+"px solid black";
            console.log("123");
            console.log( wh1);

        };
        /**
         * 修改图片比例大小
         */
        this.resize = function () {
            try {
                _self.currLength = {
                    width: _self.initLength.width + _self.resizeValue,
                    height: _self.initLength.height + _self.resizeValue / _self.whRate
                }
                var nw = new String(_self.currLength.width) + "px";
                var nh = new String(_self.currLength.height) + "px";
                _self.avatorImg.style.width = nw;
                _self.avatorImg.style.height = nh;
            }catch (err){
                alert(err);
            }
        }
        this.rotate=function(){
            console.log(_self.rotateValue);
            _self.avatorImg.style.transform="rotate("+_self.rotateValue+"deg)";
        }
        /**
         * 图片放大
         */
        /* this.resizeUp = function () {
             _self.resizeValue += 10;
             _self.resize();
         }*/
        /**
         * 图片缩小
         */
        /* this.resizeDown = function () {
             _self.resizeValue -= 10;
             _self.resize();
         }*/
        /**
         * 图片旋转
         */
        /*this.leftRotate = function () {
            _self.rotateValue -= 90;
            _self.rotate();
        }*/
        /*this.rightRotate = function () {
            _self.rotateValue += 90;
            _self.rotate();
        }
*/
        this.cutImg = function (){
            var mw = document.documentElement.clientWidth || document.body.clientWidth;
            var mh = document.documentElement.clientHeight || document.body.clientHeight;
            var _cropCanvas = document.createElement('canvas');
            _cropCanvas.width = mw;
            _cropCanvas.height= mw;
            var pm = 50;
            var cw = mw-pm*2;
            var x  = (pm-_self.avatorImg.offsetLeft)*_self.realLength.width/_self.currLength.width;
            var y  = ((mh-cw)/2-_self.avatorImg.offsetTop)*_self.realLength.height/_self.currLength.height;
            var rate = _self.realLength.width/_self.currLength.width;
            var context = _cropCanvas.getContext("2d");
            // context.save();//保存状态
            // context.translate(mw/2,mw/2);
            // context.rotate(_self.rotateValue*Math.PI/180);
            context.drawImage(_self.avatorImg,x,y,cw*rate,cw*rate,0,0,mw,mw);
            // context.restore();//恢复状态
            $(_self.targetImg).trigger('cutOverEvent', [_cropCanvas]);
            $(".photo-mask").css("display","none");
        }


        _self.init();
    }
    win.CutPhoto = CutPhoto;
})(window,jQuery);

//缩放 勾股定理方法
function getDistance(p1, p2) {
    var x = p2.pageX - p1.pageX,
        y = p2.pageY - p1.pageY;
    return Math.sqrt((x * x) + (y * y));
};