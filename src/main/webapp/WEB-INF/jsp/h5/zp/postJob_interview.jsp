
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>新增面试</title>
	<jsp:include page="../zp/base/resource.jsp"/>
</head>
<body>
<script id="taskOrCommission" type="text/html"
		data-url="/ijob/api/PositionController/h5/zp/getTaskOrCommission/{positionTemp.id}/{data.type}" data-type="POST">
	{{each list as posi}}
    <div class="PostJob">
    	<form name="form" action=""  method="post" id="input_example">
			<input type="hidden" id="positionID" value="{{posi.id}}">
			{{if posi.interview!=null}}
			<input type="hidden" id="id" value="{{posi.interview.id}}">
			<input type="hidden" id="version" value="{{posi.interview.version}}">
			{{else}}
			{{/if}}
		    <div class="mui-input-group">
		        <div class="mui-input-row">
                    <label>面试地址</label>
                	<div class="mui-input-div">
						<input id="train" style="color:#666;text-align:right;font-size:14px;" readonly="true"/>
						<i class="iconfont icon-fujin"></i>
						<%--<input  id="interviewAddress" style="color:#666;text-align:right;font-size:14px;" value="4cf9a4f1606f44b99c301395d171d198" />--%>
					</div>
                </div>
				<div class="mui-input-row">
                    <label>面试时间</label>
                	<div class="mui-input-div">
						{{if posi.interview==null}}
							<input id="Dtime" style="color:#666;text-align:right;font-size:14px;" value="" readonly="true" />
						{{else}}
							<input id="Dtime" style="color:#666;text-align:right;font-size:14px;" value="{{posi.interview.interTime | dateFormat:'yyyy-MM-dd hh:mm'}}" readonly="true" />
						{{/if}}
					    <i class="iconfont icon-arrow-right icon-arrow-hD"></i>
					</div>
                </div>
		    </div>
    		<div class="Hcease">
				{{if posi.interview==null}}
				<textarea id="character" name="instructions" placeholder="请输入面试说明" ></textarea>
				{{else}}
				<textarea id="character" name="instructions" placeholder="请输入面试说明" >{{posi.interview.instructions}}</textarea>
				{{/if}}
			</div>	
			<p class="Hcease-hine" id="result">0/200</p>
    		<div class="hlink">
    			<a href="javascript:void(0)" id="cancel" class="mui-hbut-on">取消</a>
    			<a href="javascript:void(0)" id="submitBtn"  data-url="/ijob/api/InterviewController/add" >确定</a>
    		</div>
        </form>
    </div>
	{{/each}}
    </script>
<script type="text/javascript">
    //页面加载时显示数字长度


    $("#taskOrCommission").loadData().then(function (result) {

        var now = new Date();
        if(ijob.storage.get("interviewAddr")){
            $("#Dtime").val(ijob.storage.get("interviewAddr.interTime")||ijob.dateFormat(now,'yyyy-MM-dd hh:mm'));
            $("#character").val(ijob.storage.get("interviewAddr.instructions"));
        }else{
            if(!$("#Dtime").val()){
                $("#Dtime").val(ijob.dateFormat(now,'yyyy-MM-dd hh:mm'));
            }
        }
        if(result.data.list[0].interview!=null){
            var datatime=result.data.list[0].interview.interTime;
            var databegin = datatime.substring(0,datatime.length-3);
		}
        //页面加载时会显示长度
        $("#result").text($("#character").val().length + "/200");

            (function ($) {
                $.init();
				//集合时间
				var jihe = document.getElementById("Dtime");
				jihe.addEventListener('tap', function () {
					var optionsJson = this.getAttribute('datatime-options') || '{}';
					var options = JSON.parse(optionsJson);
					options.value=databegin;
					var picker = new mui.DtPicker(options);
					picker.show(function (rs) {
						document.getElementById("Dtime").value = rs.text;
						// document.getElementById("setDate").value = rs.text + ":00";
						picker.dispose();
					});
				}, false);
            })(mui);



        var address  ={
            longitude:'',
            latitude:'',
            detailedAddress:'',
            cityID:''
        };
        var latlng = ijob.storage.get("data.latlng");
        var key,signIn  ;
        if(latlng) {
            key = latlng.key;
            if (key && key == "signIn" && latlng.value) {
                signIn = {
                    lng: latlng.value.latlng.lng,
                    lat: latlng.value.latlng.lat,
                    addr: latlng.value.poiaddress,
                    cityname: (latlng.value.cityname),
                    cityID: site.region.id(latlng.value.cityname)
                }
                ijob.storage.set("myjob.signIn", signIn);

            }
        }
        if(signIn&&signIn.cityname){
            setvalueforworkplace(signIn);
        }else{
            site.localtion().then(function () {
                var workPlace = {
                    lng:site.data.lng,
                    lat:site.data.lat,
                    addr:site.data.addr,
                    cityID:site.region.id(site.data.district||site.data.city),
                    cityname:site.data.district||site.data.city
                };
                setvalueforworkplace(workPlace);
            });
        }

        function setvalueforworkplace(workPlace){
            $("#train").val(workPlace.addr||workPlace.cityname);
            address.longitude = workPlace.lng;
            address.latitude = workPlace.lat;
            address.detailedAddress = workPlace.addr;
            address.cityID = workPlace.cityID;
        }

        $("#train").click(function(){
            ijob.gotoPage({url:"/ijob/api/WeixinController/map",data:{latlng:{key:"signIn"}}});
        });


        $("#submitBtn").click(function(){
            if ($("#character").val().length <= 200) {
                submitBtn();
            }else{
                mui.alert("工作内容过多！");
            }
		});

        function submitBtn(){
            var _this = $("#submitBtn");
            if ($("#character").val() == null || $("#character").val() == "" ) {
                mui.alert("请输入面试说明！");
            }else{
                ijob.storage.set("interviewAddr",{
                    "id":$("#id").val(),
                    "version":$("#version").val(),
                    "positionID":$("#positionID").val(),
                    "instructions" : $("#character").val(),
                    "interTime" : $("#Dtime").val(),
                    "isCultivate" : 1,
                    "localtioninfo":address
                });
                history.go(-1);
            }
        }



        //判断是否可以提交和数字长度的显示
        $(document).on("input propertychange", '#character', function () {
            var len = $(this).val().length;
            $('#result').text(len + '/200');
            if (len > 200) {
                $("#submitBtn").css({"background-color":"#999"});
            }else{
                $("#submitBtn").css({"background-color":""});
            }
        });
        $(document).on("tap", '#cancel', function () {
            history.go(-1);
        });


    });








</script>


</body>
</html>


