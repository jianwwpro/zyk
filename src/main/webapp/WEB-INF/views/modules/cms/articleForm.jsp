<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>文章管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic }/vue/vue.js"></script>
	<script type="text/javascript">
	
	var app = null;
		$(document).ready(function() {
			$("#keywords_button").click(function(){
				loading('正在生成，请稍后....');
				var content = contentCkeditor.getData();
				var title = $("#title").val();
				var description = $("#description").val();
				var categoryName = $("#categoryName").val();
				// 正常打开
				$.post("${ctx}/cms/keywords/keywords",{
					content:content,
					title:title,
					description:description,
					categoryName:categoryName
					
				},function(data){
					app.datas=data;
					var selects = $("#keywords").val();
					if(selects!=null&&selects!=''){
						var ss = selects.split(" ");
						for(var i=0;i<app.datas.length;i++){
							var name = app.datas[i].key;
							if(ss.indexOf(name)>-1){
								//app.datas[i].selected==true;
								app.datas[i].checked=true;
								//$("#box_"+app.datas[i].id).attr("checked","checked");
							}
							
						}
					}
					
					$('#myModal').modal({show:true});
					closeLoading();
				}
				,'json');
			});
			
			
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
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">关键词选择</h3>
  </div>
  <div class="modal-body">
    
<table id="contentTable" class="table table-striped table-bordered table-condensed" style="margin: 0 0;">
		<thead>
			<tr>
			<th></th>
				<th>关键词</th>
				<th>出现次数</th>
			</tr>
		</thead>
		<tbody>
			<tr v-for="keywords in datas">
				<td><input type="checkbox" v-model="keywords.checked" @change="select(keywords)" id="box_{{keywords.id}}" /> </td>
				<td>
					{{keywords.key}}
				</td>
				<td>
					{{keywords.count}}
				</td>
				
				
			</tr>
		</tbody>
	</table>
  </div>
  


</div>

	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cms/article/?category.id=${article.category.id}">文章列表</a></li>
		<li class="active"><a href="<c:url value='${fns:getAdminPath()}/cms/article/form?id=${article.id}&category.id=${article.category.id}'><c:param name='category.name' value='${article.category.name}'/></c:url>">文章<shiro:hasPermission name="cms:article:edit">${not empty article.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cms:article:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="article" action="${ctx}/cms/article/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">归属栏目:</label>
			<div class="controls">
                <sys:treeselect id="category" name="category.id" value="${article.category.id}" labelName="category.name" labelValue="${article.category.name}"
					title="栏目" url="/cms/category/treeData" module="article" selectScopeModule="true" notAllowSelectRoot="false" notAllowSelectParent="true" cssClass="required"/>&nbsp;
                <!-- <span>
                    <input id="url" type="checkbox" onclick="if(this.checked){$('#linkBody').show()}else{$('#linkBody').hide()}$('#link').val()"><label for="url">外部链接</label>
                </span> -->
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">
			 <spring:message code="cms.news.title"/>:</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="200" class="input-xxlarge measure-input required"/>
				<%-- &nbsp;<label>颜色:</label>
				<form:select path="color" class="input-mini">
					<form:option value="" label="默认"/>
					<form:options items="${fns:getDictList('color')}" itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select> --%>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">语种:</label>
			<div class="controls">
			<form:select path="articleData.copyfrom" items="${fns:getDictList('lang')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required input-xlarge"/>
			
			</div>
		</div>
       <%--  <div id="linkBody" class="control-group" style="display:none">
            <label class="control-label">外部链接:</label>
            <div class="controls">
                <form:input path="link" htmlEscape="false" maxlength="200" class="input-xlarge"/>
                <span class="help-inline">绝对或相对地址。</span>
            </div>
        </div> --%>
		<div class="control-group">
			<label class="control-label">关键字:</label>
			<div class="controls">
				<%-- <form:input path="keywords" htmlEscape="false" maxlength="200" class="input-xlarge" onclick="getKeywords()"/> --%>
				<input  id="keywords" name="keywords"  type="text" value="${article.keywords}" 
		class="" style=""/><a id="keywords_button" href="javascript:" class="btn  style="padding:4px 2px;">&nbsp;<i class="icon-search"></i>&nbsp;</a>&nbsp;&nbsp;
				<span class="help-inline">多个关键字，用空格分隔。</span>
			</div>
		</div>
		
		 <div class="control-group">
                <label class="control-label">标签:</label>
                <div class="controls">
                      <form:input path="viewConfig" htmlEscape="true"/>
                </div>
            </div>
		<div class="control-group">
			<label class="control-label">置顶:</label>
			<div class="controls">
				<%-- <form:input path="weight" htmlEscape="false" maxlength="200" class="input-mini required digits"/>&nbsp; --%>
				<span>
					<input id="weightTop" type="checkbox" onclick="$('#weight').val(this.checked?'999':'0')"><!-- <label for="weightTop">置顶</label> -->
				</span>
				<%-- &nbsp;过期时间：
				<input id="weightDate" name="weightDate" type="text" readonly="readonly" maxlength="20" class="input-small Wdate"
					value="<fmt:formatDate value="${article.weightDate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/> --%>
				<span class="help-inline">显示在列表前面。</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">摘要:</label>
			<div class="controls">
				<form:textarea path="description" htmlEscape="false" rows="4" maxlength="200" class="input-xxlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">缩略图:</label>
			<div class="controls">
                <input type="hidden" id="image" name="image" value="${article.imageSrc}" />
				<sys:ckfinder input="image" type="thumb" uploadPath="/cms/article" selectMultiple="false"/>
			</div>
		</div>
		
	
		<div class="control-group">
			<label class="control-label">正文:</label>
			<div class="controls">
				<form:textarea id="content"  path="articleData.content" rows="4" maxlength="200" class="input-xxlarge"/>
				<sys:ckeditor replace="content" uploadPath="/cms/article" />
			</div>
		</div>
		
		
		<div class="control-group">
			<label class="control-label">发布时间:</label>
			<div class="controls">
				<input id="createDate" name="createDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${article.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
	
		
		<div class="form-actions">
			<shiro:hasPermission name="cms:article:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	
	
	
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
	
</body>
</html>