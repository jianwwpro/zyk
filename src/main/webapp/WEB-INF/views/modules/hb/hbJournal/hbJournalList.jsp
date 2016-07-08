<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_journal.table.title"/><spring:message code="sys.manager"/></title>
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
		
		function journalArticleWin(journalId){
			//var btnName=zhLanguage=='zh'?'关闭':'close';
			if(journalId){
				top.$.jBox.open("iframe:${ctx}/hb/hbArticle/list4Journal?journal.id="+journalId,"${fns:getMessage('hb_journal.magazine_list')}", 1000, 600, {
					buttons:{"${langType eq 'zh'?'关闭':'close'}":"true"},
					submit:function(v, h, f){
						if (v=="ok"){
							var chkItem = top.$("#jbox-iframe").contents().find('input:radio[name=chkItem]:checked');
						}
					}, loaded:function(h){
						$(".jbox-content", top.document).css("overflow-y","hidden");
					}
				});
			}
		}
		
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/hb/hbJournal/list?journalV=${param.journalV }"><spring:message code="hb_journal.journal_list"/></a></li>
		<shiro:hasPermission name="hb:hbJournal:edit"><li><a href="${ctx}/hb/hbJournal/form?journalV=${param.journalV }"><spring:message code="hb_journal.journal_create"/></a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="hbJournal" action="${ctx}/hb/hbJournal/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="journalV" name="journalV" type="hidden" value="${param.journalV}"/>
		<ul class="ul-form">
			<%-- <li><label><spring:message code="hb_journal.del_flag" text="删除标记"/>：</label>
				<form:radiobuttons path="delFlag" items="${fns:getDictList('del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li> --%>
			<%-- <li><label><spring:message code="hb_journal.level" text="优先级"/>：</label>
				<form:input path="level" htmlEscape="false" maxlength="2" class="input-medium"/>
			</li> --%>
			
			<li><label><spring:message code="hb_journal.name" text="期名名称"/>：</label>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_journal.journal_year" text="出版年"/>：</label>
				<form:input path="journalYear" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_journal.journal_month" text="出版月"/>：</label>
				<form:input path="journalMonth" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_journal.journal_day" text="出版日"/>：</label>
				<form:input path="journalDay" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_journal.journal_no" text="卷期号"/>：</label>
				<form:input path="journalNo" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_journal.journal_sum" text="总期数"/>：</label>
				<form:input path="journalSum" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_journal.journal_pages" text="页数"/>：</label>
				<form:input path="journalPages" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label><spring:message code="hb_journal.state" text="状态"/>：</label>
						<form:radiobuttons onclick="$('#searchForm').submit();" path="status"
					 items="${statusArray}" 
					 itemLabel="label" 
					 itemValue="value" htmlEscape="false"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="sys.query"/>"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
						<spring:message code="hb_journal.name" text="期刊名称"/></th>
				<th>
						<spring:message code="hb_journal.journal_no" text="卷期号"/></th>
				<th>
						<spring:message code="hb_journal.journal_sum" text="总期数"/></th>
				<th>
						<spring:message code="hb_journal.journal_v" text="版本"/></th>
				<th>
						<spring:message code="hb_journal.journal_year" text="出版日期" /></th>
				<th>
						<spring:message code="sys.update_date"  text="更新时间"/></th>
				<th>
						<spring:message code="hb_journal.journal_remork" text="备注"/></th>
				<shiro:hasPermission name="hb:hbJournal:edit"><th><spring:message code="hb_journal.operation"/></th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="hbJournal">
			<tr>
				<td>
				<a href="${ctx}/hb/hbJournal/form?id=${hbJournal.id}&view=true">
					${hbJournal.name}
				</a>
				</td>
				<td>
					${hbJournal.journalYear}（${hbJournal.journalNo}）
				</td>
				<td>
					${hbJournal.journalSum}
				</td>
				<td>
				<spring:message code="${fns:getDictLabel(hbJournal.journalV, 'hb_journal_v', '')}"></spring:message>
					
				</td>
				<td>
				<fmt:formatDate value="${hbJournal.publicationDate}" pattern="YYYY-MM-dd"/>	
				</td>
				
				<td>
				<fmt:formatDate value="${hbJournal.updateDate}" pattern="YYYY-MM-dd hh:mm:ss"/>	
				</td>
				<td>
					${hbJournal.remarks}
				</td>
				<td>
				<shiro:hasPermission name="hb:hbJournal:edit">
				<c:if test="${hbJournal.status==1 }">
						<!-- 草稿状态 -->
						<a href="javascript:void(0)" onclick=" apply('${ctx}/hb/hbJournal/apply?id=${hbJournal.id}&apply=1')" ><spring:message code="sys.apply" text="提交"  /></a>
	    				<a href="${ctx}/hb/hbJournal/form?id=${hbJournal.id}"><spring:message code="sys.update" text="修改"/></a>
	    				
	    				<a href="${ctx}/hb/hbJournal/delete?id=${hbJournal.id}" onclick="return confirmx('<spring:message code="sys.confirm.delete"/>', this.href)"><spring:message code="sys.delete" text="删除"/></a>
    				</c:if>
    				
    				<c:if test="${hbJournal.status==3 }">
						<!-- 下架状态 -->
						<a href="${ctx }/hb/hbJournal/up?id=${hbJournal.id}" onclick="return confirmx(zhLanguage=='zh'?'确认上架吗？':'Up sure?', this.href)" ><spring:message code="hb_journal.journal_on_shelf" text="上架"  /></a>
	    				<a href="${ctx}/hb/hbJournal/form?id=${hbJournal.id}"><spring:message code="sys.update" text="修改"/></a>
	    				<a href="${ctx}/hb/hbJournal/delete?id=${hbJournal.id}" onclick="return confirmx('<spring:message code="sys.confirm.delete"/>', this.href)"><spring:message code="sys.delete" text="删除"/></a>
    				</c:if>
    				
    				<c:if test="${hbJournal.status==4 }">
						<!-- 上架状态 -->
						<a href="${ctx }/hb/hbJournal/down?id=${hbJournal.id}" onclick="return confirmx(zhLanguage=='zh'?'确认下架吗？':'Down sure?', this.href)" ><spring:message code="hb_journal.journal_off_shelf" text="上架"  /></a>
	    				
	    				
    				</c:if>
    				
    				<a href="${ctx}/hb/hbJournal/form?id=${hbJournal.id}&view=true"><spring:message code="hb_journal.detail" text="查看"/></a>
    				<a href="#" onclick="javascript:journalArticleWin('${hbJournal.id}');"><spring:message code="hb_journal.articles_list"  text="文章"/></a>
				</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>