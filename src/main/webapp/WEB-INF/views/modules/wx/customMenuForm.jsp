<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>自定义菜单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active">自定义菜单${not empty customMenu.id?'修改':'添加'}</li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="customMenu" action="${ctx}/wx/customMenu/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		
		<div class="control-group">
			<label class="control-label">名称：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="45" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上级父菜单:</label>
			<div class="controls">
				<sys:treeselect id="parent" name="parent.id" value="${customMenu.parent.id}" labelName="parent.name" labelValue="${customMenu.parent.name}"
					title="父菜单" url="/wx/customMenu/treeData" extId="${customMenu.id}" cssClass="" allowClear="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">排序：</label>
			<div class="controls">
				<form:input path="sort" htmlEscape="false" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">内容类型：</label>
			<div class="controls">
				<form:radiobutton path="contentType" value="0" label="文本消息" />
				<form:radiobutton path="contentType" value="1" label="图片消息" />
				<form:radiobutton path="contentType" value="2" label="语音消息" />
				<form:radiobutton path="contentType" value="3" label="图文消息" />
				<form:radiobutton path="contentType" value="4" label="跳转网页"  />
			</div>
		</div>
		<div class="control-group">
			<div class="controls">
				<form:hidden id="urlContent" path="content" htmlEscape="false" rows="4" maxlength="600" class="input-xxlarge hidden" />				
				
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wx:customMenu:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>