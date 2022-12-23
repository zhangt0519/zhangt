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
			<div class="panel-header">
				<h3>食品图片管理</h3>
			</div>
			<div class="panel-body">
				<input type="hidden" id="foodId" value="${food.id}">
				<table class="formTable formTable_4" cellpadding="0" cellspacing="0">
					<tbody>
						<tr>
							<td class="label">食品代码：</td>
							<td class="content">${food.code}</td>
							<td class="label">食品名称：</td>
							<td class="content">${food.name}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<!--查询条件 4列 结束 -->
		<div style="margin-top: 5px">
			<table id="list2"></table>
			<div id="pager2"></div>
		</div>
		
		<div id="imgUploadDiv" class="easyui-window"  minimizable="false" maximizable="false" closed="true" modal="false" closable="true" resizable="true" draggable="true" title="图片上传" style="width:800px; height:422px;">
			<div class="page-content">
				<form id="fileform2" action="foodImg/upload" method="post" enctype="multipart/form-data">
					<input id="foodId" name="foodId" type="hidden" value="${food.id}" />
					<!--页面级的工具栏-->
					<div style="margin-top: 5px">
						<div class="toolbar" id="toolbar">
							<div>
								<a href="#" onclick="doExport2();" class="easyui-linkbutton"
									plain="true" data-options="iconCls:'icon-save'">保存</a> <a
									href="#" onclick="goBack();" class="easyui-linkbutton"
									plain="true" data-options="iconCls:'icon-undo'">关闭</a>
							</div>
						</div>
					</div>
					<!--工具栏结束，界面信息分组开始-->
					<div class="panel">
						<div class="panel-body">
							<table class="formTable formTable_4">
								<tr>
									<td class="label">选择图片：</td>
									<td class="content">
										<input type="file" id="file2" name="file">
									</td>
									<td class="label">图片名称：</td>
									<td class="content"><input name="fileName" id="fileName"
										type="text" msg="请输入名称"/>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</form>
			</div>
		</div>
		
		<div id="imgShowDiv" class="easyui-window"  minimizable="false" maximizable="false" closed="true" modal="false" closable="true" resizable="true" draggable="true" title="图片查看" style="width:800px; height:422px;">
			<div id="showPicture" style="width:100%;height:100%;line-height:100px;overflow:auto;overflow-x:hidden; text-align: center;">
	 		</div>
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
			foodId = $("#foodId").val();
			tao = $('#list2').datagrid({
				width: 'auto', // 面板宽度，自动列宽
				height: 'auto', // 面板高度，自动列高
				nowrap: false, //True就会把数据显示在一行里
				striped: true, //True就把行条纹化。（即奇偶行使用不同背景色）
				//loadMsg: '执行中...',
				url: '/foodImg/queryTableData',  
				queryParams: {foodId: foodId},
			   	columns:[[
			   		{field:'ck', checkbox:true},  
			   		{field:'id', title:'id', hidden:'true', width:50}, 
					{field:'foodId', title:'食品ID', width:100},   
					{field:'imgName', title:'图片名称', width:100},
					{field:'imgUrl', title:'图片地址', width:350},
			       	{field:'createTimeStr', title:'新增时间', width:200},
			       	{field:'updateTimeStr', title:'修改时间', width:200},
			       	{field:'imgUrl222', title:'操作列', width:100, formatter:function(value,rowData,rowIndex){return "<a href=\'#\' onclick='showImg(\""+rowData.imgUrl+"\")'>查看</a>";}} 
				]],
			  	pagination: true,
				rownumbers: true, //True就会显示行号的列
				singleSelect: false, //True就会只允许选中一行
				pageNumber: 1,
				pageSize: 10,
				pageList: [10,15,20,30,40,50],
				toolbar: [{
					id: 'btnadd',
					text: '上传',
					iconCls: 'icon-add',
					handler: function(){
						$('#imgUploadDiv').window('open');
					}
				},{
					id:'btnedit',
					text:'置顶',
					iconCls:'icon-tip',
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
						$.ajax({
							type: "POST",
							url : '/foodImg/foodImgTop', 
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
							url : '/foodImg/foodImgDelete', 
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
				}, {
					id: 'btnback',
					text: '返回',
					iconCls: 'icon-back',
					handler: function(){
						location = "/food";
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
			$("#foodTypeId").val("");
		}
		
		function goBack() {
			$('#imgUploadDiv').window('close');
		}
		
		function doExport2() {
			var file = $("#file2").val();
			if (file == "") {
				$.messager.alert('信息', "请选择文件"); 
				return;
			}
			
		    var data = new FormData($("#fileform2")[0]);
		    $.ajax({
		        type: "POST",           //因为是传输文件，所以必须是post
		        url: '/foodImg/upload',         //对应的后台处理类的地址
		        data: data,
		        dataType: 'html',
		        contentType: false,
		        processData: false,
		        success: function (rst) {
		            $.messager.alert('信息', rst);
		            $("#list2").datagrid('reload'); 
		            $('#imgUploadDiv').window('close');
		            $("#file2").val("");
		            $("#fileName").val("");
		        }
		    });
		}
		
		function showImg(imgUrl) {
			$("#showPicture").html("");
			$("#showPicture").append("<img src='"+imgUrl+"' width='900px' height='675px' title=''/>");
			$('#imgShowDiv').window('open');
		}
		</script>


	</div>

</body>
</html>
