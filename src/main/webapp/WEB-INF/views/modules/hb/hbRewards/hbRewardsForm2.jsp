<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_rewards.table.title"/><spring:message code="sys.manager"/></title>
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
		 <li><a href="${ctx}/hb/hbRewards/listInfo"><spring:message code="hb_rewards.table.title"/><spring:message code="sys.list"/></a></li>
		<li class="active"><a href="${ctx}/hb/hbRewards/form?id=${hbRewards.id}"><spring:message code="hb_rewards.table.title"/><spring:message code="sys.add"/><shiro:hasPermission name="hb:hbRewards:edit">${not empty hbRewards.id?sys.update:sys.add}</shiro:hasPermission><shiro:lacksPermission name="hb:hbRewards:edit"><spring:message code="sys.view"/></shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="hbRewards" action="${ctx}/hb/hbRewards/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards.rewards_name" text="hb_rewards.rewards_name"/>：</label>
			<div class="controls">
				<form:input path="rewardsName" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards.state" text="hb_rewards.state"/>：</label>
			<div class="controls">
				<form:input path="state" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards.rewards_type" text="hb_rewards.rewards_type"/>：</label>
			<div class="controls">
				<form:input path="rewardsType" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards.rewards_rule" text="hb_rewards.rewards_rule"/>：</label>
			<div class="controls">
				<select name="rewardsRule">
				<option value="0" ${hbRewards.rewardsRule=='1'?'':'selected' }>单词</option>
				<option value="1" ${hbRewards.rewardsRule=='1'?'selected':'' }>多次</option>
				</select>
				
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards.rewards_url" text="hb_rewards.rewards_url"/>：</label>
			<div class="controls">
				<form:input path="rewardsUrl" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_rewards.rewards" text="hb_rewards.rewards"/>：</label>
			<div class="controls">
				<form:input path="rewards" htmlEscape="false" maxlength="11" class="input-xlarge required digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="sys.remarks" text="sys.remarks"/>：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="hb:hbRewards:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="sys.save"/>"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="<spring:message code="sys.back"/>" onclick="history.go(-1)"/>
		</div> 
		
	</form:form>
</body>
</html>