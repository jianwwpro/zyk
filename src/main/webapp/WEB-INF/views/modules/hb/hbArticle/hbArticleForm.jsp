<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>文章管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic }/vue/vue.js"></script>
	<script type="text/javascript">
	var zhLanguage="${langType}";
	var app = null;
	var applable = null;
		$(document).ready(function() {
			
			$(".journalId").click(function(){
				addpf_win()
			});
			
			$("#keywords_button").click(function(){
				loading('Loading...');
				var content = contentCkeditor.getData();
				var title = $("#title").val();
				var description = $("#introduction").val();
				var categoryName = $("#categoryName").val();
				// 正常打开
				$.post("${ctx}/hb/hbSegWords/keywords",{
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
				 rules: {
					 title:{required:true,rangelength:[0,255],
				        remote:{//验证用户名是否存在
				               type:"POST",
				               url:"${ctx}/hb/hbArticle/checkTitle",
				               data:{
				                 title:function(){
				                	 return $("#title").val();
				                },
						        id:"${hbArticle.id}"
				               } 
				              } 
				            },
				 },
				 messages: {
				     title:{remote:jQuery.format("${langType eq 'zh'?'数据库中已存在!':'Data already exists'}")}
				 },
				submitHandler: function(form){
                    if ($("#categoryId").val()==""){
                        $("#categoryName").focus();
                        top.$.jBox.tip('${langType eq "zh"?"请选择归属栏目!":"please select column"}','warning');
                    }else if (""==CKEDITOR.instances.content.getData() ){
                        top.$.jBox.tip('${langType eq "zh"?"请填写正文":"please input text"}','warning');
                    }else{
                    	data = contentCkeditor.getData();
                    	var html = $(data);
                    	var img = html.find('img')[0];
                    	if(img!=null){
                    		var src = $(img).attr("src");
                    		src = src.substring(src.indexOf("userfiles")+9);
                    		
                    		$("#thumb").val(src);
                    	}else {
                    		$("#thumb").val("");
                    	}
                        loading('${langType eq "zh"?"正在提交，请稍后":"text is submitting , please wait"}...');
                        form.submit();
                    }
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("${langType eq'zh'?'输入有误，请先更正。':'text wrong, please input again'}");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			
			
			$("#btnApply").click(function(){
				//alert("Ee");
				top.$.jBox.confirm(zhLanguage=='zh'?'确认吗？':'Sure?',zhLanguage=='zh'?'SYS prompt':'系统提示',function(v,h,f){
					if(v=='ok'){
						$("#inputForm").attr("action","${ctx}/hb/hbArticle/apply");
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
		function addpf_win(){
			//alert(resId+"&&"+resType);alert(resId+"&&"+resType);
			top.$.jBox.open("iframe:${ctx}/hb/hbJournal/list2select","${langType eq 'zh'?'选择期刊':'select issue'}", 1000, 600, {
				buttons:{"${langType eq 'zh'?'确定':'Sure'}":"ok","${langType eq 'zh'?'关闭':'close'}":"true"}, 
				submit:function(v, h, f){
					if (v=="ok"){
						var chkItem = top.$("#jbox-iframe").contents().find('input:radio[name=chkItem]:checked');
						var refIds="";
						chkItem.each(function (i) {
							//alert($(this).val());
							refIds = $(this).val();	
							
		                });
						
						if(refIds!=null&&refIds.length>0){
							$(".journalId").val(refIds.split("_")[1]);
							$("input[name='journal.id']").val(refIds.split("_")[0]);
						}else{
							alert("${langType eq 'zh'?'选择资源':'select issue'}");
						}
						
					}
				}, loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			});
		}
		
		//语种选择页面
		function addLang_win(id){
			//alert(resId+"&&"+resType);alert(resId+"&&"+resType);
			top.$.jBox.open("iframe:${ctx}/hb/hbArticle/list2select","${langType eq 'zh'?'选择语种关联文章':'选择语种关联文章 select articles'}", 1000, 600, {
				buttons:{"${langType eq 'zh'?'确定':'Sure'}":"ok","${langType eq 'zh'?'关闭':'close'}":"true"}, 
				submit:function(v, h, f){
					if (v=="ok"){
						var chkItem = top.$("#jbox-iframe").contents().find('input:checkbox[name=chkItem]:checked');
						var resIds="";
						chkItem.each(function (i) {
							//alert($(this).val());
							resIds += $(this).val()+",";	
		                });
						if(resIds!=null&&resIds.length>0){
							addpf(id,resIds.substr(0,resIds.length-1));	
						}else{
							alert("${langType eq 'zh'?'选择资源':'select issue'}");
						}
						
					}
				}, loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				},closed:function(){
					window.location.reload();
				}
			});
		}
		
		//语种查看页面
		function addlang_win(code,id){
			//alert(resId+"&&"+resType);alert(resId+"&&"+resType);
			top.$.jBox.open("iframe:${ctx}/hb/hbArticle/list2lang?code="+code+"&id="+id,"查看语种关联文章", 1000, 600, {
				buttons:{"${langType eq 'zh'?'关闭':'close'}":"true"}, 
				submit:function(v, h, f){
				}, loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				},closed:function(){
					window.location.reload();
				}
			});
		}
		
		function addpf(resId,refIds){
			$.ajax({ url: "${ctx}/hb/hbArticle/setlang",data:{"resId":resId,"refIds":refIds}, async:false,success: function(){
		      }});
			window.location.reload();
		}
	</script>
</head>
<body>
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">${langType eq 'zh'?'关键词选择':'select keywords' }</h3>
  </div>
  <div class="modal-body">
    
<table id="contentTable" class="table table-striped table-bordered table-condensed" style="margin: 0 0;">
		<thead>
			<tr>
			<th></th>
				<th><spring:message code='hb_article.keyword' text='hb_article.keyword' /></th>
				<th>${langType eq 'zh'?'出现次数':'Freq' }</th>
				<th>${langType eq 'zh'?'关联文章数':'other articles' }</th>
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
				<td>
					{{keywords.article_count}}
				</td>
				
			</tr>
		</tbody>
	</table>
  </div>
  


</div>

	<ul class="nav nav-tabs">
	<c:if test="${!('editForm' eq hbArticle.act.taskDefKey)}">
		<li ><a href="${ctx}/hb/hbArticle/?menu.id=${empty param['menu.id']?hbArticle.menu.id:param['menu.id']}"><spring:message code='hb_articls.column_list' text='hb_articls.column_list' /></a></li>
		<li class="active"><a href="${ctx}/hb/hbArticle/form?id=${hbArticle.id }&menu.id=${empty param['menu.id']?hbArticle.menu.id:param['menu.id']}"><spring:message code='hb_article.table.title' text='hb_article.table.title' /></a></li></c:if>
		
		<%-- <li class="active"><a href="<c:url value='${fns:getAdminPath()}/hb/hbArticle/form?id=${hbArticle.id}&menu.id=${param[\'menu.id\']}'><c:param name='category.name' value='${article.category.name}'/></c:url>">文章<shiro:hasPermission name="cms:article:edit">${not empty article.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cms:article:edit">查看</shiro:lacksPermission></a></li> --%>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="hbArticle" action="${ctx}/hb/hbArticle/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<input id="categoryName" type="hidden" value="${hbmenu.name }"/>
		<input id="menu.id" name="menu.id" type="hidden" value="${hbArticle.menu.id==null?param['menu.id']:hbArticle.menu.id}"/>		
		<sys:message content="${message}"/>
		
		<c:if test="${not empty hbArticle && not empty hbArticle.id }">
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_menu.table.title1" text="所属栏目"/>：</label>
			<div class="controls">
				<form:input path="menu.name" htmlEscape="false" maxlength="255" class="input-xxlarge " disabled="true"/>
			</div>
		</div>
		</c:if>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_article.title" text="标题"/>：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" id="title" maxlength="255" class=" input-xxlarge measure-input required "/>
			</div>
		</div>
		<div class="control-group">
			 <label class="control-label"><spring:message code="hb_article.subtitle" text="副标题"/>：</label>
			<div class="controls">
				<form:input path="subtitle" htmlEscape="false" maxlength="255" class="input-xlarge input-xxlarge measure-input "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_article.language" text="语种"/>：</label>
			<div class="controls">
			<form:select path="language" items="${fns:getDictList('lang')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required input-xlarge"/>
			</div>
		</div>
       
       <div class="control-group">
			<label class="control-label"><spring:message code="hb_article.journal_id" text="期"/>：</label>
			<div class="controls">
				<%-- <form:input path="journal.id" htmlEscape="false" maxlength="64" class="input-xlarge "/> --%>
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
		class="" style=""/><a id="keywords_button" href="javascript:" class="btn  style="padding:4px 2px;">&nbsp;<i class="icon-search"></i>&nbsp;</a>&nbsp;&nbsp;
				<span class="help-inline">${langType eq 'zh'?'多个关键字，用空格分隔。':'Use the “space” separated the keywords' }</span>
			</div>
		</div>
		
		 <div class="control-group">
			<label class="control-label"><spring:message code="hb_article.label" text="标签"/>：</label>
                <div class="controls">
				<select id="lables" name="label" multiple style="width:300px">
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
				<form:input path="createUser" htmlEscape="false" maxlength="64" class="input-xlarge "/>
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
				<form:select path="chineseLevel" items="${fns:getDictList('hsk_level')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required input-xlarge"/>
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
		<c:if test="${hbArticle==null || hbArticle.status==1 || empty hbArticle.status||'editForm' eq hbArticle.act.taskDefKey}">
			<div class="control-group">
			<label class="control-label"><spring:message code="hb_articls.other_language" text="hb_articls.other_language"/>：</label>
			<div class="controls">
				<a href="javascript:" onclick="addlang_win('${hbArticle.code}','${hbArticle.id}')">${hbArticle.langs}</a>
				&nbsp;&nbsp;
				<a href="javascript:" onclick="addLang_win('${hbArticle.id}')"><spring:message code="hb_articls.other_language" text="hb_articls.other_language"/></a>
			</div>
		</div>
		</c:if>
				<form:input id="thumb"  path="thumb"  htmlEscape="false"  style="display:none"  maxlength="300"  required="true" class="input-xlarge "/>
		<%-- <div class="control-group">
			<label class="control-label"><spring:message code="hb_article.thumb" text="封面"/>：</label>
			<div class="controls">
				<sys:ckfinder input="thumb"  type="images" uploadPath="/thumb" selectMultiple="false" maxWidth="100" maxHeight="100"/>
			</div>
		</div> --%> 
	
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_data.content" text="send_time"/>：</label>
			<div class="controls">
				<form:textarea id="content"  path="articleData.content" rows="4" maxlength="200" class="input-xxlarge"/>
				<sys:ckeditor replace="content" uploadPath="/cms/article" />
			</div>
		</div>
		
		<div class="form-actions">
		<shiro:hasPermission name="hb:hbArticle:edit">
			<c:if test="${hbArticle==null || hbArticle.status==1 || empty hbArticle.status||'editForm' eq hbArticle.act.taskDefKey}">
			<!-- 草稿状态可提交 -->
					<input id="btnApply" class="btn btn-primary" type="button"  value="<spring:message code='sys.apply' text='sys.apply' />"/>&nbsp;		
			</c:if>
			<c:if test="${hbArticle.status==3||hbArticle.status==1 || empty hbArticle.id||'editForm' eq hbArticle.act.taskDefKey}">
			<!-- 草稿或则下架可修改 -->
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code='sys.save' text='sys.save' />"/>
			</c:if>
		</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="<spring:message code='sys.back' text='sys.back' />" onclick="history.go(-1)"/>
		
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