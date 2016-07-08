<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>投稿管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic }/vue/vue.js"></script>
	<script type="text/javascript">
	
	var app = null;
		$(document).ready(function() {
			
            if($("#link").val()){
                $('#linkBody').show();
                $('#url').attr("checked", true);
            }
		
			$("#inputForm").validate({
				submitHandler: function(form){
                    if (CKEDITOR.instances.content.getData()=="" && $("#link").val().trim()==""){
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
			
			$(".input-xxlarge").attr("readonly","readonly");
			//同意
			$("#btnApply").click(function(){	
				$("#flag").val("yes");
				$('#myModal').modal({show:true});
			});
			//驳回
			$("#btnNo").click(function(){	
				$("#flag").val("no");
				$('#myModal').modal({show:true});
			});
			
			$("#tijiao").click(function(){
				
				$("form").submit();
			});
			
		});
		
		
		
	</script>
</head>
<body>

 

	<br/>
	<form:form id="inputForm" modelAttribute="hbContribute" action="${ctx}/hb/hbContribute/apply" method="post" class="form-horizontal">
	
	
<!-- 对话框 -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">您的意见</h3>
  </div>
  <div class="modal-body">
    <p>
    <textarea name="act.comment" id="com" rows="5" style="width: 98%"></textarea>
    </p>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">关闭</button>
    <button  id="tijiao" class="btn btn-primary">提交</button>
  </div>
</div>
	
	
		<form:hidden path="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<input type="hidden" name="pass" id="pass">
		
		<sys:message content="${message}"/>
		
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_blog.title" text="hb_blog.title"/>：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="255" class="input-xxlarge required"/>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label"><spring:message code="hb_blog.status" text="hb_blog.status"/>：</label>
			<div class="controls">
				<form:select path="status" class="input-xxlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('hb_blog_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_blog.language" text="hb_blog.language"/>：</label>
			<div class="controls">
				<form:select path="language" class="input-xxlarge ">
					<form:options items="${fns:getDictList('lang')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_blog.signature" text="hb_blog.signature"/>：</label>
			<div class="controls">
				<form:input path="signature" htmlEscape="false" maxlength="50" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_blog.audit_time" text="hb_blog.audit_time"/>：</label>
			<div class="controls">
				<fmt:formatDate value="${hbContribute.auditTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				<%-- <input name="auditTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${hbContribute.auditTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> --%>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_blog.audit_user" text="hb_blog.audit_user"/>：</label>
			<div class="controls">
				<form:input path="user.id" htmlEscape="false" maxlength="64" class="input-xxlarge " readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_blog.is_score" text="hb_blog.is_score"/>：</label>
			<div class="controls">
				<%-- <form:input path="isScore" htmlEscape="false" maxlength="1" class="input-xxlarge "/> --%>
				<%-- <form:checkbox path="isScore" value="1" style="width:145px"/> --%>
				<form:select path="isScore" class="input-xxlarge">
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_blog.is_pub" text="hb_blog.is_pub"/>：</label>
			<div class="controls">
				<%-- <form:input path="isPub" htmlEscape="false" maxlength="1" class="input-xxlarge "/> --%>
				<form:select path="isPub" class="input-xxlarge">
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label"><spring:message code="hb_blog.browse" text="hb_blog.browse"/>：</label>
			<div class="controls">
				<form:input path="browse" htmlEscape="false" maxlength="11" class="input-xxlarge "/>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label"><spring:message code="sys.remarks" text="sys.remarks"/>：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
	
		<div class="control-group">
			<div class="container" style="border: 1px solid red; height: 500px; overflow-y:auto;">
				${hbContribute.articleData.content }
			</div>
		</div>
		
		<div class="form-actions">
			<input id="btnApply" class="btn btn-primary"  type="button"  value="同 意"/>&nbsp;
			<input id="btnNo" class="btn btn-primary"  type="button"  value="驳 回"/>&nbsp;
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