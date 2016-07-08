<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_rewards_applyinfo.table.title"/><spring:message code="sys.manager"/></title>
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
		<li class="active"><a href="${ctx}/hb/hbRewardsApplyinfo/"><spring:message code="hb_rewards_applyinfo.table.title"/><spring:message code="sys.list"/></a></li>
		<shiro:hasPermission name="hb:hbRewardsApplyinfo:edit"><li><a href="${ctx}/hb/hbRewardsApplyinfo/form"><spring:message code="hb_rewards_applyinfo.table.title"/><spring:message code="sys.add"/></a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="hbRewardsApplyinfo" action="${ctx}/hb/hbRewardsApplyinfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label><spring:message code="hb_rewards_applyinfo.user_id" text="hb_rewards_applyinfo.user_id"/>：</label>
				<sys:treeselect id="user" name="user.id" value="${hbRewardsApplyinfo.user.id}" labelName="user.name" labelValue="${hbRewardsApplyinfo.user.name}"
					title="<spring:message code='sys.user'/>" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label><spring:message code="hb_rewards_applyinfo.state" text="hb_rewards_applyinfo.state"/>：</label>
				<form:input path="state" htmlEscape="false" maxlength="1" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_rewards_applyinfo.name" text="hb_rewards_applyinfo.name"/>：</label>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_rewards_applyinfo.rewards" text="hb_rewards_applyinfo.rewards"/>：</label>
				<form:input path="rewards" htmlEscape="false" maxlength="10" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_rewards_applyinfo.apply_time" text="hb_rewards_applyinfo.apply_time"/>：</label>
				<input name="applyTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${hbRewardsApplyinfo.applyTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label><spring:message code="hb_rewards_applyinfo.finsh_time" text="hb_rewards_applyinfo.finsh_time"/>：</label>
				<input name="finshTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${hbRewardsApplyinfo.finshTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label><spring:message code="hb_rewards_applyinfo.consignee" text="hb_rewards_applyinfo.consignee"/>：</label>
				<form:input path="consignee" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_rewards_applyinfo.phone" text="hb_rewards_applyinfo.phone"/>：</label>
				<form:input path="phone" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_rewards_applyinfo.address" text="hb_rewards_applyinfo.address"/>：</label>
				<form:input path="address" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_rewards_applyinfo.remarks1" text="hb_rewards_applyinfo.remarks1"/>：</label>
				<form:input path="remarks1" htmlEscape="false" maxlength="255" class="input-medium"/>
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
				<shiro:hasPermission name="hb:hbRewardsApplyinfo:edit"><th><spring:message code="sys.operation"/></th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="hbRewardsApplyinfo">
			<tr>
				<td><a href="${ctx}/hb/hbRewardsApplyinfo/form?id=${hbRewardsApplyinfo.id}">
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
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>