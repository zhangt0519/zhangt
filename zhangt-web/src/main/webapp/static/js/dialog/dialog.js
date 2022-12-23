/****************************
	@说明		: 各种选择弹出窗口
	@Author		: WangDeYu
	@Date		: 2009-04-25
****************************/

/**
 * 以弹出对话框方式打开指定URL,对话框为模态的。
 * @param width 对话框的宽度，可为null.
 * @param height 对话框的高度，可为null.
 * 
 * 调用格式: openDialog(url [,width] [,height] [,param])
 * 
 * @return {Object} 对话框的返回值
 */
function openDialog(){

	var width = screen.width*0.8;//默认宽度
	var height = 570;//默认高度
	var argLen = arguments.length;
	var param = window;//参数对象,默认将当前window对象传过去
	
	if(argLen > 1 && arguments[1] !=null ){
		width = arguments[1];
	}
	if(argLen > 2 && arguments[2] !=null){
		height = arguments[2];
	}
	if(argLen > 3 && arguments[3] !=null){
		param = arguments[3];
	}
	
	//打开对话框
	var reval = window.showModalDialog(arguments[0], param, "dialogHeight="+height+"px; dialogWidth="+width+"px;status=no");
    
	//对话框关闭，判断是否有返回值
	if(reval != null){
		return reval.returnValue;
    }
	return null;    
}
//全屏幕打开
function openDialogFullScreen(){
	var width = window.screen.availWidth;//默认宽度
	var height = window.screen.availHeight;//默认高度
	var argLen = arguments.length;
	var param = window;//参数对象,默认将当前window对象传过去
	
	if(argLen > 1 && arguments[1] !=null ){
		width = arguments[1];
	}
	if(argLen > 2 && arguments[2] !=null){
		height = arguments[3];
	}
	if(argLen > 3 && arguments[3] !=null){
		param = arguments[3];
	}
	//打开对话框
	var reval = window.open(arguments[0], "设备面板", "height="+height+"px,top=0,left=0, width="+width+"px,status=no,resizable=yes，scrollbars=yes");
    
}