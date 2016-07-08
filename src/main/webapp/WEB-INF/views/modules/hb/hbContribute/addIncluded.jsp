<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_contribute.table.title"/><spring:message code="sys.manager"/></title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic }/vue/vue.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			/* $("#btnApply").click(function(){
				 $.jBox.prevState() 
				$("#inputForm").submit();
				
			}); */
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
	</ul><br/>
	<form:form id="inputForm" modelAttribute="hbContribute" action="${ctx}/hb/hbContribute/saveIncluded" method="post" class="form-horizontal">
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_contribute.included_lang" text="hb_contribute.included_lang"/>：</label>
			<div class="controls">
				<%-- <form:input path="includedLang" htmlEscape="false" maxlength="255" class="input-xlarge required"/> --%>
				<form:select path="includedLang" class="input-medium" style="width:154px">
					<%-- <form:option value="" label=""/> --%>
					<form:options items="${fns:getDictList('hb_journal_v')}" itemLabel="description" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_contribute.included_year" text="hb_contribute.included_year"/>：</label>
			<div class="controls">
				<select name="includedYear" id="includedYear" class="input-xlarge ">
					<option value="2016">2016</option>
					<option value="2017">2017</option>
					<option value="218">2018</option>
					<option value="2019">2019</option>
					<option value="2020">2020</option>
				</select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_contribute.included_volume" text="hb_contribute.included_volume"/>：</label>
			<div class="controls">
				<select id="includedVolume" name="includedVolume">
					<option value="01">01</option>
					<option value="03">03</option>
					<option value="05">05</option>
					<option value="07">07</option>
					<option value="09">09</option>
				</select>
			</div>
		</div>
		<input type="hidden" id="id" name="id" value="${id }"/>
		<!-- <div class="form-actions">
			<input id="btnApply" class="btn btn-primary" type="button"  value="提 交"/>&nbsp;
		</div> -->
	</form:form>
</body>

<script type="text/javascript">


</script>
</html>