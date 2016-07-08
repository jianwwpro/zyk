<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_journal.table.title"/><spring:message code="sys.manager"/></title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/hb/hbJournal/list2select"><spring:message code="hb_journal.table.title"/><spring:message code="sys.list"/></a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="hbJournal" action="${ctx}/hb/hbJournal/list2select" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label><spring:message code="hb_journal.name" text="期名称"/>：</label>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_journal.journal_no" text="卷期号"/>：</label>
				<form:input path="journalNo" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_journal.journal_sum" text="总期数"/>：</label>
				<form:input path="journalSum" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_journal.journal_v" text="栏目"/>：</label>
						<c:forEach items="${fns:getDictList('hb_journal_v')}" var="tpl">
							<input type="radio" name="journalV" value="${tpl.value }" 
							<c:if test="${ journalVs eq tpl.value}"> checked="checked"</c:if>
							><spring:message code="${tpl.label }"/>
						</c:forEach>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="sys.query"/>"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>选择</th>
				<th>
						<spring:message code="hb_journal.name" text="期刊名称"/></th>
				<th>
						<spring:message code="hb_journal.journal_no" text="卷期号"/></th>
				<th>
						<spring:message code="hb_journal.journal_sum" text="总期数"/></th>
				<th>
						<spring:message code="hb_journal.journal_pages" text="页数"/></th>
				
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="hbJournal">
			<tr>
				<td>
				<input type="radio" name="chkItem" value='${hbJournal.id}_${ hbJournal.name} ${hbJournal.journalYear}（${hbJournal.journalNo}）' class="select"/>
				</td>
				<td>
				<a href="${ctx}/hb/hbJournal/form?id=${hbJournal.id}&view=true">
					${hbJournal.name}
				</a>
				</td>
				<td>
					${hbJournal.journalYear}（${hbJournal.journalNo}）
				</td>
				<td>
					(${hbJournal.journalSum})
				</td>
				<td>
					${hbJournal.journalPages}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>