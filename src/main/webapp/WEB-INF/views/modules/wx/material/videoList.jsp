<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>关注用户</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
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
		<li class="active"><a href="${ctx}/wx/material/image/list">图片素材</a></li>
	</ul>
	
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
	

		<thead><tr><th>缩略图</th><th>名称</th><th>更新时间</th></tr></thead>
		<tbody>
		<c:forEach items="${yjList.item}" var="item">
			<tr>
				<td><img width="50px" height="50px" src="${item.url}" /></td>
				
				<td>${item.name}</td>
				<td>${item.update_time}</td>
				
				<td>
    				<a href="">发送信息</a>
					
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>