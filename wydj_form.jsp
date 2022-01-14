<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
文印提交
@author 殷柏成
@date 2013-04-02
@version 1.0
--%>
<%@ page import="tdh.frame.common.UserBean"%>
<%@ page import="tdh.frame.xtgl.dao.TuserJdbcDAO"%>
<%@ page import="java.util.*"%>
<%@ page import="tdh.framework.util.StringUtils"%>
<%@ page import="tdh.frame.common.UtilComm"%>
<%@ page import="tdh.frame.lcgl.LcglFunc"%>
<%@page import="tdh.jzgl.common.JzglUtils"%>
<%@page import="tdh.court.ajgl.Eaj"%>
<%@page import="tdh.court.ajgl.cbsp.YwlcData"%>
<%@page import="tdh.court.ajgl.dao.EajDAO"%>
<%@ page import="tdh.jzgl.common.JzglConstant" %>
<%@ page import="tdh.jzgl.common.TuDmKz" %>
<%@ page import="tdh.jzgl.common.DqUtils" %>
<%
  String _path = JzglUtils.getContextURl(request);

  UserBean user = (UserBean) session.getAttribute("user");
  String ahdm = JzglUtils.getPar("ahdm", request);
  String fydm = JzglUtils.trim(user.getFy().getFydm());
  String yhdm = JzglUtils.trim(user.getYhdm());
  String fymc = JzglUtils.getFymc(user.getFydm());
  EajDAO eajDao = (EajDAO) JzglUtils.getBean("EajDAO");
  String yydm = JzglConstant.YYDM;
  Eaj aj = null;
  String ktrq = "";
  if (ahdm.length() > 0) {
    aj = (Eaj) eajDao.findById(ahdm);
  }
  if (aj == null)
    aj = new Eaj();

  String lch = JzglUtils.getPar("lch", request);
  String slh = JzglUtils.getPar("slh", request);
  /** 复用lccl.jsp中的部分方法 start **/
  String ywcl = JzglUtils.getPar8("ywcl", request);
  String xh = JzglUtils.getPar("xh", request);
  if(xh.length()==0)
  xh="001";
  String znxh = JzglUtils.getPar("znxh", request);
  if(znxh.length()==0)
  znxh="00";
  String jdbh = JzglUtils.getPar("jdbh", request);
  String yhxm = JzglUtils.getPar("yhxm", request);
  /** 复用lccl.jsp中的部分方法 end **/
  String sldyqya3dy = TuDmKz.getVal("SLDYQYA3DY");// 施乐打印A3
  boolean isDq_ln = DqUtils.isDq_ln();//辽宁地区
    boolean isDqGzs = DqUtils.isDq_gzs();

    boolean dyA3 = "1".equals(sldyqya3dy) && isDq_ln ? true : false;
  Map<String, String> lcyw_map = YwlcData.getLcywxx(lch, slh, null, null);
  String sfjj = JzglUtils.trim(lcyw_map.get("sfjj"));
  String tjr = JzglUtils.trim(lcyw_map.get("tjr"));
  String tjrq = JzglUtils.trim(lcyw_map.get("tjrq"));
  String bz = JzglUtils.trim(lcyw_map.get("tjr_spxx"));
  String jzXh  =  JzglUtils.trim(lcyw_map.get("wsXh"));
  String jzXh2 =  JzglUtils.trim(lcyw_map.get("wsXh2"));
  String jzXh3 =  JzglUtils.trim(lcyw_map.get("wsXh3"));
  String jzXh4 =  JzglUtils.trim(lcyw_map.get("wsXh4"));
  String jzXh5 =  JzglUtils.trim(lcyw_map.get("wsXh5"));
  String jzXh6 =  JzglUtils.trim(lcyw_map.get("wsXh6"));
  String jzXh7 =  JzglUtils.trim(lcyw_map.get("wsXh7"));
  String jzXh8 =  JzglUtils.trim(lcyw_map.get("wsXh8"));
  String jzXh9 =  JzglUtils.trim(lcyw_map.get("wsXh9"));
  String jzXh10=  JzglUtils.trim(lcyw_map.get("wsXh10"));
  String printCnt  =  JzglUtils.trim(lcyw_map.get("printCnt"));
  String printCnt2 =  JzglUtils.trim(lcyw_map.get("printCnt2"));
  String printCnt3 =  JzglUtils.trim(lcyw_map.get("printCnt3"));
  String printCnt4 =  JzglUtils.trim(lcyw_map.get("printCnt4"));
  String printCnt5 =  JzglUtils.trim(lcyw_map.get("printCnt5"));
  String printCnt6 =  JzglUtils.trim(lcyw_map.get("printCnt6"));
  String printCnt7 =  JzglUtils.trim(lcyw_map.get("printCnt7"));
  String printCnt8 =  JzglUtils.trim(lcyw_map.get("printCnt8"));
  String printCnt9 =  JzglUtils.trim(lcyw_map.get("printCnt9"));
  String printCnt10 = JzglUtils.trim(lcyw_map.get("printCnt10"));
    String printCntA3  =  JzglUtils.trim(lcyw_map.get("printCntA3"));
    String printCnt2A3 =  JzglUtils.trim(lcyw_map.get("printCnt2A3"));
    String printCnt3A3 =  JzglUtils.trim(lcyw_map.get("printCnt3A3"));
    String printCnt4A3 =  JzglUtils.trim(lcyw_map.get("printCnt4A3"));
    String printCnt5A3 =  JzglUtils.trim(lcyw_map.get("printCnt5A3"));
    String printCnt6A3 =  JzglUtils.trim(lcyw_map.get("printCnt6A3"));
    String printCnt7A3 =  JzglUtils.trim(lcyw_map.get("printCnt7A3"));
    String printCnt8A3 =  JzglUtils.trim(lcyw_map.get("printCnt8A3"));
    String printCnt9A3 =  JzglUtils.trim(lcyw_map.get("printCnt9A3"));
    String printCnt10A3 = JzglUtils.trim(lcyw_map.get("printCnt10A3"));
  if (slh.length() == 0) {
    tjr = yhdm;
    tjrq = UtilComm.convertRq(new Date(), "yyyyMMdd");
  }
  String selJzxh = JzglUtils.getPar8("selJzxh", request);
  if("".equals(selJzxh)){
      selJzxh = jzXh;
  }
  String[] jzxh_arr = {"","","","","","","","","",""};
  String[] jzxhs = selJzxh.split(",");
  for(int i = 0;i<jzxhs.length;i++){
	  jzxh_arr[i] = jzxhs[i];
  }
  String wsXh = JzglUtils.trim(lcyw_map.get("wsXh"));
  String cpwsXh = "";
  String wsMc = "";
  String wslb = "";
  String islc = "";
  String islc2 = "";
  String[] wsMcs = {"","","","","","","","","",""};
  if (ahdm.length() > 0 && slh.length() == 0) {
    if (selJzxh.length() > 0) {
    	List<Map<String, Object>> list_jz = JzglUtils.getJzxxByIds(ahdm, selJzxh);
		for (int i = 0; i < list_jz.size(); i++) {
			wslb = JzglUtils.trimVal(list_jz.get(0).get("LB"));
			wsMc = JzglUtils.trimVal(list_jz.get(i).get("MC"));
	        String wjgs = JzglUtils.trimVal(list_jz.get(i).get("WJGS"));
            if (JzglUtils.strToInt(list_jz.get(i).get("pdfqz")) > 0) {
                wjgs = "pdf";
            }
	        if (wsMc.length() > 0 && wjgs.length() > 0) wsMcs[i] = wsMc + "." + wjgs;
		}
    }
  }
  
  if(!"".equals(jzxhs[0])&&!"".equals(ahdm) && "".equals(slh)){
    Map<String,String> islcmap = new HashMap();
    islcmap.put("ahdm", ahdm);
    islcmap.put("wsXh", jzxhs[0]);
    islcmap.put("lch", JzglConstant.YYDM+"_10024");
    islc = YwlcData.ajInLcWy(islcmap);
    
    if("440100".equals(fydm)){
        islc2 = YwlcData.ajInLcWssp(islcmap);
    }
    if("true".equals(islc) || "true".equals(islc2) ){
        for(int i = 0; i<wsMcs.length;i++){
        	wsMcs[i] ="";
        }
    }
  }
  //选择案件显示的标记
  String xzAjFlag=JzglUtils.getPar("xzAjFlag", request);;
  if(StringUtils.isEmpty(ahdm)){
      xzAjFlag="1";
  }
  String jdsxOpts = new LcglFunc().getJdsxOptions(ahdm, JzglConstant.YYDM+"_10024", "".equals(jdbh)?"p_0":jdbh, slh, xh, fydm);
  if(jdsxOpts.startsWith("1")){
    jdsxOpts = jdsxOpts.substring(1);
  }else{
    jdsxOpts = "";
  }
  Boolean isSpxt15 = JzglUtils.isSpxt15();
  String wslb1 = isSpxt15?"15_000113-255":"09_01091-1";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文印审批</title>
    <meta http-equiv="cache-control" content="no-cache">
<script type="text/javascript" src="<%=_path%>/uiplugs/jquery/jquery.min.js" ></script>
<script src="<%=WebUtils.getContextPath(request) %>/uiplugs/layer/layer.js"></script>
<script type="text/javascript" src="<%=_path%>/uiplugs/layer/layer-openmodal.js"></script>
<script src="<%=_path%>/js/common.js" type="text/javascript"></script>
<script src="<%=_path%>/js/check.js" type="text/javascript"></script>
<%@ include file="/common/button.jsp"%>
<script type="text/javascript" src="<%=_path%>/frame/lcgl/js/func.js"></script>
<script type='text/javascript' src='<%=_path%>/dwr/interface/lcglFunc.js'></script>
<script type='text/javascript' src='<%=_path%>/dwr/engine.js'></script>
<script type="text/javascript" src="<%=_path%>/js/courtmsg/CourtMsg.js"></script>
<style>
html,body {font-family: "宋体", Arial, Helvetica, sans-serif;}
table {font-size: 12px;border-collapse: collapse;}
TR {word-break: break-all;}
TD {white-space: nowrap;}
textarea {width: 100%;height: 100%;overflow: auto;border: 0;}
.reportOutTab td {padding: 2px; border: 1px;white-space: normal;vertical-align: middle;
  border-style: solid;border-color: #7F9DB9;font-size: 12px;}
.reportInTab td {
  padding: 2px;border: 0px;white-space: normal;vertical-align: middle;font-size: 12px;}
a.abtn:link {color: #385ea2; font-size: 12px; font-weight: bold; text-decoration: none;}
a.abtn:visited {color: #385ea2; font-size: 12px; font-weight: bold; text-decoration: none;}
a.abtn:hover {color: #385ea2; font-size: 12px; font-weight: bold; text-decoration: none;}
a.abtn:active {color: #385ea2; font-size: 12px; font-weight: bold; text-decoration: none;}
a.alink:link {color: #0000FF; font-size: 12px; font-weight: bold; text-decoration: none;}
a.alink:visited {color: #0000FF; font-size: 12px; font-weight: bold; text-decoration: none;}
a.alink:hover {color: #0000FF; font-size: 12px; font-weight: bold; text-decoration: none;}
a.alink:active {color: #0000FF; font-size: 12px; font-weight: bold; text-decoration: none;}
</style>
<style media=print>
.Noprint {
  display: none;
}
a.abtn {
display: none;
}
</style>
<script type="text/javascript">
  var jq = jQuery.noConflict();
  var $ = jq;
  var _path = "<%=_path%>";
  var _ywcl = "<%=ywcl%>";
  var yydm = "<%=yydm%>";
  var dyA3 = <%=dyA3%>;

  jq(document).ready(function() {
            <%if("true".equals(islc) || "true".equals(islc2)){%>
            <%if("440100".equals(fydm)){%>
            alert('该文书已有在办【文印流程】或【文书审批-签章文印】，不能重复提交，请删除或联系处理人退回原文书后，再次提交！');
            <%}else{%>
            alert('该文书已有文印流程正在办理，不允许重复提交！请选择其他文书！');
            <%}}%>
  });
</script>
</head>
<body style="margin: 0px;">
<table width="100%" align="center" style="table-layout:fixed">
  <tr>
    <td>
    <table width="600" class="reportOutTab" cellpadding="0" cellspacing="0" align="center">
      <tr height="60">
        <td colspan="8" align="center" style="padding: 4px; font-size: 14px; font-weight: bold;"><%=fymc%><br>法律文书文印审批表</td>
      </tr>
      <tr height="25">
        <td width="70" align="right">案号</td>
        <td width="220" colspan="3">
          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="reportInTab">
            <tr>
              <td><%=JzglUtils.trim(aj.getAh())%></td>
              <%
              if (!StringUtils.isEmpty(xzAjFlag)&& slh.length() == 0 && JzglUtils.getPar("selJzxh", request).length() == 0) {
              %>
              <td width="40"><a class="abtn" href="javascript:void(0);" onclick="selAj();return false;">[选择]</a></td>
              <%
              }
              %>
            </tr>
          </table>
        </td>
        <td width="70" align="right">立案日期</td>
        <td width="220" colspan="3"><%=UtilComm.convertRq3(aj.getLarq())%></td>
      </tr>
      <tr height="25">
        <td width="70" align="right">案由</td>
        <td colspan="3"><%=JzglUtils.trim(aj.getAyms())%></td>
        <td align="right">裁判文书</td>
        <td colspan="<%=isDqGzs ? 1 : 3%>>"><input type="radio" id="cpws1" name="cpws" value="1" <%=wslb1.equals(wslb)?"checked":"" %>/>是&nbsp;<input type="radio" id="cpws2" name="cpws" value="2" <%=wslb1.equals(wslb)?"":"checked" %>/>否</td>
          <%if(isDqGzs){%>
          <td width="70" align="right">是否急件</td>
          <td>
              <input type="radio" name="sfjj" value="1" <%="1".equals(sfjj) ? "checked" : "" %>/>是&nbsp;
              <input type="radio" name="sfjj" value="0" <%="1".equals(sfjj) ? "" : "checked" %>/>否
          </td>
          <%}%>
      </tr>
      <tr height="25">
        <td width="70" align="right">承办部门</td>
        <td colspan="3" width="220"><%=JzglUtils.getBmmc(aj.getCbbm1())%></td>
        <td   align="right">承办人</td>
        <td  colspan="3"><%=JzglUtils.getYhmc(aj.getCbr())%></td>
      </tr>

      <tr id="wswytr1" class="wswytr">
        <td width="70" align="right">文书1</td>
        <td style="padding: 0px;" colspan="3">
        <table class="reportInTab" cellpadding="0" cellspacing="0" width="100%" height="100%">
          <tr height="25">
             <td>
                  <input type="hidden" name="wsXh" id="wsXh" value="<%= jzxh_arr[0].length() > 0 ? jzxh_arr[0] : "" %>" />
                  <span id="wsShow">
                   <%
                  if (slh.length() > 0) {
                  %>
                <%--   <a class="alink" title="<%= JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc"))%>" href="javascript:void(0);" onclick="viewLcfj('<%= xh%>', '<%= znxh %>','<%=JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc")).substring(JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc")).length()-3)%>')"><%= JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc"))%></a> --%>
                   <a class="alink" title="<%= JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc"))%>" href="javascript:void(0);" onclick="viewJz('<%=ahdm %>', '<%= jzXh %>','<%=JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc")).substring(JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc")).length()-3)%>')"><%= JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc"))%></a>
                  <%
                  }
                  %>
                  <%
                   if (jzxh_arr[0].length() > 0 && wsMcs[0].length() > 0) {
                  %>
                  <a class="alink" title="<%=wsMcs[0] %>" href="javascript:void(0);" onclick="viewJz('<%=ahdm %>', '<%= jzxh_arr[0] %>','<%=wsMcs[0].substring(wsMcs[0].length()-3)%>')"><%=wsMcs[0] %></a>
                  <%
                  }
                  %>
                  </span>
                </td>
                <td width="40px">
                  <a class="abtn" href="javascript:void(0);" onclick="selDoc('wsXh','wsShow','printCnt')">[选择]</a>
                </td>
          </tr>
        </table>
        </td>
          <%if(dyA3){%>
          <td  width="70" cellpadding="0" cellspacing="0" style="border-right: 1px solid #7F9DB9;"  align="right">A3印数</td>
          <td  style="border-right: 1px solid #7F9DB9">
              <input  type='text' name="printCntA3" id="printCntA3" value="<%=printCntA3 %>" <%= jzxh_arr[0].length() > 0  ? "" : "readonly" %>  class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right;width:68px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <td  width="70" cellpadding="0" cellspacing="0" style="border-right: 1px solid #7F9DB9" align="right">A4印数</td>
          <td >
              <input  type='text' name="printCnt" id="printCnt" value="<%=printCnt %>" <%= jzxh_arr[0].length() > 0  ? "" : "readonly" %>  class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right; width:68px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <%}else{%>
             <td width="70" align="right">印数</td>
             <td colspan="3">
             <input type='text' name="printCnt" id="printCnt" value="<%=printCnt %>" <%= jzxh_arr[0].length() > 0  ? "" : "readonly" %>  class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right; width:219px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
             </td>
          <%}%>
      </tr>
      <tr id="wswytr2" class="wswytr">
        <td width="70" align="right">文书2</td>
        <td style="padding: 0px;" colspan="3">
        <table class="reportInTab" cellpadding="0" cellspacing="0" width="100%" height="100%">
          <tr height="25">
             <td>
                  <input type="hidden" name="wsXh2" id="wsXh2" value="<%= jzxh_arr[1].length() > 0 ? jzxh_arr[1] : jzXh2 %>" />
                  <span id="wsShow2">
                    <%
                  if (jzXh2.length() > 0) {
                  %>
                  <a class="alink" title="<%= JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc2"))%>" href="javascript:void(0);" onclick="viewJz('<%=ahdm %>', '<%= jzXh2 %>','<%=JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc2")).substring(JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc2")).length()-3)%>')"><%= JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc2"))%></a>
                  <%
                  }
                  %>
                  <%
                   if (jzxh_arr[1].length() > 0 && wsMcs[1].length() > 0) {
                  %>
                  <a class="alink" title="<%=wsMcs[1] %>" href="javascript:void(0);" onclick="viewJz('<%=ahdm %>', '<%= jzxh_arr[1] %>','<%=wsMcs[1].substring(wsMcs[1].length()-3)%>')"><%=wsMcs[1] %></a>
                  <%
                  }
                  %>
                  </span>
                </td>
                <td width="40px">
                  <a class="abtn" href="javascript:void(0);" onclick="selDoc('wsXh2','wsShow2','printCnt2')">[选择]</a>
                </td>
          </tr>
        </table>
        </td>
          <%if(dyA3){%>
          <td width="70"  cellpadding="0" cellspacing="0" style="border-right: 1px solid #7F9DB9" align="right">A3印数</td>
          <td width="75" style="border-right: 1px solid #7F9DB9">
              <input  type='text' name="printCnt2A3" id="printCnt2A3" value="<%=printCnt2A3 %>" <%= jzxh_arr[0].length() > 0  ? "" : "readonly" %>  class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right;width:68px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <td  width="70" cellpadding="0" cellspacing="0" style="border-right: 1px solid #7F9DB9" align="right">A4印数</td>
          <td >
              <input  type='text' name="printCnt2" id="printCnt2" value="<%=printCnt2 %>" <%= jzxh_arr[0].length() > 0  ? "" : "readonly" %>  class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right; width:68px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>

          <%}else{%>
          <td width="70" align="right">印数</td>
          <td colspan="3">
              <input type='text' name="printCnt2" id="printCnt2" value="<%=printCnt2 %>" <%= jzxh_arr[1].length() > 0  ? "" : "readonly" %> class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right; width:219px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <%}%>

      </tr>
      <tr  id="wswytr3" class="wswytr">
        <td width="70" align="right">文书3</td>
        <td style="padding: 0px;" colspan="3">
        <table class="reportInTab" cellpadding="0" cellspacing="0" width="100%" height="100%">
          <tr height="25">
             <td>
                  <input type="hidden" name="wsXh3" id="wsXh3" value="<%= jzxh_arr[2].length() > 0 ? jzxh_arr[2] : jzXh3 %>" />
                  <span id="wsShow3">
                  <%
                  if (jzXh3.length() > 0) {
                  %>
                  <a class="alink" title="<%= JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc3"))%>" href="javascript:void(0);" onclick="viewJz('<%=ahdm %>', '<%= jzXh3 %>','<%=JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc3")).substring(JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc3")).length()-3)%>')"><%= JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc3"))%></a>
                  <%
                  }
                  %>
                  <%
                   if (jzxh_arr[2].length() > 0 && wsMcs[2].length() > 0) {
                  %>
                  <a class="alink" title="<%=wsMcs[2] %>" href="javascript:void(0);" onclick="viewJz('<%=ahdm %>', '<%= jzxh_arr[2] %>','<%=wsMcs[2].substring(wsMcs[2].length()-3)%>')"><%=wsMcs[2] %></a>
                  <%
                  }
                  %>
                  </span>
                </td>
                <td width="40px">
                  <a class="abtn" href="javascript:void(0);" onclick="selDoc('wsXh3','wsShow3','printCnt3')">[选择]</a>
                </td>
          </tr>
        </table>
        </td>
          <%if(dyA3){%>
          <td width="70"  cellpadding="0" cellspacing="0" style="border-right: 1px solid #7F9DB9" align="right">A3印数</td>
          <td width="75" style="border-right: 1px solid #7F9DB9">
              <input  type='text' name="printCnt3A3" id="printCnt3A3" value="<%=printCnt3A3 %>" <%= jzxh_arr[0].length() > 0  ? "" : "readonly" %>  class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right;width:68px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <td  width="70" cellpadding="0" cellspacing="0" style="border-right: 1px solid #7F9DB9" align="right">A4印数</td>
          <td >
              <input  type='text' name="printCnt3" id="printCnt3" value="<%=printCnt3 %>" <%= jzxh_arr[0].length() > 0  ? "" : "readonly" %>  class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right; width:68px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <%}else{%>
          <td width="70" align="right">印数</td>
          <td colspan="3">
              <input type='text' name="printCnt3" id="printCnt3" value="<%=printCnt3 %>" <%= jzxh_arr[2].length() > 0  ? "" : "readonly" %> class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right; width:219px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <%}%>
      </tr>
      <tr  id="wswytr4" class="wswytr">
        <td width="70" align="right">文书4</td>
        <td style="padding: 0px;" colspan="3">
        <table class="reportInTab" cellpadding="0" cellspacing="0" width="100%" height="100%">
          <tr height="25">
             <td>
                  <input type="hidden" name="wsXh4" id="wsXh4" value="<%= jzxh_arr[3].length() > 0 ? jzxh_arr[3] : jzXh4 %>" />
                  <span id="wsShow4">
                    <%
                  if (jzXh4.length() > 0) {
                  %>
                  <a class="alink" title="<%= JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc4"))%>" href="javascript:void(0);" onclick="viewJz('<%=ahdm %>', '<%= jzXh4 %>','<%=JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc4")).substring(JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc4")).length()-3)%>')"><%= JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc4"))%></a>
                  <%
                  }
                  %>
                  <%
                   if (jzxh_arr[3].length() > 0 && wsMcs[3].length() > 0) {
                  %>
                  <a class="alink" title="<%=wsMcs[3] %>" href="javascript:void(0);" onclick="viewJz('<%=ahdm %>', '<%= jzxh_arr[3] %>','<%=wsMcs[3].substring(wsMcs[3].length()-3)%>')"><%=wsMcs[3] %></a>
                  <%
                  }
                  %>
                  </span>
                </td>
                <td width="40px">
                  <a class="abtn" href="javascript:void(0);" onclick="selDoc('wsXh4','wsShow4','printCnt4')">[选择]</a>
                </td>
          </tr>
        </table>
        </td>
          <%if(dyA3){%>
          <td width="70"  cellpadding="0" cellspacing="0" style="border-right: 1px solid #7F9DB9" align="right">A3印数</td>
          <td width="75" style="border-right: 1px solid #7F9DB9">
              <input  type='text' name="printCnt4A3" id="printCnt4A3" value="<%=printCnt4A3 %>" <%= jzxh_arr[0].length() > 0  ? "" : "readonly" %>  class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right;width:68px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <td  width="70" cellpadding="0" cellspacing="0" style="border-right: 1px solid #7F9DB9" align="right">A4印数</td>
          <td >
              <input  type='text' name="printCnt4" id="printCnt4" value="<%=printCnt4 %>" <%= jzxh_arr[0].length() > 0  ? "" : "readonly" %>  class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right; width:68px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <%}else{%>
          <td width="70" align="right">印数</td>
          <td colspan="3">
              <input type='text' name="printCnt4" id="printCnt4"  value="<%=printCnt4 %>" <%= jzxh_arr[3].length() > 0  ? "" : "readonly" %> class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right;width:219px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <%}%>
      </tr>
      <tr id="wswytr5" class="wswytr">
        <td width="70" align="right">文书5</td>
        <td style="padding: 0px;" colspan="3">
        <table class="reportInTab" cellpadding="0" cellspacing="0" width="100%" height="100%">
          <tr height="25">
             <td>
                  <input type="hidden" name="wsXh5" id="wsXh5" value="<%= jzxh_arr[4].length() > 0 ? jzxh_arr[4] : jzXh5 %>" />
                  <span id="wsShow5">
                   <%
                  if (jzXh5.length() > 0) {
                  %>
                  <a class="alink" title="<%= JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc5"))%>" href="javascript:void(0);" onclick="viewJz('<%=ahdm %>', '<%= jzXh5 %>','<%=JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc5")).substring(JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc5")).length()-3)%>')"><%= JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc5"))%></a>
                  <%
                  }
                  %>
                  <%
                   if (jzxh_arr[4].length() > 0 && wsMcs[4].length() > 0) {
                  %>
                  <a class="alink" title="<%=wsMcs[4] %>" href="javascript:void(0);" onclick="viewJz('<%=ahdm %>', '<%= jzxh_arr[4] %>','<%=wsMcs[4].substring(wsMcs[4].length()-3)%>')"><%=wsMcs[4] %></a>
                  <%
                  }
                  %>
                  </span>
             </td>
             <td width="40px"><a class="abtn" href="javascript:void(0);" onclick="selDoc('wsXh5','wsShow5','printCnt5')">[选择]</a></td>
          </tr>

        </table>
        </td>
          <%if(dyA3){%>
          <td width="70"  cellpadding="0" cellspacing="0" style="border-right: 1px solid #7F9DB9" align="right">A3印数</td>
          <td width="75" style="border-right: 1px solid #7F9DB9">
              <input  type='text' name="printCnt5A3" id="printCnt5A3" value="<%=printCnt5A3 %>" <%= jzxh_arr[0].length() > 0  ? "" : "readonly" %>  class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right;width:68px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <td  width="70" cellpadding="0" cellspacing="0" style="border-right: 1px solid #7F9DB9" align="right">A4印数</td>
          <td >
              <input  type='text' name="printCnt5" id="printCnt5" value="<%=printCnt5 %>" <%= jzxh_arr[0].length() > 0  ? "" : "readonly" %>  class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right; width:68px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <%}else{%>
          <td width="70" align="right">印数</td>
          <td colspan="3">
              <input type='text' name="printCnt5" id="printCnt5" value="<%=printCnt5 %>" <%= jzxh_arr[4].length() > 0  ? "" : "readonly" %> class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right; width:219px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <%}%>
      </tr>


     <tr id="wswytr6" class="wswytr" style="">
        <td width="70" align="right">文书6</td>
        <td style="padding: 0px;" colspan="3">
        <table class="reportInTab" cellpadding="0" cellspacing="0" width="100%" height="100%">
          <tr height="25">
             <td>
                  <input type="hidden" name="wsXh6" id="wsXh6" value="<%= jzxh_arr[5].length() > 0 ? jzxh_arr[5] : jzXh6 %>" />
                  <span id="wsShow6">
                   <%
                  if (jzXh6.length() > 0) {
                  %>
                  <a class="alink" title="<%= JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc6"))%>" href="javascript:void(0);" onclick="viewJz('<%=ahdm %>', '<%= jzXh6 %>','<%=JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc6")).substring(JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc6")).length()-3)%>')"><%= JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc6"))%></a>
                  <%
                  }
                  %>
                  <%
                   if (jzxh_arr[5].length() > 0 && wsMcs[5].length() > 0) {
                  %>
                  <a class="alink" title="<%=wsMcs[5] %>" href="javascript:void(0);" onclick="viewJz('<%=ahdm %>', '<%= jzxh_arr[5] %>','<%=wsMcs[5].substring(wsMcs[5].length()-3)%>')"><%=wsMcs[5] %></a>
                  <%
                  }
                  %>
                  </span>
             </td>
             <td width="40px"><a class="abtn" href="javascript:void(0);" onclick="selDoc('wsXh6','wsShow6','printCnt6')">[选择]</a></td>
          </tr>

        </table>
        </td>
         <%if(dyA3){%>
         <td width="70"  cellpadding="0" cellspacing="0" style="border-right: 1px solid #7F9DB9" align="right">A3印数</td>
         <td width="75" style="border-right: 1px solid #7F9DB9">
             <input  type='text' name="printCnt6A3" id="printCnt6A3" value="<%=printCnt6A3 %>" <%= jzxh_arr[0].length() > 0  ? "" : "readonly" %>  class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right;width:68px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
         </td>
         <td  width="70" cellpadding="0" cellspacing="0" style="border-right: 1px solid #7F9DB9" align="right">A4印数</td>
         <td >
             <input  type='text' name="printCnt6" id="printCnt6" value="<%=printCnt6 %>" <%= jzxh_arr[0].length() > 0  ? "" : "readonly" %>  class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right; width:68px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
         </td>
         <%}else{%>
         <td width="70" align="right">印数</td>
         <td colspan="3">
             <input type='text' name="printCnt6" id="printCnt6" value="<%=printCnt6 %>" <%= jzxh_arr[5].length() > 0  ? "" : "readonly" %> class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right; width:219px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
         </td>
         <%}%>
      </tr>

      <tr id="wswytr7" class="wswytr" style="">
        <td width="70" align="right">文书7</td>
        <td style="padding: 0px;" colspan="3">
        <table class="reportInTab" cellpadding="0" cellspacing="0" width="100%" height="100%">
          <tr height="25">
             <td>
                  <input type="hidden" name="wsXh7" id="wsXh7" value="<%= jzxh_arr[6].length() > 0 ? jzxh_arr[6] : jzXh7 %>" />
                  <span id="wsShow7">
                   <%
                  if (jzXh7.length() > 0) {
                  %>
                  <a class="alink" title="<%= JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc7"))%>" href="javascript:void(0);" onclick="viewJz('<%=ahdm %>', '<%= jzXh7 %>','<%=JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc7")).substring(JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc7")).length()-3)%>')"><%= JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc7"))%></a>
                  <%
                  }
                  %>
                  <%
                   if (jzxh_arr[6].length() > 0 && wsMcs[6].length() > 0) {
                  %>
                  <a class="alink" title="<%=wsMcs[6] %>" href="javascript:void(0);" onclick="viewJz('<%=ahdm %>', '<%= jzxh_arr[6] %>','<%=wsMcs[6].substring(wsMcs[6].length()-3)%>')"><%=wsMcs[6] %></a>
                  <%
                  }
                  %>
                  </span>
             </td>
             <td width="40px"><a class="abtn" href="javascript:void(0);" onclick="selDoc('wsXh7','wsShow7','printCnt7')">[选择]</a></td>
          </tr>

        </table>
        </td>
          <%if(dyA3){%>
          <td width="70"  cellpadding="0" cellspacing="0" style="border-right: 1px solid #7F9DB9" align="right">A3印数</td>
          <td width="75" style="border-right: 1px solid #7F9DB9">
              <input  type='text' name="printCnt7A3" id="printCnt7A3" value="<%=printCnt7A3 %>" <%= jzxh_arr[0].length() > 0  ? "" : "readonly" %>  class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right;width:68px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <td  width="70" cellpadding="0" cellspacing="0" style="border-right: 1px solid #7F9DB9" align="right">A4印数</td>
          <td >
              <input  type='text' name="printCnt7" id="printCnt7" value="<%=printCnt7 %>" <%= jzxh_arr[0].length() > 0  ? "" : "readonly" %>  class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right; width:68px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <%}else{%>
          <td width="70" align="right">印数</td>
          <td colspan="3">
              <input type='text' name="printCnt7" id="printCnt7" value="<%=printCnt7 %>" <%= jzxh_arr[6].length() > 0  ? "" : "readonly" %> class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right; width:219px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <%}%>
      </tr>

      <tr id="wswytr8" class="wswytr" style="">
        <td width="70" align="right">文书8</td>
        <td style="padding: 0px;" colspan="3">
        <table class="reportInTab" cellpadding="0" cellspacing="0" width="100%" height="100%">
          <tr height="25">
             <td>
                  <input type="hidden" name="wsXh8" id="wsXh8" value="<%= jzxh_arr[7].length() > 0 ? jzxh_arr[7] : jzXh8 %>" />
                  <span id="wsShow8">
                   <%
                  if (jzXh8.length() > 0) {
                  %>
                  <a class="alink" title="<%= JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc8"))%>" href="javascript:void(0);" onclick="viewJz('<%=ahdm %>', '<%= jzXh8 %>','<%=JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc8")).substring(JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc8")).length()-3)%>')"><%= JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc8"))%></a>
                  <%
                  }
                  %>
                  <%
                   if (jzxh_arr[7].length() > 0 && wsMcs[7].length() > 0) {
                  %>
                  <a class="alink" title="<%=wsMcs[7] %>" href="javascript:void(0);" onclick="viewJz('<%=ahdm %>', '<%= jzxh_arr[7] %>','<%=wsMcs[7].substring(wsMcs[7].length()-3)%>')"><%=wsMcs[7] %></a>
                  <%
                  }
                  %>
                  </span>
             </td>
             <td width="40px"><a class="abtn" href="javascript:void(0);" onclick="selDoc('wsXh8','wsShow8','printCnt8')">[选择]</a></td>
          </tr>

        </table>
        </td>
          <%if(dyA3){%>
          <td width="70"  cellpadding="0" cellspacing="0" style="border-right: 1px solid #7F9DB9" align="right">A3印数</td>
          <td width="75" style="border-right: 1px solid #7F9DB9">
              <input  type='text' name="printCnt8A3" id="printCnt8A3" value="<%=printCnt8A3 %>" <%= jzxh_arr[0].length() > 0  ? "" : "readonly" %>  class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right;width:68px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <td  width="70" cellpadding="0" cellspacing="0" style="border-right: 1px solid #7F9DB9" align="right">A4印数</td>
          <td >
              <input  type='text' name="printCnt8" id="printCnt8" value="<%=printCnt8 %>" <%= jzxh_arr[0].length() > 0  ? "" : "readonly" %>  class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right; width:68px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <%}else{%>
          <td width="70" align="right">印数</td>
          <td colspan="3">
              <input type='text' name="printCnt8" id="printCnt8" value="<%=printCnt8 %>" <%= jzxh_arr[7].length() > 0  ? "" : "readonly" %> class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right; width:219px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <%}%>
      </tr>

      <tr id="wswytr9" class="wswytr" style="">
        <td width="70" align="right">文书9</td>
        <td style="padding: 0px;" colspan="3">
        <table class="reportInTab" cellpadding="0" cellspacing="0" width="100%" height="100%">
          <tr height="25">
             <td>
                  <input type="hidden" name="wsXh9" id="wsXh9" value="<%= jzxh_arr[8].length() > 0 ? jzxh_arr[8] : jzXh9 %>"/>
                  <span id="wsShow9">
                   <%
                  if (jzXh9.length() > 0) {
                  %>
                  <a class="alink" title="<%= JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc9"))%>" href="javascript:void(0);" onclick="viewJz('<%=ahdm %>', '<%= jzXh9 %>','<%=JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc9")).substring(JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc9")).length()-3)%>')"><%= JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc9"))%></a>
                  <%
                  }
                  %>
                  <%
                   if (jzxh_arr[8].length() > 0 && wsMcs[8].length() > 0) {
                  %>
                  <a class="alink" title="<%=wsMcs[8] %>" href="javascript:void(0);" onclick="viewJz('<%=ahdm %>', '<%= jzxh_arr[8] %>','<%=wsMcs[8].substring(wsMcs[8].length()-3)%>')"><%=wsMcs[8] %></a>
                  <%
                  }
                  %>
                  </span>
             </td>
             <td width="40px"><a class="abtn" href="javascript:void(0);" onclick="selDoc('wsXh9','wsShow9','printCnt9')">[选择]</a></td>
          </tr>

        </table>
        </td>
          <%if(dyA3){%>
          <td width="70"  cellpadding="0" cellspacing="0" style="border-right: 1px solid #7F9DB9" align="right">A3印数</td>
          <td width="75" style="border-right: 1px solid #7F9DB9">
              <input  type='text' name="printCnt9A3" id="printCnt9A3" value="<%=printCnt9A3 %>" <%= jzxh_arr[0].length() > 0  ? "" : "readonly" %>  class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right;width:68px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <td  width="70" cellpadding="0" cellspacing="0" style="border-right: 1px solid #7F9DB9" align="right">A4印数</td>
          <td >
              <input  type='text' name="printCnt9" id="printCnt9" value="<%=printCnt9 %>" <%= jzxh_arr[0].length() > 0  ? "" : "readonly" %>  class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right; width:68px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <%}else{%>
          <td width="70" align="right">印数</td>
          <td colspan="3">
              <input type='text' name="printCnt9" id="printCnt9" value="<%=printCnt9 %>" <%= jzxh_arr[8].length() > 0  ? "" : "readonly" %> class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right; width:219px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <%}%>
      </tr>

      <tr id="wswytr10" class="wswytr" style="">
        <td width="70" align="right">文书10</td>
        <td style="padding: 0px;" colspan="3">
        <table class="reportInTab" cellpadding="0" cellspacing="0" width="100%" height="100%">
          <tr height="25">
             <td>
                  <input type="hidden" name="wsXh10" id="wsXh10" value="<%= jzxh_arr[9].length() > 0 ? jzxh_arr[9] : jzXh10 %>" />
                  <span id="wsShow10">
                   <%
                  if (jzXh10.length() > 0) {
                  %>
                  <a class="alink" title="<%= JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc10"))%>" href="javascript:void(0);" onclick="viewJz('<%=ahdm %>', '<%= jzXh10 %>','<%=JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc10")).substring(JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc10")).length()-3)%>')"><%= JzglUtils.trim(lcyw_map.get("tjr_ws_wsmc10"))%></a>
                  <%
                  }
                  %>
                  <%
                   if (jzxh_arr[9].length() > 0 && wsMcs[9].length() > 0) {
                  %>
                  <a class="alink" title="<%=wsMcs[9] %>" href="javascript:void(0);" onclick="viewJz('<%=ahdm %>', '<%= jzxh_arr[9] %>','<%=wsMcs[9].substring(wsMcs[9].length()-3)%>')"><%=wsMcs[9] %></a>
                  <%
                  }
                  %>
                  </span>
             </td>
             <td width="40px"><a class="abtn" href="javascript:void(0);" onclick="selDoc('wsXh10','wsShow10','printCnt10')">[选择]</a></td>
          </tr>

        </table>
        </td>
          <%if(dyA3){%>
          <td width="70"  cellpadding="0" cellspacing="0" style="border-right: 1px solid #7F9DB9" align="right">A3印数</td>
          <td width="75" style="border-right: 1px solid #7F9DB9">
              <input  type='text' name="printCnt10A3" id="printCnt10A3" value="<%=printCnt10A3 %>" <%= jzxh_arr[0].length() > 0  ? "" : "readonly" %>  class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right;width:68px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <td  width="70" cellpadding="0" cellspacing="0" style="border-right: 1px solid #7F9DB9" align="right">A4印数</td>
          <td >
              <input  type='text' name="printCnt10" id="printCnt10" value="<%=printCnt10 %>" <%= jzxh_arr[0].length() > 0  ? "" : "readonly" %>  class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right; width:68px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <%}else{%>
          <td width="70" align="right">印数</td>
          <td colspan="3">
              <input type='text' name="printCnt10" id="printCnt10" value="<%=printCnt10 %>" <%= jzxh_arr[9].length() > 0  ? "" : "readonly" %> class="sala_definput" onkeydown="onlyNum()" onfocus="this.style.imeMode='disabled'" onBlur="check_int(this);" style="text-align:right; width:219px;padding-right:1px; border: none; font-size:12px;"  maxlength="4"  />
          </td>
          <%}%>

      </tr>
      
          <tr height="25">
            <td   align="right">提交人</td>
            <td align="left" style="border-top: 1px solid; padding:0px;" colspan="3">
              <table width="100%" height="100%" border="0"  cellpadding="0" cellspacing="0" class="reportInTab">
                <tr height="25">
                  <td></td>

                  <td    align="right">
<%
String qmPath = "";
byte[] qm = null;
if(!"".equals(tjr)){
  qm = new TuserJdbcDAO().getZpQm(tjr,"YHQM");
}
if (qm != null) {
  qmPath = WebUtils.getContextPath(request) + "/frame/xtgl/yhgl/downYhzp.jsp?yhdm="+JzglUtils.encode8(tjr)+"&optype=yhqm&timetemp="+new Date().getTime();
}
qm = null;
if("".equals(qmPath)){
  out.println(JzglUtils.getYhmc(tjr));
}else{
  out.println("<img style='width:50px; height:25px' src='" + qmPath + "'>");
}
%>
                  </td>

                </tr>
              </table>
            </td>
              <td   align="right">提交日期</td>
                  <td   align="right" colspan="3">
<%= UtilComm.convertRq10(UtilComm.convertRq(new Date(), "yyyyMMdd")) %>
                  </td>
          </tr>
<%if("".equals(slh) ){ //&& "440104".equals(fydm)广州越秀法院%>
        <tr>
            <td width="70" align="right">下一步处理</td>
            <td colspan="7">
                <select id="sel_jdsx" style="width:220px"><%=jdsxOpts %></select>
            </td>
        </tr>
<%} %>
     <tr height="25">
        <td width="70" align="right">说明</td>
        <td colspan="7"  > <input type='text' name="bz" id="bz"  value="<%=bz %>" class="sala_definput"   style="width:'100%' ;  border: none ;font-size:12px;" /></td>
      </tr>


    </table>
    </td>
  </tr>
</table>


</body>
<script type="text/javascript">
var xhs = "<%=(selJzxh.length() > 0 && wsMc.length() > 0) ? selJzxh : ""%>";
var yydm = "<%=yydm%>";
jq(function(){
    jq(".wswytr").each(function(){
        //alert(jq(this).css("display"));
    })
})

var xhName;
var mcName;
var cntName;
// 选择文书 doc, rtf, pdf
function selDoc(xhname,mcname,cntname) {
    xhName = xhname;
    mcName = mcname;
    cntName = cntname;
  if('<%=ahdm%>'==''){alert('请先选择案号');return;}
  openModalWin("文书选择","wsSin.jsp?ahdm=<%=ahdm%>" , 300, 330,"wsSinCallback");

}

function wsSinCallback(rtn) {

    if (! rtn) return;
    if(rtn=="1"){
        jq('#'+mcName).html('');
        jq('#'+xhName).val('');
        jq("#"+cntName).val('');
        jq("#"+cntName).attr("readonly",true);
        return;
    }
    var xh = rtn.split("::")[0];
    var currxh =  jq('#'+xhName).val();
    var xhArr = xhs.split(",");
    if(xhs.indexOf(xh)>=0){
        alert("该文书已选，不可重复！"); return;
    }else{
        var result = jq.ajax({
            type : "POST",
            url : "<%=_path%>/wysp/lcsp.do",
            data : "pageLx=ajInLc&ahdm=<%=ahdm%>&slh=<%=slh%>&wsXh="+xh,
            async : false
        }).responseText;
        result = jq.trim(result);
        if("exits" == result) {
            <%if("440100".equals(fydm)){%>
            alert('该文书已有在办【文印流程】或【文书审批-签章文印】，不能重复提交，请删除或联系处理人退回原文书后，再次提交！');
            return;
            <%}else{%>
            alert('该文书已有文印流程正在办理，不允许重复提交！'); return;
            <%}%>
        }else{
            xhArr.remove(currxh);
            xhs = xhArr.join(",");
            xhs += ","+xh;
        }
    }
    var mc  = rtn.split("::").length > 1 ? rtn.split("::")[1] : "";
    var lb = rtn.split("::").length > 2 ? rtn.split("::")[2] : "";

    if (lb == "<%=wslb1%>" && xhs.indexOf(",")>0) {
        document.getElementById("cpws1").checked = true;
    } else {
        document.getElementById("cpws2").checked = true;
    }

    jq('#'+mcName).html('<a class="alink" title="' + mc + '" href="javascript:void(0);" onclick="viewJz(\'<%=ahdm%>\', \''+ xh +'\',\''+mc.substring(mc.length-3)+'\')">'+autoAddEllipsis(mc, 30)+'</a>');
    jq('#'+xhName).val(xh);
    jq("#"+cntName).attr("readonly",false);
}
function viewJz(ahdm,xh,wjgs){
    if(wjgs=="pdf" || wjgs=="PDF"){
        var viewJzPdf = "";
        try {
            var rtn = jq.ajax({
                type : "POST",
                url : "<%=_path%>/webapp/court/ajgl/wysp/wsSin_xml.jsp",
                data : "type=json&ahdm=<%=ahdm%>&wsXh="+wsXh, 
                async : false
            }).responseText;
            var json = eval("(" + jq.trim(rtn) + ")");
            for (var i = 0; i < json.length; i += 1) {
                if (json[i].XH == xh) {
                    if (json[i].pdfqz > 0) {
                        viewJzPdf = "1";
                    }
                    break;
                }
            }
        } catch(e){}
    	openMax("<%=_path%>/webapp/jzgl/jzbj/jzbj.jsp?ahdm="+ahdm+"&xxhh="+xh+"&wjgs="+wjgs+"&ly=wy&viewJzPdf=" + viewJzPdf);
    }else{
    	openMax("<%=_path%>/webapp/jzgl/weboffice/officejzll.jsp?AHDM="+ahdm+"&XXHH="+xh);
    }
   
}

// 选择案件
function selAj() {
  var rtn = openModal("selAj.jsp","" , 800, 700);
  if (! rtn) return;

  var jsp = window.location.href.split("?")[0];
  var param = window.location.href.split("?").length > 1 ? window.location.href.split("?")[1] : "";
  param = addParam(param, "ahdm", rtn);
  param = param.substr(1);
  var url = jsp+"?"+param +"&xzAjFlag=<%=xzAjFlag%>";
  window.location.href = url;
}

// 编辑卷宗
function editJz(ahdm, xh) {
  openModal(_path+"/webapp/jzgl/wszz/ws.jsp?ahdm="+ahdm+"&xxhh="+xh+"&isWsspEdit=1", "");
}

function doPrint() {
  window.print();
}

var fun_doCp = true;
function doCp(val) {
  var ahdm = "<%= ahdm%>";
  if (!ahdm) {
    alert('请先选择案件');
    return;
  }
  var sfjj = trim(jq("input[name='sfjj']:checked").val());
  var wsXh = trim(jq('#wsXh').val());
  var wsXh2 = trim(jq('#wsXh2').val());
  var wsXh3 = trim(jq('#wsXh3').val());
  var wsXh4 = trim(jq('#wsXh4').val());
  var wsXh5 = trim(jq('#wsXh5').val());
  var wsXh6 = trim(jq('#wsXh6').val());
  var wsXh7 = trim(jq('#wsXh7').val());
  var wsXh8 = trim(jq('#wsXh8').val());
  var wsXh9 = trim(jq('#wsXh9').val());
  var wsXh10 = trim(jq('#wsXh10').val());
  if (!wsXh && !wsXh2 && !wsXh3 &&!wsXh4 &&!wsXh5 &&!wsXh6 &&!wsXh7 &&!wsXh8 &&!wsXh9 &&!wsXh10) {
    alert('请选择文书');
    return;
  }

  var printCnt = trim(jq('input[name=printCnt]').val())
  var printCnt2 = trim(jq('input[name=printCnt2]').val())
  var printCnt3 = trim(jq('input[name=printCnt3]').val())
  var printCnt4 = trim(jq('input[name=printCnt4]').val())
  var printCnt5 = trim(jq('input[name=printCnt5]').val())
  var printCnt6 = trim(jq('input[name=printCnt6]').val())
  var printCnt7 = trim(jq('input[name=printCnt7]').val())
  var printCnt8 = trim(jq('input[name=printCnt8]').val())
  var printCnt9 = trim(jq('input[name=printCnt9]').val())
  var printCnt10 = trim(jq('input[name=printCnt10]').val())

    var printCntA3 = trim(jq('input[name=printCntA3]').val())
    var printCnt2A3 = trim(jq('input[name=printCnt2A3]').val())
    var printCnt3A3 = trim(jq('input[name=printCnt3A3]').val())
    var printCnt4A3 = trim(jq('input[name=printCnt4A3]').val())
    var printCnt5A3 = trim(jq('input[name=printCnt5A3]').val())
    var printCnt6A3 = trim(jq('input[name=printCnt6A3]').val())
    var printCnt7A3 = trim(jq('input[name=printCnt7A3]').val())
    var printCnt8A3 = trim(jq('input[name=printCnt8A3]').val())
    var printCnt9A3 = trim(jq('input[name=printCnt9A3]').val())
    var printCnt10A3 = trim(jq('input[name=printCnt10A3]').val())

  if ((!dyA3 && wsXh && !printCnt) || (dyA3 && wsXh && (!printCnt || !printCntA3))) {
    alert('请输入文书1印数');
    return;
  }
  if ((!dyA3 && wsXh2 && !printCnt2) || (dyA3 && wsXh2 && (!printCnt2 || !printCnt2A3))) {
    alert('请输入文书2印数');
    return;
  }
  if ((!dyA3 && wsXh3 && !printCnt3) || (dyA3 && wsXh3 && (!printCnt3 || !printCnt3A3))) {
    alert('请输入文书3印数');
    return;
  }
  if ((!dyA3 && wsXh4 && !printCnt4) || (dyA3 && wsXh4 && (!printCnt4 || !printCnt4A3))) {
    alert('请输入文书4印数');
    return;
  }
  if ((!dyA3 && wsXh5 && !printCnt5) || (dyA3 && wsXh5 && (!printCnt5 || !printCnt5A3))) {
    alert('请输入文书5印数');
    return;
  }
  if ((!dyA3 && wsXh6 && !printCnt6) || (dyA3 && wsXh6 && (!printCnt6 || !printCnt6A3))) {
    alert('请输入文书6印数');
    return;
  }
  if ((!dyA3 && wsXh7 && !printCnt7) || (dyA3 && wsXh7 && (!printCnt7 || !printCnt7A3))) {
    alert('请输入文书7印数');
    return;
  }
  if ((!dyA3 && wsXh8 && !printCnt8) || (dyA3 && wsXh8 && (!printCnt8 || !printCnt8A3))) {
    alert('请输入文书8印数');
    return;
  }
  if ((!dyA3 && wsXh9 && !printCnt9) || (dyA3 && wsXh9 && (!printCnt9 || !printCnt9A3))) {
    alert('请输入文书9印数');
    return;
  }
  if ((!dyA3 && wsXh10 && !printCnt10) || (dyA3 && wsXh10 && (!printCnt10 || !printCnt10A3))) {
    alert('请输入文书10印数');
    return;
  }
  var params = "";

//   var rtn = jq.ajax({
//       type : "POST",
//       url : "ajax.jsp",
<%--       data : "pageLx=ajInLc&ahdm=<%=ahdm%>&wsXh="+wsXh, --%>
//       async : false
//     }).responseText;
//   rtn = jq.trim(rtn);

//   if("exits" == rtn) {
//      alert('该文书已有文印流程正在办理，不允许重复提交！');
//   } else {
     <%--  rtn = jq.ajax({
          type : "POST",
          url : "<%=_path%>/wysp/lcsp.do",
          data : "pageLx=checkCnt&ahdm=<%=ahdm%>&wsXh="+wsXh+","+wsXh2+","+wsXh3+","+wsXh4+","+wsXh5+","+wsXh6+","+wsXh7+","+wsXh8+","+wsXh9+","+wsXh10,
          async : false
      }).responseText;
      rtn = jq.trim(rtn);
      var arr = rtn.split(",");
      var msg = "";
      for(var i=0;i<10;i++){
          if(arr[i]>0) msg+=",文书"+(i+1);
      }
      if(msg.length>1){
          msg = msg.substring(1);
            if (!confirm("在选择文书中 "+msg+" 已经文印，是否继续？")) {
              return;
          }
      } --%>
            params = "pageLx=tjlc&ahdm=<%=ahdm%>";
            params += "&sfjj=" + sfjj;
            params += "&wsXh="+wsXh+"&wsXh2="+wsXh2+"&wsXh3="+wsXh3+"&wsXh4="+wsXh4+"&wsXh5="+wsXh5+"&wsXh6="+wsXh6+"&wsXh7="+wsXh7+"&wsXh8="+wsXh8+"&wsXh9="+wsXh9+"&wsXh10="+wsXh10;
            params += "&printCnt="+ printCnt+"&printCnt2="+ printCnt2+"&printCnt3="+ printCnt3+"&printCnt4="+ printCnt4+"&printCnt5="+ printCnt5+"&printCnt6="+ printCnt6+"&printCnt7="+ printCnt7+"&printCnt8="+ printCnt8+"&printCnt9="+ printCnt9+"&printCnt10="+ printCnt10;
            params += "&printCntA3="+ printCntA3+"&printCnt2A3="+ printCnt2A3+"&printCnt3A3="+ printCnt3A3+"&printCnt4A3="+ printCnt4A3+"&printCnt5A3="+ printCnt5A3+"&printCnt6A3="+ printCnt6A3+"&printCnt7A3="+ printCnt7A3+"&printCnt8A3="+ printCnt8A3+"&printCnt9A3="+ printCnt9A3+"&printCnt10A3="+ printCnt10A3;
            params += "&bz="+ encodeStr(trim(jq('#bz').val()));
            if(jq("#sel_jdsx").val()){
                params += "&cljg="+jq("#sel_jdsx").val();
            }else{
                params += "&cljg="+val;
            }
          var cpws = document.getElementsByName("cpws");
          if (cpws != null && cpws.length > 0) {
            for (var i=0; i<cpws.length; i++) {
              if (cpws[i].checked) {
                params += "&wslb="+ cpws[i].value;
                break;
              }
            }
          }
          rtn = jq.ajax({
          type : "POST",
          url : "<%=_path%>/wysp/lcsp.do",
          data : params,
          async : false
        }).responseText;
          rtn = jq.trim(rtn);
          if (rtn.indexOf("err") == 0) {
                if(rtn.indexOf("重复提交") > 0) {
                   <%--  <%if("440100".equals(fydm)){%>
                    alert('该文书已有在办【文印流程】或【文书审批-签章文印】，不能重复提交，请删除或联系处理人退回原文书后，再次提交！');
                     <%}else{%>
                    alert('该文书已有文印流程正在办理，不允许重复提交！'); 
                     <%}%> --%>
                     alert(rtn.substring(3,rtn.length-1)); 
                } else {
                alert('操作失败-'+rtn);
            }
          } else {
              slhh = rtn.split(";")[1]
            doLcCompete('<%=WebUtils.getContextPath(request)%>','<%=fydm%>',yydm+'_10024',slhh, 'msg');
            //alert('操作成功.');
            //window.parent.close();
          }
//  }
}

var slhh = '';
function msg() {
    CourtMsg.info("提交成功", function(){
        window.returnValue = slhh;
         window.parent.close();
        // CloseWebPage();
    });
}


function viewLcfj(xh, znxh,wjgs) {
<%--   openModal("wsspfj.jsp?lch=<%=lch%>&slh=<%=slh%>&xh=" + xh + "&znxh=" + znxh + "&act=viewNew","") --%>
 var printCnt = trim(jq('input[name=printCnt]').val())
  openModal("wyspfj.jsp?lch=<%=lch%>&slh=<%=slh%>&ahdm=<%=ahdm%>&xh=" + xh + "&znxh=" + znxh + "&act=viewNew&currentxh=<%=xh%>&printCnt="+printCnt+"&ywcl=<%=ywcl%>&wjgs="+wjgs,"")
}

  // 保存
  var fun_doSave = true;
  function doSave(flow) {
      var wsXh  = trim(jq('#wsXh').val());
      var wsXh2 = trim(jq('#wsXh2').val());
      var wsXh3 = trim(jq('#wsXh3').val());
      var wsXh4 = trim(jq('#wsXh4').val());
      var wsXh5 = trim(jq('#wsXh5').val());
      var wsXh6 = trim(jq('#wsXh6').val());
      var wsXh7 = trim(jq('#wsXh7').val());
      var wsXh8 = trim(jq('#wsXh8').val());
      var wsXh9 = trim(jq('#wsXh9').val());
      var wsXh10 = trim(jq('#wsXh10').val());
      if (!wsXh && !wsXh2 && !wsXh3 &&!wsXh4 &&!wsXh5 &&!wsXh6 &&!wsXh7 &&!wsXh8 &&!wsXh9 &&!wsXh10) {
        alert('请选择文书');
        return;
      }
    
      var printCnt  = trim(jq('input[name=printCnt]').val())
      var printCnt2 = trim(jq('input[name=printCnt2]').val())
      var printCnt3 = trim(jq('input[name=printCnt3]').val())
      var printCnt4 = trim(jq('input[name=printCnt4]').val())
      var printCnt5 = trim(jq('input[name=printCnt5]').val())
      var printCnt6 = trim(jq('input[name=printCnt6]').val())
      var printCnt7 = trim(jq('input[name=printCnt7]').val())
      var printCnt8 = trim(jq('input[name=printCnt8]').val())
      var printCnt9 = trim(jq('input[name=printCnt9]').val())
      var printCnt10 = trim(jq('input[name=printCnt10]').val())
      var printCntA3 = trim(jq('input[name=printCntA3]').val())
      var printCnt2A3 = trim(jq('input[name=printCnt2A3]').val())
      var printCnt3A3 = trim(jq('input[name=printCnt3A3]').val())
      var printCnt4A3 = trim(jq('input[name=printCnt4A3]').val())
      var printCnt5A3 = trim(jq('input[name=printCnt5A3]').val())
      var printCnt6A3 = trim(jq('input[name=printCnt6A3]').val())
      var printCnt7A3 = trim(jq('input[name=printCnt7A3]').val())
      var printCnt8A3 = trim(jq('input[name=printCnt8A3]').val())
      var printCnt9A3 = trim(jq('input[name=printCnt9A3]').val())
      var printCnt10A3 = trim(jq('input[name=printCnt10A3]').val())

      if ((!dyA3 && wsXh && !printCnt) || (dyA3 && wsXh && (!printCnt || !printCntA3))) {
          alert('请输入文书1印数');
          return;
      }
      if ((!dyA3 && wsXh2 && !printCnt2) || (dyA3 && wsXh2 && (!printCnt2 || !printCnt2A3))) {
          alert('请输入文书2印数');
          return;
      }
      if ((!dyA3 && wsXh3 && !printCnt3) || (dyA3 && wsXh3 && (!printCnt3 || !printCnt3A3))) {
          alert('请输入文书3印数');
          return;
      }
      if ((!dyA3 && wsXh4 && !printCnt4) || (dyA3 && wsXh4 && (!printCnt4 || !printCnt4A3))) {
          alert('请输入文书4印数');
          return;
      }
      if ((!dyA3 && wsXh5 && !printCnt5) || (dyA3 && wsXh5 && (!printCnt5 || !printCnt5A3))) {
          alert('请输入文书5印数');
          return;
      }
      if ((!dyA3 && wsXh6 && !printCnt6) || (dyA3 && wsXh6 && (!printCnt6 || !printCnt6A3))) {
          alert('请输入文书6印数');
          return;
      }
      if ((!dyA3 && wsXh7 && !printCnt7) || (dyA3 && wsXh7 && (!printCnt7 || !printCnt7A3))) {
          alert('请输入文书7印数');
          return;
      }
      if ((!dyA3 && wsXh8 && !printCnt8) || (dyA3 && wsXh8 && (!printCnt8 || !printCnt8A3))) {
          alert('请输入文书8印数');
          return;
      }
      if ((!dyA3 && wsXh9 && !printCnt9) || (dyA3 && wsXh4 && (!printCnt9 || !printCnt9A3))) {
          alert('请输入文书9印数');
          return;
      }
      if ((!dyA3 && wsXh10 && !printCnt10) || (dyA3 && wsXh10 && (!printCnt10 || !printCnt10A3))) {
          alert('请输入文书10印数');
          return;
      }
    var params = "pageLx=tjSave&ahdm=<%=ahdm%>&lch=<%=lch%>&slh=<%=slh%>&xh=<%=xh%>&znxh=<%=znxh%>&ywcl=<%=JzglUtils.encode8(ywcl)%>&jdbh=<%=jdbh%>";
    params += "&wsXh="+wsXh+"&wsXh2="+wsXh2+"&wsXh3="+wsXh3+"&wsXh4="+wsXh4+"&wsXh5="+wsXh5+"&wsXh6="+wsXh6+"&wsXh7="+wsXh7+"&wsXh8="+wsXh8+"&wsXh9="+wsXh9+"&wsXh10="+wsXh10;
    params += "&printCnt="+ printCnt+"&printCnt2="+ printCnt2+"&printCnt3="+ printCnt3+"&printCnt4="+ printCnt4+"&printCnt5="+ printCnt5+"&printCnt6="+ printCnt6+"&printCnt7="+ printCnt7+"&printCnt8="+ printCnt8+"&printCnt9="+ printCnt9+"&printCnt10="+ printCnt10;
      params += "&printCntA3="+ printCntA3+"&printCnt2A3="+ printCnt2A3+"&printCnt3A3="+ printCnt3A3+"&printCnt4A3="+ printCnt4A3+"&printCnt5A3="+ printCnt5A3+"&printCnt6A3="+ printCnt6A3+"&printCnt7A3="+ printCnt7A3+"&printCnt8A3="+ printCnt8A3+"&printCnt9A3="+ printCnt9A3+"&printCnt10A3="+ printCnt10A3;
      params += "&bz="+ encodeStr(trim(jq('#bz').val()));
    rtn = jq.ajax({
        type : "POST",
        url : "<%=_path%>/wysp/lcsp.do",
        data : params,
        async : false
      }).responseText;
    rtn = jq.trim(rtn);
    if (rtn == "ok") {
      if (flow != '0') {
        flowTJ(flow);
      } else {
        CourtMsg.info('操作成功.')
      }
    } else {
      alert('操作失败.')
    }
  }

  // 提交
  function flowTJ(val) {
    var jdsx = false;
    var cljg = "";
    var params = "pageLx=tjSp&fydm=<%=fydm%>&yhdm=<%=yhdm%>&ahdm=<%=ahdm%>&lch=<%=lch%>&slh=<%=slh%>&jdbh=<%=jdbh%>&xh=<%=xh%>&znxh=<%=znxh%>&yhxm=<%=yhxm%>";
    params += "&cljg="+val; 
    var rtn = jq.ajax({
        type : "POST",
        url : "<%=_path%>/wysp/lcsp.do",
        data : params,
        async : false
      }).responseText;
    rtn = jq.trim(rtn);
    afterforwardSuccesa(rtn);
  }

  // 流程提交后的处理函数
  function afterforwardSuccesa(data) {
    var rtn = data;
    if (!rtn || rtn.indexOf("exec=1") == -1) {
      alert('流转失败.');
      return;
    }
    doLcCompete('<%=WebUtils.getContextPath(request)%>','<%=fydm%>','<%=lch%>','<%=slh%>',function(){
        CourtMsg.info("提交成功", function(){
            window.returnValue = rtn;
            window.parent.close();
            //CloseWebPage();
        });
    });
//     window.returnValue = rtn;
//     window.parent.close();
  }

</script>
</html>