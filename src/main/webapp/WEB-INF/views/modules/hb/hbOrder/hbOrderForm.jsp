<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_order.table.title"/><spring:message code="sys.manager"/></title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$(".input-xlarge").attr("readonly","readonly");
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
		<li><a href="${ctx}/hb/hbOrder/"><spring:message code="hb_order.table.title"/><spring:message code="sys.list"/></a></li>
		<li class="active"><a href="${ctx}/hb/hbOrder/form?id=${hbOrder.id}"><spring:message code="hb_order.table.title"/><shiro:hasPermission name="hb:hbOrder:edit">${not empty hbOrder.id?sys.update:sys.add}</shiro:hasPermission><shiro:lacksPermission name="hb:hbOrder:edit"><spring:message code="sys.view"/></shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="hbOrder" action="${ctx}/hb/hbOrder/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<%-- <div class="control-group">
			<label class="control-label"><spring:message code="hb_order.status" text="status"/>：</label>
			<div class="controls">
				<form:input path="status" htmlEscape="false" maxlength="1" class="input-xlarge " />
			</div>
		</div> 
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_order.code" text="code"/>：</label>
			<div class="controls">
				<form:input path="code" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"> </span>
			</div>
		</div>--%>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_order.consignee" text="收货人"/>：</label>
			<div class="controls">
				<form:input path="consignee" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
				<span class="help-inline"> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_order.consignee_address" text="收货人地址"/>：</label>
			<div class="controls">
				<form:input path="consigneeAddress" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
				<span class="help-inline"> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_order.consignee_phone" text="收货人电话"/>：</label>
			<div class="controls">
				<form:input path="consigneePhone" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
				<span class="help-inline"> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_order.user_id" text="订阅人"/>：</label>
			<div class="controls">
			<form:input path="userInfo.id" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
				<span class="help-inline"> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_order.order_time" text="订单时间"/>：</label>
			<div class="controls">
				<fmt:formatDate value="${hbOrder.orderTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				<span class="help-inline"> </span>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="hb:hbOrder:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="sys.save"/>"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="<spring:message code="sys.back"/>" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>