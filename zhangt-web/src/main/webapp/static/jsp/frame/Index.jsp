<%@ page contentType="text/html;charset=GBK"%>
<%
	String root = request.getContextPath();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>银企平台</title>
<script language="JavaScript" type="text/JavaScript">
	function MM_reloadPage(init) {
		if (init == true)
			with (navigator) {
				if ((appName == "Netscape") && (parseInt(appVersion) == 4)) {
					document.MM_pgW = innerWidth;
					document.MM_pgH = innerHeight;
					onresize = MM_reloadPage;
				}
			}
		else if (innerWidth != document.MM_pgW
				|| innerHeight != document.MM_pgH)
			location.reload();
	}
	MM_reloadPage(true);
//-->
</script>

</head>
<frameset rows="63,*,13" cols="*" framespacing="0" frameborder="no"
	border="0" name="iman">
	<frame src="/static/jsp/frame/Head.jsp" name="headFrame" frameborder="no"
		scrolling="NO" noresize marginwidth="0" marginheight="0">
	<frameset name="main" rows="*" cols="207,*" framespacing="0"
		frameborder="NO" border="0">
		<frameset rows="*" cols="204,9" framespacing="0" frameborder="no"
			border="0" name="viewArea">
			<frame src="/static/jsp/frame/Menu.jsp?v=2" name="menuFrame"
				frameborder="no" marginwidth="0" marginheight="0" scrolling="no">
			<frame src="/static/jsp/frame/SizeControl.jsp" name="sizeControlFrame"
				scrolling="no" noresize>
		</frameset>
		<frame src="/static/jsp/frame/Main.jsp" name="mainFrame" scrolling="NO"
			noresize>
	</frameset>
	<frame src="/static/jsp/frame/Footer.jsp" name="footFrame"
		frameborder="no" scrolling="NO" noresize marginwidth="0"
		marginheight="0">
</frameset>
<noframes>
	<body>
	</body>
</noframes>
</html>
