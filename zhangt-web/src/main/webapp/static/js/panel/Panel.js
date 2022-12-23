/**  
 * @fileOverview jqGrid�ű��Զ����ؽű�
 * @author <a href="http://www.ajaxbbs.net" target="_blank">yemoo</a>
 * @version 1.0 
 * @lastupdate 2010-11-02
 *
 * update log
 * 
 * 2010-11-10  �Զ���������CSS
 */
(function($) { //panel
    /*��ȡ��ǰ�ļ�·��*/
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
            openText:'����',    //չ����ʾ���ı�
            closeText:'չ��',   //�����ı�
            ctnCls:'panel',      //���������class,
            hdCls:'panel-header',//header������class
            bdCls:'panel-body' //body������class
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