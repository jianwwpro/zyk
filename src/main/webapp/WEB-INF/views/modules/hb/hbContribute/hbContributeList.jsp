<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_contribute.table.title"/><spring:message code="sys.manager"/></title>
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
		
	function addIncluded(id){
		top.$.jBox('iframe:${ctx}/hb/hbContribute/jumpIncluded?id='+id,{title: '',width: 950,height: 600,buttons: { "${langType eq 'zh'?'确定':'Sure'}":"ok","${langType eq 'zh'?'关闭':'close'}":"true"},
			submit:function(v, h, f){
				if(v=='ok'){
					var w = h.find("iframe")[0].contentWindow;
					w.$('#inputForm').submit();
					//页面跳不过来，直接跳在了层里，所以手动刷新，为防止刷新太快页面没有处理完，延迟1.5s
					window.setTimeout(window.location.reload(),1500);
				}
			}
		});}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/hb/hbContribute/listStatus"><spring:message code="hb_contribute.table.title"/><spring:message code="sys.list"/></a></li>
		 
	</ul>
	<form:form id="searchForm" modelAttribute="hbContribute" action="${ctx}/hb/hbContribute/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label><spring:message code="hb_contribute.contribute_menu" text="hb_contribute.contribute_menu"/>：</label>
				<form:select path="contributeMenu" class="input-medium" style="width:154px">
					<form:option value="" label=""/>
					<form:options items="${menuList}" itemLabel="name" itemValue="id" htmlEscape="false"/>
				</form:select>
				
			</li> 
			<li><label><spring:message code="hb_contribute.editorial" text="hb_contribute.editorial"/>：</label>
				<form:select path="editorial" class="input-medium" style="width:154px">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('hb_journal_v')}" itemLabel="description" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li> 
			<li><label><spring:message code="hb_contribute.create_user" text="hb_contribute.create_user"/>：</label>
				<form:input path="createBy.name" htmlEscape="false" maxlength="64" class="input-medium"/>
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
						<spring:message code="hb_contribute.title" text="hb_contribute.title"/></th>
				<th>
						<spring:message code="hb_contribute.contribute_menu" text="hb_contribute.contribute_menu"/></th>
				<th>
						<spring:message code="hb_contribute.language" text="hb_contribute.language"/></th>
				<th>
						<spring:message code="hb_contribute.editorial" text="hb_contribute.editorial"/></th>
				<th>
						<spring:message code="hb_contribute.create_user" text="hb_contribute.create_user"/></th>
				<th>
						<spring:message code="hb_contribute.audit_time" text="hb_contribute.audit_time"/></th>
				<th>
						<spring:message code="hb_contribute.status" text="hb_contribute.status"/></th>
				<th>
						<spring:message code="hb_contribute.included" text="hb_contribute.included"/></th>
				<%-- <th>
						<spring:message code="sys.update_date" text="sys.update_date"/></th>
				<th>
						<spring:message code="sys.remarks" text="sys.remarks"/></th> --%>
				<shiro:hasPermission name="hb:hbContribute:edit"><th><spring:message code="sys.operation"/></th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="hbContribute">
			<tr>
				<td><a href="${ctx}/hb/hbContribute/form?id=${hbContribute.id}">
					${hbContribute.title}
				</a></td>
				<td>
					${hbContribute.hbMenu.name }
					<%-- ${fns:getDictLabel(hbContribute.status, 'hb_blog_status', '')} --%>
				</td>
				<td>
					${fns:getDictLabel(hbContribute.language, 'lang', '')}
					<%-- <fmt:formatDate value="${hbContribute.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/> --%>
				</td>
				<td>
					<%-- ${hbContribute.editorial} --%>
					${fns:getDictLabel(hbContribute.editorial, 'hb_journal_v', '')}
				</td>
				<td>
					${hbContribute.createBy.name }
					<%-- ${fns:getDictLabel(hbContribute.isPub, 'yes_no', '')} --%>
				</td>
				<td>
					 <fmt:formatDate value="${hbContribute.auditTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${hbContribute.status}
				</td>
				<td>
					<c:choose>
						<c:when test="${!empty hbContribute.includedLang}">
							${fns:getDictLabel(hbContribute.includedLang, 'hb_journal_v', '')}&nbsp;&nbsp;${hbContribute.includedYear }&nbsp;&nbsp;${hbContribute.includedVolume }
						</c:when>
						<c:otherwise>
							<a href="#" onclick="addIncluded('${hbContribute.id}');"><spring:message code='hb_contribute.included_btn' text='hb_contribute.included_btn'/></a>
						</c:otherwise>
					</c:choose>
				</td>
				<%-- <td>
					${hbContribute.updateDate}
				</td>
				<td>
					${hbContribute.remarks}
				</td> --%>
				<shiro:hasPermission name="hb:hbContribute:edit"><td>
				<!-- 只有状态为4的可被查出来 -->
				<a href="${ctx}/hb/hbContribute/jumpContributeDetails?id=${hbContribute.id}&view=true"><spring:message code="sys.view" text="查看"/></a>
    				<%-- <c:if test="${hbContribute.status==1 }"> --%>
    				<%-- <a href="javascript:void(0)" onclick=" apply('${ctx}/hb/hbContribute/apply?id=${hbContribute.id}&apply=1')" ><spring:message code="sys.apply" text="提交"  /></a> --%>
    				<%-- <a href="${ctx}/hb/hbContribute/form?id=${hbContribute.id}"><spring:message code="sys.update" text="修改"/></a>					 --%>
    				<%-- <a href="${ctx}/hb/hbContribute/delete?id=${hbContribute.id}" onclick="return confirmx('<spring:message code="sys.confirm.delete"/>', this.href)"><spring:message code="sys.delete" text="删除"/></a> --%>
    				<%-- </c:if> --%>
    				
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>