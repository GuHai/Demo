
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta charset="UTF-8">
    <title>发布职位</title>
    <jsp:include page="../zp/base/resource.jsp"/>
</head>
<body>
    <div class="PostJob">
    	<form name="form" action=""  method="post" id="input_example">
    		<div class="Hcease">
				<textarea id="character" placeholder="请输入注意事项"></textarea>
			</div>	
			<p class="Hcease-hine">0/200</p>			
    		<div class="hlink">
    			<a href="javascript:void(0);" class="mui-hbut-on">取消</a>
    			<a href="javascript:void(0);">确定</a>
    		</div>
        </form>
    </div>

<script type="text/javascript">
//限制文字
	var oBox=document.getElementById('character');
	var demoHtml = oBox.innerHTML.slice(0,200)+'';
		oBox.innerHTML = demoHtml;
</script>


</body>
</html>


