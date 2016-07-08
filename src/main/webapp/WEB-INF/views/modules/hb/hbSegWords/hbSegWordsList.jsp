<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_seg_words.table.title"/><spring:message code="sys.manager"/></title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/hb/hbSegWords/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			$("#btnImport").click(function(){
				$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
					bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
			});
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
<div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/hb/hbSegWords/import" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<a href="${ctx}/hb/hbSegWords/import/template">下载模板</a>
		</form>
	</div>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/hb/hbSegWords/list"><spring:message code="hb_seg_words.table.title"/><spring:message code="sys.list"/></a></li>
		<shiro:hasPermission name="hb:hbSegWords:edit"><li><a href="${ctx}/hb/hbSegWords/form"><spring:message code="hb_seg_words.table.title"/><spring:message code="sys.add"/></a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="hbSegWords" action="${ctx}/hb/hbSegWords/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<!-- 关键词 -->
			<li><label><spring:message code="hb_seg_words.words" text="hb_seg_words.words"/>：</label>
				<form:input path="words" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<!-- 一级关键词 -->
			<li><label><spring:message code="hb_seg_words.frist_relation_Words" text="hb_seg_words.frist_relation_Words"/>：</label>
				<form:input path="fristRelationWords" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<!-- 级别 -->
			<li><label><spring:message code="hb_seg_words.hsk_level" text="hb_seg_words.hsk_level"/>：</label>
				<form:input path="hskLevel" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<%-- 
			<li><label><spring:message code="hb_seg_words.source" text="hb_seg_words.source"/>：</label>
				<form:input path="source" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			 --%>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="sys.query"/>"/>
			<input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
				<input id="btnImport" class="btn btn-primary" type="button" value="导入"/>
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<!-- 词 -->
				<th>
						<spring:message code="hb_seg_words.words" text="hb_seg_words.words"/></th>
				<!-- 一级关键词 -->
				<th>
						<spring:message code="hb_seg_words.frist_relation_Words" text="hb_seg_words.frist_relation_Words"/></th>
				<!-- 级别 -->
				<th>
						<spring:message code="hb_seg_words.hsk_level" text="hb_seg_words.hsk_level"/></th>
				<!-- 更新时间 -->
				<th>
						<spring:message code="sys.update_date" text="sys,update_date"/></th>
				
				
				<th >
						<spring:message code="hb_seg_words.source" text="hb_seg_words.source"/></th>
				<th class="sort-column articleCount">
						<spring:message code="hb_seg_words.article_count" text="hb_seg_words.article_count"/></th>
				<th class="sort-column articleSum">
						<spring:message code="hb_seg_words.article_sum" text="hb_seg_words.article_sum"/></th>
				<shiro:hasPermission name="hb:hbSegWords:edit"><th><spring:message code="sys.operation"/></th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="hbSegWords">
			<tr>
				<td>
					${hbSegWords.words}
				</td>
				<td>
					${hbSegWords.fristRelationWords}
				</td>
				<td>
					${hbSegWords.hskLevel}
				</td>
				<td><%-- <a href="${ctx}/hb/hbSegWords/form?id=${hbSegWords.id}"> --%>
					<fmt:formatDate value="${hbSegWords.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				<!-- </a> --></td>
				 <td>
					${hbSegWords.source}
				</td>
				
				
				<td>
					${hbSegWords.articleCount}
				</td>
				<td>
					${hbSegWords.articleSum}
				</td>
				<shiro:hasPermission name="hb:hbSegWords:edit"><td>
    				<a href="${ctx}/hb/hbSegWords/form?id=${hbSegWords.id}"><spring:message code="sys.update" text="修改"/></a>					<a href="${ctx}/hb/hbSegWords/delete?id=${hbSegWords.id}" onclick="return confirmx('<spring:message code="sys.confirm.delete"/>', this.href)"><spring:message code="sys.delete" text="删除"/></a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>