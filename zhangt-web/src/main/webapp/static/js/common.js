/*用来处理页面公共问题及浏览器bug等*/
(function(){
    /*获取当前文件路径*/
    window.getCurScriptPath = function(reg){
        var scripts = document.getElementsByTagName('script');
        if(!reg){
            var i = scripts.length - 1;
            return !!document.querySelector ? scripts[i].src : scripts[i].getAttribute("src", 4);
        }else{
            reg = typeof reg == 'object' ? reg : new RegExp(reg.replace(/\//g,'//'),"i");
            for(var i = 0, n = scripts.length; i < n; i++){  
                var curScript = !!document.querySelector ? scripts[i].src : scripts[i].getAttribute("src", 4);  
                if(curScript && reg.test(curScript)){
                    return curScript;
                }
            }
        }
    };
    //获取文件目录路径
    window.getCurScriptDir = function(curScript, reg){
        curScript = curScript || getCurScriptPath(reg);
        return curScript.substring(0, curScript.lastIndexOf('/') + 1);
    };

    //脚本库
    var sclibs = {
        common:{
            'form': 'form/Form.js',
            'datepicker': 'form/DatePicker/WdatePicker.js',
            'panel': 'panel/Panel.min.js',
            'tab': 'tab/TabPanel.min.js',
            'grid': 'jqGrid/jqGrid.min.js'
        },
        debug:{
            'form': 'form/Form.js',
            'datepicker': 'form/DatePicker/WdatePicker.js',
            'panel': 'panel/Panel.js',
            'tab': 'tab/TabPanel.js',
            'grid': 'jqGrid/jqGrid.js'
        }
    };

    //文件路径，黑/白名单列表，过滤模式(w:白名单过滤，b:黑名单过滤)，是否不加载所有组件
    var filepath = getCurScriptPath(), flist={}, filter = 'w', kAll = false, devMode = false;
    var params = filepath.substr(filepath.indexOf("?"));
    if(params){
        //黑白名单列表
        if(/[\?\&](b|w)=([^&]+)/i.test(params)){
            filter = RegExp.$1;
            //不加载任何组件
            if(filter == 'b' && RegExp.$2.toLowerCase() == 'all') {
                kAll = true;
            }else{  //屏蔽部分组件
                $.each(RegExp.$2.split(','),function(){
                    flist[this] = true;
                });
            }
        }
        //开发模式
        if(/[\?\&]m=debug/i.test(params)) devMode = true;
    }

    if(!kAll){
        var dir = getCurScriptDir(filepath);    //当前文件路径
        //开发模式/普通模式
        var scripts = sclibs[ devMode ? 'debug' : 'common'];    
        for(var i in scripts){
            if(filter == 'w' ? flist[i] : !flist[i]) document.write('<script type="text/javascript" src="'+ dir + scripts[i] +'"></script>');
        }
    }

    
    //解决IE6 iframe出现横向滚动条的问题
    if($.browser.msie && $.browser.version == "6.0"){
        var fixIE6Scroller = function(){
            if($("html")[0].scrollHeight > $("html").height()){
                $("html").css("overflowY","scroll");
            }else{
                $("html").css("overflowY","auto");
            }
            document.body.style.zoom = 1.1;
            document.body.style.zoom = 1;
        };
        $(fixIE6Scroller);
        $(window).resize(fixIE6Scroller);
    }

})();