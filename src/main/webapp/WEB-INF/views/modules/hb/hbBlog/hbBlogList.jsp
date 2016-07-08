<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_blog.table.title"/><spring:message code="sys.manager"/></title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	var zhLanguage="${langType}";
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		function apply(url){
			top.$.jBox.confirm(zhLanguage=='zh'?'确认吗？':'Sure?',zhLanguage=='zh'?'SYS prompt':'系统提示',function(v,h,f){
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
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/hb/hbBlog/"><spring:message code="hb_blog.table.title"/><spring:message code="sys.list"/></a></li>
		
	</ul>
	<form:form id="searchForm" modelAttribute="hbBlog" action="${ctx}/hb/hbBlog/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<%-- <li><label><spring:message code="hb_blog.id" text="sys.id"/>：</label>
				<form:input path="id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li> --%>
			<li><label><spring:message code="hb_blog.title" text="hb_blog.title"/>：</label>
				<form:input path="title" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_blog.status" text="hb_blog.status"/>：</label>
				<form:select path="status" class="input-medium" style="width:175px">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('hb_blog_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				
			</li>
			<li><label><spring:message code="hb_blog.language" text="hb_blog.language"/>：</label>
				
				<form:select path="language" class="input-medium" style="width:175px">
					<form:option value="">${langType eq 'zh'?'全部':'All' }</form:option>
					<form:options items="${fns:getDictList('lang')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label><spring:message code="hb_blog.signature" text="hb_blog.signature"/>：</label>
				<form:input path="signature" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<%-- <li><label><spring:message code="hb_blog.audit_time" text="hb_blog.audit_time"/>：</label>
				<input name="auditTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${hbBlog.auditTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li> --%>
			<%-- <li><label><spring:message code="hb_blog.audit_user" text="hb_blog.audit_user"/>：</label>
				<form:input path="user.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li> --%>
			<li><label style="width:100px"><spring:message code="hb_blog.is_score" text="hb_blog.is_score"/>：</label>
				<%-- <form:input path="isScore" htmlEscape="false" maxlength="1" class="input-medium"/> --%>
				<%-- <form:checkbox path="isScore" value="1" style="width:145px"/> --%>
				<form:select path="isScore" class="input-medium" style="width:154px">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label><spring:message code="hb_blog.is_pub" text="hb_blog.is_pub"/>：</label>
				<%-- <form:input path="isPub" htmlEscape="false" maxlength="1" class="input-medium"/> --%>
				<form:select path="isPub" class="input-medium" style="width:175px">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<%-- <li><label><spring:message code="hb_blog.browse" text="hb_blog.browse"/>：</label>
				<form:input path="browse" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li> --%>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="sys.query"/>"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
						<spring:message code="hb_blog.title" text="hb_blog.title"/></th>
				<th>
						<spring:message code="hb_blog.status" text="hb_blog.status"/></th>
				<th>
						<spring:message code="hb_blog.language" text="hb_blog.language"/></th>
				<th>
						<spring:message code="hb_blog.signature" text="hb_blog.signature"/></th>
				<%-- <th>
						<spring:message code="hb_blog.audit_time" text="hb_blog.audit_time"/></th>
				<th>
						<spring:message code="hb_blog.audit_user" text="hb_blog.audit_user"/></th>--%>
				<th> 
						<spring:message code="hb_blog.is_score" text="hb_blog.is_score"/></th>
				<th>
						<spring:message code="hb_blog.is_pub" text="hb_blog.is_pub"/></th>
				<th>
						<spring:message code="hb_blog.browse" text="hb_blog.browse"/></th>
				<%--<th>
						<spring:message code="sys.update_date" text="sys.update_date"/></th>
				 <th>
						<spring:message code="sys.remarks" text="sys.remarks"/></th> --%>
				<shiro:hasPermission name="hb:hbBlog:edit"><th><spring:message code="sys.operation"/></th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="hbBlog">
			<tr>
				<td><a href="${ctx}/hb/hbBlog/form?id=${hbBlog.id}&view=true">
					${hbBlog.title}
				</a></td>
				<td>
					<c:forEach items="${statusArray }" var="dict">
						<c:if test="${dict.value==hbBlog.status }">
							${dict.label }
						</c:if>
					</c:forEach>
				</td>
				<td>
					${fns:getDictLabel(hbBlog.language, 'lang', '')}
				</td>
				<td>
					${hbBlog.signature}
				</td>
				<%-- <td>
					<fmt:formatDate value="${hbBlog.auditTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${hbBlog.user.id}
				</td> --%>
				<td>
				<%-- <input type="checkbox"  disabled="true" <c:if test='${hbBlog.isScore eq"1"}'>checked="true"</c:if>/> --%>
					${fns:getDictLabel(hbBlog.isScore, 'yes_no', '')}
				</td>
				<td>
					${fns:getDictLabel(hbBlog.isPub, 'yes_no', '')}
				</td>
				<td>
					${hbBlog.browse}
				</td>
				<%--<td>
					${hbBlog.updateDate}
				</td>
				 <td>
					${hbBlog.remarks}
				</td> --%>
				<shiro:hasPermission name="hb:hbBlog:edit"><td>
				<c:if test="${hbBlog.status==1 }">
				<a href="javascript:void(0)" onclick=" apply('${ctx}/hb/hbBlog/apply?id=${hbBlog.id}&apply=1')" ><spring:message code="sys.apply" text="提交"  /></a>
    				<a href="${ctx}/hb/hbBlog/form?id=${hbBlog.id}"><spring:message code="sys.update" text="修改"/></a>					
    				<a href="${ctx}/hb/hbBlog/delete?id=${hbBlog.id}" onclick="return confirmx('<spring:message code="sys.confirm.delete"/>', this.href)"><spring:message code="sys.delete" text="删除"/></a>
    				</c:if>
    				<a href="${ctx}/hb/hbBlog/form?id=${hbBlog.id}&view=true"><spring:message code="sys.view" text="查看"/></a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>