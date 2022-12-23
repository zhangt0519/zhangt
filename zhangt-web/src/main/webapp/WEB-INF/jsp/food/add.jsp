<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=GBK"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<link rel="stylesheet" type="text/css" href="/static/css/common/skin/default/css/common.css">
<script type="text/javascript" src="/static/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="/static/js/json2.js"></script>



<script src="/static/js/base.js" type="text/javascript"></script>

<script type="text/javascript" src="/static/js/validate/jquery.validate.js"></script>
<script type="text/javascript" src="/static/js/json2.js"></script>
<script src="/static/js/common.min.js" type="text/javascript"></script>

<link rel="stylesheet" type="text/css" href="/static/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="/static/js/easyui/themes/icon.css">
<script type="text/javascript" src="/static/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="/static/js/easyui/locale/easyui-lang-zh_CN.js"></script>  

<title>添加页面</title>
</head>
<body>
	<!--页面开始，最外层的布局控制-->
	<div class="page-content">
		<form id="frm" >
			<input name="id" type="hidden" value="${food.id}" />
			<!--页面级的工具栏-->
			<div style="margin-top: 5px">
			<div class="toolbar" id="toolbar">
				<div>
					<a href="#" onclick="doSave();" class="easyui-linkbutton" plain="true" data-options="iconCls:'icon-save'">保存</a>
					<a href="#" onclick="goBack();" class="easyui-linkbutton" plain="true" data-options="iconCls:'icon-undo'">返回</a>
				</div>
			</div>
			</div>
			<!--工具栏结束，界面信息分组开始-->
			<div class="panel">
				<!-- <div class="panel-header">
					<h3>基本信息</h3>
				</div> -->
				<div class="panel-body">
					<table class="formTable formTable_4">
						<tr>
							<td class="label">代码：</td>
							<td class="content"><input name="code" id="code" type="text" dataType="Require" msg="请输入代码" value="${food.code}" /><span class="text_red">*</span></td>
							<td class="label">名称：</td>
							<td class="content"><input name="name" id="name" type="text" dataType="Require" msg="请输入名称" value="${food.name}" /><span class="text_red">*</span></td>
						</tr>
						<tr>
							<td class="label">描述：</td>
							<td class="content"><input name="remark" id="remark" type="text" dataType="Require" msg="请输入描述" value="${food.remark}" /><span class="text_red">*</span></td>
							<td class="label">食品分类：</td>
							<input type="hidden" id="foodTypeIdVal" value="${food.foodTypeId}">
							<td class="content">
								<select id="foodTypeId" name="foodTypeId" >
							    	<option value="" >请选择食品分类</option>
								</select>
								<span class="text_red">*</span>
							</td>
						</tr>
						<tr>
							<td class="label">是否打折：</td>
							<td class="content">
								<select id="isDiscount" name="isDiscount" >
							    	<option value="" >请选择是否打折</option>
							    	<option value="0" ${food.isDiscount==0?'selected':''} >否</option>
							    	<option value="1" ${food.isDiscount==1?'selected':''} >是</option>
								</select>
								<span class="text_red">*</span>
							</td>
							<td class="label">价格：</td>
							<td class="content"><input name="price" id="price" type="text" dataType="Require" msg="请输入价格" value="${food.price}" /><span class="text_red">*</span></td>
						</tr>
						<tr>
							<td class="label">原价：</td>
							<td class="content"><input name="oldPrice" id="oldPrice" type="text" dataType="Require" msg="请输入原价" value="${food.oldPrice}" /></td>
						</tr>
					</table>
				</div>
				
			</div>
	</div>
	
	
	</form>

	<script type="text/javascript">
	
	$(document).ready(function(){
		$("#frm").validate({
			debug: true,
			rules: {
				code: { required:true},
				name: { required:true},
				price: { required:true, number:true},
				oldPrice: { number:true},
				isDiscount: { required:true},
				foodTypeId: { required:true}
			},
			messages: {
				code: { required: ' 请填写代码'},
				name: { required: ' 请填写名称'},
				price: { required: ' 请填写价格', number: '价格只能是数字.' },
				oldPrice: { number: '价格只能是数字.' },
				isDiscount: { required: ' 请选择是否打折'},
				foodTypeId: { required: ' 请选择食品分类'}
			},
			//onfocusout:false

			errorContainer: "#AlertTips",
			//errorLabelContainer: "#AlertTips div",
			wrapper: "p",
			submitHandler: function(form) {	
				var tt = $('#frm').serializeObject();
		    	tt2 = JSON.stringify(tt)
		    	 
				jQuery.ajax( {  
			          type : 'POST',  
			          contentType : 'application/json',  
			          url : '/food/foodSave',  
			          data: tt2, 
			          dataType : 'html',  
			          success : function(rst) {  
			        	  $.messager.confirm('信息', rst, function(r){
				  				if (r){
				  					goBack();
				  				}
				  			});
			          },  
			          error : function(data) {  
			            $.messager.alert('信息', "系统错误，请联系管理员");
			          }  
			        }); 
			}
		});
		
		$.ajax({
			type: "POST",
			url : '/foodType/getAllFoodType', 
			success : function(data) {  
				$.each(data,function(index,rst){
					temp = "<option value='"+rst.id+"'>"+rst.name+"</option>";
					$("#foodTypeId").append(temp);
				});
				
				$("#foodTypeId").val($("#foodTypeIdVal").val());
				
			},  
		 	error : function(data) {  
		 		$.messager.alert('信息', "系统错误，请联系管理员"); 
			} 
		});
	})
	
	function doSave() {
		$("#frm").submit();
	}
	
	function goBack() {
		location = "/food"
	}
	</script>
</body>
</html>

