<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>微信消息管理</title>
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
		<li class="active"><a href="${ctx}/wx/wxMessage/">微信消息列表</a></li>
		<shiro:hasPermission name="wx:wxMessage:edit"><li><a href="${ctx}/wx/wxMessage/form">微信消息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="wxMessage" action="${ctx}/wx/wxMessage/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>标题：</label>
				<form:input path="title" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>作者：</label>
				<form:input path="createBy.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>标题</th>
				<th>作者</th>
				<th>更新时间</th>
				<th>备注</th>
				<shiro:hasPermission name="wx:wxMessage:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="wxMessage">
			<tr>
				<td><a href="${ctx}/wx/wxMessage/form?id=${wxMessage.id}">
					${wxMessage.title}
				</a></td>
				<td>
					${wxMessage.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${wxMessage.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${wxMessage.remarks}
				</td>
				<shiro:hasPermission name="wx:wxMessage:edit"><td>
    				<a href="${ctx}/wx/wxMessage/form?id=${wxMessage.id}">修改</a>
					<a href="${ctx}/wx/wxMessage/delete?id=${wxMessage.id}" onclick="return confirmx('确认要删除该微信消息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>