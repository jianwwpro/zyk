<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_data.table.title"/><spring:message code="sys.manager"/></title>
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
		<li class="active"><a href="${ctx}/hb/hbData/"><spring:message code="hb_data.table.title"/><spring:message code="sys.list"/></a></li>
		<shiro:hasPermission name="hb:hbData:edit"><li><a href="${ctx}/hb/hbData/form"><spring:message code="hb_data.table.title"/><spring:message code="sys.add"/></a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="hbData" action="${ctx}/hb/hbData/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="sys.query"/>"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th><spring:message code="sys.update_date"/></th>
				<th><spring:message code="sys.remarks"/></th>
				<shiro:hasPermission name="hb:hbData:edit"><th><spring:message code="sys.operation"/></th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="hbData">
			<tr>
				<td><a href="${ctx}/hb/hbData/form?id=${hbData.id}">
					${hbData.updateDate}
				</a></td>
				<td>
					${hbData.remarks}
				</td>
				<shiro:hasPermission name="hb:hbData:edit"><td>
    				<a href="${ctx}/hb/hbData/form?id=${hbData.id}">修改</a>
					<a href="${ctx}/hb/hbData/delete?id=${hbData.id}" onclick="return confirmx('<spring:message code="sys.confirm.delete"/>', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>