<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>活动流程</title>
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
	<form:form id="inputForm" modelAttribute="hbActivity" action="${ctx}/hb/hbActivity/apply" method="post" class="form-horizontal">
	
	
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
			<label class="control-label"><spring:message code="hb_activity.title" text="hb_activity.title"/>：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label"><spring:message code="hb_activity.status" text="hb_activity.status"/>：</label>
			<div class="controls">
				<form:input path="status" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div> --%>
		</div>
			<div class="control-group">
				<label class="control-label"></label>
				<div class="controls" id="iamgePic">
					<c:forEach var="pf" items="${listPf }">
						<span id='file${pf.id }'><a href='${ctxBase}/userfiles/${pf.pfpath}' style='width:50px;height:50px;'>${pf.extName }</a></span>
					</c:forEach>
				</div>
			</div>
		<%-- <div class="control-group">
			<label class="control-label"><spring:message code="hb_activity.publish_time" text="hb_activity.publish_time"/>：</label>
			<div class="controls">
			<fmt:formatDate value="${hbContribute.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				<input name="publishTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${hbActivity.publishTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_activity.publish_user" text="hb_activity.publish_user"/>：</label>
			<div class="controls">
				<form:input path="user.id" htmlEscape="false" maxlength="64" class="input-xlarge " readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_activity.style" text="hb_activity.style"/>：</label>
			<div class="controls">
				<form:select path="style" class="input-xlarge ">
					<form:options items="${fns:getDictList('hb_activity_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_activity.placed_top" text="hb_activity.placed_top"/>：</label>
			<div class="controls">
				<form:input path="placedTop" htmlEscape="false" maxlength="1" class="input-xlarge "/>
				<form:select path="placedTop" class="input-xlarge">
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_activity.language" text="hb_activity.language"/>：</label>
			<div class="controls">
				<form:select path="language" class="input-xlarge ">
					<form:options items="${fns:getDictList('lang')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label"><spring:message code="hb_activity.abstracts" text="hb_activity.abstracts"/>：</label>
			<div class="controls">
				<form:input path="abstracts" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_activity.source" text="hb_activity.source"/>：</label>
			<div class="controls">
				<form:input path="source" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_activity.browse" text="hb_activity.browse"/>：</label>
			<div class="controls">
				<form:input path="browse" htmlEscape="false" maxlength="11" class="input-xlarge " readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="sys.remarks" text="sys.remarks"/>：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div> --%>
	
		<div class="control-group">
			<div class="container" style="border: 1px solid red; height: 500px; overflow-y:auto;">
				${hbActivity.articleData.content }
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