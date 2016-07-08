<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_journal.table.title"/><spring:message code="sys.manager"/></title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic}/ckfinder/ckfinder.js"></script>
	<script type="text/javascript">
	
	
		function createPdfPic(pdfPath,isReturn,oldValue){
			var params={journalPdf:pdfPath };
			if(!isReturn){
				params.id='${hbJournal.id}';
			}
			$.post("${ctx}/hb/hbJournal/createPdfPic",params,function(data){
				if(data.type=='success'){
					if(!oldValue) oldValue=$("#createPdfPicBtn").val();
					$("#createPdfPicBtn").attr('disabled',true);
					$("#createPdfPicBtn").val(oldValue+"("+data.curPage+"/"+data.pageCount+")");
					setTimeout("createPdfPic('"+pdfPath+"',true,'"+oldValue+"')",1000);
				}else if(data.type=='ok'){
					$("#createPdfPicBtn").removeAttr('disabled');
					$("#createPdfPicBtn").val(oldValue);
				}else {
					$("#createPdfPicBtn").val(oldValue);
				}
			},'json');
		}
		$(document).ready(function() {
			$(".input-xlarge").attr("readonly","readonly");
			$(".input-xxlarge").attr("readonly","readonly");
			$("[id$='Preview']").siblings("a").remove();
			$("[id$='Preview']").children("li").children("a:last-child").remove();
			$("#journalYear").attr("readonly","readonly");
			$("#journalNo").attr("readonly","readonly");
			$("[name=publicationDate]").attr("disabled","disabled");
			$("a[class=btn]").remove();
			$("[id$='Preview']").parent().find("input[class=btn]").remove();
		});
		
</script>
</head>
<body>
	<ul class="nav nav-tabs">
	<li class="active"><a href="${ctx}/hb/hbJournal/form?id=${hbJournal.id}&view=true&act.taskId=${hbJournal.act.taskId }&act.procInsId=${hbJournal.act.procInsId }&act.taskDefKey=${hbJournal.act.taskDefKey }&act.taskName=${hbJournal.act.taskName }&act.procDefId=${hbJournal.act.procDefId }">
			<spring:message code="hb_journal.table.title"/>
		</a></li>
		<li ><a href="${ctx}/hb/hbJournalList/listCheck?act.taskId=${hbJournal.act.taskId }&act.procInsId=${hbJournal.act.procInsId }&act.taskDefKey=${hbJournal.act.taskDefKey }&act.taskName=${hbJournal.act.taskName }&act.procDefId=${hbJournal.act.procDefId }&journalId=${hbJournal.id}&view=true"><spring:message code="hb_journal_list.table.title"/><spring:message code="sys.list"/></a></li>
	</ul><br/>
	<form:form id="inputForm"  modelAttribute="hbJournal" action="${ctx}/hb/hbJournal/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
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
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.status" text="状态"/>：</label>
			<div class="controls">
				<form:input path="status" htmlEscape="false" maxlength="1"  class="input-xlarge " readonly="true"/>
			</div>
		</div>
		 --%>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.remarks" text="备注"/>：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge " readonly="true"/>
			</div>
		</div>
		<div class="form-actions">
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