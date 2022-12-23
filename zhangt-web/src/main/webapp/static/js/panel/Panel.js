/**  
 * @fileOverview jqGrid脚本自动加载脚本
 * @author <a href="http://www.ajaxbbs.net" target="_blank">yemoo</a>
 * @version 1.0 
 * @lastupdate 2010-11-02
 *
 * update log
 * 
 * 2010-11-10  自动引入面板的CSS
 */
(function($) { //panel
    /*获取当前文件路径*/
    getCurScriptDir = typeof getCurScriptDir == 'function'? getCurScriptDir : function(curScript, reg){
        if(!curScript){
            var scripts = document.getElementsByTagName('script');
            if(!reg){
                var i = scripts.length - 1;
                curScript = !!document.querySelector ? scripts[i].src : scripts[i].getAttribute("src", 4);
            }else{
                reg = typeof reg == 'object' ? reg : new RegExp(reg.replace(/\//g,'//'),"i");
                for(var i = 0, n = scripts.length; i < n; i++){  
                    var src = !!document.querySelector ? scripts[i].src : scripts[i].getAttribute("src", 4);  
                    if(src && reg.test(src)){
                        curScript = src;
                    }
                }
            }
        }
        return curScript && curScript.substring(0, curScript.lastIndexOf('/') + 1);
    };
    var __DIR__ = getCurScriptDir(null, /\/Panel(?:\.min)?\.js/i);

    var config;
    Panel = function(conf){
        var dftConfig = {
            openText:'收起',    //展开显示的文本
            closeText:'展开',   //收起文本
            ctnCls:'panel',      //面板容器的class,
            hdCls:'panel-header',//header的容器class
            bdCls:'panel-body' //body的容器class
        };
        config = $.extend(dftConfig, conf);
        this.init();
    };
    Panel.prototype = {
        init: function(){
            var $hd = $('<span class="toggleBtn">'+ config.openText +'</span>').appendTo('.' + config.ctnCls+':not(.notoggle) .' + config.hdCls);
            $hd.click(function() {
                var close = $(this).hasClass('close');
                var panelBody = $(this).parents('.' + config.ctnCls).find('.' + config.bdCls);

                $(this)[close ? 'removeClass': 'addClass']('close').html(close ? config.openText: config.closeText);
                panelBody[close ? 'slideDown': 'slideUp']('fast');
            });
        }
    };
    
    $(function(){
        var css = __DIR__ + 'skin/default/style.css';
        document.createStyleSheet ? document.createStyleSheet(css) : $('<link rel="stylesheet" type="text/css" href="'+ css +'" />').appendTo(document.body);
        new Panel();
    });

})(jQuery);