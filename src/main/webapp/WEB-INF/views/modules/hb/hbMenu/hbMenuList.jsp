<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_menu.table.title"/><spring:message code="sys.manager"/></title>
	<style>
.div_parent { width: 510px; }
.div_child { width: 150px; border: 1px solid green; display: inline-block; margin: 1ex; }
</style>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic }/vue/vue.js"></script>
	<script type="text/javascript">
	
	var app = null;
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
		function updateSort() {
			loading('${langType eq "zh"?"正在提交，请稍等":"text is submitting , please wait"}...');
	    	$("#listForm").attr("action", "${ctx}/hb/hbMenu/updateSort");
	    	$("#listForm").submit();
    	}
		//标签管理div
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/hb/hbMenu/"><spring:message code="hb_menu.table.title"/><spring:message code="sys.list"/></a></li>
		<shiro:hasPermission name="hb:hbMenu:edit"><li><a href="${ctx}/hb/hbMenu/form"><spring:message code="hb_menu.table.title"/><spring:message code="sys.add"/></a></li></shiro:hasPermission>
	</ul>
	
	<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="">
	<input type="hidden" id="menuId">
	  <div class="modal-header">
	    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
	    <h3 id="myModalLabel">${langType eq'zh'?'标签管理':'Label Manage' }</h3>
	    <input id="btnAdd" class="btn btn-primary" type="button" @click="addList()"  value="<spring:message code="sys.add"  />">
	    <input id="btnSubmit" class="btn btn-primary" type="button" value="<spring:message code='sys.save' text='sys.save' />" @click="saveList()"/>
	  </div>
	  <div class="div_parent">
			<div class="div_child" v-for="lables in datas" >
				<input style="width:100px;height:30px;" v-model="lables.name" />
				<input type="hidden"  v-model="lables.menuId"/>
				<a href="javascript:void(0);" @click="del(lables)"><i class="icon-cancel"><spring:message code="sys.delete" text="删除"/></i></a>
			</div>
			
	  </div>
	</div>
	<sys:message content="${message}"/>
	<form id="listForm" method="post">
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th><spring:message code="hb_menu.name"/></th>
				<th><spring:message code="hb_menu.ename"/></th>
				<th><spring:message code="hb_menu.sort"/></th>
				<th><spring:message code="hb_menu.href"/></th>
				<shiro:hasPermission name="hb:hbMenu:edit"><th><spring:message code="sys.operation"/></th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="hbMenu">
			<tr>
				<td><a href="${ctx}/hb/hbMenu/form?id=${hbMenu.id}">
					${hbMenu.name}
				</a></td>
				<td>
					${hbMenu.ename}
				</td>
				
				<td>
					<shiro:hasPermission name="hb:hbMenu:edit">
							<input type="hidden" name="ids" value="${hbMenu.id}"/>
							<input name="sorts" type="text" value="${hbMenu.sort}" style="width:50px;margin:0;padding:0;text-align:center;">
						</shiro:hasPermission><shiro:lacksPermission name="hb:hbMenu:edit">
							${hbMenu.sort}
						</shiro:lacksPermission>
				</td>
				<td>
					${hbMenu.href}
				</td>
				<shiro:hasPermission name="hb:hbMenu:edit"><td>
    				<a href="${ctx}/hb/hbMenu/form?id=${hbMenu.id}"><spring:message code='sys.update' text='sys.update' /></a>
     				<a href="javascript:" id="labels_button" @click="openLables('${hbMenu.id}')">${langType eq 'zh'?'标签管理':'Label Manage' }</a>
 					<a href="${ctx}/hb/hbMenu/delete?id=${hbMenu.id}" onclick="return confirmx('<spring:message code="sys.confirm.delete"/>', this.href)"><spring:message code='sys.delete' text='sys.delete' /></a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	</form>
	<shiro:hasPermission name="hb:hbMenu:edit"><div class="form-actions pagination-left">
			<input id="btnSubmit" class="btn btn-primary" type="button" value="<spring:message code='hb_menu.btn_sequence' text='hb_menu.btn_sequence' />" onclick="updateSort();"/>
		</div></shiro:hasPermission>
	<div class="pagination">${page}</div>
<script type="text/javascript">
Array.prototype.remove = function(val) {
	var index = this.indexOf(val);
	if (index > -1) {
	this.splice(index, 1);
	}
	};
app= new Vue({
	el:'body',
	data:{
		datas:[],
	},methods:{
		//添加一个标签
		addList:function(){
			this.datas.push({name:'',menuId:$('#menuId').val()});
		},
		saveList:function(){//保存事件
			var _this=this;
			var old_d = app.datas;
			for(var i=0;i<app.datas.length;i++){
				var name = app.datas[i].name;
				for(var j=i+1;j<app.datas.length;j++){
					var e_name = app.datas[j].name;
					if(e_name.trim()==name.trim()){
						alert("${langType eq 'zh'?'不能保存相同的标签值！':'Same tags can not be save'}");
						return 
					}
				}
				
			}
			  jQuery.ajax({  
		            type: 'POST',  
		            contentType: 'application/json',  
		            url: '${ctx}/hb/hbLable/saveList',  
		            data:JSON.stringify(app.datas),
		            dataType: 'json',  
		            success: function(data){  
		                //alert(data);
		                console.log(data);
		                _this.loadDatas($('#menuId').val());
		            },  
		            error: function(){  
		                alert("error")  
		            }  
		        });
		},
		del:function(p){//删除事件
			var _this = this;
			jQuery.ajax({  
		        type: 'POST',  
		        contentType: 'application/json',  
		        url: '${ctx}/hb/hbLable/del?id='+p.id,  
		        dataType: 'json',  
		        success: function(data){
		        	_this.datas.remove(p);
		        },  
		        error: function(){  
		            alert("error")  
		        }  
		    });
		},
		openLables: function (menuId){//加载显示
			
			$("#menuId").val(menuId);//
			// 正常打开
			this.loadDatas(menuId);
			
		},
		loadDatas:function(menuId){//加载
			loading('Loading...');
			$.post("${ctx}/hb/hbLable/lables",{
				menuId:menuId
				
			},function(data){
				//alert(data);
				app.datas=data;
				var selects = $("#lables").val();
				if(selects!=null&&selects!=''){
					var ss = selects.split(" ");
					for(var i=0;i<app.datas.length;i++){
						var name = app.datas[i].name;
						if(ss.indexOf(name)>-1){
							//app.datas[i].selected==true;
							app.datas[i].checked=true;
							//$("#box_"+app.datas[i].id).attr("checked","checked");
						}
						
					}
				}
				
				$('#myModal').modal({show:true});
				closeLoading();
			},'json');
		}
	},
	ready:function(){
	
	}
});
function del(id){
	
}
</script>
</body>

</html>