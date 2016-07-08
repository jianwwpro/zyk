<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_contribute.table.title"/><spring:message code="sys.manager"/></title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic }/vue/vue.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('<spring:message code="sys.loadding"/>');
					if (""==CKEDITOR.instances.content.getData() ){
                        top.$.jBox.tip('请填写正文','warning');
                    }else{
                        loading('正在提交，请稍等...');
                        form.submit();
                    }
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("<spring:message code="sys.input.error"/>");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			
			$("#btnApply").click(function(){
				$("#inputForm").attr("action","${ctx}/hb/hbContribute/apply");
				top.$.jBox.confirm('确认吗？','系统提示',function(v,h,f){
					if(v=='ok'){
						resetTip(); //loading();
						$("#inputForm").submit();
					}
				},{buttonsFocus:1, closed:function(){
					if (typeof closed == 'function') {
						closed();
					}
				}});
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/hb/hbContribute/"><spring:message code="hb_contribute.table.title"/><spring:message code="sys.list"/></a></li>
		<li class="active"><a href="${ctx}/hb/hbContribute/form?id=${hbContribute.id}"><spring:message code="hb_contribute.table.title"/><shiro:hasPermission name="hb:hbContribute:edit">${not empty hbContribute.id?sys.update:sys.add}</shiro:hasPermission><shiro:lacksPermission name="hb:hbContribute:edit"><spring:message code="sys.view"/></shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="hbContribute" action="${ctx}/hb/hbContribute/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<sys:message content="${message}"/>		
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
		<%-- <div class="control-group">
			<label class="control-label"><spring:message code="hb_contribute.status" text="hb_contribute.status"/>：</label>
			<div class="controls">
				<form:select path="status" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('hb_blog_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_contribute.signature" text="hb_contribute.signature"/>：</label>
			<div class="controls">
				<form:input path="signature" htmlEscape="false" maxlength="30" class="input-xlarge "/>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label"><spring:message code="hb_contribute.audit_time" text="hb_contribute.audit_time"/>：</label>
			<div class="controls">
			<fmt:formatDate value="${hbContribute.auditTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				<input name="auditTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${hbContribute.auditTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_contribute.audit_user" text="hb_contribute.audit_user"/>：</label>
			<div class="controls">
				<form:input path="user.id" htmlEscape="false" maxlength="64" class="input-xlarge " readonly="true"/>
			</div>
		</div> --%>
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
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_contribute.keyword" text="hb_contribute.keyword"/>：</label>
			<div class="controls">
				<form:input path="keyword" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_contribute.content" text="hb_contribute.content"/>：</label>
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
	</form:form>
</body>

<script type="text/javascript">
Array.prototype.remove = function(val) {
	var index = this.indexOf(val);
	if (index > -1) {
	this.splice(index, 1);
	}
	};
app= new Vue({
	el:'#myModal',
	data:{
		datas:[],
	},methods:{
		select:function(k){
			var names = "";
			console.log(this.datas);
			for(var i=0;i<this.datas.length;i++){
				console.log(this.datas[i]);
				if(this.datas[i].checked==true){
					names+=this.datas[i].key+" ";
				}	
			}
			$("#keywords").val(names);
		}
	},
	ready:function(){
	
	}
});

</script>
</html>