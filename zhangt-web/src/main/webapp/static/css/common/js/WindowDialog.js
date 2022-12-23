
var DIALOG_POP_WINDOW_PARAM = "dialogWidth:800px; status:no; dialogHeight:500px; statusbar:no; resizable:no;";  //较小的模式窗口
var web_context="/irms";//定义web_app的上下文环境，暂时写死
/**
 * 1、对于打开界面选择参数的字段属性，界面初始化时需要初始化为两对信息，一对是实际名称，一对是在实际名称后加“_labletext”用于显示
 * 2、入参：obj,paramRule
 * 3、{fromModelIndex:1_1_0,paramRule:[{equipname:zh_label}]}
 * 传入参数有
 * @param obj，需要返回值的字段对象
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
 * 打开行政区域参数选择
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
 * 打开站点选择
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
 * 打开机房选择
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
