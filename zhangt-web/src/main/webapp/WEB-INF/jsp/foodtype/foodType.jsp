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
							<td class="label">食品分类代码：</td>
							<td class="content"><input type="text" id="code" maxlength="100" value="" /></td>
							<td class="label">食品分类名称：</td>
							<td class="content"><input type="text" id="name" maxlength="100" value="" /></td>
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
			code = $("#code").val();
			name = $("#name").val();
			tao = $('#list2').datagrid({
				width: 'auto', // 面板宽度，自动列宽
				height: 'auto', // 面板高度，自动列高
				nowrap: false, //True就会把数据显示在一行里
				striped: true, //True就把行条纹化。（即奇偶行使用不同背景色）
				//loadMsg: '执行中...',
				url: '/foodType/queryTableData',  
				queryParams: {name: name, code: code},
			   	columns:[[
			   		{field:'ck', checkbox:true},  
			   		{field:'id', title:'id', hidden:'true', width:100}, 
					{field:'code', title:'代码', width:150},   
					{field:'name', title:'名称', width:150},
			       	{field:'createTimeStr', title:'新增时间', width:200},
			       	{field:'updateTimeStr', title:'修改时间', width:200}
				]],
			  	pagination: true,
				rownumbers: true, //True就会显示行号的列
				singleSelect: false, //True就会只允许选中一行
				pageNumber: 1,
				pageSize: 10,
				pageList: [10,15,20,30,40,50],
				toolbar: [{
					id: 'btnadd',
					text: '新增',
					iconCls: 'icon-add',
					handler: function(){
						document.location = "/foodTypeAdd";
					}
				},{
					id:'btnedit',
					text:'修改',
					iconCls:'icon-edit',
					handler:function(){
						var rows = $('#list2').datagrid('getSelections');
						
						if (rows.length != 1) {
							$.messager.alert('信息', "请选择1条数据进行修改"); 
							return;
						}
						var id = "";
						for(var i = 0; i < rows.length; i++){
							id = rows[i].id;
						}
						document.location = "/foodTypeAdd?id="+id;
						
					}
				},{
					id:'btncut',
					text:'删除',
					iconCls:'icon-remove',
					handler:function(){
						var ids = [];
						var rows = $('#list2').datagrid('getSelections');
						if (rows.length == 0) {
							$.messager.alert('信息', "请选择需要删除的记录"); 
							return;
						}
						var ids=new Array();
						
						var iddata = "";
						for(var i = 0; i < rows.length; i++){
							ids.push(rows[i].id);
							iddata += "ids="+rows[i].id+"&"
						}
						
						$.ajax({
							type: "POST",
							url : '/foodType/foodTypeDelete', 
							data: iddata,
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
			$("#code").val("");
			$("#name").val("");
		}
		</script>


	</div>

</body>
</html>
