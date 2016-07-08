<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>关键词管理管理</title>
	<meta name="decorator" content="default"/>

</head>
<body>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>关键词</th>
				<th>一级关联词</th>
				<th>二级关联词</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="cms:keywords:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${keys}" var="keywords">
			<tr>
				<td><a href="${ctx}/cms/keywords/form?id=${keywords.id}">
					${keywords.name}
				</a></td>
				<td>
					${keywords.firstRelationKey}
				</td>
				<td>
					${keywords.secondRelationKey}
				</td>
				<td>
					<fmt:formatDate value="${keywords.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${keywords.remarks}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	
</body>
</html>