<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_rewards_applyinfo.table.title"/><spring:message code="sys.manager"/></title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="#"><spring:message code="hb_rewards_applyinfo.table.title"/><spring:message code="sys.list"/></a></li>
		<shiro:hasPermission name="hb:hbRewardsApplyinfo:edit"><li><a href="${ctx}/hb/hbRewardsApplyinfo/form"><spring:message code="hb_rewards_applyinfo.table.title"/><spring:message code="sys.add"/></a></li></shiro:hasPermission>
	</ul>
	<%-- <form id="searchForm"  class="breadcrumb form-search">
		<ul class="ul-form">
			<li><label><spring:message code="hb_user_info.login_name" text="hb_user_info.login_name"/>：</label>
				<form:input path="userName" value="${userName }" htmlEscape="false" maxlength="64" class="input-medium" disabled="true" />
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="sys.query"/>"/></li>
			<li class="clearfix"></li>
			<!-- 兑换次数 -->
			<li><label><spring:message code="hb_user_info.rewar_count" text="hb_user_info.rewar_count"/>：</label>
				<form:input path="rewarCount" value="${fn:length(hbRewardsApplyinfo) }" htmlEscape="false" maxlength="64" class="input-medium" disabled="true"/>
			</li>
		</ul>
	</form> --%>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<!-- 审核时间 -->
				<th>
						<spring:message code="hb_rewards_applyinfo.finsh_time" text="hb_rewards_applyinfo.finsh_time"/></th>
				<!-- 使用积分 -->
				<th>
						<spring:message code="hb_rewards_applyinfo.rewards" text="hb_rewards_applyinfo.rewards"/></th>
				<!-- 兑换内容 -->
				<th>
						<spring:message code="hb_rewards_applyinfo.name" text="hb_rewards_applyinfo.name"/></th>
				<!-- 备注 -->
				<th>
						<spring:message code="sys.remarks" text="sys.remarks"/></th>
				<%-- <th>
						<spring:message code="sys.update_date" text="sys.update_date"/></th>
				<th>
						<spring:message code="hb_rewards_applyinfo.remarks" text="sys.remarks"/></th>
				<th>
						<spring:message code="hb_rewards_applyinfo.user_id" text="hb_rewards_applyinfo.user_id"/></th>
				<th>
						<spring:message code="hb_rewards_applyinfo.state" text="hb_rewards_applyinfo.state"/></th>
				<th>
						<spring:message code="hb_rewards_applyinfo.name" text="hb_rewards_applyinfo.name"/></th>
				<th>
						<spring:message code="hb_rewards_applyinfo.rewards" text="hb_rewards_applyinfo.rewards"/></th>
				<th>
						<spring:message code="hb_rewards_applyinfo.apply_time" text="hb_rewards_applyinfo.apply_time"/></th>
				<th>
						<spring:message code="hb_rewards_applyinfo.finsh_time" text="hb_rewards_applyinfo.finsh_time"/></th>
				<th>
						<spring:message code="hb_rewards_applyinfo.consignee" text="hb_rewards_applyinfo.consignee"/></th>
				<th>
						<spring:message code="hb_rewards_applyinfo.phone" text="hb_rewards_applyinfo.phone"/></th>
				<th>
						<spring:message code="hb_rewards_applyinfo.address" text="hb_rewards_applyinfo.address"/></th>
				<th>
						<spring:message code="hb_rewards_applyinfo.remarks1" text="hb_rewards_applyinfo.remarks1"/></th>
				<shiro:hasPermission name="hb:hbRewardsApplyinfo:edit"><th><spring:message code="sys.operation"/></th></shiro:hasPermission> --%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${hbRewardsApplyinfo}" var="hbRewardsApplyinfo">
			<tr>
				<td>
					<fmt:formatDate value="${hbRewardsApplyinfo.finshTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${hbRewardsApplyinfo.remarks}
				</td>
				<td>
					${hbRewardsApplyinfo.name}
				</td>
				<td>
					${hbRewardsApplyinfo.remarks1}
				</td>
				<%-- <td><a href="${ctx}/hb/hbRewardsApplyinfo/form?id=${hbRewardsApplyinfo.id}">
					${hbRewardsApplyinfo.updateDate}
				</a></td>
				<td>
					${hbRewardsApplyinfo.remarks}
				</td>
				<td>
					${hbRewardsApplyinfo.user.name}
				</td>
				<td>
					${hbRewardsApplyinfo.state}
				</td>
				<td>
					${hbRewardsApplyinfo.name}
				</td>
				<td>
					${hbRewardsApplyinfo.rewards}
				</td>
				<td>
					<fmt:formatDate value="${hbRewardsApplyinfo.applyTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${hbRewardsApplyinfo.finshTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${hbRewardsApplyinfo.consignee}
				</td>
				<td>
					${hbRewardsApplyinfo.phone}
				</td>
				<td>
					${hbRewardsApplyinfo.address}
				</td>
				<td>
					${hbRewardsApplyinfo.remarks1}
				</td>
				<shiro:hasPermission name="hb:hbRewardsApplyinfo:edit"><td>
    				<a href="${ctx}/hb/hbRewardsApplyinfo/form?id=${hbRewardsApplyinfo.id}"><spring:message code="sys.update" text="修改"/></a>					<a href="${ctx}/hb/hbRewardsApplyinfo/delete?id=${hbRewardsApplyinfo.id}" onclick="return confirmx('<spring:message code="sys.confirm.delete"/>', this.href)"><spring:message code="sys.delete" text="删除"/></a>
				</td></shiro:hasPermission> --%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	
</body>
</html>