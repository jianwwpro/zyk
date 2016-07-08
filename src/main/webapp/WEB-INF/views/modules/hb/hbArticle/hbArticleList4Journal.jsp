<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_article.table.title"/><spring:message code="sys.manager"/></title>
	<meta name="decorator" content="default"/>
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
		//推荐
		function recommend(hbArticleId){
			var params={};
			params['journal.id']='${param['journal.id'] }';
			params.id=hbArticleId;
			$.post('${ctx}/hb/hbArticle/journalRecommend',params,function(data){
				 window.location.reload();
			});
		}
		
		//取消推荐
		function canleRecommend(hbArticleId){
			var params={};
			params['journal.id']='${param['journal.id'] }';
			params.id=hbArticleId;
			$.post('${ctx}/hb/hbArticle/canleJournalRecommend',params,function(data){
				 window.location.reload();
			});
		}
		//上移
		function upRecommend(hbArticleId){
			var params={};
			params['journal.id']='${param['journal.id'] }';
			params.id=hbArticleId;
			$.post('${ctx}/hb/hbArticle/upJournalRecommend',params,function(data){
				 window.location.reload();
			});
		}
		//下移
		function downRecommend(hbArticleId){
			var params={};
			params['journal.id']='${param['journal.id'] }';
			params.id=hbArticleId;
			$.post('${ctx}/hb/hbArticle/downJournalRecommend',params,function(data){
				 window.location.reload();
			});
		}
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="hbArticle" action="${ctx}/hb/hbArticle/list4Journal" method="get" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="journal.id" name="journal.id" type="hidden" value="${param['journal.id'] }"/>
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
						<spring:message code="hb_article.state" text="状态"/></th>
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
				<td>
					${hbArticle.title}
				</td>
				<td>
					${fns:getDictLabel(hbArticle.language,'lang','')}
				</td>
				
				<td>
					<c:forEach items="${statusArray }" var="dict">
					
						<c:if test="${dict.value==hbArticle.status }">
							${dict.label }
						</c:if>
					</c:forEach>
					
				</td>
				<td>
									<c:if test="${ not empty hbArticle.journal.id}">
				
					${hbArticle.journal.journalYear}（${hbArticle.journal.journalNo}）
					</c:if>
				</td>
				
				<td>
					${hbArticle.browse}
				</td>
				<td>
				
					
				<shiro:hasPermission name="hb:hbArticle:journalRecommend">
						<c:if test="${hbArticle.journalRecommend==0  }">
	    					<a href="#" onclick="javascript:recommend('${hbArticle.id}')"><spring:message code="hb_article.RCMD" text="推荐"/></a>
	    				</c:if>
						<c:if test="${hbArticle.journalRecommend!=0  }">
	    					<a href="#" onclick="javascript:canleRecommend('${hbArticle.id}')"><spring:message code="hb_article.Cancel-RCMD" text="取消推荐"/></a>
		    				<a href="#" onclick="javascript:upRecommend('${hbArticle.id}');"><spring:message code="hb_article.up" text="上移"/></a>
		    				<a href="#" onclick="javascript:downRecommend('${hbArticle.id}');"><spring:message code="hb_article.down" text="下移"/></a>
	    				</c:if>
				</shiro:hasPermission>
    				
    				<a href="${ctx}/hb/hbArticle/info?id=${hbArticle.id}&view=true" target="blank"><spring:message code="sys.view" text="查看"/></a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>