<!--
功能：jsp页面引用js css
创建人：郭策
创建时间：Nov 25, 2010
-->
<%@ page contentType="text/html;charset=GBK" %>
<%
    String rootPath = request.getContextPath();
%><!DOCTYPE html>
<link href="<%=rootPath%>/common/skin/default/css/common.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="${base}/common/skin/default/css/common.css">
<script src="<%=rootPath%>/frame/common/script/SpryTabbedPanels.js" type="text/javascript"></script>
<script src="<%=rootPath%>/frame/common/script/MSIE.PNG.js" type="text/javascript"></script>
<script src="<%=rootPath%>/plugin/jquery-1.4.4.js" type="text/javascript"></script>
<script src="<%=rootPath%>/plugin/jqGrid/jqGrid.min.js" type="text/javascript"></script>
<script src="<%=rootPath%>/plugin/form/effect.js" type="text/javascript"></script>
<script src="<%=rootPath%>/plugin/panel/Panel.min.js" type="text/javascript"></script>
<script src="<%=rootPath%>/plugin/tab/TabPanel.js"></script>
<script src="<%=rootPath%>/common/js/MSIE.PNG.js" type="text/javascript"></script>
<script src="<%=rootPath%>/common/js/Validator.js" type="text/javascript"></script>
<script src="<%=rootPath%>/plugin/form/Form.min.js" type="text/javascript"></script>
<script src="<%=rootPath%>/plugin/form/DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="<%=rootPath%>/plugin/dialog/dialog.js" type="text/javascript"></script>
<script src="<%=rootPath%>/plugin/popup/ymPrompt.js" type="text/javascript"></script>
<meta http-equiv="Cache-Control" content="no-store"/>
<meta http-equiv="Pragma" content="no-cache"/>
<meta http-equiv="Expires" content="0"/>
		
