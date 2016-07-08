<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_journal.table.title"/><spring:message code="sys.manager"/></title>
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
			
			if('${param.view}'){
				$(".input-xlarge").attr("readonly","readonly");
			}
			
		});
		
		
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/hb/hbJournal/list?journalV=${empty param.journalV?hbJournal.journalV:param.journalV }"><spring:message code="hb_journal.table.title"/><spring:message code="sys.list"/></a></li>
		
		<li class="active"><a href="${ctx}/hb/hbJournal/form?id=${hbJournal.id}">
			<shiro:hasPermission name="hb:hbJournal:edit">
				<spring:message code="hb_journal.table.title"/>
				<spring:message code="sys.view"  text="查看"/>
			</shiro:hasPermission>
			<shiro:lacksPermission name="hb:hbJournal:edit"><spring:message code="sys.view"/></shiro:lacksPermission></a>
		
		</li>
		<shiro:hasPermission name="hb:hbJournal:edit">
			<c:if test="${not empty hbJournal.id }">
				<li ><a href="${ctx}/hb/hbJournalList/list?journalId=${hbJournal.id}"><spring:message code="hb_journal_list.table.title"/><spring:message code="sys.list"/></a></li>
			</c:if>
		</shiro:hasPermission>
		
	</ul><br/>
	<form:form id="inputForm"  modelAttribute="hbJournal" action="${ctx}/hb/hbJournal/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<input type="hidden" name="journalV"  value="${empty hbJournal.id ?param.journalV:hbJournal.journalV }">
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.name" text="期刊名称"/>：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false"  maxlength="11"  	required="true" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.journal_thumb" text="期封面"/>：</label>
			<div class="controls">
				<form:input id="journalThumb"  path="journalThumb"  htmlEscape="false"  style="display:none"  maxlength="100"  required="true" class="input-xlarge "/>
				<sys:ckfinder input="journalThumb"  type="images" uploadPath="/thumb" selectMultiple="false" maxWidth="100" maxHeight="100"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.journal_pdf" text="期PDF"/>：</label>
			<div class="controls">
				<form:input id="journalPdf" path="journalPdf"  htmlEscape="false"  required="true"  style="display:none"  maxlength="100"   class="input-xlarge"/>
				<sys:ckfinder input="journalPdf"  type="files" uploadPath="/pdf"  selectMultiple="false" maxWidth="100" maxHeight="100"/>
				<c:if test="${ (not  empty hbJournal.journalPdf )  and  (not  empty hbJournal.id)}">
					<input type="button"  class="btn" id="createPdfPicBtn"  value="生成图片"  onclick="javascript:createPdfPic('${hbJournal.journalPdf }')" />
				</c:if>
			</div>
			
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.journal_no" text="卷期号"/>：</label>
			<div class="controls">
				<form:input path="journalNo" htmlEscape="false" maxlength="11"  digits="true" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.journal_sum" text="总期数"/>：</label>
			<div class="controls">
				<form:input path="journalSum" htmlEscape="false" maxlength="11"  digits="true"  class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.journal_year"  text="出版年"/>：</label>
			<div class="controls">
				<form:input path="journalYear" htmlEscape="false" maxlength="11"  digits="true"  class="input-xlarge "/>
			</div>
		</div>
	
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.journal_month" text="出版月"/>：</label>
			<div class="controls">
				<form:input path="journalMonth" htmlEscape="false" maxlength="11" digits="true"   class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.journal_day" text="出版日"/>：</label>
			<div class="controls">
				<form:input path="journalDay" htmlEscape="false" maxlength="11"  digits="true"  class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.journal_pages" text="页数"/>：</label>
			<div class="controls">
				<form:input path="journalPages" htmlEscape="false" maxlength="11"  digits="true"  class="input-xlarge "/>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.level" text="优先级"/>：</label>
			<div class="controls">
				<form:input path="level" htmlEscape="false" maxlength="2"  digits="true"  class="input-xlarge "/>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.status" text="状态"/>：</label>
			<div class="controls">
				<form:input path="status" htmlEscape="false" maxlength="1"  class="input-xlarge " readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.remarks" text="备注"/>：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="hb:hbJournal:edit">
			<c:if test="${not empty hbJournal.id }">
			<input id="btnApply" class="btn btn-primary" type="button"  value="提 交"/>&nbsp;
			</c:if>
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="sys.save"/>"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="<spring:message code="sys.back"/>" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>

<script type="text/javascript">
Array.prototype.remove = function(val) {
	var index = this.indexOf(val);
	if (index > -1) {
	this.splice(index, 1);
	}
	};
</script>

</script>

</html>