/**  
 * @fileOverview jqGrid�ű��Զ����ؽű�
 * @author <a href="http://www.ajaxbbs.net" target="_blank">yemoo</a>
 * @version 1.0 
 * 
 * update log
 *
 * 2010-11-10 ֧��ͨ������unloadValidator=true����ֹ�Զ�������֤���
 *            ����button.css���������Զ�����button��CSS
 * 2010-11-8  Ϊģ�ⰴť�ṩ���ύ�����ù��ܣ�֧�ֱ���֤
 * 2010-11-2  �����hoverЧ��,��λ��굽��һ�������
 */ 
(function($){
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
    var __DIR__ = getCurScriptDir(null, /Form(?:\.min)?\.js/i);

    $(function(){
        //�����hoverЧ��
        var $ipt = $('input:text,textarea,input:file', $('.formTable:not(.formTable_no)')).hover(function(){
            $(this).addClass('inputHover');
        },function(){
            if(document.activeElement!=this){
                $(this).removeClass('inputHover');
            }
        }).focus(function(){
            $(this).addClass('inputHover');
        }).blur(function(){
            $(this).removeClass('inputHover');
        });

        /*��λ��굽��һ�������*/
        if($ipt.length){
            $ipt.eq(0).focus(); 
            //IE��λ��굽�ı���ĩβ
            /*
            if($.browser.msie){
                var range = $ipt[0].createTextRange();    
                range.moveStart('character',$ipt.val().length);    
                range.collapse(true);    
                range.select();
            }
            */
        }
        
        /*���ذ�ť��CSS*/
        var btnCSS = __DIR__ + "button/skin/default/style.css";
        document.createStyleSheet ? document.createStyleSheet(btnCSS) : $('<link rel="stylesheet" type="text/css" href="'+ btnCSS +'" />').appendTo(document.body);
        /*Ϊģ�ⰴť�ṩ���ύ�����ù���*/
        $('a.btn').click(function(e){
            e.preventDefault();
            //��ͨ��ťֻȡ��������Ϊ
            if(!$(this).hasClass('submit') && !$(this).hasClass('reset')) return;   

            var thisForm = $(this).parents('form');
            if(!thisForm.length) return;

            //�ύ�����ñ�
            if($(this).hasClass('submit')){
                thisForm.submit();
            }else{
                thisForm[0].reset();
            }
        });
        
        //�Ƿ��Զ�������֤���
       // if(window['unloadValidator'] !== true){
           // /*�󶨱���֤����*/
           // var js = __DIR__ + "Validator/jquery.validate.min.js", css = __DIR__ + "Validator/css/style.css";
           // $('<script type="text/javascript" src="'+ js +'"></script>').appendTo(document.body);
            //document.createStyleSheet ? document.createStyleSheet(css) : $('<link rel="stylesheet" type="text/css" href="'+ css +'" />').appendTo(document.body);

           // $("form").each(function(){
              //  $(this).validate({onkeyup:false});
            //});
       // }
    });
})(jQuery);