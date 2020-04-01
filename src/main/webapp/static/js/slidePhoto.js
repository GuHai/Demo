(function SlidePhoto(win,$) {
    var SlidePhoto = function (img) {
        var _self = this;
        $(".wrap").append("  <div class='photo-mask' style='display: none;" +
            "            justify-content:center;" +
            "            align-items:Center;position: fixed;top: 0;left: 0; z-index: 99; width: 100%;height: 100%;background: rgba(0, 0, 0, .5);'>" +
            "        <img id='bigimg' src='/ijob/upload/iJob/images/resource/gzh.jpg\' width='100%' />" +
            "    </div>");

        this.currIndex = 0;
        this.startX = 0;
        this.endX = 0;
        this.photos = [];
        this.startHandler = function(event){
            var _touch = event.originalEvent.targetTouches[0];
            var _x= _touch.pageX;
            if(_self.startX == 0){
                _self.startX = _x;
            }
            _self.endX = _x;
        }

        this.endHandler = function(event){
            if(  _self.endX-_self.startX<0){
                _self.currIndex ++;
            }else{
                _self.currIndex --;
            }
            _self.currIndex  = (_self.currIndex +_self.photos.length) % _self.photos.length;
            _self.startX = 0;
            _self.endX = 0;
            _self.play();
        }


        this.play = function(){
            $(".photo-mask").css("display","flex");
            $("#bigimg").attr("src",_self.photos[ _self.currIndex]);
        }

        this.init = function(){
            $(".photo-mask").click(function(){
                $(".photo-mask").hide();
            });
            $("#bigimg").click(function(e){
                e.stopPropagation();
            });

            $(img).each(function(i,item){
                _self.photos.push($(item).attr("src"))
            });
            $("#bigimg").on('touchmove',_self.startHandler);
            $("#bigimg").on('touchend',_self.endHandler);
            $(img).on('click',function(){
                var src = $(this).attr("src");
                $.each(_self.photos,function(i,item){
                    if(item==src){
                        _self.currIndex = i;
                    }
                });
                _self.play();
            });
        }

        _self.init();
    }
    win.SlidePhoto = SlidePhoto;
})(window,jQuery);