<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_rewards_info.table.title"/><spring:message code="sys.manager"/></title>
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
		<li class="active"><a href="#"><spring:message code="hb_rewards_info.table.title"/><spring:message code="sys.list"/></a></li>
	</ul>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
						<spring:message code="hb_rewards_info.rewards_date" text="hb_rewards_info.rewards_date"/></th>
				
				<th>
						<spring:message code="hb_rewards_info.rewards_name" text="hb_rewards_info.rewards_name"/></th>
				<th>
						<spring:message code="hb_user_info.real_name" text="hb_user_info.real_name"/></th>
				
				<th>
						<spring:message code="hb_rewards_info.rewards_no" text="hb_rewards_info.rewards_no"/></th>
				<th>
						<spring:message code="hb_rewards_info.rewards_rule" text="hb_rewards_info.rewards_rule"/></th>
				<th>
						<spring:message code="sys.remarks" text="sys.remarks"/></th>
				<%-- <shiro:hasPermission name="hb:hbRewardsInfo:edit"><th><spring:message code="sys.operation"/></th></shiro:hasPermission> --%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="hbRewardsInfo">
			<tr>
				<td>
					<fmt:formatDate value="${hbRewardsInfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				
				<td>
					${hbRewardsInfo.rewardsName}
				</td>
				<td>
					${hbRewardsInfo.user.realName}
				</td>
				<%-- <td>
					<fmt:formatDate value="${hbRewardsInfo.rewardsDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td> --%>
				<td>
					${hbRewardsInfo.rewardsNo}
				</td>
				<td>
					${hbRewardsInfo.reward.rewardsName}
				</td>
				<td>
					${hbRewardsInfo.remarks}
				</td>
				<%-- <shiro:hasPermission name="hb:hbRewardsInfo:edit"><td>
    				<a href="${ctx}/hb/hbRewardsInfo/form?id=${hbRewardsInfo.id}"><spring:message code="sys.update" text="修改"/></a>					<a href="${ctx}/hb/hbRewardsInfo/delete?id=${hbRewardsInfo.id}" onclick="return confirmx('<spring:message code="sys.confirm.delete"/>', this.href)"><spring:message code="sys.delete" text="删除"/></a>
				</td></shiro:hasPermission> --%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>