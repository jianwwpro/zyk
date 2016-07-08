<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>素材编辑</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            if($("#link").val()){
                $('#linkBody').show();
                $('#url').attr("checked", true);
            }
			$("#title").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
                    if ($("#categoryId").val()==""){
                        $("#categoryName").focus();
                        top.$.jBox.tip('请选择归属栏目','warning');
                    }else if (CKEDITOR.instances.content.getData()=="" && $("#link").val().trim()==""){
                        top.$.jBox.tip('请填写正文','warning');
                    }else{
                        loading('正在提交，请稍等...');
                        form.submit();
                    }
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
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
		<li ><a href="${ctx}/wx/material/news/list">文章列表</a></li>
		<li class="active" ><a href="${ctx}/wx/material/news/form?media_id=${param.media_id}">文章列表</a></li>
	</ul><br/>
	
	<sys:message content="${message}"/>
	<div class="">
	<div class=" row" style="border: 1px solid red;"><!-- row -->
		<div class="span4" style="border: 1px solid blue;">dd</div>
		<div class="span8" style="border: 1px solid blue;"><!-- right -->
			<form id="inputForm" method="post" >
			<c:forEach items="${result.news_item }" var="article" varStatus="status">
				<div class="edit_form">
					<div class="control-group">
						<label class="control-label">标题:</label>
						<div class="controls">
							<input htmlEscape="false" maxlength="200"  name="title_${status.index }"  value="${article.title }" class="input-xxlarge measure-input required"/>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">作者:</label>
						<div class="controls">
							<input htmlEscape="false" maxlength="200" class="input-xxlarge " name="author_${status.index }"  value="${article.author }" />
						</div>
					</div>
					<div class="control-group">
						<label class="control-label">正文:</label>
						<div class="controls">
							<textarea id="content_${status.index }" htmlEscape="true" rows="4" maxlength="200" class="input-xxlarge">${article.content }</textarea>
							<sys:ckeditor replace="content_${status.index }" uploadPath="/cms/article"  height="900px"  />
						</div>
					</div>
				</div>	
			
			</c:forEach>
			
			</form>
		
		</div><!-- right -->
		
		
	</div><!-- row -->
	</div>
</body>
</html>