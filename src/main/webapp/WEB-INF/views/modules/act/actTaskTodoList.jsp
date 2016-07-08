<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>待办任务</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		/**
		 * 签收任务
		 */
		function claim(taskId) {
			$.get('${ctx}/act/task/claim' ,{taskId: taskId}, function(data) {
				if (data == 'true'){
		        		top.$.jBox.tip('<spring:message code="hb_todo.todo.done" text="hb_todo.todo.done" />');
		            location = '${ctx}/act/task/todo/';
				}else{
		        	top.$.jBox.tip('<spring:message code="hb_todo.todo.fail" text="hb_todo.todo.fail" />');
				}
		    });
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/act/task/todo/"><spring:message code="hb_todo.todo.done_work" text="hb_todo.todo.done_work" /></a></li>
		<li><a href="${ctx}/act/task/historic/"><spring:message code="hb_todo.todo.todo_work" text="hb_todo.todo.todo_work" /></a></li>
		
	</ul>
	<form:form id="searchForm" modelAttribute="act" action="${ctx}/act/task/todo/" method="get" class="breadcrumb form-search">
		<div>
			<label><spring:message code="hb_todo.todo.process_type" text="hb_todo.todo.process_type" />：&nbsp;</label>
			<form:select path="procDefKey" class="input-medium">
				<form:option value="" label="${fns:getMessage('hb_todo.todo.all_process') }"/>
				<form:options items="${fns:getDictList('act_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</form:select>
			<label><spring:message code='hb_todo.todo.create_time' text='hb_todo.todo.create_time' />：</label>
			<input id="beginDate"  name="beginDate"  type="text" readonly="readonly" maxlength="20" class="input-medium Wdate" style="width:163px;"
				value="<fmt:formatDate value="${act.beginDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
				　--　
			<input id="endDate" name="endDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate" style="width:163px;"
				value="<fmt:formatDate value="${act.endDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
			&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code='hb_todo.todo.search' text='hb_todo.todo.search' />"/>
		</div>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th><spring:message code='hb_todo.todo.title' text='hb_todo.todo.title' /></th>
				<th><spring:message code='hb_todo.todo.current_point' text='hb_todo.todo.current_point' /></th>
				<th><spring:message code='hb_todo.todo.process_name' text='hb_todo.todo.process_name' /></th>
				<th><spring:message code='hb_todo.todo.editor' text='hb_todo.todo.editor' /></th>
				<th><spring:message code='hb_todo.todo.create_time' text='hb_todo.todo.create_time' /></th>
				<th><spring:message code='hb_todo.todo.operation' text='hb_todo.todo.operation' /></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="act">
				<c:set var="task" value="${act.task}" />
				<c:set var="vars" value="${act.vars}" />
				<c:set var="procDef" value="${act.procDef}" />
				<c:set var="status" value="${act.status}" />
				<tr>
					<td>
						<c:if test="${empty task.assignee}">
							<a href="javascript:claim('${task.id}');" title="签收任务">${fns:abbr(not empty act.vars.map.title ? act.vars.map.title : task.id, 60)}</a>
						</c:if>
						<c:if test="${not empty task.assignee}">
							<a href="${ctx}/act/task/form?taskId=${task.id}&taskName=${fns:urlEncode(task.name)}&taskDefKey=${task.taskDefinitionKey}&procInsId=${task.processInstanceId}&procDefId=${task.processDefinitionId}&status=${status}">${fns:abbr(not empty vars.map.title ? vars.map.title : task.id, 60)}</a>
						</c:if>
					</td>
					<td>
						<a target="_blank" href="${pageContext.request.contextPath}/act/rest/diagram-viewer?processDefinitionId=${task.processDefinitionId}&processInstanceId=${task.processInstanceId}">${task.name}</a>
					</td>
					<td>${procDef.name}</td>
					<td><b title='申请者'>${act.createBy.name}</b></td>
					<td><fmt:formatDate value="${task.createTime}" type="both"/></td>
					<td>
						<c:if test="${empty task.assignee}">
							<a href="javascript:claim('${task.id}');"><spring:message code='hb_todo.todo.sign' text='hb_todo.todo.sign' /></a>
						</c:if>
						<c:if test="${not empty task.assignee}"><%--
							<a href="${ctx}${procExecUrl}/exec/${task.taskDefinitionKey}?procInsId=${task.processInstanceId}&act.taskId=${task.id}">办理</a> --%>
							<a href="${ctx}/act/task/form?taskId=${task.id}&taskName=${fns:urlEncode(task.name)}&taskDefKey=${task.taskDefinitionKey}&procInsId=${task.processInstanceId}&procDefId=${task.processDefinitionId}&status=${status}"><spring:message code='hb_todo.todo.deal_with' text='hb_todo.todo.deal_with' /></a>
						</c:if>
						<shiro:hasPermission name="act:process:edit">
							<c:if test="${empty task.executionId}">
								<a href="${ctx}/act/task/deleteTask?taskId=${task.id}&reason=" onclick="return promptx(\"<spring:message code='hb_todo.todo.delete_task' text='hb_todo.todo.delete_task' />\",\"<spring:message code='hb_todo.todo.delete_reason' text='hb_todo.todo.delete_reason' />\",this.href);"><spring:message code='hb_todo.todo.delete_task' text='hb_todo.todo.delete_task' /></a>
							</c:if>
						</shiro:hasPermission>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>
