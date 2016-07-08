<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_order_info.table.title"/><spring:message code="sys.manager"/></title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
			<li ><a href="${ctx}/hb/hbOrder"><spring:message code="hb_order.table.title"/><spring:message code="sys.list"/></a></li>
		<li class="active"><a href="${ctx}/hb/hbOrderInfo?order.id=${param['order.id']}"><spring:message code="hb_order_info.table.title"/><spring:message code="sys.list"/></a></li>
<%-- 		<shiro:hasPermission name="hb:hbOrderInfo:edit"><li><a href="${ctx}/hb/hbOrderInfo/form"><spring:message code="hb_order_info.table.title"/><spring:message code="sys.add"/></a></li></shiro:hasPermission>--%>	</ul>
	<form:form id="searchForm" modelAttribute="hbOrderInfo" action="${ctx}/hb/hbOrderInfo?order.id=${param.order.id}" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<%-- <ul class="ul-form">
			<li><label><spring:message code="hb_order_info.order_id" text="订单id"/>：</label>
				<form:input path="order.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_order_info.journal_id" text="期刊id"/>：</label>
				<form:input path="journal.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="sys.query"/>"/></li>
			<li class="clearfix"></li>
		</ul> --%>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<%-- <th>
						<spring:message code="hb_order_info.order_id" text="订单id"/></th>--%>
				<th> 
						<spring:message code="hb_journal.name" text="期刊名称"/></th>
				<th>
						<spring:message code="hb_journal.journal_no" text="卷期号"/></th>
				<th>
						<spring:message code="hb_journal.journal_sum" text="总期数"/></th>
				<th>
						<spring:message code="hb_journal.journal_v" text="版本"/></th>
				<shiro:hasPermission name="hb:hbOrderInfo:edit"><th><spring:message code="sys.operation"/></th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="hbOrderInfo">
			<tr>
				<%-- <td>
					${hbOrderInfo.order.code}
				</td> --%>
				<td>
				<a href="${ctxFront}/journal/journalDetail?id=${hbOrderInfo.journal.id}" target="_blank">
					${hbOrderInfo.journal.name}
				</a>
				</td>
				<td>
					${hbOrderInfo.journal.journalYear}（${hbOrderInfo.journal.journalNo}）
				</td>
				<td>
					${hbOrderInfo.journal.journalSum}
				</td>
				<td>
				<spring:message code="${fns:getDictLabel(hbOrderInfo.journal.journalV, 'hb_journal_v', '')}"></spring:message>
					
				</td>
				<shiro:hasPermission name="hb:hbOrderInfo:edit"><td>
    				<%-- <a href="${ctx}/hb/hbOrderInfo/delete?id=${hbOrderInfo.id}" onclick="return confirmx('<spring:message code="sys.confirm.delete"/>', this.href)"><spring:message code="sys.delete" text="删除"/></a> --%>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>