//��������·��
var  rootpath = "";

//dtree Ŀ¼
var __dtreeDir__ = (function(){
	var scripts = document.getElementsByTagName('script');
    var curScript = scripts[scripts.length-1];
    return curScript.src.substring(0,curScript.src.lastIndexOf('/')+1);
})();
//�õ���������·��
function getRootPath(){
    
    return __dtreeDir__;
}
//��÷����������·��
function getFacePath(){
    var facePath = "";
    facePath=document.location.href;
    facePath = facePath.substring(facePath.indexOf('//') + 2, facePath.length);
    facePath = facePath.substring(facePath.indexOf('/') + 1, facePath.length);
    facePath = facePath.substring(facePath.indexOf('/'), facePath.length);
    return facePath;
}
/*���¼�����������Dreamweaver�Զ������Ĵ��룬��Ҫ���ڿ���ͼƬ�ı任Ч��*/
function MM_preloadImages() { //v3.0
    var d = document;
    if (d.images) {
        if (!d.MM_p) d.MM_p = new Array();
        var i,j = d.MM_p.length,a = MM_preloadImages.arguments;
        for (i = 0; i < a.length; i++)
            if (a[i].indexOf("#") != 0) {
                d.MM_p[j] = new Image();
                d.MM_p[j++].src = a[i];
            }
    }
}

function MM_swapImgRestore() { //v3.0
    var i,x,a = document.MM_sr;
    for (i = 0; a && i < a.length && (x = a[i]) && x.oSrc; i++) x.src = x.oSrc;
}

function MM_findObj(n, d) { //v4.01
    var p,i,x;
    if (!d) d = document;
    if ((p = n.indexOf("?")) > 0 && parent.frames.length) {
        d = parent.frames[n.substring(p + 1)].document;
        n = n.substring(0, p);
    }
    if (!(x = d[n]) && d.all) x = d.all[n];
    for (i = 0; !x && i < d.forms.length; i++) x = d.forms[i][n];
    for (i = 0; !x && d.layers && i < d.layers.length; i++) x = MM_findObj(n, d.layers[i].document);
    if (!x && d.getElementById) x = d.getElementById(n);
    return x;
}

function MM_swapImage() { //v3.0
    var i,j = 0,x,a = MM_swapImage.arguments;
    document.MM_sr = new Array;
    for (i = 0; i < (a.length - 2); i += 3)
        if ((x = MM_findObj(a[i])) != null) {
            document.MM_sr[j++] = x;
            if (!x.oSrc) x.oSrc = x.src;
            x.src = a[i + 2];
        }
}

//����������ͼ��
function hideViewArea() {
    top.main.cols = "9,*";
    top.viewArea.cols = "0,9";
	//top.headFrame.img1.style.visibility="hidden";
	//top.headFrame.img2.style.visibility="hidden";
    var imageId = top.sizeControlFrame.document.getElementById("image");
    //var imgSrc = "<a href=" + "javascript:showViewArea();" + "><img src='default/images/showRight.gif' name='leftImage' width='8' height='66' border='0' id='leftImage' onMouseOver=" + " MM_swapImage('leftImage','','default/images/showRightOver.gif',1)" + " onMouseOut=" + " MM_swapImgRestore()" + "></a>";
    var imgSrc = "<a href=" + "javascript:showViewArea();" + "><img src='/static/jsp/frame/common/images/showRight.gif' name='leftImage' width='8' height='66' border='0' id='leftImage' onMouseOver=" + " MM_swapImage('leftImage','','/static/jsp/frame/common/images/showRightOver.gif',1)" + " onMouseOut=" + " MM_swapImgRestore()" + "></a>";
    imageId.innerHTML = imgSrc;
    if(typeof top.mainFrame.areachangstate!="undefined" && typeof top.mainFrame.areachangstate=="function"){
       top.mainFrame.areachangstate();
    }
  
}

//��ʾ������ͼ��
function showViewArea() {
    top.main.cols = "207,*";
    top.viewArea.cols = "200,9";
    //top.headFrame.img1.style.visibility="visible";
	//top.headFrame.img2.style.visibility="visible";
    var imageId = top.sizeControlFrame.document.getElementById("image");
    // var imgSrc = "<a href=" + "javascript:hideViewArea();" + "><img src='default/images/hideLeft.gif' name='leftImage' width='8' height='66' border='0' id='leftImage' onMouseOver=" + " MM_swapImage('leftImage','','default/images/hideLeftOver.gif',1)" + " onMouseOut=" + " MM_swapImgRestore()" + "></a>";
    var imgSrc = "<a href=" + "javascript:hideViewArea();" + "><img src='/static/jsp/frame/common/images/hideLeft.gif' name='leftImage' width='8' height='66' border='0' id='leftImage' onMouseOver=" + " MM_swapImage('leftImage','','/static/jsp/frame/common/images/hideLeftOver.gif',1)" + " onMouseOut=" + " MM_swapImgRestore()" + "></a>";
    imageId.innerHTML = imgSrc;
    if(typeof top.mainFrame.areachangstate!="undefined" && typeof top.mainFrame.areachangstate=="function"){
       top.mainFrame.areachangstate();
    }
}
//�������ص�����ͼ
function hideNavigateView() {
    top.navigateView.rows = "*,8";
    var imageId = top.navigateFrame.document.getElementById("image");
    //var imgSrc = "<a href=" + "javascript:showNavigateView();" + "><img src='default/images/showUp.gif' name='Image2' width='50' height='7' border='0' id='Image2' onMouseOver=" + " MM_swapImage('Image2','','default/images/showUpOver.gif',1)" + " onMouseOut=" + " MM_swapImgRestore()" + "></a>";
    var imgSrc = "<a href=" + "javascript:showNavigateView();" + "><img src='/static/jsp/frame/common/images/showUp.gif' name='Image2' width='50' height='7' border='0' id='Image2' onMouseOver=" + " MM_swapImage('Image2','','/static/jsp/frame/common/images/showUpOver.gif',1)" + " onMouseOut=" + " MM_swapImgRestore()" + "></a>";
    imageId.innerHTML = imgSrc;
}
//������ʾ������ͼ
function showNavigateView() {
    top.navigateView.rows = "*,250";
    var imageId = top.navigateFrame.document.getElementById("image");
    // var imgSrc = "<a href=" + "javascript:hideNavigateView();" + "><img src='default/images/hideDown.gif' name='Image2' width='50' height='7' border='0' id='Image2' onMouseOver=" + " MM_swapImage('Image2','','default/images/hideDownOver.gif',1)" + " onMouseOut=" + " MM_swapImgRestore()" + "></a>";
    var imgSrc = "<a href=" + "javascript:hideNavigateView();" + "><img src='/static/jsp/frame/common/images/hideDown.gif' name='Image2' width='50' height='7' border='0' id='Image2' onMouseOver=" + " MM_swapImage('Image2','','/static/jsp/frame/common/images/hideDownOver.gif',1)" + " onMouseOut=" + " MM_swapImgRestore()" + "></a>";
    imageId.innerHTML = imgSrc;
}



