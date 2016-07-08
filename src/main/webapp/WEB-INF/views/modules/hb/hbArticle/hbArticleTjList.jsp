<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_article.table.title"/><spring:message code="sys.manager"/></title>
	<meta name="decorator" content="default"/>
		<script type="text/javascript" src="${ctxStatic }/common/site.js"></script>
	<script type="text/javascript">
	var zhLanguage="${langType}";
		$(document).ready(function() {

			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		function apply(url){
			top.$.jBox.confirm(zhLanguage=='zh'?'确认吗？':'Sure?',zhLanguage=='zh'?'SYS prompt':'系统提示',function(v,h,f){
				if(v=='ok'){
					resetTip(); //loading();
					location.href=url;
				}
			},{buttonsFocus:1, closed:function(){
				if (typeof closed == 'function') {
					closed();
				}
			}});
		}
		//语种查看页面
		function addlang_win(code,id){
			//alert(resId+"&&"+resType);alert(resId+"&&"+resType);
			top.$.jBox.open("iframe:${ctx}/hb/hbArticle/list2lang?code="+code+"&id="+id,"${langType eq 'zh'?'查看语种关联文章':'show the related articles'}", 1000, 600, {
				buttons:{"${langType eq 'zh'?'关闭':'close'}":"true"}, 
				submit:function(v, h, f){
				}, loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			});
		}
		//语种选择页面
		function addpf_win(id){
			//alert(resId+"&&"+resType);alert(resId+"&&"+resType);
			top.$.jBox.open("iframe:${ctx}/hb/hbArticle/list2select","${langType eq 'zh'?'选择语种关联文章':'select the related articles'}", 1000, 600, {
				buttons:{ "${langType eq 'zh'?'确定':'Sure'}":"ok","${langType eq 'zh'?'关闭':'close'}":"true"}, 
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
				}
			});
		}
	/**
		给资源添加附件
	**/
	function addpf(resId,refIds){
		$.ajax({ url: "${ctx}/hb/hbArticle/setlang",data:{"resId":resId,"refIds":refIds}, async:false,success: function(){
	      }});
		window.location.reload();
	}
	//推荐
	function recommend(hbArticleId){
		var params={};
		params['menu.id']='${param['menu.id'] }';
		params.id=hbArticleId;
		$.post('${ctx}/hb/hbArticle/recommend',params,function(data){
			resetTip(); //loading();
			$("#searchForm").submit();
		});
	}
	
	//取消推荐
	function canleRecommend(hbArticleId){
		var params={};
		params['menu.id']='${param['menu.id'] }';
		params.id=hbArticleId;
		$.post('${ctx}/hb/hbArticle/canleRecommend',params,function(data){
			resetTip(); //loading();
			$("#searchForm").submit();
		});
	}
	//上移
	function upRecommend(hbArticleId){
		var params={};
		params['menu.id']='${param['menu.id'] }';
		params.id=hbArticleId;
		$.post('${ctx}/hb/hbArticle/upRecommend',params,function(data){
			resetTip(); //loading();
			$("#searchForm").submit();
		});
	}
	//下移
	function downRecommend(hbArticleId){
		var params={};
		params['menu.id']='${param['menu.id'] }';
		params.id=hbArticleId;
		$.post('${ctx}/hb/hbArticle/downRecommend',params,function(data){
			resetTip(); //loading();
			$("#searchForm").submit();
		});
	}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/hb/hbArticle/tjList"><spring:message code="hb_article.table.title"/><spring:message code="sys.list"/></a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="hbArticle" action="${ctx}/hb/hbArticle/tjList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label><spring:message code="hb_article.title" text="标题"/>：</label>
				<form:input path="title" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			
			<li><label><spring:message code="hb_article.subtitle" text="副标题"/>：</label>
				<form:input path="subtitle" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_article.language" text="语种"/>：</label>
				<form:select path="language" >
				<option value="">--${langType eq 'zh'?'请选择':'select' }--</option>
					<form:options items="${fns:getDictList('lang')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="clearfix"></li>
			
			<%-- <li><label><spring:message code="hb_article.label" text="标签"/>：</label>
				<form:input path="label" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li> --%>
			<li><label><spring:message code="hb_article.keyword" text="关键字"/>：</label>
				<form:input path="keyword" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_article.chinese_level" text="汉语等级"/>：</label>
				<form:select path="chineseLevel">
					<option value="">--${langType eq 'zh'?'请选择':'select' }--</option>
					<form:options items="${fns:getDictList('hsk_level')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="clearfix"></li>
			<li class="btns">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="sys.query"/>"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
						<spring:message code="hb_article.title" text="标题"/></th>
				<th>
						<spring:message code="hb_article.language" text="语种"/></th>
				<th>
						<spring:message code="hb_article.other_language" text="其他语种"/></th>
				<th>
						<spring:message code="hb_article.journal_id" text="期"/></th>
				<th>
						<spring:message code="hb_journal.journal_no" text="journalNo"/></th>
				
				<th>
						<spring:message code="hb_article.browse" text="浏览量"/></th>
				
				<shiro:hasPermission name="hb:hbArticle:edit"><th><spring:message code="sys.operation"/></th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="hbArticle">
			<tr>
				<td><a href="${ctx}/hb/hbArticle/view?id=${hbArticle.id}&view=${param.view}">
					${hbArticle.title}
				</a></td>
				<td>
					${fns:getDictLabel(hbArticle.language,'lang','')}
				</td>
				<td>
					<a href="javascript:" onclick="addlang_win('${hbArticle.code}','${hbArticle.id}')">${hbArticle.langs}</a>
				</td>
				<td>
					${hbArticle.journal.name}
				</td>
				<td>
					<c:if test="${ not empty hbArticle.journal.id}">
						${hbArticle.journal.journalYear}（${hbArticle.journal.journalNo}）
					</c:if>
				</td>
				
				<td>
					${hbArticle.browse}
				</td>
				
				<shiro:hasPermission name="hb:hbArticle:edit">
					<td>
	    				<a href="${ctx}/hb/hbArticle/view?id=${hbArticle.id}&view=${param.view}"><spring:message code="sys.view" text="查看"/></a>
	    				<shiro:hasPermission name="hb:hbArticle:recommend">
							<c:if test="${hbArticle.recommend==0  }">
		    					<a href="#" onclick="javascript:recommend('${hbArticle.id}')"><spring:message code="hb_article.RCMD" text="推荐"/></a>
		    				</c:if>
							<c:if test="${hbArticle.recommend!=0  }">
		    					<a href="#" onclick="javascript:canleRecommend('${hbArticle.id}')"><spring:message code="hb_article.Cancel-RCMD" text="取消推荐"/></a>
			    				<a href="#" onclick="javascript:upRecommend('${hbArticle.id}');"><spring:message code="hb_article.up" text="上移"/></a>
			    				<a href="#" onclick="javascript:downRecommend('${hbArticle.id}');"><spring:message code="hb_article.down" text="下移"/></a>
		    				</c:if>
					</shiro:hasPermission>
					</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>