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
	//�˳�ϵͳ
	function quitSys() {
		if (confirm('ȷ���˳���')) {
	    	parent.location = "/login";
		}
	}
</script>
</head>
<body class="headFrameBg">




	<!-- ͷ����ʼ -->
	<div class="head_right">
		��ӭ <b><%=((User) request.getSession().getAttribute("user")).getName()%></b> ���� <a href="#" onclick="quitSys();">�˳�</a>
	</div>

	<div class="head" style="float: left; text-align: left;">
		<div class="logo">
			<div style="width: 2024px; float: left;">
			
			</div>
			

		</div>
		
	</div>


	<!-- ���� -->
</body>
</html>