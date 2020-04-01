

function IJobRefresh(config){
    var ijobrefresh = this;
    this.scrollarr = [];
    this.container = config.container;
    this.panel = config.panel;
    this.clear = config.clear!=undefined?config.clear:true;
    this.up = config.up;
    this.check=function(htmlHeight){
        var index = $.inArray(htmlHeight,ijobrefresh.scrollarr);
        if(index >= 0){
            return false;
        }
        ijobrefresh.scrollarr.push(htmlHeight);
        return true;
    }
    this.init=function(){
        if(this.clear == true){
            $(ijobrefresh.container).children().not("script").remove();
        }else{
            $(ijobrefresh.container).find(".noMore").parent().remove();
        }
        $(ijobrefresh.container).append("<div  style='text-align: center;padding: 15px 0;font-size: 12px;color: grey;' ><img id='loadimg' src=\"/ijob/static/images/loading.gif\"><p id='loadmsg' >"+dict.PullDict.Loading+"</p></div>");
       /* $(window).on('touchmove',function(){
            //下面这句主要是获取网页的总高度，主要是考虑兼容性所以把Ie支持的documentElement也写了，这个方法至少支持IE8
            var htmlHeight=document.body.scrollHeight||document.documentElement.scrollHeight;
            //clientHeight是网页在浏览器中的可视高度，
            var clientHeight=document.body.clientHeight||document.documentElement.clientHeight;
            //scrollTop是浏览器滚动条的top位置，
            var scrollTop=document.body.scrollTop||document.documentElement.scrollTop;
            //通过判断滚动条的top位置与可视网页之和与整个网页的高度是否相等来决定是否加载内容；
            if(scrollTop+clientHeight==htmlHeight && ijobrefresh.check(htmlHeight)==true){
                ijobrefresh.load(htmlHeight);
            }
            if(ijobrefresh.scrollarr.length==0){
                ijobrefresh.load(htmlHeight);
            }
        });*/
        $(window).unbind();
        $(window).scroll(function(){
            scrollHandler();
        });

        function scrollHandler(){
            //下面这句主要是获取网页的总高度，主要是考虑兼容性所以把Ie支持的documentElement也写了，这个方法至少支持IE8
            var htmlHeight=document.body.scrollHeight||document.documentElement.scrollHeight;
            //clientHeight是网页在浏览器中的可视高度，
            var clientHeight=document.body.clientHeight||document.documentElement.clientHeight;
            //scrollTop是浏览器滚动条的top位置，
            var scrollTop=document.body.scrollTop||document.documentElement.scrollTop;
            //通过判断滚动条的top位置与可视网页之和与整个网页的高度是否相等来决定是否加载内容；
            if(scrollTop+clientHeight>=htmlHeight-1){
                ijobrefresh.load(htmlHeight);
            }
        }
        var num = setTimeout(function(){
            if(ijobrefresh.scrollarr.length==0){
                ijobrefresh.load(0);
                clearTimeout(num);
            }
        },100);
    }
    this.load = function(htmlHeight){
        if($(ijobrefresh.panel)  &&  $(ijobrefresh.panel).css("display")=="none"){

        }else if(ijobrefresh.check(htmlHeight)==true){
            config.up.call();
        }
    }

    this.endPullupToRefresh = function(flag){
        if(flag==true){
            $(window).off("scroll");
            $(ijobrefresh.container).find("#loadmsg").parent().html("<p class='noMore'><span style=\"color: #999;font-size: 15px;margin-right: 5px;\" class=\"iconfont icon-jiarugouwuche00-copy-copy-copy\"></span>"+dict.PullDict.NoMore+"</p>");
        }
    };

    this.init();

}