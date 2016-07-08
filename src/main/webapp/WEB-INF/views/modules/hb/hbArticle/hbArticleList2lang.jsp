<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_article.table.title"/><spring:message code="sys.manager"/></title>
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
		//移除语种关联
		function moveCode(id){
			// 正常打开
			$.post("${ctx}/cms/keywords/keywords",{
				id:id
			},function(data){
				var d=data;
				
			},'json');
		}
	</script>
</head>
<body>
	
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
						<spring:message code="hb_article.title" text="标题"/></th>
				<th>
						<spring:message code="hb_article.language" text="语种"/></th>
				<th>
						<spring:message code="hb_article.other_language" text="其他语种"/></th>
				<th>
						<spring:message code="hb_article.journal_id" text="期"/></th>
				<th>
						<spring:message code="hb_journal.journal_no" text="journalNo"/></th>
				
				<%-- <th>
						<spring:message code="hb_article.browse" text="浏览量"/></th>
				<th>
						<spring:message code="hb_article.introduction" text="简介"/></th> --%>
				<th><spring:message code="sys.operation"/></th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="hbArticle">
			<tr>
				<td><a href="${ctx}/hb/hbArticle/form?id=${hbArticle.id}&view=${param.view}">
					${hbArticle.title}
				</a></td>
				<td>
					${fns:getDictLabel(hbArticle.language,'lang','')}
				</td>
				<td>
					${hbArticle.langs }
				</td>
				<td>
					${hbArticle.journal.name}
				</td>
				
				<td><c:if test="${ not empty hbArticle.journal.id}">
				
					${hbArticle.journal.journalYear}（${hbArticle.journal.journalNo}）
					</c:if>
				</td>
				
				<%-- <td>
					${hbArticle.browse}
				</td>
				<td>
					${hbArticle.introduction}
				</td> --%>
				<td>
				<a href="${ctx}/hb/hbArticle/moveCode?id=${hbArticle.id}&pid=${param.id}&code=${hbArticle.code}" onclick="return confirmx('<spring:message code="sys.confirm.delete"/>', this.href)"><spring:message code="hb_articls.clear" text="移除关联"/></a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>