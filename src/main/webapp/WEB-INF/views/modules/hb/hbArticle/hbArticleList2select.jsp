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
		function apply(url){
			top.$.jBox.confirm('确认吗？','系统提示',function(v,h,f){
				if(v=='ok'){
					resetTip(); //loading();
					location.href=url;
				}
			},{buttonsFocus:1, closed:function(){
				if (typeof closed == 'function') {
					closed();
				}
			}});
		}
		
	</script>
</head>
<body>
	
	<form:form id="searchForm" modelAttribute="hbArticle" action="${ctx}/hb/hbArticle/list2select" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="menu.id" name="menu.id" type="hidden" value="${hbArticle.menu.id==null?param['menu.id']:hbArticle.menu.id}"/>
		<ul class="ul-form">
			<li><label><spring:message code="hb_article.title" text="标题"/>：</label>
				<form:input path="title" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			
			<li><label><spring:message code="hb_article.subtitle" text="副标题"/>：</label>
				<form:input path="subtitle" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_article.language" text="语种"/>：</label>
				<form:select path="language">
				<option value="">--请选择--</option>
					<form:options items="${fns:getDictList('lang')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="clearfix"></li>
			
			<li><label><spring:message code="hb_article.label" text="标签"/>：</label>
				<form:input path="label" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_article.keyword" text="关键字"/>：</label>
				<form:input path="keyword" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_article.chinese_level" text="汉语等级"/>：</label>
				
				<form:select path="chineseLevel">
				<option value="">--请选择--</option>
					<form:options items="${fns:getDictList('hsk_level')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="clearfix"></li>
			<li class="btns">
			
			
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="sys.query"/>"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>选择</th>
				<th>
						<spring:message code="hb_article.title" text="标题"/></th>
				<th>
						<spring:message code="hb_article.language" text="语种"/></th>
				<th>
						<spring:message code="hb_article.relation_language" text="其他语种"/></th>
				<th>
						<spring:message code="hb_article.journal_id" text="期"/></th>
				<th>
						<spring:message code="hb_journal.journal_no" text="journalNo"/></th>
				
				<%-- <th>
						<spring:message code="hb_article.browse" text="浏览量"/></th>
				<th>
						<spring:message code="hb_article.introduction" text="简介"/></th> --%>
				
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="hbArticle">
			<tr>
				<td><input type="checkbox" name="chkItem" value='${hbArticle.id}' class="select"/></td>
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
				
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>