<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_activity.table.title"/><spring:message code="sys.manager"/></title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
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
				 
				$("#inputForm").attr("action","${ctx}/hb/hbActivity/apply");
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
			/* 无id时保存并提价*/
			$("#btnSaveAndApply").click(function(){
				$("#inputForm").attr("action","${ctx}/hb/hbActivity/saveAndApply");
				$("#inputForm").submit();	
			});
			
			$("#upFile").on('click',function(){
				$("#headPic").trigger("click");
			});
		});
		//上传图片
		function addActivityFile(){
			 $.ajax({
				    url: '${ctxFront}/uploadFile/upAllFile',
				    type: 'POST',
				    cache: false,
				    data: new FormData($('#uploadForm')[0]),
				    processData: false,
				    contentType: false
				}).done(function(res) {
					if(res.success){
						 var str="<span id='file"+res.fileId+"'><input type='hidden' name='fileUpdateId' value='"+res.fileId+"'/><a target='_blank' href='${ctxBase}/userfiles/"+res.url+"' style='width:50px;height:50px;'>"+res.extName+"</a><span onclick=\"delImg('"+res.fileId+"')\">${langType eq 'zh'?'删除':'Delete'}</span></span>";
						$("#iamgePic").append(str);
						//  	2/files/photo/1464865845067.png
						/* $("#headImg").attr("src",'${ctxBase}/userfiles/'+res.url);	 */
					}else{
						alert("${langType eq 'zh'?'上传失败！':'Upload failed!'}");
					}
				}).fail(function(res) {});  
		}
		function delImg(id){
			$.post("${ctxFront}/uploadFile/delBlogPic?id="+id,function(data){
				if(data.success){
					$("#file"+id).remove();
				}
			});
			//
		}
	</script>
</head>
<body>
<form id="uploadForm" action="${ctxFront}/uploadFile/upFile" enctype="multipart/form-data">
	<input type="file" name="file" id="headPic" style="display:none" onchange="addActivityFile();"/>
</form>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/hb/hbActivity/"><spring:message code="hb_activity.table.title"/><spring:message code="sys.list"/></a></li>
		<li class="active"><a href="${ctx}/hb/hbActivity/form?id=${hbActivity.id}"><spring:message code="hb_activity.table.title"/><shiro:hasPermission name="hb:hbActivity:edit">${not empty hbActivity.id?sys.update:sys.add}</shiro:hasPermission><shiro:lacksPermission name="hb:hbActivity:edit"><spring:message code="sys.view"/></shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="hbActivity" action="${ctx}/hb/hbActivity/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		
		<input type="hidden" name="style" value="1">
		
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_activity.title" text="hb_activity.title"/>：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
			</div>
		</div>
		<c:if test="${empty param.view }">
		<div class="control-group">
			<label class="control-label"><spring:message code="sys.uploadName" text="sys.uploadName"/>：</label>
			<div class="controls">
			<span class="uploadBtn"><input type="button" value="${langType eq 'zh'?'选择附件':'Select attachment' }" id="upFile" style="background:#666666;color:#fff;"></span>
			</div>
		</div>
		</c:if>
		
			<div class="control-group">
				<label class="control-label"><%-- <spring:message code="sys.uploadName" text="sys.uploadName"/>： --%></label>
				<div class="controls" id="iamgePic">
					<c:forEach var="pf" items="${listPf }">
						<span id='file${pf.id }'><a href='${ctxBase}/userfiles/${pf.pfpath}' target="_blank" style='width:50px;height:50px;'>${pf.extName }</a><c:if test="${empty param.view }"><span onclick="delImg('${pf.id}')">${langType eq 'zh'?'删除':'Delete' }</span></c:if></span>
					</c:forEach>
				</div>
			</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_activity.language" text="hb_activity.language"/>：</label>
			<div class="controls">
				<form:select path="language" class="input-xlarge ">
					<form:options items="${fns:getDictList('lang')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
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
			<shiro:hasPermission name="hb:hbActivity:edit">
			<c:if test="${not empty param.id }">
			<input id="btnApply" class="btn btn-primary" type="button"  value="<spring:message code='sys.apply'/>"/>&nbsp;
			</c:if>
			<c:if test="${empty param.id }">
			<input id="btnSaveAndApply" class="btn btn-primary" type="button"  value="<spring:message code='sys.apply'/>"/>&nbsp;
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