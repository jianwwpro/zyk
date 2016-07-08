<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_journal.table.title"/><spring:message code="sys.manager"/></title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic}/ckfinder/ckfinder.js"></script>
	<script type="text/javascript">
	var zhLanguage="${langType}";
	
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
			
			if($("#name").val()==''){
				$("#name").val("孔子学院");
			} 
			$("#name").change(function(){
				if($(this).val()==''){
					$(this).val("孔子学院");
				}
			})
			
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
			
			if('${param.view}' && '${param.view}'!=''){
				$(".input-xlarge").attr("readonly","readonly");
				$(".input-xxlarge").attr("readonly","readonly");
				$("[id$='Preview']").siblings("a").remove();
				$("[id$='Preview']").children("li").children("a").last().remove();
				$("#journalYear").attr("readonly","readonly");
				$("#journalNo").attr("readonly","readonly");
				$("[name=publicationDate]").attr("disabled","disabled");
				
			}
			
			
			$("#btnApply").click(function(){
				//alert("Ee");
				$("#inputForm").attr("action","${ctx}/hb/hbJournal/apply");
				top.$.jBox.confirm(zhLanguage=='zh'?'确认吗？':'Sure?',zhLanguage=='zh'?'SYS prompt':'系统提示',function(v,h,f){
					if(v=='ok'){
						resetTip(); //loading();
						$("#inputForm").submit();
					}
				},{buttonsFocus:1, closed:function(){
					if (typeof closed == 'function') {
						closed();
					}
				}});
			});
		});
		
		
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/hb/hbJournal/list?journalV=${empty param.journalV?hbJournal.journalV:param.journalV }"><spring:message code="hb_journal.journal_list"/></a></li>
		
		<li class="active"><a href="${ctx}/hb/hbJournal/form?id=${hbJournal.id}&view=${param.view }">
			<shiro:hasPermission name="hb:hbJournal:edit">
				<spring:message code="hb_journal.table.title"/>
				<c:if test="	${empty param.view}">
				<c:choose>
					<c:when test="${not empty hbJournal.id}">
						<spring:message code="sys.update" text="修改"/>
					</c:when>
					<c:otherwise>
						<spring:message code="sys.add" text="添加"/>
					</c:otherwise>
				</c:choose>
				</c:if>
				<c:if test="	${not empty param.view}">
						<spring:message code="sys.view"  text="查看"/>
				</c:if>
			</shiro:hasPermission>
			<shiro:lacksPermission name="hb:hbJournal:edit"><spring:message code="sys.view"/></shiro:lacksPermission></a>
		
		</li>
		<shiro:hasPermission name="hb:hbJournal:edit">
			<c:if test="${not empty hbJournal.id }">
				<li ><a href="${ctx}/hb/hbJournalList/list?act.taskId=${hbJournal.act.taskId }&act.procInsId=${hbJournal.act.procInsId }&act.taskDefKey=${hbJournal.act.taskDefKey }&journalId=${hbJournal.id}&view=${param.view}"><spring:message code="hb_journal.magazine_catalog"/></a></li>
			</c:if>
		</shiro:hasPermission>
		
	</ul><br/>
	<form:form id="inputForm"  modelAttribute="hbJournal" action="${ctx}/hb/hbJournal/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<input type="hidden" name="journalV"  value="${empty hbJournal.id ?param.journalV:hbJournal.journalV }">
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.name" text="期刊名称"/>：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false"   maxlength="200"  	required="true" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.cover_photo" text="期封面"/>：</label>
			<div class="controls">
				<form:input id="journalThumb"  path="journalThumb"  htmlEscape="false"  style="display:none"  maxlength="300"  required="true" class="input-xlarge "/>
				<sys:ckfinder input="journalThumb"  type="images" uploadPath="/thumb" selectMultiple="false" maxWidth="100" maxHeight="100"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.PDF_show" text="期PDF"/>：</label>
			<div class="controls">
				<form:input id="journalPdf" path="journalPdf"  htmlEscape="false"  required="true"  style="display:none"  maxlength="300"   class="input-xlarge"/>
				<sys:ckfinder input="journalPdf"  type="files" uploadPath="/pdf"  selectMultiple="false" maxWidth="100" maxHeight="100"/>
				<c:if test="${ (not  empty hbJournal.journalPdf )  and  (not  empty hbJournal.id) and empty param.view}">
					<input type="button"  class="btn" id="createPdfPicBtn"  value="生成图片"  onclick="javascript:createPdfPic('${hbJournal.journalPdf }')" />
				</c:if>
			</div>
			
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.uploadPdf" text="下载pdf"/>：</label>
			<div class="controls">
				<form:input id="downPdfPath"  path="downPdfPath"  htmlEscape="false"  required="true"  style="display:none"  maxlength="300"   class="input-xlarge"/>
				<sys:ckfinder input="downPdfPath"  type="files" uploadPath="/pdf/down"  selectMultiple="false" maxWidth="100" maxHeight="100"/>
			</div>
			
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.journal_no" text="卷期号"/>：</label>
			<div class="controls">
				<%-- <form:input path="journalNo" htmlEscape="false" maxlength="11"  digits="true" class="input-xlarge " required="true" /> --%>
				<form:select path="journalYear" items="${years }">
				</form:select>
				<form:select path="journalNo" items="${journalNo }"  cssStyle="width:50px;">
				
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.journal_sum" text="总期数"/>：</label>
			<div class="controls">
				<form:input path="journalSum" htmlEscape="false" maxlength="11"  digits="true"  class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.journal_year"  text="出版日期"/>：</label>
			<div class="controls">
				<input type="text" readonly="readonly" name="publicationDate"  value="<fmt:formatDate value="${hbJournal.publicationDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				<%-- <form:input path="journalYear" htmlEscape="false" maxlength="11"  digits="true"  class="input-xlarge "/> --%>
			</div>
		</div>
	
		<%-- <div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.journal_month" text="出版月"/>：</label>
			<div class="controls">
				<form:select path="journalMonth" items="${month }">
				
				</form:select>
				<form:input path="journalMonth" htmlEscape="false" maxlength="11" digits="true"   class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.journal_day" text="出版日"/>：</label>
			<div class="controls">
				<form:input path="journalDay" htmlEscape="false" maxlength="11"  digits="true"  class="input-xlarge "/>
			</div>
		</div> --%>
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
			<label class="control-label"><spring:message code="hb_journal.journal_remork" text="备注"/>：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions" ${hbJournal.status }>
			<shiro:hasPermission name="hb:hbJournal:edit">
				<c:if test="${empty param.view }">
					<c:if test="${hbJournal==null || hbJournal.status==1 || hbJournal.status==2 || empty hbJournal.status }">
					<!-- 草稿状态可提交 -->
						<input id="btnApply" class="btn btn-primary" type="button"  value="<spring:message code='hb_journal.submit'/>"/>&nbsp;		
				</c:if>
				<c:if test="${hbJournal.status==3||hbJournal.status==1 || hbJournal.status==2 ||  empty hbJournal.status }">
				<!-- 草稿或则下架可修改 -->
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="sys.save"/>"/>
				</c:if>
				</c:if>
		</shiro:hasPermission>
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