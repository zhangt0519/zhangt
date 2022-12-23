<%@page import="com.zhangt.sjz.domain.User"%>
<%@ page contentType="text/html;charset=GBK"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>head</title>
<link href="/static/jsp/frame/common/style/frame.css?v=1" rel="stylesheet" type="text/css">
<script src="/static/jsp/frame/common/script/MSIE.PNG.js" type="text/javascript"></script>


<link rel="stylesheet" type="text/css" href="/static/jsp/b2efile/bootstrap.min.css">
<link href="/static/jsp/b2efile/purchase_reset_bootstrap.css" rel="stylesheet" type="text/css">
<link href="/static/jsp/b2efile/main_bootstrap.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
	//退出系统
	function quitSys() {
		if (confirm('确定退出吗？')) {
	    	parent.location = "/login";
		}
	}
</script>
</head>
<body class="headFrameBg">




	<!-- 头部开始 -->
	<div class="head_right">
		欢迎 <b><%=((User) request.getSession().getAttribute("user")).getName()%></b> 访问 <a href="#" onclick="quitSys();">退出</a>
	</div>

	<div class="head" style="float: left; text-align: left;">
		<div class="logo">
			<div style="width: 2024px; float: left;">
			
			</div>
			

		</div>
		
	</div>


	<!-- 结束 -->
</body>
</html>