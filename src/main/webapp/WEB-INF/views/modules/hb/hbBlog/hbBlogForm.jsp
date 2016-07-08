<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_blog.table.title"/><spring:message code="sys.manager"/></title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic }/vue/vue.js"></script>
	<script type="text/javascript">
	var zhLanguage="${langType}";
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('<spring:message code="sys.loadding"/>');
					if (""==CKEDITOR.instances.content.getData() ){
                        top.$.jBox.tip('${langType eq "zh"?"请填写正文":"please input text"}','warning');
                    }else{
                        loading('${langType eq "zh"?"正在提交，请稍等":"text is submitting , please wait"}...');
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
				$("#inputForm").attr("action","${ctx}/hb/hbBlog/apply");
				top.$.jBox.confirm(zhLanguage=='zh'?'确认吗？':'Sure?',zhLanguage=='zh'?'SYS prompt':'系统提示',function(v,h,f){
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
		<li><a href="${ctx}/hb/hbBlog/"><spring:message code="hb_blog.table.title"/><spring:message code="sys.list"/></a></li>
		<li class="active"><a href="${ctx}/hb/hbBlog/form?id=${hbBlog.id}"><spring:message code="hb_blog.table.title"/><shiro:hasPermission name="hb:hbBlog:edit">${not empty hbBlog.id?sys.update:sys.add}</shiro:hasPermission><shiro:lacksPermission name="hb:hbBlog:edit"><spring:message code="sys.view"/></shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="hbBlog" action="${ctx}/hb/hbBlog/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_blog.title" text="hb_blog.title"/>：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label"><spring:message code="hb_blog.status" text="hb_blog.status"/>：</label>
			<div class="controls">
				<form:select path="status" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('hb_blog_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_blog.language" text="hb_blog.language"/>：</label>
			<div class="controls">
				<form:select path="language" class="input-xlarge ">
					<form:options items="${fns:getDictList('lang')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_blog.signature" text="hb_blog.signature"/>：</label>
			<div class="controls">
				<form:input path="signature" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_blog.audit_time" text="hb_blog.audit_time"/>：</label>
			<div class="controls">
				<fmt:formatDate value="${hbBlog.auditTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				<%-- <input name="auditTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${hbBlog.auditTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> --%>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_blog.audit_user" text="hb_blog.audit_user"/>：</label>
			<div class="controls">
				<form:input path="user.id" htmlEscape="false" maxlength="64" class="input-xlarge " readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_blog.is_score" text="hb_blog.is_score"/>：</label>
			<div class="controls">
				<%-- <form:input path="isScore" htmlEscape="false" maxlength="1" class="input-xlarge "/> --%>
				<%-- <form:checkbox path="isScore" value="1" style="width:145px"/> --%>
				<form:select path="isScore" class="input-xlarge">
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_blog.is_pub" text="hb_blog.is_pub"/>：</label>
			<div class="controls">
				<%-- <form:input path="isPub" htmlEscape="false" maxlength="1" class="input-xlarge "/> --%>
				<form:select path="isPub" class="input-xlarge">
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label"><spring:message code="hb_blog.browse" text="hb_blog.browse"/>：</label>
			<div class="controls">
				<form:input path="browse" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label"><spring:message code="sys.remarks" text="sys.remarks"/>：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
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
			<shiro:hasPermission name="hb:hbBlog:edit">
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