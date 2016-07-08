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
		<li class="active"><a href="${ctx}/hb/hbRewardsInfo/"><spring:message code="hb_rewards_info.table.title"/><spring:message code="sys.list"/></a></li>
		<shiro:hasPermission name="hb:hbRewardsInfo:edit"><li><a href="${ctx}/hb/hbRewardsInfo/form"><spring:message code="hb_rewards_info.table.title"/><spring:message code="sys.add"/></a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="hbRewardsInfo" action="${ctx}/hb/hbRewardsInfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label><spring:message code="hb_rewards_info.rewards_name" text="hb_rewards_info.rewards_name"/>：</label>
				<form:input path="rewardsName" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_rewards_info.user_id" text="hb_rewards_info.user_id"/>：</label>
				<sys:treeselect id="user" name="user.id" value="${hbRewardsInfo.user.id}" labelName="user.name" labelValue="${hbRewardsInfo.user.realName}"
					title="<spring:message code='sys.user'/>" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label><spring:message code="hb_rewards_info.rewards_date" text="hb_rewards_info.rewards_date"/>：</label>
				<input name="rewardsDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${hbRewardsInfo.rewardsDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label><spring:message code="hb_rewards_info.rewards_no" text="hb_rewards_info.rewards_no"/>：</label>
				<form:input path="rewardsNo" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_rewards_info.rewards_state" text="hb_rewards_info.rewards_state"/>：</label>
				<form:select path="rewardsState" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('hb_rewards_info_state')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label><spring:message code="hb_rewards_info.rewards_rule" text="hb_rewards_info.rewards_rule"/>：</label>
				<form:select path="reward.id" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
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
						<spring:message code="sys.remarks" text="sys.remarks"/></th>
				<th>
						<spring:message code="hb_rewards_info.rewards_name" text="hb_rewards_info.rewards_name"/></th>
				<th>
						<spring:message code="hb_rewards_info.user_id" text="hb_rewards_info.user_id"/></th>
				<th>
						<spring:message code="hb_rewards_info.rewards_date" text="hb_rewards_info.rewards_date"/></th>
				<th>
						<spring:message code="hb_rewards_info.rewards_no" text="hb_rewards_info.rewards_no"/></th>
				<th>
						<spring:message code="hb_rewards_info.rewards_state" text="hb_rewards_info.rewards_state"/></th>
				<th>
						<spring:message code="hb_rewards_info.rewards_rule" text="hb_rewards_info.rewards_rule"/></th>
				<shiro:hasPermission name="hb:hbRewardsInfo:edit"><th><spring:message code="sys.operation"/></th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="hbRewardsInfo">
			<tr>
				<td><a href="${ctx}/hb/hbRewardsInfo/form?id=${hbRewardsInfo.id}">
					<fmt:formatDate value="${hbRewardsInfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${hbRewardsInfo.remarks}
				</td>
				<td>
					${hbRewardsInfo.rewardsName}
				</td>
				<td>
					${hbRewardsInfo.user.realName}
				</td>
				<td>
					<fmt:formatDate value="${hbRewardsInfo.rewardsDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${hbRewardsInfo.rewardsNo}
				</td>
				<td>
					${fns:getDictLabel(hbRewardsInfo.rewardsState, 'hb_rewards_info_state', '')}
				</td>
				<td>
					${fns:getDictLabel(hbRewardsInfo.reward.id, '', '')}
				</td>
				<shiro:hasPermission name="hb:hbRewardsInfo:edit"><td>
    				<a href="${ctx}/hb/hbRewardsInfo/form?id=${hbRewardsInfo.id}"><spring:message code="sys.update" text="修改"/></a>					<a href="${ctx}/hb/hbRewardsInfo/delete?id=${hbRewardsInfo.id}" onclick="return confirmx('<spring:message code="sys.confirm.delete"/>', this.href)"><spring:message code="sys.delete" text="删除"/></a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>