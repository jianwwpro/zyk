<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_journal_list.table.title"/><spring:message code="sys.manager"/></title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic }/vue/vue.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#importForm [name=language]' ).val($("#searchForm [name=language]:checked").val());
			$("#searchForm [name=language]").change(function(){
				$('#importForm [name=language]' ).val(this.value);
			});
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		function saveJournalList(id){
           var url = "${ctx}/hb/hbJournalList/form?journalId=${param.journalId }";
           if(id){
        	   url+="&id="+id;
           }
    		top.journalListForm=top.$.jBox("iframe:"+url, {title: "添加期目录", width:$(top.window).width()-100, height: $(top.window).height()-200, buttons:{'关闭': true},
    			closed:function(){
    				window.location.reload(true) ;
    			}
    		}); 
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<ul class="nav nav-tabs">
			<li ><a href="${ctx}/hb/hbJournal/form?id=${empty param.journalId?hbJournalList.journalId:param.journalId}&view=true&act.taskId=${param['act.taskId']  }&act.procInsId=${param['act.procInsId']  }&act.taskDefKey=${param['act.taskDefKey']  }&act.taskName=${param['act.taskName']  }&act.procDefId=${param['act.procDefId']  }">
			<spring:message code="hb_journal.table.title"/>
		</a></li>
		<li class="active"><a href="${ctx}/hb/hbJournalList/listCheck?act.taskId=${param['act.taskId'] }&act.procInsId=${param['act.procInsId '] }&act.taskDefKey=${param['act.taskDefKey']  }&act.taskName=${param['act.taskName']  }&act.procDefId=${param['act.procDefId']  }&journalId=${empty param.journalId?hbJournalList.journalId:param.journalId}&view=${param.view}"><spring:message code="hb_journal_list.table.title"/><spring:message code="sys.list"/></a></li>
	</ul><br/>
	
	</ul>
	<form:form id="searchForm" modelAttribute="hbJournalList" action="" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="journalV" name="journalV" type="hidden" value="${hbJournal.journalV }"/>
		<input id="journalId" name="journalId" type="hidden" value="${empty param.journalId?hbJournalList.journalId:param.journalId }"/>
		<ul class="ul-form">
			<li>
				
				  
				
				 <li><label>语种：</label>
				 <c:forEach items="${fns:getDictList('lang')}" varStatus="status" var="lan">
					<span><input ${ empty hbJournalList.language  ? (status.index==0 ? 'checked':''):( hbJournalList.language==lan.value?'checked':'')} @click="search()" id="language${status.index }" name="language" type="radio" value="${lan.value }"  ><label for="language${status.index }">${lan.label }</label></span>
				</c:forEach>
				
				 
				 
			</li>
			</li>
			
			<li class="clearfix"></li>
			<li class="btns">
			</li>
			
			<li class="clearfix"></li>
		</ul>
	</form:form>
		<form action="${ctx}/hb/hbJournalList/import"  enctype="multipart/form-data" id="importForm"  method="post">
		<input id="journalV" name="journalV" type="hidden" value="${hbJournal.journalV }"/>
		<input  name="language"  type="hidden" />
		<input id="journalId" name="journalId" type="hidden" value="${empty param.journalId?hbJournalList.journalId:param.journalId }"/>
		<input type="file" style="display:none" name="importFile" id="importFile" onchange="$('#importForm').submit();" >
			<c:if test="${empty param.view }">
				<input type="button"  style="float:right;" value="导入" onclick="$('#importFile').click();">
			</c:if>
		</form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th style="width:100px;">
				<spring:message code="hb_journal_list.pic_path" text="编号"/>
				</th>
				<th style="width:550px;">
				<spring:message code="hb_journal_list.name" text="目录标题"/>
				</th>
				
				
				<th style="width:50px;">
				<spring:message code="hb_journal_list.sort" text="排序"/>
				</th>
				
				<th style="width:100px;">
				
				<spring:message code="sys.operation"/>
				</th>
				
			</tr>
		</thead>
		<tbody>
			<tr v-for="l in list">
				<td>
					<img width="60px" height="60px" v-bind:src="l.picPath | showImg" />
				</td>
				<td >
					<input style="width:550px;height:50px;" v-model="l.name">
				</td>
				<!-- <td >
					<textarea style="height:60px; width:95%;" v-model="l.content"></textarea>
				</td> -->
				<td >
					<input style="width:50px; height:50px;" v-model="l.sort">
				</td>
				<td>			
					<c:if test="${empty param.view }">		
	    				<a href="${ctx}/hb/hbJournalList/delete?id={{l.id}}" onclick="return confirmx('<spring:message code="sys.confirm.delete"/>', this.href)"><spring:message code="sys.delete" text="删除"/></a>
	    				<a href="javascript:return false;" @click="selectPic(l)">选图</a>
	    			</c:if>
				</td>
			</tr>
		</tbody>
	</table>
	<c:if test="${empty param.view }">
	<input id="btnAdd" class="btn btn-primary" type="button" @click="addList()"  value="<spring:message code="sys.add"  />">
	<input id="btnSubmit" class="btn btn-primary" type="button" value="保存" @click="saveList()"/>
	</c:if>
	<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	
	
	<script type="text/javascript">
	
	Vue.filter('showImg', function (string) {
		
		if(string==null||string==''){
			return "${ctxStatic}/images/journal.jpg"
		}else {
			return "/resize_350x350${ctxBase}/userfiles"+string;
		}
		
	});
	var _this = null;
		var app = new Vue({
			el:"body",
			data:{
				list:[]
			},
			watch:{
				
			},
			methods:{
				//选图
				selectPic:function(l){
					top.$.jBox.open("iframe:${ctx}/hb/hbJournal/picList", "期刊图片", 800, 520, {
						ajaxData:{id: l.journalId},buttons:{"确定":"ok","关闭":true}, submit:function(v, h, f){
							if (v=="ok"){
								var a = h.find("iframe")[0].contentWindow.$(".selected_mask_icon");//h.find("iframe").contents();
								var basePath = h.find("iframe")[0].contentWindow.$("#basePath").val();//h.find("iframe").contents();

								var id = a.attr("id");
								l.code=id;
								l.picPath=basePath+"/"+id;
								
							}
							else if (v=="clear"){
								
			                }
						}, loaded:function(h){
							$(".jbox-content", top.document).css("overflow-y","hidden");
						}
					});
				}
				,
				addList:function(){
					var lan = $('input[name="language"]:checked ').val();
					var sort=1;
					if(_this.list.length==0) sort=1;
					else {
						sort = _this.list[_this.list.length-1].sort+1;
					}
					this.list.push({name:'',content:'',language:lan,sort:sort,journalId:$("#journalId").val(),picPath:''});
				},
				saveList:function(){
					var lan = $('input[name="language"]:checked ').val();
					  jQuery.ajax({  
				            type: 'POST',  
				            contentType: 'application/json',  
				            url: '${ctx}/hb/hbJournalList/saveList',  
				            data:JSON.stringify(_this.list),
				            dataType: 'json',  
				            success: function(data){  
				            	var location = window.location+"";
				            	if(location.indexOf("language")>0){
				            		location=location.replace(/language=\d/, "")
				            	}
				            	location+="&language="+lan;
				            	
				            	
				                window.location.href=location;
				                
				            },  
				            error: function(){  
				                alert("error")  
				            }  
				        });
				},
				//页面搜索
				search:function(){
					loading('<spring:message code="sys.loadding"/>');
					var lan = $('input[name="language"]:checked ').val();
					$.getJSON('${ctx}/hb/hbJournalList/listJson?pageSize=1000&orderBy=sort ASC&pageNo=1&language='+lan+'&journalId='+$("#journalId").val(),function(data){
						if(data.list!=null)
						_this.list = data.list;
						else _this.list=[];
						
						closeLoading();
					});
				}
			},
			ready:function(){
				 _this = this;
				this.search();
			}
		});
	
	</script>
	
</body>


</html>