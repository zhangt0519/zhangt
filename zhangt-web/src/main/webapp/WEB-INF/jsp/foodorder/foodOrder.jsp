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
							<td class="label">手机号：</td>
							<td class="content"><input type="text" id="tel" maxlength="100" value="" /></td>
							<td class="label">是否完单：</td>
							<td class="content">
								<select id="isDone" name="isDone" size="1">
									<option value="">请选择</option>
									<option value="0">未完单</option>
									<option value="1">已完单</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="label">下单开始时间：</td>
							<td class="content"><input id="startTimeStr" class="easyui-datetimebox"  style="width:200px"></td>
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
		
		
		<div id="detailDiv" class="easyui-window"  minimizable="false" maximizable="false" closed="true" modal="false" closable="true" resizable="true" draggable="true" title="订单明细" style="width:800px; height:422px;">
			<table id="detaillist2"></table>
 		</div>
		
		<script type="text/javascript">
		$(function(){
			loadData();
			
			$.ajax({
				type: "POST",
				url : '/foodType/getAllFoodType', 
				success : function(data) {  
					$.each(data,function(index,rst){
						temp = "<option value='"+rst.id+"'>"+rst.name+"</option>";
						$("#foodTypeId").append(temp);
					});
				},  
			 	error : function(data) {  
			 		$.messager.alert('信息', "系统错误，请联系管理员"); 
				} 
			});
		});
		
		
		function loadData(){
			tel = $("#tel").val();
			isDone = $("#isDone").val();
			startTimeStr = $('#startTimeStr').datebox('getValue');  
			endTimeStr = $('#endTimeStr').datebox('getValue');
			tao = $('#list2').datagrid({
				width: 'auto', // 面板宽度，自动列宽
				height: 'auto', // 面板高度，自动列高
				nowrap: false, //True就会把数据显示在一行里
				striped: true, //True就把行条纹化。（即奇偶行使用不同背景色）
				//loadMsg: '执行中...',
				url: '/foodOrder/queryTableData',  
				queryParams: {tel: tel, isDone: isDone, startTimeStr: startTimeStr, endTimeStr: endTimeStr},
			   	columns:[[
			   		{field:'ck', checkbox:true},  
			   		{field:'id', title:'ID', width:50}, 
					{field:'tel', title:'手机号', width:100},   
					{field:'orderPrice', title:'订单金额(元)', width:100},
			       	{field:'createTimeStr', title:'下单时间', width:200},
			       	{field:'isDone', title:'是否完单', width:150, formatter:function(value,rowData,rowIndex){
		        	  	if (value == 0) {
		        	  		return '未完单'
		        	  	} else if (value == 1) {
		        	  		return '已完单'
		        	  	}
					}},
					{field:'temp222', title:'操作列', width:100, formatter:function(value,rowData,rowIndex){return "<a href=\'#\' onclick='showDetail(\""+rowData.id+"\")'>查看明细</a>";}} 
				]],
			  	pagination: true,
				rownumbers: true, //True就会显示行号的列
				singleSelect: false, //True就会只允许选中一行
				pageNumber: 1,
				pageSize: 10,
				pageList: [10,15,20,30,40,50],
				toolbar: [{
					id:'btn-img-ctrl',
					text:'完单',
					iconCls:'icon-reload',
					handler:function(){
						var ids = [];
						var rows = $('#list2').datagrid('getSelections');
						if (rows.length != 1) {
							$.messager.alert('信息', "请选择1条记录进行操作");
							return;
						}
						var id = rows[0].id;
						
						$.ajax({
							type: "POST",
							url : '/foodOrder/foodOrderDone', 
							data: {id: id},
							success : function(rst) {  
								$.messager.alert('信息', rst); 
							 	$("#list2").datagrid('reload'); 
							},  
						    error : function(data) {  
						    	$.messager.alert('信息', "系统错误，请联系管理员");  
							} 
						});
					}
				}]
			});
		}
		
		
		function query() {
			loadData();
					
		}
		function reset() {
			$("#tel").val("");
			$('#isDone').val("")
			$('#startTimeStr').combo('setText','');
			$('#endTimeStr').combo('setText','');
			$('#startTimeStr').combo('setValue','');
			$('#endTimeStr').combo('setValue','');
		}
		
		function showDetail(orderId) {
			tao = $('#detaillist2').datagrid({
				width: 'auto', // 面板宽度，自动列宽
				height: 'auto', // 面板高度，自动列高
				nowrap: false, //True就会把数据显示在一行里
				striped: true, //True就把行条纹化。（即奇偶行使用不同背景色）
				//loadMsg: '执行中...',
				url: '/foodOrderDetail/queryTableData',  
				queryParams: {orderId: orderId},
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
			
			$('#detailDiv').window('open');
		}
		</script>


	</div>

</body>
</html>
