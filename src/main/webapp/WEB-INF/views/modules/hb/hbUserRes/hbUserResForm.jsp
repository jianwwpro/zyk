<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_user_res.table.title"/><spring:message code="sys.manager"/></title>
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
		<li><a href="${ctx}/hb/hbUserRes/"><spring:message code="hb_user_res.table.title"/><spring:message code="sys.list"/></a></li>
		<li class="active"><a href="${ctx}/hb/hbUserRes/form?id=${hbUserRes.id}"><spring:message code="hb_user_res.table.title"/><shiro:hasPermission name="hb:hbUserRes:edit">${not empty hbUserRes.id?sys.update:sys.add}</shiro:hasPermission><shiro:lacksPermission name="hb:hbUserRes:edit"><spring:message code="sys.view"/></shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="hbUserRes" action="${ctx}/hb/hbUserRes/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_res.state" text="hb_user_res.state"/>：</label>
			<div class="controls">
				<form:input path="state" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_res.user_id" text="hb_user_res.user_id"/>：</label>
			<div class="controls">
				<sys:treeselect id="user" name="user.id" value="${hbUserRes.user.id}" labelName="user.name" labelValue="${hbUserRes.user.name}"
					title="<spring:message code="sys.user"/>" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_res.res_id" text="hb_user_res.res_id"/>：</label>
			<div class="controls">
				<form:input path="article.id" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_res.res_type" text="hb_user_res.res_type"/>：</label>
			<div class="controls">
				<form:select path="resType" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('hb_article_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_res.apply_type" text="hb_user_res.apply_type"/>：</label>
			<div class="controls">
				<form:select path="applyType" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('hb_article_business_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_res.time_long" text="hb_user_res.time_long"/>：</label>
			<div class="controls">
				<form:input path="timeLong" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_res.apply_num" text="hb_user_res.apply_num"/>：</label>
			<div class="controls">
				<form:input path="applyNum" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_res.remarks" text="sys.remarks"/>：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="hb:hbUserRes:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="sys.save"/>"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="<spring:message code="sys.back"/>" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>