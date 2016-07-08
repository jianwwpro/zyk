<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_pf.table.title"/><spring:message code="sys.manager"/></title>
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
		<li class="active"><a href="${ctx}/hb/hbPf/"><spring:message code="hb_pf.table.title"/><spring:message code="sys.list"/></a></li>
		<shiro:hasPermission name="hb:hbPf:edit"><li><a href="${ctx}/hb/hbPf/form"><spring:message code="hb_pf.table.title"/><spring:message code="sys.add"/></a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="hbPf" action="${ctx}/hb/hbPf/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label><spring:message code="hb_pf.create_by" text="create_by"/>：</label>
				<form:input path="createBy.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_pf.create_date" text="create_date"/>：</label>
				<input name="createDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${hbPf.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label><spring:message code="hb_pf.update_by" text="update_by"/>：</label>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_pf.update_date" text="update_date"/>：</label>
				<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${hbPf.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label><spring:message code="hb_pf.remarks" text="remarks"/>：</label>
				<form:input path="remarks" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_pf.del_flag" text="del_flag"/>：</label>
				<form:radiobuttons path="delFlag" items="${fns:getDictList('del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li><label><spring:message code="hb_pf.pf_type" text="pf_type"/>：</label>
				<form:input path="pfType" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_pf.biz_type" text="biz_type"/>：</label>
				<form:input path="bizType" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_pf.pfpath" text="pfpath"/>：</label>
				<form:input path="pfpath" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_pf.pf_name" text="pf_name"/>：</label>
				<form:input path="pfName" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_pf.ext_name" text="ext_name"/>：</label>
				<form:input path="extName" htmlEscape="false" maxlength="10" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="sys.query"/>"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
						<spring:message code="sys.update_date" text="update_date"/></th>
				<th>
						<spring:message code="hb_pf.remarks" text="remarks"/></th>
				<shiro:hasPermission name="hb:hbPf:edit"><th><spring:message code="sys.operation"/></th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="hbPf">
			<tr>
				<td><a href="${ctx}/hb/hbPf/form?id=${hbPf.id}">
					${hbPf.updateDate}
				</a></td>
				<td>
					${hbPf.remarks}
				</td>
				<shiro:hasPermission name="hb:hbPf:edit"><td>
    				<a href="${ctx}/hb/hbPf/form?id=${hbPf.id}"><spring:message code="sys.update" text="修改"/></a>					<a href="${ctx}/hb/hbPf/delete?id=${hbPf.id}" onclick="return confirmx('<spring:message code="sys.confirm.delete"/>', this.href)"><spring:message code="sys.delete" text="删除"/></a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>