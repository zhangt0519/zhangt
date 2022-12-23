/*��������ҳ�湫�����⼰�����bug��*/
(function(){
    /*��ȡ��ǰ�ļ�·��*/
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
    //��ȡ�ļ�Ŀ¼·��
    window.getCurScriptDir = function(curScript, reg){
        curScript = curScript || getCurScriptPath(reg);
        return curScript.substring(0, curScript.lastIndexOf('/') + 1);
    };

    //�ű���
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

    //�ļ�·������/�������б�����ģʽ(w:���������ˣ�b:����������)���Ƿ񲻼����������
    var filepath = getCurScriptPath(), flist={}, filter = 'w', kAll = false, devMode = false;
    var params = filepath.substr(filepath.indexOf("?"));
    if(params){
        //�ڰ������б�
        if(/[\?\&](b|w)=([^&]+)/i.test(params)){
            filter = RegExp.$1;
            //�������κ����
            if(filter == 'b' && RegExp.$2.toLowerCase() == 'all') {
                kAll = true;
            }else{  //���β������
                $.each(RegExp.$2.split(','),function(){
                    flist[this] = true;
                });
            }
        }
        //����ģʽ
        if(/[\?\&]m=debug/i.test(params)) devMode = true;
    }

    if(!kAll){
        var dir = getCurScriptDir(filepath);    //��ǰ�ļ�·��
        //����ģʽ/��ͨģʽ
        var scripts = sclibs[ devMode ? 'debug' : 'common'];    
        for(var i in scripts){
            if(filter == 'w' ? flist[i] : !flist[i]) document.write('<script type="text/javascript" src="'+ dir + scripts[i] +'"></script>');
        }
    }

    
    //���IE6 iframe���ֺ��������������
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