
var DIALOG_POP_WINDOW_PARAM = "dialogWidth:800px; status:no; dialogHeight:500px; statusbar:no; resizable:no;";  //��С��ģʽ����
var web_context="/irms";//����web_app�������Ļ�������ʱд��
/**
 * 1�����ڴ򿪽���ѡ��������ֶ����ԣ������ʼ��ʱ��Ҫ��ʼ��Ϊ������Ϣ��һ����ʵ�����ƣ�һ������ʵ�����ƺ�ӡ�_labletext��������ʾ
 * 2����Σ�obj,paramRule
 * 3��{fromModelIndex:1_1_0,paramRule:[{equipname:zh_label}]}
 * ���������
 * @param obj����Ҫ����ֵ���ֶζ���
 */
function openDialogWindowForModel(obj) {
    var openUrl = web_context+"/display/paramSelectPage_simpleQuery.action?objValue=" + obj.value + "&paramRule=" + obj.rvalue;
    var resultValue = window.showModalDialog(openUrl, null, DIALOG_POP_WINDOW_PARAM);
    if (!resultValue)return false;
    var returnItem = {};
    for (var i = 0; i < resultValue.length; i++) {
        returnItem = resultValue[i];
        document.getElementsByName(returnItem.key)[0].value = returnItem.value;
    }
}
/**
 * �������������ѡ��
 * @param obj
 */
function openDialogWindowForDistrict(obj) {
    var openUrl = web_context+"/location/district_open.action";
    var resultValue = window.showModalDialog(openUrl, null, DIALOG_POP_WINDOW_PARAM);
    if (!resultValue)return false;
    var returnItem = {};
    for (var i = 0; i < resultValue.length; i++) {
        returnItem = resultValue[i];
        document.getElementsByName(returnItem.key)[0].value = returnItem.value;
    }
}
/**
 * ��վ��ѡ��
 * @param obj
 */
function openDialogWindowForSite(obj) {
    var openUrl = web_context+"/location/district_open.action";
    var resultValue = window.showModalDialog(openUrl, null, DIALOG_POP_WINDOW_PARAM);
    if (!resultValue)return false;
    var returnItem = {};
    for (var i = 0; i < resultValue.length; i++) {
        returnItem = resultValue[i];
        document.getElementsByName(returnItem.key)[0].value = returnItem.value;
    }
}

/**
 * �򿪻���ѡ��
 * @param obj
 */
function openDialogWindowForRoom(obj) {
    var openUrl = web_context+"/location/district_open.action";
    var resultValue = window.showModalDialog(openUrl, null, DIALOG_POP_WINDOW_PARAM);
    if (!resultValue)return false;
    var returnItem = {};
    for (var i = 0; i < resultValue.length; i++) {
        returnItem = resultValue[i];
        document.getElementsByName(returnItem.key)[0].value = returnItem.value;
    }
}
