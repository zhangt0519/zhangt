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

<title>���ҳ��</title>
</head>
<body>
	<!--ҳ�濪ʼ�������Ĳ��ֿ���-->
	<div class="page-content">
		<form id="frm" >
			<input name="id" type="hidden" value="${foodType.id}" />
			<!--ҳ�漶�Ĺ�����-->
			<div style="margin-top: 5px">
			<div class="toolbar" id="toolbar">
				<div>
					<a href="#" onclick="doSave();" class="easyui-linkbutton" plain="true" data-options="iconCls:'icon-save'">����</a>
					<a href="#" onclick="goBack();" class="easyui-linkbutton" plain="true" data-options="iconCls:'icon-undo'">����</a>
				</div>
			</div>
			</div>
			<!--������������������Ϣ���鿪ʼ-->
			<div class="panel">
				<!-- <div class="panel-header">
					<h3>������Ϣ</h3>
				</div> -->
				<div class="panel-body">
					<table class="formTable formTable_4">
						<tr>
							<td class="label">���룺</td>
							<td class="content"><input name="code" id="code" type="text" dataType="Require" msg="���������" value="${foodType.code}" /><span class="text_red">*</span></td>
							<td class="label">���ƣ�</td>
							<td class="content"><input name="name" id="name" type="text" dataType="Require" msg="����������" value="${foodType.name}" /><span class="text_red">*</span></td>
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
				name: { required:true}
			},
			messages: {
				//tel: { required: '����д�绰', number: '�绰ֻ��������.' },
				code: { required: ' ����д����'},
				name: { required: ' ����д����'}
			},
			//onfocusout:false,

			errorContainer: "#AlertTips",
			//errorLabelContainer: "#AlertTips div",
			wrapper: "p",
			submitHandler: function(form) {	
				var tt = $('#frm').serializeObject();
		    	tt2 = JSON.stringify(tt)
		    	 
				jQuery.ajax( {  
			          type : 'POST',  
			          contentType : 'application/json',  
			          url : '/foodType/foodTypeSave',  
			          data: tt2, 
			          dataType : 'html',  
			          success : function(rst) {  
			        	  $.messager.confirm('��Ϣ', rst, function(r){
				  				if (r){
				  					goBack();
				  				}
				  			});
			          },  
			          error : function(data) {  
			            $.messager.alert('��Ϣ', "ϵͳ��������ϵ����Ա");
			          }  
			        }); 
			}
		});	
	})
	
	function doSave() {
		$("#frm").submit();
	}
	
	function goBack() {
		location = "/foodType"
	}
	</script>
</body>
</html>

