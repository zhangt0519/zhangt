/**  
 * @fileOverview jqGrid脚本自动加载脚本
 * @author <a href="http://www.ajaxbbs.net" target="_blank">yemoo</a>
 * @version 1.0 
 * 
 * update log
 *
 * 2010-11-10 支持通过声明unloadValidator=true来禁止自动加载验证组件
 *            整理button.css到组件里，并自动加载button的CSS
 * 2010-11-8  为模拟按钮提供表单提交与重置功能，支持表单验证
 * 2010-11-2  输入框hover效果,定位鼠标到第一个输入框
 */ 
(function($){
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
    var __DIR__ = getCurScriptDir(null, /Form(?:\.min)?\.js/i);

    $(function(){
        //输入框hover效果
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

        /*定位鼠标到第一个输入框*/
        if($ipt.length){
            $ipt.eq(0).focus(); 
            //IE定位光标到文本框末尾
            /*
            if($.browser.msie){
                var range = $ipt[0].createTextRange();    
                range.moveStart('character',$ipt.val().length);    
                range.collapse(true);    
                range.select();
            }
            */
        }
        
        /*加载按钮的CSS*/
        var btnCSS = __DIR__ + "button/skin/default/style.css";
        document.createStyleSheet ? document.createStyleSheet(btnCSS) : $('<link rel="stylesheet" type="text/css" href="'+ btnCSS +'" />').appendTo(document.body);
        /*为模拟按钮提供表单提交与重置功能*/
        $('a.btn').click(function(e){
            e.preventDefault();
            //普通按钮只取消链接行为
            if(!$(this).hasClass('submit') && !$(this).hasClass('reset')) return;   

            var thisForm = $(this).parents('form');
            if(!thisForm.length) return;

            //提交或重置表单
            if($(this).hasClass('submit')){
                thisForm.submit();
            }else{
                thisForm[0].reset();
            }
        });
        
        //是否自动引入验证框架
       // if(window['unloadValidator'] !== true){
           // /*绑定表单验证功能*/
           // var js = __DIR__ + "Validator/jquery.validate.min.js", css = __DIR__ + "Validator/css/style.css";
           // $('<script type="text/javascript" src="'+ js +'"></script>').appendTo(document.body);
            //document.createStyleSheet ? document.createStyleSheet(css) : $('<link rel="stylesheet" type="text/css" href="'+ css +'" />').appendTo(document.body);

           // $("form").each(function(){
              //  $(this).validate({onkeyup:false});
            //});
       // }
    });
})(jQuery);