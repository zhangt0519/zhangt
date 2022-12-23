<!--页面大小控制页面-->
<%@ page contentType="text/html; charset=GBK" %>
<%
    String rootPath = request.getContextPath();
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>控制页面</title>
    <link href="/static/jsp/frame/common/style/frame.css" rel="stylesheet" type="text/css">
    <script src="/static/jsp/frame/common/script/frame.js" language="JavaScript" type="text/JavaScript"></script>
    <script src="/static/jsp/frame/common/script/MSIE.PNG.js" type="text/javascript"></script>

    <script>
       
    </script>
</head>
<body class="left-vertical-body-background" onLoad="MM_preloadImages('/static/jsp/frame/common/images/hideLeft.gif')">
<table width="9" height="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td valign="top"><img name="" src="/static/jsp/frame/common/images/left_sf_topbg.png" width="9" height="17" alt=""></td>
    </tr>
    <tr>
        <td>
            <div id="image"><a href="javascript:hideViewArea();">
                <img src="/static/jsp/frame/common/images/hideLeft.gif" name="leftImage" width="8" height="66" border="0" id="leftImage"
                     onMouseOver="MM_swapImage('leftImage','','/static/jsp/frame/common/images/hideLeftOver.gif',1)"
                     onMouseOut="MM_swapImgRestore()">
            </a></div>
        </td>
    </tr>
    <tr>
        <td valign="bottom"><img name="" src="/static/jsp/frame/common/images/left_sf_bottombg.png" width="9" height="17" alt=""></td>
    </tr>
</table>
</body>
</html>