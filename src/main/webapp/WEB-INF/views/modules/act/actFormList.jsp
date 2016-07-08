<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>流程表单管理</title>
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
		<li class="active"><a href="${ctx}/act/actForm/">流程表单列表</a></li>
		<shiro:hasPermission name="act:actForm:edit"><li><a href="${ctx}/act/actForm/form">流程表单添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="actForm" action="${ctx}/act/actForm/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>pro_def_id</th>
				<th>task_def_id</th>
				<shiro:hasPermission name="act:actForm:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="actForm">
			<tr>
				<td><a href="${ctx}/act/actForm/form?id=${actForm.id}">
					${actForm.proDefId}
				</a></td>
				<td>
					${actForm.taskDefId}
				</td>
				<shiro:hasPermission name="act:actForm:edit"><td>
    				<a href="${ctx}/act/actForm/form?id=${actForm.id}">修改</a>
					<a href="${ctx}/act/actForm/delete?id=${actForm.id}" onclick="return confirmx('确认要删除该流程表单吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>