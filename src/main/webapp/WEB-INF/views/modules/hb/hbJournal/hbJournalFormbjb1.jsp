<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_journal.table.title"/><spring:message code="sys.manager"/></title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic}/ckfinder/ckfinder.js"></script>
		<script type="text/javascript" src="${ctxStatic }/vue/vue.js"></script>
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
			
			//同意
			$("#btnApply").click(function(){	
				$("#flag").val("yes");
				$('#myModal').modal({show:true});
			});
			//驳回
			$("#btnNo").click(function(){	
				$("#flag").val("no");
				$('#myModal').modal({show:true});
			});
			
			$("#tijiao").click(function(){
				
				$("form").submit();
			});
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
	<form:form id="inputForm"  modelAttribute="hbJournal" action="${ctx}/hb/hbJournal/apply" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<input type="hidden" name="journalV"  value="${empty hbJournal.id ?param.journalV:hbJournal.journalV }">
		<input type="hidden" name="apply"  value="apply">
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.name" text="期刊名称"/>：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false"   maxlength="200"  	required="true" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.journal_thumb" text="期封面"/>：</label>
			<div class="controls">
				<form:input id="journalThumb"  path="journalThumb"  htmlEscape="false"  style="display:none"  maxlength="300"  required="true" class="input-xlarge "/>
				<sys:ckfinder input="journalThumb"  type="images" uploadPath="/thumb" selectMultiple="false" maxWidth="100" maxHeight="100"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.journal_pdf" text="期PDF"/>：</label>
			<div class="controls">
				<form:input id="journalPdf" path="journalPdf"  htmlEscape="false"  required="true"  style="display:none"  maxlength="300"   class="input-xlarge"/>
				<sys:ckfinder input="journalPdf"  type="files" uploadPath="/pdf"  selectMultiple="false" maxWidth="100" maxHeight="100"/>
				<c:if test="${ (not  empty hbJournal.journalPdf )  and  (not  empty hbJournal.id) and empty param.view}">
					<input type="button"  class="btn" id="createPdfPicBtn"  value="生成图片"  onclick="javascript:createPdfPic('${hbJournal.journalPdf }')" />
				</c:if>
			</div>
			
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_journal.down_pdf_path" text="下载pdf"/>：</label>
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
			<label class="control-label"><spring:message code="hb_journal.publication_date"  text="出版日期"/>：</label>
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
			<label class="control-label"><spring:message code="hb_journal.remarks" text="备注"/>：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<input id="btnApply" class="btn btn-primary"  type="button"  value="同 意"/>&nbsp;
			<input id="btnNo" class="btn btn-primary"  type="button"  value="驳 回"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		
		<!-- 对话框 -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">您的意见</h3>
  </div>
  <div class="modal-body">
    <p>
    <textarea name="act.comment" id="com" rows="5" style="width: 98%"></textarea>
    </p>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
    <button  id="tijiao" class="btn btn-primary">提交</button>
  </div>
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
	
	app= new Vue({
		el:'#myModal',
		data:{
			datas:[],
		},methods:{
			select:function(k){
				var names = "";
				console.log(this.datas);
				for(var i=0;i<this.datas.length;i++){
					console.log(this.datas[i]);
					if(this.datas[i].checked==true){
						names+=this.datas[i].key+" ";
					}	
				}
				$("#keywords").val(names);
			}
		},
		ready:function(){
		
		}
	});
</script>

</script>

</html>