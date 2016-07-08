<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_journal_list.table.title"/><spring:message code="sys.manager"/></title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	
		var validator;
		$(document).ready(function() {
				$("#pageNum").change(function(){
					var value=$(this).val();
				});
				
				 validator=$("#inputForm").validate({errorContainer: "#messageBox",
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
		
		function addJournalList(){
			var form =$("#inputForm");
			if(validator &&　validator.form()){
				var url=$(form).attr("action");
				$.post(url,$(form).serialize(),function(data){
							$.jBox.alert(data.message,'消息');
							top.window.jBox.close();
				},'json');
			}
			
			return false;
		}
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
		<input type="hidden" name="journalId" value="${empty param.journalId?hbJournalList.journalId:param.journalId }">
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal_list.code" text="编号"/>：</label>
			<div class="controls">
				<form:input path="code" htmlEscape="false" maxlength="20"  required="true" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal_list.name" text="目录标题"/>：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="60"  required="true" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal_list.content" text="目录摘要"/>：</label>
			<div class="controls">
				<form:textarea path="content" htmlEscape="false" rows="4" maxlength="50" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal_list.sort" text="排序"/>：</label>
			<div class="controls">
				<form:input path="sort" htmlEscape="false" maxlength="11" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal_list.page_num" text="页号"/>：</label>
			<div class="controls">
				<form:input path="pageNum" htmlEscape="false" maxlength="11"  digits="true"  required="true"  class="input-xlarge  digits"/>
				
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal_list.remarks" text="备注"/>：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal_list.language" text="语种"/>：</label>
			<div class="controls">
				<form:select path="language">
					<form:options items="${fns:getDictList('lang')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="hb:hbJournalList:edit"><input id="btnSubmit" class="btn btn-primary" type="button" onclick="javascript:addJournalList();" value="<spring:message code="sys.save"/>"/>&nbsp;</shiro:hasPermission>
		</div>
	</form:form>
</body>
</html>