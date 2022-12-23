<%@ page isELIgnored="false" %>
<%@ page language="java" pageEncoding="utf-8"%>
<%
	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<link rel="stylesheet" type="text/css" href="/static/css/common/skin/default/css/common.css">
<script src="/static/js/jquery-1.4.4.min.js" type="text/javascript"></script>
<script src="/static/js/common.min.js?w=panel,form,grid" type="text/javascript"></script>

<link rel="stylesheet" type="text/css" href="/static/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="/static/js/easyui/themes/icon.css">
<script type="text/javascript" src="/static/js/jquery-1.7.1.js"></script>
<script type="text/javascript" src="/static/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="/static/js/easyui/locale/easyui-lang-zh_CN.js"></script>  

<script type="text/javascript" src="/static/js/json2.js"></script>
<title>查询页面</title>
</head>
<body>
	<!--页面开始，最外层的布局控制-->
	<div class="page-content">
		<!--查询条件 4列 开始 -->
		<div class="panel" style="padding: 0; margin: 0">
			<!-- <div class="panel-header">
				<h3>基本信息</h3>
			</div> -->
			<div class="panel-body">
				<table class="formTable formTable_4" cellpadding="0" cellspacing="0">
					<tbody>
						<tr>
							<td class="label">订单ID：</td>
							<td class="content"><input type="text" id="orderId" maxlength="100" value="" /></td>
							<td class="label">下单开始时间：</td>
							<td class="content"><input id="startTimeStr" class="easyui-datetimebox"  style="width:200px"></td>
						</tr>
						<tr>
							<td class="label">下单结束时间：</td>
							<td class="content"><input id="endTimeStr" class="easyui-datetimebox"  style="width:200px"></td>
						</tr>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="4"><a href="#" id="btnSumit" class="btn search submit" onclick="query();"><em>查询</em></a><a href="#" class="btn reset" onclick="reset();"><em>重置</em></a></td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
		<!--查询条件 4列 结束 -->
		<div style="margin-top: 5px">
			<table id="list2"></table>
			<div id="pager2"></div>
		</div>
		
		<script type="text/javascript">
		$(function(){
			loadData();
			
		});
		
		
		function loadData(){
			orderId = $("#orderId").val();
			startTimeStr = $('#startTimeStr').datebox('getValue');  
			endTimeStr = $('#endTimeStr').datebox('getValue');
			tao = $('#list2').datagrid({
				width: 'auto', // 面板宽度，自动列宽
				height: 'auto', // 面板高度，自动列高
				nowrap: false, //True就会把数据显示在一行里
				striped: true, //True就把行条纹化。（即奇偶行使用不同背景色）
				//loadMsg: '执行中...',
				url: '/foodOrderDetail/queryTableData',  
				queryParams: {orderId: orderId, startTimeStr: startTimeStr, endTimeStr: endTimeStr},
			   	columns:[[
			   		{field:'ck', checkbox:true},  
			   		{field:'id', title:'id', hidden:'true', width:50}, 
			   		{field:'orderId', title:'订单ID', width:100},
					{field:'foodId', title:'食品ID', width:100}, 
					{field:'foodName', title:'食品名称', width:100},
					{field:'foodPrice', title:'食品单价(元)', width:100},
					{field:'foodCount', title:'数量', width:100},
					{field:'detailPrice', title:'合计(元)', width:100},
			       	{field:'createTimeStr', title:'下单时间', width:200}
				]],
			  	pagination: true,
				rownumbers: true, //True就会显示行号的列
				singleSelect: false, //True就会只允许选中一行
				pageNumber: 1,
				pageSize: 10,
				pageList: [10,15,20,30,40,50]
			});
		}
		
		
		function query() {
			loadData();
					
		}
		function reset() {
			$("#orderId").val("");
			$('#startTimeStr').combo('setText','');
			$('#endTimeStr').combo('setText','');
			$('#startTimeStr').combo('setValue','');
			$('#endTimeStr').combo('setValue','');
		}
		</script>


	</div>

</body>
</html>
