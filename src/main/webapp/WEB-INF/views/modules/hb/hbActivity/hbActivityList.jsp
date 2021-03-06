<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_activity.table.title"/><spring:message code="sys.manager"/></title>
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
		<li class="active"><a href="${ctx}/hb/hbActivity/"><spring:message code="hb_activity.table.title"/><spring:message code="sys.list"/></a></li>
		<shiro:hasPermission name="hb:hbActivity:edit"><li><a href="${ctx}/hb/hbActivity/form"><spring:message code="hb_activity.table.title"/><spring:message code="sys.add"/></a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="hbActivity" action="${ctx}/hb/hbActivity/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input  name="style" type="hidden" value="1"/>
		<ul class="ul-form">
			<li><label><spring:message code="hb_activity.title" text="hb_activity.title"/>：</label>
				<form:input path="title" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			
			
		<%-- 	<li><label><spring:message code="hb_activity.style" text="hb_activity.style"/>：</label>
				<form:select path="style" class="input-medium" style="width:175px">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('hb_activity_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
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
						<spring:message code="hb_activity.title" text="hb_activity.title"/></th>
				<th>
						<spring:message code="hb_activity.status" text="hb_activity.status"/></th>
				
				<th>
						<spring:message code="hb_activity.language" text="hb_activity.language"/></th>
				
				<shiro:hasPermission name="hb:hbActivity:edit"><th><spring:message code="sys.operation"/></th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="hbActivity">
			<tr>
				<td><a href="${ctx}/hb/hbActivity/form?view=true&id=${hbActivity.id}">
					${hbActivity.title}
				</a></td>
				<td>
					<c:forEach items="${statusArray }" var="dict">
					
						<c:if test="${dict.value==hbActivity.status }">
							${dict.label }
						</c:if>
					</c:forEach>
				</td>
				
				
				</td>
				<td>
					${fns:getDictLabel(hbActivity.language, 'lang', '')}
				</td>
				<%-- <td>
					${hbActivity.abstracts}
				</td>
				<td>
					${hbActivity.source}
				</td>
				<td>
					${hbActivity.browse}
				</td> --%>
				<%-- <td>
					${hbActivity.updateDate}
				</td>
				<td>
					${hbActivity.remarks}
				</td> --%>
				<shiro:hasPermission name="hb:hbActivity:edit"><td>
    				<c:if test="${hbActivity.status==1 }">
    				<a href="javascript:void(0)" onclick=" apply('${ctx}/hb/hbActivity/apply?id=${hbActivity.id}&apply=1')" ><spring:message code="sys.apply" text="提交"  /></a>
    				<a href="${ctx}/hb/hbActivity/form?id=${hbActivity.id}"><spring:message code="sys.update" text="修改"/></a>					
    				<a href="${ctx}/hb/hbActivity/delete?id=${hbActivity.id}" onclick="return confirmx('<spring:message code="sys.confirm.delete"/>', this.href)"><spring:message code="sys.delete" text="删除"/></a>
    				</c:if>
    				<c:choose>
    				<c:when test="${hbActivity.placedTop < 1}">
    					<a href="${ctx}/hb/hbActivity/zhiding?id=${hbActivity.id}" onclick="return confirmx(${langType eq 'zh'?'是否置顶？':'At the top？'}, this.href)"><spring:message code='hb_activity.placed_top' text='hb_activity.placed_top' /></a>
    				</c:when>
    				<c:otherwise>
    					<a href="${ctx}/hb/hbActivity/up?id=${hbActivity.id}&view=true"><spring:message code="hb_activity.up" text="hb_activity.up"/></a>
    					<a href="${ctx}/hb/hbActivity/down?id=${hbActivity.id}&view=true"><spring:message code="hb_activity.down" text="hb_activity.down"/></a>
    				</c:otherwise>
    				</c:choose>
    				<a href="${ctx}/hb/hbActivity/form?id=${hbActivity.id}&view=true"><spring:message code="sys.view" text="查看"/></a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>