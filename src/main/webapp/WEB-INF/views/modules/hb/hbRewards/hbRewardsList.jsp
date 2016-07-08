<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_rewards.table.title"/><spring:message code="sys.manager"/></title>
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
		<li class="active"><a href="${ctx}/hb/hbRewards/"><spring:message code="hb_rewards.table.title"/><spring:message code="sys.list"/></a></li>
		<shiro:hasPermission name="hb:hbRewards:edit"><li><a href="${ctx}/hb/hbRewards/form"><spring:message code="hb_rewards.table.title"/><spring:message code="sys.add"/></a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="hbRewards" action="${ctx}/hb/hbRewards/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label><spring:message code="hb_rewards.id" text="sys.id"/>：</label>
				<form:input path="id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_rewards.rewards_name" text="hb_rewards.rewards_name"/>：</label>
				<form:input path="rewardsName" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_rewards.state" text="hb_rewards.state"/>：</label>
				<form:input path="state" htmlEscape="false" maxlength="1" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_rewards.rewards_type" text="hb_rewards.rewards_type"/>：</label>
				<form:input path="rewardsType" htmlEscape="false" maxlength="1" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_rewards.rewards_rule" text="hb_rewards.rewards_rule"/>：</label>
				<form:input path="rewardsRule" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_rewards.rewards_url" text="hb_rewards.rewards_url"/>：</label>
				<form:input path="rewardsUrl" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_rewards.rewards" text="hb_rewards.rewards"/>：</label>
				<form:input path="rewards" htmlEscape="false" maxlength="11" class="input-medium"/>
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
						<spring:message code="sys.update_date" text="sys.update_date"/></th>
				<th>
						<spring:message code="hb_rewards.remarks" text="sys.remarks"/></th>
				<th>
						<spring:message code="hb_rewards.rewards_name" text="hb_rewards.rewards_name"/></th>
				<th>
						<spring:message code="hb_rewards.state" text="hb_rewards.state"/></th>
				<th>
						<spring:message code="hb_rewards.rewards_type" text="hb_rewards.rewards_type"/></th>
				<th>
						<spring:message code="hb_rewards.rewards_rule" text="hb_rewards.rewards_rule"/></th>
				<th>
						<spring:message code="hb_rewards.rewards_url" text="hb_rewards.rewards_url"/></th>
				<th>
						<spring:message code="hb_rewards.rewards" text="hb_rewards.rewards"/></th>
				<shiro:hasPermission name="hb:hbRewards:edit"><th><spring:message code="sys.operation"/></th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="hbRewards">
			<tr>
				<td><a href="${ctx}/hb/hbRewards/form?id=${hbRewards.id}">
					${hbRewards.updateDate}
				</a></td>
				<td>
					${hbRewards.remarks}
				</td>
				<td>
					${hbRewards.rewardsName}
				</td>
				<td>
					${hbRewards.state}
				</td>
				<td>
					${hbRewards.rewardsType}
				</td>
				<td>
					${hbRewards.rewardsRule}
				</td>
				<td>
					${hbRewards.rewardsUrl}
				</td>
				<td>
					${hbRewards.rewards}
				</td>
				<shiro:hasPermission name="hb:hbRewards:edit"><td>
    				<a href="${ctx}/hb/hbRewards/form?id=${hbRewards.id}"><spring:message code="sys.update" text="修改"/></a>					<a href="${ctx}/hb/hbRewards/delete?id=${hbRewards.id}" onclick="return confirmx('<spring:message code="sys.confirm.delete"/>', this.href)"><spring:message code="sys.delete" text="删除"/></a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>