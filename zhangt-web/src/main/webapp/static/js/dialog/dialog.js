/****************************
	@˵��		: ����ѡ�񵯳�����
	@Author		: WangDeYu
	@Date		: 2009-04-25
****************************/

/**
 * �Ե����Ի���ʽ��ָ��URL,�Ի���Ϊģ̬�ġ�
 * @param width �Ի���Ŀ�ȣ���Ϊnull.
 * @param height �Ի���ĸ߶ȣ���Ϊnull.
 * 
 * ���ø�ʽ: openDialog(url [,width] [,height] [,param])
 * 
 * @return {Object} �Ի���ķ���ֵ
 */
function openDialog(){

	var width = screen.width*0.8;//Ĭ�Ͽ��
	var height = 570;//Ĭ�ϸ߶�
	var argLen = arguments.length;
	var param = window;//��������,Ĭ�Ͻ���ǰwindow���󴫹�ȥ
	
	if(argLen > 1 && arguments[1] !=null ){
		width = arguments[1];
	}
	if(argLen > 2 && arguments[2] !=null){
		height = arguments[2];
	}
	if(argLen > 3 && arguments[3] !=null){
		param = arguments[3];
	}
	
	//�򿪶Ի���
	var reval = window.showModalDialog(arguments[0], param, "dialogHeight="+height+"px; dialogWidth="+width+"px;status=no");
    
	//�Ի���رգ��ж��Ƿ��з���ֵ
	if(reval != null){
		return reval.returnValue;
    }
	return null;    
}
//ȫ��Ļ��
function openDialogFullScreen(){
	var width = window.screen.availWidth;//Ĭ�Ͽ��
	var height = window.screen.availHeight;//Ĭ�ϸ߶�
	var argLen = arguments.length;
	var param = window;//��������,Ĭ�Ͻ���ǰwindow���󴫹�ȥ
	
	if(argLen > 1 && arguments[1] !=null ){
		width = arguments[1];
	}
	if(argLen > 2 && arguments[2] !=null){
		height = arguments[3];
	}
	if(argLen > 3 && arguments[3] !=null){
		param = arguments[3];
	}
	//�򿪶Ի���
	var reval = window.open(arguments[0], "�豸���", "height="+height+"px,top=0,left=0, width="+width+"px,status=no,resizable=yes��scrollbars=yes");
    
}