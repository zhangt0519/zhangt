/**  
 * @fileOverview tab�������� 
 * @author <a href="http://www.ajaxbbs.net" target="_blank">yemoo</a>
 * @version 1.0 
 * @lastupdate 2010-11-01
 */ 
var TabPanel = function(){};
(function($){
    /*���ȫ�ֱ���*/
    var container, config = {}, idCache = {}, tabCount = 0, tabCache = {header:[],body:[]};
    var header, body, footer;
    
    /*ģ�����*/
    var parseTpl = function(tpl,obj){
        return tpl.replace(/\{([^}]+)\}/g,function(o,i){
            return obj[i] || '';
        });
    };
    
    var isIE6 = $.browser.msie && $.browser.version == '6.0';
    /*ת��Ϊ����*/
    var toInt = function(o){
        return !isNaN(parseInt(o)) ? parseInt(o) : 0;
    };
    /*��ȡ���±߿�margin�ܺ�*/
    var getPx = function(o){
        return toInt(o.css('margin-top')) + toInt(o.css('margin-bottom')) + toInt(o.css('border-top-width')) + toInt(o.css('border-bottom-width'));
    };
    /*��ȡ���ұ߿�margin�ܺ�*/
    var getHpx = function(o){
        return toInt(o.css('margin-left')) + toInt(o.css('margin-right')) + toInt(o.css('border-right-width')) + toInt(o.css('border-left-width'));
    };
    /*��ȡ��ǰ�ļ�·��*/
    var scripts = document.getElementsByTagName('script');
    var curScript = scripts[scripts.length - 1];
    var __DIR__ =  curScript.src.substring(0, curScript.src.lastIndexOf('/') + 1);

    //�ж��ܿ���Ƿ񳬳�����
    var calcTab = function(){
        while(parseInt(header.attr('iw')) > parseInt(header.attr('w'))){
            this.removeTab(config.owIndex);
        };
    };
    /**
     * @requires jQuery 
     * @class TabPanel��
     */
    TabPanel = function(id,conf){
        container = $(id);
        /*ȫ������*/
        var dftConfig = {
            max: -1, //��������tab��
            defaultIcon: null,    //ͼ�꣬�����null����Ĭ��û��ͼ�꣬������ΪĬ��ͼ��ʹ��
            showClose: false, //�Ƿ���ʾ�ر�ͼ��
            owIndex: 1,  //�ﵽ���tab��ǩ��Ĭ�ϳ����tab�������ţ�
            blankImg: __DIR__ + "skin/blank.gif",    //IE6ʹ��
            tpl:{
                hd:'<li id="{id}" class="{closeCls}"><s class="il"></s><s class="ir"></s>{icon}{title}{closeicon}</li>',
                bd:'<iframe src="{url}" frameborder="0" scrolling="auto" border="0" id="{id}_body"  width="100%"></iframe>'
            }
        };
        if(!container.length || !container[0].nodeType) return alert('�޷���Ⱦ�����������ڣ�');

        config = $.extend(dftConfig, conf);

        /*�����������*/
        if(isNaN(parseInt(config.max))) config.max = dftConfig.max;
        if(!config.tpl || !config.hd || !config.bd) config.tpl = dftConfig.tpl;
        if(isNaN(parseInt(config.owIndex))) config.owIndex = dftConfig.owIndex;
        config.owIndex = Math.min(Math.max(config.owIndex,0),config.max - 1);

        /*��ʼ���ṹ*/
        container.addClass('tabpanel');
        var oHeader = $('<div class="tab-header"><s class="l"></s><s class="r"></s><ul></ul></div>').appendTo(container);
        header = oHeader.find('ul').eq(0);
       header.attr('w', header.width());  //��¼�ܿ�
        header.attr('iw', 0); //�ڲ�Tab�ܿ�

        body = $('<div class="tab-body"></div>').appendTo(container);
        //footer = $('<div class="tabFoot"><s class="l"></s><s class="r"></s></div>').appendTo(el);
        
        /*��������:bindEvent, resize��*/
        header.click($.proxy(this.headerClick, this));
        var otherHeight = getPx(oHeader) + oHeader.height() + getPx(body);
        body.height(container.height() - otherHeight);
        var _this = this;
        
        $(window).resize(function(){
            header.attr('w', header.width());  //��¼�ܿ�
            calcTab.call(_this);

            body.hide().height(container.height() - otherHeight).show();
        });
    };
    TabPanel.prototype={
        /**  
         * @param {Object} conf ���������url,title,icon���ԡ� 
         * @param {Boolean} reload �Ƿ�ǿ�����¼���
         */
        showTab : function(conf,reload){   //��ʾĳ��tab��������ֱ����ʾ�����򴴽�
            this.hasTab(conf) ? this.activeTab(conf,reload) : this.addTab(conf);
            return this;
        },
        /**  
         * @param {Object} conf ���������url���ԡ� 
         */
        activeTab:function(conf,reload){   //ֱ����ʾĳ��tab
            var id = this.getId(conf);
            $.each(tabCache.header,function(){
                this.removeClass('active');
            })
            var hd = $('#'+id).addClass('active');
            $.each(tabCache.body,function(){
                this.css('display','none');
            });
            var bd = $('#'+id+'_body').css('display','block');
            if(reload){
                var ifrm = bd.get(0), src = ifrm.src;
                ifrm.src = "javascript:false";
                ifrm.src = conf.url || src;
            }
            if($.isFunction(config.onActive)) config.onActive.apply(this,[id,hd,bd]);
            return this;
        },
        /**  
         * @param {Object} conf ���������url,title,icon���ԡ� 
         */
        addTab: function(conf){ //����tab
            if(parseInt(config.max) > 0 && tabCount >= parseInt(config.max)){
                this.removeTab(config.owIndex);
            }
            var id = this.getId(conf);
            var icon = conf.icon || config.defaultIcon;
            icon = isIE6 ? "<img src='"+ config.blankImg +"' style=\"filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='image', src='" + icon + "')\" />" : "<img src='" + icon + "' />";
            
            var showClose = conf.showClose == undefined ? config.showClose : conf.showClose;
            var closeicon = showClose ? "<s class='close' title='�ر�'>�ر�</s>" : '';

            var data = $.extend(conf, {id:id,icon:icon,closeicon:closeicon,closeCls: showClose ? 'closeCls' : ''});
            var hd,bd;
            tabCache.header.push(hd = $(parseTpl(config.tpl.hd, data)).appendTo(header));
            tabCache.body.push(bd = $(parseTpl(config.tpl.bd, data)).appendTo(body));
            tabCount ++;
            
            header.attr('iw', parseInt(header.attr('iw')) + parseInt(hd.attr('w', hd.outerWidth()+getHpx(hd)).attr('w')));   //���������ܿ�
            calcTab.call(this);

            this.activeTab(conf);
            if($.isFunction(config.onAdd)) config.onAdd.apply(this,[id,hd,bd]);
            return this;
        },
        /**  
         * @param {number} index Ҫɾ����Tabҳ�������š� 
         */
        removeTab:function(index, autoActive){
            if(!tabCache.header[index]) return;

            this.fixIFrame(tabCache.body[index]);   //�ͷ�iframe�ڴ�
            
            var hd = tabCache.header[index].remove();
            var bd = tabCache.body[index].remove();
            header.attr('iw', header.attr('iw') - hd.attr('w'));

            tabCache.header.splice(index, 1);
            tabCache.body.splice(index, 1);
            -- tabCount;

            try{CollectGarbage();}catch(e){}
            if($.isFunction(config.onRemove)) config.onRemove.apply(this,[hd.attr('id'),hd,bd]);
            //�Զ��������ڵ�Tab
            if(autoActive){
                var active = (index == tabCount) ? index - 1 : index;
                this.activeTab(tabCache.header[active].attr('id'));
            }
            return this;
        },
        /**  
         * @param {Object} conf ���������url���ԡ� 
         */
        hasTab : function(conf){    //ĳ��tab�Ƿ����
            return $('#' + this.getId(conf)).length;
        },
        /**  
         * @param {Object} conf ���������url���ԡ� 
         */
        getId:function(conf){    //����url��ȡtab��id
            if(conf.id) return conf.id;
            if(!conf || !conf.url || typeof conf == 'string') return conf || '';
            return idCache[conf.url] || (idCache[conf.url] = conf.url.replace(/[\/\.\?\&\:\=]/g,'_'));
        },
        /**  
         * @param {Object} iframe Ҫ���ٵ�iframeԪ�ػ����丸������ 
         */
        fixIFrame : function(iframe) {
            iframe = $(iframe);
            if(!iframe.length) return;
            if(iframe.get(0).tagName.toLowerCase()!='iframe') iframe = iframe.find('iframe');
            if(iframe.length > 0){
                iframe.each(function(){
                    this.src = "javascript:false";
                });
            }
        }, 
        /**  
         * @param {String} id ����Ԫ��id��ȡԪ�ص����� 
         */
        getIndexById: function(id){
            var index = -1;
            $.each(tabCache.header, function(i){
                if(this.attr('id') == id){
                    index = i;
                    return false;
                }
            });
            return index;
        },
        /**
         * @ignore
         */
        headerClick:function(e){
            var target = e.target, tagName = target.tagName.toLowerCase(), action='active';
            if($(target).hasClass('close')) action = 'remove';
            if(tagName == 'span' || tagName == 's') target = $(target).parent('li').get(0);
            if(target.tagName.toLowerCase() != 'li') return;
 
            action == 'active' ? this.activeTab(target.id) : this.removeTab(this.getIndexById(target.id),true);
        }
    };
})(jQuery);