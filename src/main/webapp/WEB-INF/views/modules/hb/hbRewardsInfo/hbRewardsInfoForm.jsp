<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_rewards_info.table.title"/><spring:message code="sys.manager"/></title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('<spring:message code="sys.loadding"/>');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("<spring:message code="sys.input.error"/>");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/hb/hbRewardsInfo/"><spring:message code="hb_rewards_info.table.title"/><spring:message code="sys.list"/></a></li>
		<li class="active"><a href="${ctx}/hb/hbRewardsInfo/form?id=${hbRewardsInfo.id}"><spring:message code="hb_rewards_info.table.title"/><shiro:hasPermission name="hb:hbRewardsInfo:edit">${not empty hbRewardsInfo.id?sys.update:sys.add}</shiro:hasPermission><shiro:lacksPermission name="hb:hbRewardsInfo:edit"><spring:message code="sys.view"/></shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="hbRewardsInfo" action="${ctx}/hb/hbRewardsInfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards_info.remarks" text="sys.remarks"/>：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards_info.state" text="hb_rewards_info.state"/>：</label>
			<div class="controls">
				<form:input path="state" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards_info.rewards_name" text="hb_rewards_info.rewards_name"/>：</label>
			<div class="controls">
				<form:input path="rewardsName" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards_info.user_id" text="hb_rewards_info.user_id"/>：</label>
			<div class="controls">
				<sys:treeselect id="user" name="user.id" value="${hbRewardsInfo.user.id}" labelName="user.name" labelValue="${hbRewardsInfo.user.name}"
					title="<spring:message code="sys.user"/>" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards_info.rewards_date" text="hb_rewards_info.rewards_date"/>：</label>
			<div class="controls">
				<input name="rewardsDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${hbRewardsInfo.rewardsDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards_info.rewards_no" text="hb_rewards_info.rewards_no"/>：</label>
			<div class="controls">
				<form:input path="rewardsNo" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards_info.rewards_state" text="hb_rewards_info.rewards_state"/>：</label>
			<div class="controls">
				<form:select path="rewardsState" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('hb_rewards_info_state')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards_info.rewards_rule" text="hb_rewards_info.rewards_rule"/>：</label>
			<div class="controls">
				<form:select path="reward.id" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="hb:hbRewardsInfo:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="sys.save"/>"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="<spring:message code="sys.back"/>" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>