/**  
 * @fileOverview jqGrid脚本自动加载脚本
 * @author <a href="http://www.ajaxbbs.net" target="_blank">yemoo</a>
 * @version 1.0 
 * @lastupdate 2010-11-02
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
    var __DIR__ = getCurScriptDir(null, /jqGrid(?:\.min)?\.js/i);

    /*脚本配置*/
    var scriptList = {
        'Base':{
            'Grid base': 'grid.base.js',
            'Formatter': 'jquery.fmatter.js',
            'Custom': 'grid.custom.js'
        },
        'Editing':{
            'Common' : 'grid.common.js',
            'Form Edit' : 'grid.formedit.js',
            'Search Plugin' : 'jquery.searchFilter.js',
            'In place edit' : 'grid.inlinedit.js',
            'Cell Editing' : 'grid.celledit.js',
            'Modal dialog' : 'jqModal.js',
            'Dragging and resizing' :'jqDnR.js'
        },
        'Subgrid':{
            'Subgrid' : 'grid.subgrid.js'   
        },
        'Grouping':{
            'Grouping' :'grid.grouping.js'    
        },
        'TreeGrid':{
            'Tree Grid' : 'grid.treegrid.js'    
        },
        'Import/Export' : {
            'Import/Export' : 'grid.import.js',
            'JSON/Xml utils' : 'JsonXml.js'
        },
        'Other modules':{
            'Columns Hide/Show' : 'grid.setcolumns.js',
            'Post methods' : 'grid.postext.js',
            'Table to Grid' : 'grid.tbltogrid.js'
        },
        'jQuery UI addon methods':{
            'Additional methods using jQuery UI library' : 'grid.jqueryui.js'    
        }
    };
    
    //基础文件
    var scriptHTML = [
        '<script type="text/javascript" src="'+ __DIR__ +'i18n/grid.locale-cn.js"></script>',
        '<script type="text/javascript" src="'+ __DIR__ +'jquery-ui-1.8.2.custom.min.js"></script>'
    ];
    for(var i in scriptList){
        var module = scriptList[i];
        for(var j in module){
            scriptHTML.push('<script type="text/javascript" src="'+ __DIR__ + 'js/' + module[j] +'"></script>');
        };
    }
    //css
    scriptHTML.push('<link rel="stylesheet" href="'+ __DIR__ +'skin/default/jquery-ui-1.8.2.custom.css">');
    scriptHTML.push('<link rel="stylesheet" href="'+ __DIR__ +'css/ui.jqgrid.css">');
    document.write(scriptHTML.join(''));

})(jQuery);