<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_contribute.table.title"/><spring:message code="sys.manager"/></title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(function(){
			$("#copyright").click(function(){
				var param={};
				param.id="${hbContribute.id}";
				param.copyright=2;
				if($("#copyright").attr("checked")){
					param.copyright=1;
				}
				$.ajax({
					   type: "POST",
					   url: "${ctx}/hb/hbContribute/statementUpdate",
					   data: param,
					   success: function(msg){
					   }
					});
			});
			
			$("#cut").click(function(){
				var param={};
				param.id="${hbContribute.id}";
				param.cut=2;
				if($("#cut").attr("checked")){
					param.cut=1;
				}
				$.ajax({
					   type: "POST",
					   url: "${ctx}/hb/hbContribute/statementUpdate",
					   data: param,
					   success: function(msg){
					   }
					});
			});
			$("#adopt").click(function(){
				var param={};
				param.id="${hbContribute.id}";
				param.cut=2;
				if($("#adopt").attr("checked")){
					param.cut=1;
				}
				$.ajax({
					   type: "POST",
					   url: "${ctx}/hb/hbContribute/statementUpdate",
					   data: param,
					   success: function(msg){
					   }
					});
			});
			
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/hb/hbContribute//listStatus"><spring:message code="hb_contribute.table.title"/><spring:message code="sys.list"/></a></li>
		<li class="active"><a href="${ctx}/hb/hbContribute/form?id=${hbContribute.id}"><spring:message code="hb_contribute.table.title"/><shiro:hasPermission name="hb:hbContribute:edit">${not empty hbContribute.id?sys.update:sys.add}</shiro:hasPermission><shiro:lacksPermission name="hb:hbContribute:edit"><spring:message code="sys.view"/></shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="hbContribute" action="#" method="post" class="form-horizontal">
		<sys:message content="${message}"/>
			
		     <table>
		     	<tr>
		     	<td>
				<div class="control-group">
					<label class="control-label"><spring:message code="hb_contribute.title" text="hb_contribute.title"/>：</label>
					<div class="controls">
						<form:input path="title" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label"><spring:message code="hb_contribute.create_user" text="hb_contribute.create_user"/>：</label>
					<div class="controls">
						<form:input path="createBy.name" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label"><spring:message code="hb_contribute.signature" text="hb_contribute.signature"/>：</label>
					<div class="controls">
						<form:input path="signature" htmlEscape="false" maxlength="30" class="input-xlarge "/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label"><spring:message code="hb_contribute.language" text="hb_contribute.language"/>：</label>
					<div class="controls">
						<form:select path="language" class="input-xlarge ">
							<form:options items="${fns:getDictList('lang')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label"><spring:message code="hb_contribute.editorial" text="hb_contribute.editorial"/>：</label>
					<div class="controls">
						<form:select path="editorial" class="input-medium" style="width:154px">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('hb_journal_v')}" itemLabel="description" itemValue="value" htmlEscape="false"/>
						</form:select>
					</div>
				</div>
			</td>
			<td>
				<span style="display:block;border:1px solid black;padding-left:3px;">
					<h3  style="text-align:center;color:blue;">版权声明</h3>
					亲爱的会员你好，很高兴您再本站投稿，温馨提示<br/>
					您：投稿的内容与图片等请确保不侵犯其他任何第三方<br/>
					机构和个人的权利。如果因此而发生的纠纷，由您本人<br/>
					承担侵权所造成的一切后果，谢谢<br/>
					<input type="checkbox" id="copyright" name="copyright"/>我同意以上声明
				</span>
			</td>
			</tr>
			<tr><td>
				<div class="control-group">
					<label class="control-label"><spring:message code="hb_contribute.keyword" text="hb_contribute.keyword"/>：</label>
					<div class="controls">
						<form:input path="keyword" htmlEscape="false" maxlength="64" class="input-xlarge "/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label"><spring:message code="hb_data.content" text="send_time"/>：</label>
					<div class="controls">
						<form:textarea id="content"  path="articleData.content" rows="4" maxlength="200" class="input-xxlarge"/>
						<sys:ckeditor replace="content" uploadPath="/cms/article" />
					</div>
				</div>
				<div class="form-actions">
					<c:if test="${empty param.view }">
					<shiro:hasPermission name="hb:hbContribute:edit">
					<c:if test="${not empty param.id }">
					<input id="btnApply" class="btn btn-primary" type="button"  value="提 交"/>&nbsp;
					</c:if>
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="sys.save"/>"/>&nbsp;</shiro:hasPermission>
					</c:if>
					<input id="btnCancel" class="btn" type="button" value="<spring:message code="sys.back"/>" onclick="history.go(-1)"/>
				</div>
			</td>
			<td>
				<span style="display:block;border:1px solid black;padding-left:3px;">
					<h3  style="text-align:center;color:blue;">允许删减声明</h3>
					秉承公正、客观及合理性的原则，本站编辑可能对您<br/>
					投稿的内容进行删减或再编辑，谢谢。<br/>
					<br/>
					<input type="checkbox" name="cut" id="cut"/>我同意以上声明
				</span>
				<br/>
				<br/>
				<span style="display:block;border:1px solid black;padding-left:3px;">
					<h3 style="text-align:center;color:blue;">采纳声明</h3>
					投稿已提交审批，请您密切关注【读者俱乐部-我的<br/>
					投稿】中的审批及上线状态。如果您的稿件被小编过<br/>
					份青睐，可能会收录到即将出版的<孔子学院>纸质<br/>
					期刊中哦。
					<br/>
					<input type="checkbox" name="adopt" id="adopt"/>我同意以上声明
				</span>
			</td>
			</tr>
		    </table>
		
	</form:form>
</body>
</html>