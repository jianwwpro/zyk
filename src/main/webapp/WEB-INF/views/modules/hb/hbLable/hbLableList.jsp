<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_lable.table.title"/><spring:message code="sys.manager"/></title>
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
		<li class="active"><a href="${ctx}/hb/hbLable/"><spring:message code="hb_lable.table.title"/><spring:message code="sys.list"/></a></li>
		<shiro:hasPermission name="hb:hbLable:edit"><li><a href="${ctx}/hb/hbLable/form"><spring:message code="hb_lable.table.title"/><spring:message code="sys.add"/></a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="hbLable" action="${ctx}/hb/hbLable/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label><spring:message code="hb_lable.name" text="标签名称"/>：</label>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="sys.query"/>"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
						<spring:message code="hb_lable.name" text="标签名称"/></th>
				<th>
						<spring:message code="sys.update_date" text="update_date"/></th>
				<shiro:hasPermission name="hb:hbLable:edit"><th><spring:message code="sys.operation"/></th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="hbLable">
			<tr>
				<td><a href="${ctx}/hb/hbLable/form?id=${hbLable.id}">
					${hbLable.name}
				</a></td>
				<td>
					${hbLable.updateDate}
				</td>
				<shiro:hasPermission name="hb:hbLable:edit"><td>
    				<a href="${ctx}/hb/hbLable/form?id=${hbLable.id}"><spring:message code="sys.update" text="修改"/></a>					<a href="${ctx}/hb/hbLable/delete?id=${hbLable.id}" onclick="return confirmx('<spring:message code="sys.confirm.delete"/>', this.href)"><spring:message code="sys.delete" text="删除"/></a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>