<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>会员操作信息管理</title>
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
		<li class="active"><a href="${ctx}/shop/customerInfo/">会员操作信息列表</a></li>
		<shiro:hasPermission name="shop:customerInfo:edit"><li><a href="${ctx}/shop/customerInfo/form">会员操作信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="customerInfo" action="${ctx}/shop/customerInfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>会员名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="45" class="input-medium"/>
			</li>
			<li><label>性别：</label>
				<form:select path="gender" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>装填：</label>
				<form:input path="status" htmlEscape="false" maxlength="45" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>会员编号</th>
				<th>会员名称</th>
				<th>性别</th>
				<th>出生日期</th>
				<th>手机</th>
				<th>电子邮件</th>
				<th>装填</th>
				<th>更新时间</th>
				<shiro:hasPermission name="shop:customerInfo:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="customerInfo">
			<tr>
				<td><a href="${ctx}/shop/customerInfo/form?id=${customerInfo.id}">
					${customerInfo.code}
				</a></td>
				<td>
					${customerInfo.name}
				</td>
				<td>
					${fns:getDictLabel(customerInfo.gender, '', '')}
				</td>
				<td>
					<fmt:formatDate value="${customerInfo.birthday}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${customerInfo.shouji}
				</td>
				<td>
					${customerInfo.email}
				</td>
				<td>
					${customerInfo.status}
				</td>
				<td>
					<fmt:formatDate value="${customerInfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="shop:customerInfo:edit"><td>
    				<a href="${ctx}/shop/customerInfo/form?id=${customerInfo.id}">修改</a>
					<a href="${ctx}/shop/customerInfo/delete?id=${customerInfo.id}" onclick="return confirmx('确认要删除该会员操作信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>