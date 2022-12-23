/**  
 * @fileOverview tab面板操作类 
 * @author <a href="http://www.ajaxbbs.net" target="_blank">yemoo</a>
 * @version 1.0 
 * @lastupdate 2010-11-01
 */ 
var TabPanel = function(){};
(function($){
    /*组件全局变量*/
    var container, config = {}, idCache = {}, tabCount = 0, tabCache = {header:[],body:[]};
    var header, body, footer;
    
    /*模板解析*/
    var parseTpl = function(tpl,obj){
        return tpl.replace(/\{([^}]+)\}/g,function(o,i){
            return obj[i] || '';
        });
    };
    
    var isIE6 = $.browser.msie && $.browser.version == '6.0';
    /*转换为数字*/
    var toInt = function(o){
        return !isNaN(parseInt(o)) ? parseInt(o) : 0;
    };
    /*获取上下边框及margin总和*/
    var getPx = function(o){
        return toInt(o.css('margin-top')) + toInt(o.css('margin-bottom')) + toInt(o.css('border-top-width')) + toInt(o.css('border-bottom-width'));
    };
    /*获取左右边框及margin总和*/
    var getHpx = function(o){
        return toInt(o.css('margin-left')) + toInt(o.css('margin-right')) + toInt(o.css('border-right-width')) + toInt(o.css('border-left-width'));
    };
    /*获取当前文件路径*/
    var scripts = document.getElementsByTagName('script');
    var curScript = scripts[scripts.length - 1];
    var __DIR__ =  curScript.src.substring(0, curScript.src.lastIndexOf('/') + 1);

    //判断总宽度是否超出容器
    var calcTab = function(){
        while(parseInt(header.attr('iw')) > parseInt(header.attr('w'))){
            this.removeTab(config.owIndex);
        };
    };
    /**
     * @requires jQuery 
     * @class TabPanel类
     */
    TabPanel = function(id,conf){
        container = $(id);
        /*全局配置*/
        var dftConfig = {
            max: -1, //最多允许的tab数
            defaultIcon: null,    //图标，如果是null，则默认没有图标，否则作为默认图标使用
            showClose: false, //是否显示关闭图标
            owIndex: 1,  //达到最多tab标签后默认冲掉的tab（索引号）
            blankImg: __DIR__ + "skin/blank.gif",    //IE6使用
            tpl:{
                hd:'<li id="{id}" class="{closeCls}"><s class="il"></s><s class="ir"></s>{icon}{title}{closeicon}</li>',
                bd:'<iframe src="{url}" frameborder="0" scrolling="auto" border="0" id="{id}_body"  width="100%"></iframe>'
            }
        };
        if(!container.length || !container[0].nodeType) return alert('无法渲染，容器不存在！');

        config = $.extend(dftConfig, conf);

        /*意外参数处理*/
        if(isNaN(parseInt(config.max))) config.max = dftConfig.max;
        if(!config.tpl || !config.hd || !config.bd) config.tpl = dftConfig.tpl;
        if(isNaN(parseInt(config.owIndex))) config.owIndex = dftConfig.owIndex;
        config.owIndex = Math.min(Math.max(config.owIndex,0),config.max - 1);

        /*初始化结构*/
        container.addClass('tabpanel');
        var oHeader = $('<div class="tab-header"><s class="l"></s><s class="r"></s><ul></ul></div>').appendTo(container);
        header = oHeader.find('ul').eq(0);
       header.attr('w', header.width());  //记录总宽
        header.attr('iw', 0); //内部Tab总宽

        body = $('<div class="tab-body"></div>').appendTo(container);
        //footer = $('<div class="tabFoot"><s class="l"></s><s class="r"></s></div>').appendTo(el);
        
        /*其他处理:bindEvent, resize等*/
        header.click($.proxy(this.headerClick, this));
        var otherHeight = getPx(oHeader) + oHeader.height() + getPx(body);
        body.height(container.height() - otherHeight);
        var _this = this;
        
        $(window).resize(function(){
            header.attr('w', header.width());  //记录总宽
            calcTab.call(_this);

            body.hide().height(container.height() - otherHeight).show();
        });
    };
    TabPanel.prototype={
        /**  
         * @param {Object} conf 配置项，包含url,title,icon属性。 
         * @param {Boolean} reload 是否强制重新加载
         */
        showTab : function(conf,reload){   //显示某个tab，存在则直接显示，否则创建
            this.hasTab(conf) ? this.activeTab(conf,reload) : this.addTab(conf);
            return this;
        },
        /**  
         * @param {Object} conf 配置项，包含url属性。 
         */
        activeTab:function(conf,reload){   //直接显示某个tab
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
         * @param {Object} conf 配置项，包含url,title,icon属性。 
         */
        addTab: function(conf){ //创建tab
            if(parseInt(config.max) > 0 && tabCount >= parseInt(config.max)){
                this.removeTab(config.owIndex);
            }
            var id = this.getId(conf);
            var icon = conf.icon || config.defaultIcon;
            icon = isIE6 ? "<img src='"+ config.blankImg +"' style=\"filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='image', src='" + icon + "')\" />" : "<img src='" + icon + "' />";
            
            var showClose = conf.showClose == undefined ? config.showClose : conf.showClose;
            var closeicon = showClose ? "<s class='close' title='关闭'>关闭</s>" : '';

            var data = $.extend(conf, {id:id,icon:icon,closeicon:closeicon,closeCls: showClose ? 'closeCls' : ''});
            var hd,bd;
            tabCache.header.push(hd = $(parseTpl(config.tpl.hd, data)).appendTo(header));
            tabCache.body.push(bd = $(parseTpl(config.tpl.bd, data)).appendTo(body));
            tabCount ++;
            
            header.attr('iw', parseInt(header.attr('iw')) + parseInt(hd.attr('w', hd.outerWidth()+getHpx(hd)).attr('w')));   //增加内容总宽
            calcTab.call(this);

            this.activeTab(conf);
            if($.isFunction(config.onAdd)) config.onAdd.apply(this,[id,hd,bd]);
            return this;
        },
        /**  
         * @param {number} index 要删除的Tab页的索引号。 
         */
        removeTab:function(index, autoActive){
            if(!tabCache.header[index]) return;

            this.fixIFrame(tabCache.body[index]);   //释放iframe内存
            
            var hd = tabCache.header[index].remove();
            var bd = tabCache.body[index].remove();
            header.attr('iw', header.attr('iw') - hd.attr('w'));

            tabCache.header.splice(index, 1);
            tabCache.body.splice(index, 1);
            -- tabCount;

            try{CollectGarbage();}catch(e){}
            if($.isFunction(config.onRemove)) config.onRemove.apply(this,[hd.attr('id'),hd,bd]);
            //自动激活相邻的Tab
            if(autoActive){
                var active = (index == tabCount) ? index - 1 : index;
                this.activeTab(tabCache.header[active].attr('id'));
            }
            return this;
        },
        /**  
         * @param {Object} conf 配置项，包含url属性。 
         */
        hasTab : function(conf){    //某个tab是否存在
            return $('#' + this.getId(conf)).length;
        },
        /**  
         * @param {Object} conf 配置项，包含url属性。 
         */
        getId:function(conf){    //根据url获取tab的id
            if(conf.id) return conf.id;
            if(!conf || !conf.url || typeof conf == 'string') return conf || '';
            return idCache[conf.url] || (idCache[conf.url] = conf.url.replace(/[\/\.\?\&\:\=]/g,'_'));
        },
        /**  
         * @param {Object} iframe 要销毁的iframe元素或者其父容器。 
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
         * @param {String} id 根据元素id获取元素的索引 
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