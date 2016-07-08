<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_order.table.title"/><spring:message code="sys.manager"/></title>
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
		<li class="active"><a href="${ctx}/hb/hbOrder/"><spring:message code="hb_order.table.title"/><spring:message code="sys.list"/></a></li>
		<%-- <shiro:hasPermission name="hb:hbOrder:edit"><li><a href="${ctx}/hb/hbOrder/form"><spring:message code="hb_order.table.title"/><spring:message code="sys.add"/></a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="hbOrder" action="${ctx}/hb/hbOrder/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label><spring:message code="hb_order.consignee" text="收货人"/>：</label>
				<form:input path="consignee" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_order.consignee_address" text="收货人地址"/>：</label>
				<form:input path="consigneeAddress" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_order.consignee_phone" text="收货人电话"/>：</label>
				<form:input path="consigneePhone" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
<%-- 			<li><label><spring:message code="hb_order.user_id" text="订阅人"/>：</label>
				<sys:treeselect id="userInfo" name="userInfo.id" value="${hbOrder.userInfo.id}" labelName="userInfo.name" labelValue="${hbOrder.userInfo.name}"
					title="<spring:message code="sys.user"/>" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
 --%>			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="sys.query"/>"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
						<spring:message code="hb_order.consignee" text="收货人"/></th>
				<th>
						<spring:message code="hb_order.consignee_address" text="收货人地址"/></th>
				<th>
						<spring:message code="hb_order.consignee_phone" text="收货人电话"/></th>
				<th>
						<spring:message code="hb_order.user_id" text="订阅人"/></th>
				<th>
						<spring:message code="hb_order.order_time" text="订单时间"/></th>
				<shiro:hasPermission name="hb:hbOrder:edit"><th><spring:message code="sys.operation"/></th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="hbOrder">
			<tr>
				<td>
					${hbOrder.consignee}
				</td>
				<td>
					${hbOrder.consigneeAddress}
				</td>
				<td>
					${hbOrder.consigneePhone}
				</td>
				<td>
					${hbOrder.userInfo.realName}(${hbOrder.userInfo.loginName })
				</td>
				<td>
					<fmt:formatDate value="${hbOrder.orderTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
				<shiro:hasPermission name="hb:hbOrder:edit">
    				<%-- <a href="${ctx}/hb/hbOrder/form?id=${hbOrder.id}"><spring:message code="sys.update" text="修改"/></a> --%>
    				<%-- <a href="${ctx}/hb/hbOrder/delete?id=${hbOrder.id}" onclick="return confirmx('<spring:message code="sys.confirm.delete"/>', this.href)"><spring:message code="sys.delete" text="删除"/></a> --%>
    				
				</shiro:hasPermission>
				<a href="${ctx}/hb/hbOrderInfo/list?order.id=${hbOrder.id}">详情</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>