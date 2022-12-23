<%@page import="com.zhangt.sjz.domain.User"%>
<%@ page contentType="text/html;charset=GBK"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=GBK"/>
    <title>系统功能权限菜单</title>
    <link href="/static/jsp/frame/common/style/frame.css" rel="stylesheet" type="text/css">
    <link href="/static/jsp/frame/dtree/dtree.css" rel="stylesheet" type="text/css">
    <script src="/static/jsp/frame/dtree/dtree.js" type="text/javascript"></script>
    <script src="/static/jsp/frame/common/script/MSIE.PNG.js" type="text/javascript"></script>
</head>
<script language="JavaScript">
/**
 *写出带有链接的子菜单
 */
function showitem(id, name) {
    return ("<span><a href='" + id + "' target=_blank>" + name + "</a></span><br>")
}

/**
 *选择菜单项
 */
function switchoutlookBar(number) {
    var i = outlookbar.opentitle;
    outlookbar.opentitle = number;
    var id1,id2,id1b,id2b
    if (number != i && outlooksmoothstat == 0) {
        if (number != -1) {
            if (i == -1) {
                id2 = "blankdiv";
                id2b = "blankdiv";
            } else {
                id2 = "outlookdiv" + i;
                id2b = "outlookdivin" + i;
                //		document.all("outlooktitle"+i).style.border="1px none navy";
                document.all("outlooktitle" + i).style.background = outlookbar.maincolor;
                document.all("outlooktitle" + i).style.color = "#000000";
                document.all("outlooktitle" + i).style.textalign = "center";
                document.all("outlooktitle" + i).style.fontWeight = "normal";
            }
            id1 = "outlookdiv" + number
            id1b = "outlookdivin" + number
            //	document.all("outlooktitle"+number).style.border="1px none white";
            document.all("outlooktitle" + number).style.background = outlookbar.highlightcolor;
            //title
            document.all("outlooktitle" + number).style.color = "#000000";
            document.all("outlooktitle" + number).style.textalign = "center";
            document.all("outlooktitle" + number).style.fontWeight = "bold";
            smoothout(id1, id2, id1b, id2b, 0);
        } else {
            document.all("blankdiv").style.display = "";
            document.all("blankdiv").sryle.height = "100%";
            document.all("outlookdiv" + i).style.display = "none";
            document.all("outlookdiv" + i).style.height = "0%";
            //	document.all("outlooktitle"+i).style.border="1px none navy";
            document.all("outlooktitle" + i).style.background = outlookbar.maincolor;
            document.all("outlooktitle" + i).style.color = "#000000";
            document.all("outlooktitle" + i).style.textalign = "center";
        }
    }
}
function smoothout(id1, id2, id1b, id2b, stat) {
    if (stat == 0) {
        tempinnertext1 = document.all(id1b).innerHTML;
        tempinnertext2 = document.all(id2b).innerHTML;
        document.all(id1b).innerHTML = "";
        document.all(id2b).innerHTML = "";
        outlooksmoothstat = 1;
        document.all(id1b).style.overflow = "hidden";
        document.all(id2b).style.overflow = "hidden";
        document.all(id1).style.height = "0%";
        document.all(id1).style.display = "";
        setTimeout("smoothout('" + id1 + "','" + id2 + "','" + id1b + "','" + id2b + "'," + outlookbar.inc + ")", outlookbar.timedalay);
    } else {
        stat += outlookbar.inc;
        if (stat > 100) {
            stat = 100;
        }
        document.all(id1).style.height = stat + "%";
        document.all(id2).style.height = (100 - stat) + "%";
        if (stat < 100) {
            setTimeout("smoothout('" + id1 + "','" + id2 + "','" + id1b + "','" + id2b + "'," + stat + ")", outlookbar.timedalay);
        } else {
            document.all(id1b).innerHTML = tempinnertext1;
            document.all(id2b).innerHTML = tempinnertext2;
            outlooksmoothstat = 0;
            document.all(id1b).style.overflow = "auto";
            document.all(id2).style.display = "none";
        }
    }
}

function getOutLine() {
    outline = "<table " + outlookbar.otherclass + ">";
    for (i = 0; i < (outlookbar.titlelist.length); i++) {
        outline += "<tr><td name=outlooktitle" + i + " id=outlooktitle" + i + " ";
        if (i != outlookbar.opentitle) //当栏目没有打开时字体
            outline += " nowrap align=left style='cursor:hand;background:url(dtree/images/title_bg.gif) repeat-x 0 0;color:#000000;height:24px;line-height:24px' ";
        else
            outline += " nowrap align=left style='cursor:hand;background:url(dtree/images/title_zk_bg.png) repeat-x 0 -2px;color:#000000;font-size:12px;font-weight:bold;height:24px;line-height:24px' ";
        outline += outlookbar.titlelist[i].otherclass
        outline += " onclick='switchoutlookBar(" + i + ")'>"
        if (outlookbar.titlelist[i].icon) {
            outline += "<img style='float:left;margin:4px 5px 0 8px;vertical-align:middle' src='" + outlookbar.titlelist[i].icon + "' />";
        }
        outline += "<span class=smallFont>";
        outline += outlookbar.titlelist[i].title + "</span></td></tr>";
        outline += "<tr><td name=outlookdiv" + i + " valign=top align=left id=outlookdiv" + i + " style='width:100%;padding-top:3px;padding-left:3px;"
        if (i != outlookbar.opentitle) //判断是否书写内容
            outline += ";display:none;height:0%;";
        else
            outline += ";display:;height:100%;";
        outline += "'><div name=outlookdivin" + i + " id=outlookdivin" + i + " style='overflow:auto;width:190px;height:100%'>";
        //展开项内容
        //outline+=tt();
        outline += menuScript(i);
        //for (j=0;j<outlookbar.itemlist[i].length;j++)
        //outline+=showitem(outlookbar.itemlist[i][j].key,outlookbar.itemlist[i][j].title);
        //key为链接title为名字
        outline += "</div></td></tr>";
    }
    outline += "</table>";
    return outline;
}

function show() {
    var outline;
    outline = "<div id=outLookBarDiv name=outLookBarDiv style='width=100%;height:100%'>";
    //整体的框架格局背景
    outline += outlookbar.getOutLine();
    outline += "</div>";
    document.write(outline);
}
function theitem(intitle, instate, inkey, icon) {
    this.state = instate;
    this.otherclass = " nowrap ";
    this.key = inkey;
    this.title = intitle;
    this.icon = icon;
}
function addtitle(intitle, icon) {
    outlookbar.itemlist[outlookbar.titlelist.length] = new Array();
    outlookbar.titlelist[outlookbar.titlelist.length] = new theitem(intitle, 1, 0, icon);
    return(outlookbar.titlelist.length - 1);
}

function outlook() {
    this.titlelist = new Array();
    this.itemlist = new Array();
    this.divstyle = "style='height:100%;width:100%;overflow:auto' align=center";
    this.otherclass = "border=0 cellspacing='0' cellpadding='0' style='height:100%;width:100%'valign=middle align=center ";
    this.addtitle = addtitle;
    //this.additem=additem;
    this.starttitle = -1;
    this.show = show;
    this.getOutLine = getOutLine;
    this.opentitle = this.starttitle;
    this.reflesh = outreflesh;
    this.timedelay = 50;
    this.inc = 10;
    this.maincolor = "url(dtree/images/title_bg.gif) repeat-x 0 0";
    this.highlightcolor = "url(dtree/images/title_zk_bg.png) repeat-x 0 -2px";
    this.dir
}

function outreflesh() {
    document.all("outLookBarDiv").innerHTML = outlookbar.getOutLine();
}

function locatefold(foldname) {
    if (foldname == "" && outlookbar.titlelist.length > 0)
        foldname = outlookbar.titlelist[0].title
    for (var i = 0; i < outlookbar.titlelist.length; i++) {
        if (foldname == outlookbar.titlelist[i].title) {
            outlookbar.starttitle = i;
            outlookbar.opentitle = i;
        }
    }
}
var outlookbar = new outlook();
var tempinnertext1,tempinnertext2,outlooksmoothstat;
outlooksmoothstat = 0;
var tree;
//outlookbar.addtitle('界面控件', 'common/images/right_title_sjfx.png');
//000
//outlookbar.addtitle('系统界面模板', 'common/images/left_title_zyzx.png');
//100
//outlookbar.addtitle('我的工作台', 'common/images/right_title_sjfx.png');
// 200
outlookbar.addtitle('后台维护平台', 'common/images/right_title_sjfx.png');
// 300

<%
	User loginUser = (User) session.getAttribute("user");
	Integer userType = loginUser.getType();

%>


function menuScript(index) {
	dTree200 = new dTree('dTree200');
    dTree200.add(200, -1, '');
    
    dTree200.add(200103, 200, '食品分类', "/foodType", "", "mainFrame");
    dTree200.add(200194, 200, '食品明细', "/food", "", "mainFrame");
    dTree200.add(200195, 200, '订单管理', "/foodOrder", "", "mainFrame");
    dTree200.add(200196, 200, '订单详情', "/foodOrderDetail", "", "mainFrame");

    return ("<span>" + dTree200 + "</span>");
}
//
</script>
<body>

<table id="mnuList" cellspacing=0 cellpadding=0 bgcolor="#ffffff" style="WIDTH:196px;HEIGHT: 100%; margin:0 0 0 2px ; padding:0;">
    <tr>
        <td style="width:196px; font-size:12px; color:#fff;font-weight: bold; height:25px; background-image: url(common/images/left_top_bg01.jpg);background-repeat: no-repeat;">
            <div style="float:left;padding-left:6px; padding-top:3px;"><img src="common/images/left_top.png" alt=""
                                                                            width="16" height="16" align="absbottom">
            </div>
            <div style="float:left;padding-left:5px; padding-top:5px;">系统功能菜单</div>
        </td>
    </tr>
    <tr>
        <td id="outLookBarShow" style="HEIGHT: 100%; border-left:2px solid #98AED1;border-right:1px solid #98AED1;"
            valign="top" align="center" name="outLookBarShow">
            <script language="JavaScript">
                <!--
                locatefold("")
                outlookbar.show()
                //-->
            </script>
        </td>
    </tr>
    <tr>
        <td valign="bottom" style="padding:0; margin:0;"><img src="/static/jsp/frame/common/images/but_left_bottom.png" width="196" height="10" alt="" border="0"></td>
    </tr>
</table>
<script src="/static/js/jquery-1.7.1.js" type="text/javascript"></script>
</body>
</html>
