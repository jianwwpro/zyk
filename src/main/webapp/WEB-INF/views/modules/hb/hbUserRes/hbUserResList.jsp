<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_user_res.table.title"/><spring:message code="sys.manager"/></title>
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
		<li class="active"><a href="${ctx}/hb/hbUserRes/"><spring:message code="hb_user_res.table.title"/><spring:message code="sys.list"/></a></li>
		<shiro:hasPermission name="hb:hbUserRes:edit"><li><a href="${ctx}/hb/hbUserRes/form"><spring:message code="hb_user_res.table.title"/><spring:message code="sys.add"/></a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="hbUserRes" action="${ctx}/hb/hbUserRes/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label><spring:message code="hb_user_res.user_id" text="hb_user_res.user_id"/>：</label>
				<sys:treeselect id="user" name="user.id" value="${hbUserRes.user.id}" labelName="user.name" labelValue="${hbUserRes.user.name}"
					title="<spring:message code='sys.user'/>" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label><spring:message code="hb_user_res.res_type" text="hb_user_res.res_type"/>：</label>
				<form:select path="resType" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('hb_article_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label><spring:message code="hb_user_res.apply_type" text="hb_user_res.apply_type"/>：</label>
				<form:select path="applyType" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('hb_article_business_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label><spring:message code="hb_user_res.time_long" text="hb_user_res.time_long"/>：</label>
				<form:input path="timeLong" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_user_res.apply_num" text="hb_user_res.apply_num"/>：</label>
				<form:input path="applyNum" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label><spring:message code="sys.remarks" text="sys.remarks"/>：</label>
				<form:input path="remarks" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label><spring:message code="sys.create_date" text="sys.create_date"/>：</label>
				<input name="createDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${hbUserRes.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
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
						<spring:message code="sys.update_date" text="sys.update_date"/></th>
				<th>
						<spring:message code="hb_user_res.user_id" text="hb_user_res.user_id"/></th>
				<th>
						<spring:message code="hb_user_res.res_type" text="hb_user_res.res_type"/></th>
				<th>
						<spring:message code="hb_user_res.apply_type" text="hb_user_res.apply_type"/></th>
				<th>
						<spring:message code="hb_user_res.time_long" text="hb_user_res.time_long"/></th>
				<th>
						<spring:message code="hb_user_res.apply_num" text="hb_user_res.apply_num"/></th>
				<th>
						<spring:message code="sys.remarks" text="sys.remarks"/></th>
				<th>
						<spring:message code="sys.create_date" text="sys.create_date"/></th>
				<shiro:hasPermission name="hb:hbUserRes:edit"><th><spring:message code="sys.operation"/></th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="hbUserRes">
			<tr>
				<td><a href="${ctx}/hb/hbUserRes/form?id=${hbUserRes.id}">
					${hbUserRes.updateDate}
				</a></td>
				<td>
					${hbUserRes.user.name}
				</td>
				<td>
					${fns:getDictLabel(hbUserRes.resType, 'hb_article_type', '')}
				</td>
				<td>
					${fns:getDictLabel(hbUserRes.applyType, 'hb_article_business_type', '')}
				</td>
				<td>
					${hbUserRes.timeLong}
				</td>
				<td>
					${hbUserRes.applyNum}
				</td>
				<td>
					${hbUserRes.remarks}
				</td>
				<td>
					<fmt:formatDate value="${hbUserRes.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="hb:hbUserRes:edit"><td>
    				<a href="${ctx}/hb/hbUserRes/form?id=${hbUserRes.id}"><spring:message code="sys.update" text="修改"/></a>					<a href="${ctx}/hb/hbUserRes/delete?id=${hbUserRes.id}" onclick="return confirmx('<spring:message code="sys.confirm.delete"/>', this.href)"><spring:message code="sys.delete" text="删除"/></a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>