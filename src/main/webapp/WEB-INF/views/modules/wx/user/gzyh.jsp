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
		<li class="active"><a href="${ctx}/wx/user/gzyh">关注用户</a></li>
	</ul>
	
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
	
	<!-- 详细资料
剑舞
备注名 修改备注
地区 中国 江西 九江
签名 多行，少言。认真做人，认真做事。学会真正的享受孤独。
标签
星标组 
	 -->
		<thead><tr><th>头像</th><th>昵称</th><th>性别</th><th>地区</th><th>公众号</th><th>操作</th></tr></thead>
		<tbody>
		<c:forEach items="${wxUsers}" var="wxUser">
			<tr>
				<td><img width="50px" height="50px" src="${wxUser.headimgurl}" /></td>
				<td>${wxUser.nickname}</td>
				<td>${fns:getDictLabel(wxUser.sex, "sex", "0")}</td>
				<td>${wxUser.country } ${wxUser.province } ${wxUser.city }</td>
				<td>${wxUser.unionid}</td>
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