<%@ page contentType="text/html; charset=GBK"%>
<%
	String rootPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<title>default</title>
<meta charset="gbk">
<style>
	body, h1, h2, h3, h4, h5, h6, hr, p, blockquote,dl, dt, dd, ul, ol, li, pre,form, fieldset, legend, button,input, textarea,th, td {margin: 0;padding: 0;}
	body {line-height: 1;}
	body,button, input, select, textarea,
	h1, h2, h3, h4, h5, h6 { font-size: 100%; }
	ul, ol { list-style: none; }
	a { text-decoration: none; }
	a:hover { text-decoration: underline; }
	legend { color: #000; }
	fieldset, img { border: 0; }
	button, input, select, textarea { font-size: 100%; } /* 使得表单元素在 ie 下能继承字体大小 */
	table { border-collapse: collapse; border-spacing: 0; }
	html,body,#tabArea{height:100%;width:100%}
</style>
<script src="common/script/jquery-1.4.4.min.js"></script>
<script src="tabPanel/tabPanel.js"></script>
<link rel="stylesheet" href="tabPanel/skin/default/style.css">
<script>
	$(function(){
		var tabPanel = top.tabPanel = new TabPanel($('#tabArea'),{
			max:6,
			//defaultIcon:'common/images/right_top_xtzm.png',
            defaultIcon:'common/images/icon_07.gif',
			showClose: true,
			owIndex: 1,
			onAdd: function(id,hd,bd){
				//解决IE6首次不显示的问题
				if($.browser.msie && $.browser.version == '6.0'){
					bd[0].contentWindow.location.reload();
				}
			}
		});
		tabPanel.addTab({
			title:'食品分类',
			url:'/foodType',
			showClose:true,
			icon:'common/images/right_top_xtzm.png'
		});
		
	});

	
	
</script>
</head>
<body>
  <div id="tabArea"></div>
</body>
</html>
