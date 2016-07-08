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
			
            if($("#link").val()){
                $('#linkBody').show();
                $('#url').attr("checked", true);
            }
		
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
	<form:form id="inputForm" modelAttribute="hbArticle" action="${ctx}/hb/hbArticle/apply" method="post" class="form-horizontal">
	
	
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
		
		
<input id="menu.id" name="menu.id" type="hidden" value="${hbArticle.menu.id==null?param['menu.id']:hbArticle.menu.id}"/>		
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_menu.table.title1" text="所属栏目"/>：</label>
			<div class="controls">
				<form:input path="menu.name" htmlEscape="false" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_article.title" text="标题"/>：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			 <label class="control-label"><spring:message code="hb_article.subtitle" text="副标题"/>：</label>
			<div class="controls">
				<form:input path="subtitle" htmlEscape="false" maxlength="255" class=" input-xxlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_article.language" text="语种"/>：</label>
			<div class="controls">
			<form:select path="language" items="${fns:getDictList('lang')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required input-xxlarge"/>
			</div>
		</div>
       
       <div class="control-group">
			<label class="control-label"><spring:message code="hb_article.journal_id" text="期"/>：</label>
			<div class="controls">
				<%-- <input  type="text" value="${hbArticle.journal.name}" disabled="disabled"
		class="journalId input-xxlarge" style=""/>
			<input name="journal.id" value="${hbArticle.journal.id }" type="hidden"> --%>
			<input  type="text" value="<c:if test="${not empty hbArticle.journal && not empty hbArticle.journal.id}">${hbArticle.journal.name}</c:if>
				" disabled="disabled"
		class="journalId" style=""/><a href="javascript:" class="btn journalId"  style="padding:4px 2px;">&nbsp;<i class="icon-search"></i>&nbsp;</a>&nbsp;&nbsp;
			<input name="journal.id" value="${hbArticle.journal.id }" type="hidden">
			</div>
		</div>
       
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_article.keyword" text="关键字"/>：</label>
			<div class="controls">
				<input  id="keywords" name="keyword"  type="text" value="${hbArticle.keyword}" 
		class="input-xxlarge" style=""/>
			</div>
		</div>
		
		 <div class="control-group">
			<label class="control-label"><spring:message code="hb_article.label" text="标签"/>：</label>
                <div class="controls">
				<select id="lables" name="label" multiple style="width:300px"  disabled="disabled">
                <c:forEach var="lable" items="${hbLables }" varStatus="s" >
					<option value="${lable.name }">${lable.name }</option>
				</c:forEach>
				</select> 
				<script type="text/javascript">
				var value ='${hbArticle.label}';
				$("#lables").val(value.split(',')).select2();
				</script>
                </div>
            </div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_article.create_user" text="作者"/>：</label>
			<div class="controls">
				<form:input path="createUser" htmlEscape="false" maxlength="64" class="input-xxlarge "/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_article.introduction" text="简介"/>：</label>
			<div class="controls">
				<form:textarea path="introduction" htmlEscape="false" rows="4" maxlength="2000" class="input-xxlarge"/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_article.chinese_level" text="汉语等级"/>：</label>
			<div class="controls">
				<form:select path="chineseLevel" items="${fns:getDictList('hsk_level')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required input-xxlarge"/>
			</div>
		</div>
			<div class="control-group">
			<label class="control-label"><spring:message code="hb_article.send_time" text="send_time"/>：</label>
			<div class="controls">
				<input name="sendTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${hbArticle.sendTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		
		
		
	
		<div class="control-group">
			<div class="container" style="border: 1px solid red; height: 500px; overflow-y:auto;">
				${hbArticle.articleData.content }
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