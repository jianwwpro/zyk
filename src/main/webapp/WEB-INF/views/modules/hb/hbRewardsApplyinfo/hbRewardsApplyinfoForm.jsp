<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_rewards_applyinfo.table.title"/><spring:message code="sys.manager"/></title>
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
		<li><a href="${ctx}/hb/hbRewardsApplyinfo/"><spring:message code="hb_rewards_applyinfo.table.title"/><spring:message code="sys.list"/></a></li>
		<li class="active"><a href="${ctx}/hb/hbRewardsApplyinfo/form?id=${hbRewardsApplyinfo.id}"><spring:message code="hb_rewards_applyinfo.table.title"/><shiro:hasPermission name="hb:hbRewardsApplyinfo:edit">${not empty hbRewardsApplyinfo.id?sys.update:sys.add}</shiro:hasPermission><shiro:lacksPermission name="hb:hbRewardsApplyinfo:edit"><spring:message code="sys.view"/></shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="hbRewardsApplyinfo" action="${ctx}/hb/hbRewardsApplyinfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards_applyinfo.remarks" text="sys.remarks"/>：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards_applyinfo.user_id" text="hb_rewards_applyinfo.user_id"/>：</label>
			<div class="controls">
				<sys:treeselect id="user" name="user.id" value="${hbRewardsApplyinfo.user.id}" labelName="user.name" labelValue="${hbRewardsApplyinfo.user.name}"
					title="<spring:message code="sys.user"/>" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards_applyinfo.state" text="hb_rewards_applyinfo.state"/>：</label>
			<div class="controls">
				<form:input path="state" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards_applyinfo.name" text="hb_rewards_applyinfo.name"/>：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards_applyinfo.rewards" text="hb_rewards_applyinfo.rewards"/>：</label>
			<div class="controls">
				<form:input path="rewards" htmlEscape="false" maxlength="10" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards_applyinfo.apply_time" text="hb_rewards_applyinfo.apply_time"/>：</label>
			<div class="controls">
				<input name="applyTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${hbRewardsApplyinfo.applyTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards_applyinfo.check_time" text="hb_rewards_applyinfo.check_time"/>：</label>
			<div class="controls">
				<input name="checkTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${hbRewardsApplyinfo.checkTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards_applyinfo.finsh_time" text="hb_rewards_applyinfo.finsh_time"/>：</label>
			<div class="controls">
				<input name="finshTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${hbRewardsApplyinfo.finshTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards_applyinfo.consignee" text="hb_rewards_applyinfo.consignee"/>：</label>
			<div class="controls">
				<form:input path="consignee" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards_applyinfo.phone" text="hb_rewards_applyinfo.phone"/>：</label>
			<div class="controls">
				<form:input path="phone" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards_applyinfo.address" text="hb_rewards_applyinfo.address"/>：</label>
			<div class="controls">
				<form:input path="address" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards_applyinfo.remarks1" text="hb_rewards_applyinfo.remarks1"/>：</label>
			<div class="controls">
				<form:input path="remarks1" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="hb:hbRewardsApplyinfo:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="sys.save"/>"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="<spring:message code="sys.back"/>" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>