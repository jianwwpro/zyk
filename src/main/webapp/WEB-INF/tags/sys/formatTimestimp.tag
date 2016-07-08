<%@tag import="java.text.SimpleDateFormat"%>
<%@tag import="java.util.Date"%>
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="timestimp" type="java.lang.Long" required="true" description="时间戳"%>
<%@ attribute name="partten" type="java.lang.String" required="true" description="格式化类型"%>

<%=(new SimpleDateFormat(jspContext.getAttribute("partten").toString())).format(new Date(Long.valueOf(jspContext.getAttribute("timestimp").toString())*1000))%>