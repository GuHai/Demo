

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
 <!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>发布职位</title>
	 <jsp:include page="../zp/base/resource.jsp"/>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=SsT8H9B2IVN4rrg94alxcGGKfzL2ETzL"></script>

	<link rel="stylesheet" href="/ijob/static/css/index/SearchJob.css">
	<link rel="stylesheet" href="/ijob/static/css/index/part-time.css">
	<link rel="stylesheet" href="/ijob/static/css/mine/add_preview.css">

</head>
<body>

<style>
.wrap .head .head-fixe{background:#fff;margin-top:0px;padding-top:0.267rem;height:1.333rem;}
.wrap .head .head-fixe .positioning{color:#666;padding-top:4px;}
.wrap .head .head-fixe .positioning .mui-icon-arrowdown{color:#666;}
.mui-input-row .mui-btn+input, .mui-input-row label+input, .mui-input-row:last-child{}
.mui-input-row .mui-Ha{display:block;width:100%;height:0.800rem;background:#f2f5f7;border-radius:0.667rem;color:#666;}
.wrap .head .head-fixe .head-find > a > input[type=search]{color:#666;opacity: 1;height: 0.800rem;border-radius: 0.667rem;border: 0px; background-color: #f2f5f7; }
.wrap .head .head-fixe .head-find > a .mui-placeholder{color:#666;line-height:0.800rem;}
.wrap .head .head-fixe .mui-search .mui-placeholder .mui-icon{color:#666;}
.wrap .head .head-rt>.btn{font-size:0.347rem;color:#333;text-align:center;height:1.333rem;line-height:1.333rem;}
.wrap .head .mui-input-row .mui-input-clear~.mui-icon-clear{top:0.320rem;}
.positioning{width:1.600rem;color:#666;line-height:1.200rem;margin-left:0.453rem;}
.positioning i{font-size:0.533rem;}
.wrap .head .head-lf>input{margin:0.160rem 0px;width:100%;height:0.800rem;}
.wrap .head .head-lf>i{left:0.187rem;top:0.267rem;}
.wrap .head .head-lf{flex:1;display:block;margin-right:0.453rem;}

</style>

<div class="wrap">
    <!--搜索框-->
    <header class="head" style="width:100%;margin-top:1.200rem;height:1.200rem;overflow:hidden;background:#fff;display:flex;">
		<div class="positioning" id="prompt"><span>长沙</span><i class="mui-icon mui-icon-arrowdown"></i></div>
        <div class="head-lf mui-input-row">
            <i class="mui-icon mui-icon-search"></i>
            <input type="text" class=" mui-input-clear" placeholder="搜索小区/大厦/学校">
        </div>
    </header>
	<div class="hmap" id="map" ></div>
	<div class="hmapT">
		<ul class="hmapT-ul">
			<li>
				<p class="hmapT-ulp">第二工人文化宫-活动楼</p>
				<p>湘春路305号第2</p>
			</li>
			<li>
				<p class="hmapT-ulp">艾豪斯酒店（湘春路店）</p>
				<p>湘春路199号东宸19公馆</p>
			</li>
			<li>
				<p class="hmapT-ulp">复地昆玉国际7栋</p>
				<p>北正街湘春路复地·昆玉国际</p>
			</li>
		</ul>
		<div class="hmapT-put">
			<input type="text" class="hampT-putI" name="" placeholder="请输入详细地址" maxlength="20"/>
			<div class="hampT-putS"><input type="submit" name="" style="background:#108ee9;color:#fff;border-radius:0.160rem;font-size:0.347rem;" value="提交" /></div>
		</div>
	</div>
	
</div>

<script type="text/javascript">
	var btn = ['取消', '切换'];
$('#prompt').on('click', function (e) {
    mui.confirm('定位为长沙市，是否切换？', '提示', btn, function (e) {
        if (e.index == 0) {

        } else {
            self.location='index/selectarea.html';
        }
    })
})

    //创建和初始化地图函数：
    function initMap(){
      createMap();//创建地图
      setMapEvent();//设置地图事件
      addMapOverlay();//向地图添加覆盖物
    }
    function createMap(){ 
      map = new BMap.Map("map"); 
      map.centerAndZoom(new BMap.Point(112.945473,28.234889),12);
    }
    function setMapEvent(){
      map.enableScrollWheelZoom();
      map.enableKeyboard();
      map.enableDragging();
      map.enableDoubleClickZoom()
    }
    function addClickHandler(target,window){
      target.addEventListener("click",function(){
        target.openInfoWindow(window);
      });
    }
    function addMapOverlay(){
    }
    //向地图添加控件
    function addMapControl(){
      var navControl = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
      map.addControl(navControl);
    }
    var map;
      initMap();
</script>

</body>
</html>


