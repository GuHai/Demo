(function Slide(win,$) {
    var Slide = function (warp,div,panel) {
        this.wrap = warp;
        this.div = div;
        this.lastpotin ;
        this.panel = panel;
        var _self = this;
        this.disTouch=function () {
            _self.wrap.on('touchmove',_self.touchHandler);
            _self.div.on('touchend',_self.endHandler);
        }
        this.endHandler=function(event){
            _self.lastpotin = undefined;
        }
        this.touchHandler=function(event){
            event.preventDefault();
            var _touch = event.originalEvent.targetTouches[0];
            var _y= _touch.pageY;
            if(_self.lastpotin==undefined){
                _self.lastpotin = _y;
            }
            $(_self.panel).scrollTop($(_self.panel).scrollTop()+(_self.lastpotin - _y));
            _self.lastpotin  = _y;
        }
        this.ableTouch=function(){
            _self.wrap.off('touchmove',_self.touchHandler);
            _self.div.off('touchend',_self.endHandler);
        }
    }
    win.Slide = Slide;
})(window,jQuery);