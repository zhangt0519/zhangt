<%@ page contentType="text/html;charset=GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">


<title>ϵͳ�û���¼</title>
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<link rel="stylesheet" href="static/css/login/login.css?v=111">
<style type="text/css">
@media screen and (max-width: 1100px) {
	.login_box {
		position: fixed !important;
		top: 105px !important;
		right: 20px !important;
	}
	.footer {
		width: 100% !important;
	}
	.login_tel {
		margin-right: 30px !important;
	}
}
</style>

<script src="/static/js/jquery-1.7.1.js"></script>
<script src="/static/js/json2.js"></script>

<script language="JavaScript">
<!--
	function checkform(obj) {
		if (obj.code.value.length < 1) {
			alert("��Ϣ������ʾ��\n����¼ʱ����Ҫ�����û����룡");
			obj.code.focus();
			obj.code.select();
			return false;
		}

		if (obj.pwd.value.length < 1) {
			alert("��Ϣ������ʾ��\n����¼ʱ����Ҫ�����¼���룡");
			obj.pwd.focus();
			obj.pwd.select();
			return false;
		}
		info.innerText = '���ڽ��������֤�����Ժ�......';
	}

	function refresh() {
		//IE���ڻ���,��Ҫnew Date()ʵ�ָ���·��������  
		document.getElementById("image").src = "/static/css/login/image.jsp?" + new Date();
	}
	
	function doLogin() {
		code = $("#code").val();
		pwd = $("#pwd").val();
		rand = $("#rand").val();
		
		$.ajax({
		   type: "POST",
		   url: "/user/login",
		   data: "code="+code+"&pwd="+pwd+"&rand="+rand+"",
		   success: function(msg){
		     if ("ok" == msg) {
		    	 // location = "index";
		    	 top.location = "/static/jsp/frame/Index.jsp"
		     } else {
		    	 alert(msg);
		     }
		   }
		});
		
	}
//-->
</script>
</head>


<body>
	<form name="form1" method="post" onsubmit="return checkform(this);">

		<div class="long_dl">
			<div class="mainlogo" style="width: 100%">
				<div class="login_logo">
					<img src="static/css/login/logonew.png">
				</div>
				<div class="login_tel"></div>
				<div class="clear"></div>
			</div>
			<div class="b01">
				<div class="main" id="loginmain">
					<form method="post" id="loginForm" name="loginForm">
						<div class="login_box">
							<dl style="padding: 0; margin: 0">
								<dt class="l_zhuce">�û���¼</dt>
								<dd class="errortxt01" id="errmsg"></dd>
								<dd class="username">
									<input placeholder="�û���" class="username" type="text" id="code" name="code">
								</dd>
								<dd class="password">
									<input placeholder="����" class="password" type="password" id="pwd" name="pwd">
								</dd>
								<dd class="yzminput">
									<input placeholder="��֤��" class="yzminput fl" name="rand" id="rand"><img id="image" border="0" onclick="refresh()" src="static/css/login/image.jsp" title="���ˢ����֤��">
								</dd>

								<dd>
									<input name="submit" class="loginbtn" value="��¼" type="button" onclick="doLogin();">
								</dd>
								<dd>
									<div class="forgetpass" style="margin-top: 10px"></div>
								</dd>
							</dl>
						</div>
					</form>
				</div>
			</div>
			
		</div>
		

	</form>
	

</body>
</html>
