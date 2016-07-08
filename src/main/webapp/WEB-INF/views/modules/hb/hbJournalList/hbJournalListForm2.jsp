<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_journal_list.table.title"/><spring:message code="sys.manager"/></title>
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
	<%-- <ul class="nav nav-tabs">
		<li><a href="${ctx}/hb/hbJournalList/"><spring:message code="hb_journal_list.table.title"/><spring:message code="sys.list"/></a></li>
		<li class="active"><a href="${ctx}/hb/hbJournalList/form?id=${hbJournalList.id}"><spring:message code="hb_journal_list.table.title"/><shiro:hasPermission name="hb:hbJournalList:edit">${not empty hbJournalList.id?sys.update:sys.add}</shiro:hasPermission><shiro:lacksPermission name="hb:hbJournalList:edit"><spring:message code="sys.view"/></shiro:lacksPermission></a></li>
	</ul> --%>
	<br/>
	<form:form id="inputForm" modelAttribute="hbJournalList" action="${ctx}/hb/hbJournalList/save2" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal_list.remarks" text="备注"/>：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal_list.state" text="状态"/>：</label>
			<div class="controls">
				<form:input path="state" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal_list.sort" text="排序"/>：</label>
			<div class="controls">
				<form:input path="sort" htmlEscape="false" maxlength="11" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal_list.name" text="目录标题"/>：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="60" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal_list.content" text="目录摘要"/>：</label>
			<div class="controls">
				<form:textarea path="content" htmlEscape="false" rows="4" maxlength="50" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal_list.page_num" text="关联图片"/>：</label>
			<div class="controls">
				<form:input path="pageNum" htmlEscape="false" maxlength="11" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal_list.pic_path" text="图片地址"/>：</label>
			<div class="controls">
				<form:input path="picPath" htmlEscape="false" maxlength="200" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal_list.journal_id" text="期id"/>：</label>
			<div class="controls">
				<form:input path="journalId" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal_list.code" text="编号"/>：</label>
			<div class="controls">
				<form:input path="code" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal_list.language" text="语种"/>：</label>
			<div class="controls">
				<form:input path="language" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="hb:hbJournalList:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="sys.save"/>"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="<spring:message code="sys.back"/>" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>