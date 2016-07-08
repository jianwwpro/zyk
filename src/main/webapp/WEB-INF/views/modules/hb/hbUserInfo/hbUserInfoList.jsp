<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_user_info.table.title"/><spring:message code="sys.manager"/></title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		
	function expExcel(){
		var action=$("#searchForm").attr("action");
		//${ctx}/hb/hbUserInfo/expUser
		$("#searchForm").attr("action","${ctx}/hb/hbUserInfo/expUser");
		$("#searchForm").submit();
		$("#searchForm").attr("action",action);
	}
	function clkTop(obj){
		$("#desc").val("0");
		$("#"+obj).val("1");
		$("#searchForm").submit();
	}
	function clkBottom(obj){
		$("#desc").val("1");
		$("#"+obj).val("1");
		$("#searchForm").submit();
	}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/hb/hbUserInfo/list"><spring:message code="hb_user_info.table.title"/><spring:message code="sys.list"/></a></li>
		<%--  <shiro:hasPermission name="hb:hbUserInfo:edit"><li><a href="${ctx}/hb/hbUserInfo/form"><spring:message code="hb_user_info.table.title"/><spring:message code="sys.add"/></a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="hbUserInfo" action="${ctx}/hb/hbUserInfo/aboutUserList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<!-- 会员等级 -->
			<li><label><spring:message code="hb_user_info.user_level" text="hb_user_info.user_level"/>：</label>
				<form:select path="userLevel" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('hb_user_info_level')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<!-- 会员用户名 -->
			<li><label><spring:message code="hb_user_info.login_name" text="hb_user_info.login_name"/>：</label>
				<form:input path="loginName" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<!-- 会员国别 -->
			<li><label><spring:message code="hb_user_info.nationality" text="hb_user_info.nationality"/>：</label>
				<form:select path="nationality" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('hb_country')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code='sys.query'/>"/></li>
			<li class="btns"><a id="btnExp" href="#" onclick="expExcel();" <%-- href="${ctx}/hb/hbUserInfo/expUser"  --%>class="btn btn-primary"><spring:message code='hb_user_info.export_list'/></a></li>
			<li class="clearfix"></li>
			<!-- 母语语种-->
			<li><label><spring:message code="hb_user_info.parent_lang" text="hb_user_info.parent_lang"/>：</label>
				<form:select path="parentLang" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('lang')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<!-- 学院名称 -->
			<li><label><spring:message code="hb_user_info.school" text="hb_user_info.school"/>：</label>
				<form:input path="school" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<!-- 积分值 -->
			<li><label><spring:message code="hb_user_info.rewards_c" text="hb_user_info.rewards_c"/>：</label>
				<form:input path="rewardsC" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
		</ul>
		<input type="hidden" id="isContributeCount" name="isContributeCount" value=""/>
		<input type="hidden" id="isBlogCount" name="isBlogCount" value=""/>
		<input type="hidden" id="desc" name="desc" value=""/>
		<input type="hidden" id="isRewardsC" name="isRewardsC" value=""/>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>
						<spring:message code="hb_user_info.user_level" text="hb_user_info.user_level"/></th>
				
				<th>
						<spring:message code="hb_user_info.real_name" text="hb_user_info.real_name"/></th>
				
				<th>
						<spring:message code="hb_user_info.parent_lang" text="hb_user_info.parent_lang"/></th>
				
				<th>
						<spring:message code="hb_user_info.rewards_c" text="hb_user_info.rewards_c"/>&nbsp;&nbsp;
						<sup ><a href="#" onclick="clkTop('isRewardsC');">＾</a></sup>
						<sub style="margin-left:-12px;" ><a href="#" onclick="clkBottom('isRewardsC')">ｖ</a></sub>
					</th>
				
				<th>
						<spring:message code="hb_user_info.contribute_count" text="hb_user_info.contribute_count"/>&nbsp;&nbsp;
						<sup ><a href="#" onclick="clkTop('isContributeCount');">＾</a></sup>
						<sub style="margin-left:-12px;" ><a href="#" onclick="clkBottom('isContributeCount')">ｖ</a></sub>
					</th>
				<th>
						<spring:message code="hb_user_info.blog_count" text="hb_user_info.blog_count"/>&nbsp;&nbsp;
						<sup ><a href="#" onclick="clkTop('isBlogCount');">＾</a></sup>
						<sub style="margin-left:-12px;" ><a href="#" onclick="clkBottom('isBlogCount')">ｖ</a></sub>
					</th>
				
				<th>
						<spring:message code="hb_user_info.login_time" text="hb_user_info.login_time"/></th>
				
				<%-- <th>
						<spring:message code="hb_user_info.id" text="sys.id"/></th>
				<th>
						<spring:message code="hb_user_info.nationality" text="hb_user_info.nationality"/></th>
				<th>
						<spring:message code="hb_user_info.login_name" text="hb_user_info.login_name"/></th>
				<th>
						<spring:message code="hb_user_info.real_name" text="hb_user_info.real_name"/></th>
				<th>
						<spring:message code="hb_user_info.parent_lang" text="hb_user_info.parent_lang"/></th>
				<th>
						<spring:message code="hb_user_info.second_lang" text="hb_user_info.second_lang"/></th>
				<th>
						<spring:message code="sys.update_date" text="sys.update_date"/></th>
				<th>
						<spring:message code="hb_user_info.email" text="hb_user_info.email"/></th>
				<th>
						<spring:message code="hb_user_info.sex" text="hb_user_info.sex"/></th>
				<th>
						<spring:message code="hb_user_info.birthday" text="hb_user_info.birthday"/></th>
				<th>
						<spring:message code="hb_user_info.chinese_time" text="hb_user_info.chinese_time"/></th>
				<th>
						<spring:message code="hb_user_info.hsk_leve" text="hb_user_info.hsk_leve"/></th>
				<th>
						<spring:message code="hb_user_info.note" text="hb_user_info.note"/></th>
				<th>
						<spring:message code="hb_user_info.school" text="hb_user_info.school"/></th>
				<th>
						<spring:message code="hb_user_info.major" text="hb_user_info.major"/></th>
				<th>
						<spring:message code="hb_user_info.profession" text="hb_user_info.profession"/></th>
				<th>
						<spring:message code="hb_user_info.contact_way" text="hb_user_info.contact_way"/></th>
				<th>
						<spring:message code="hb_user_info.facebook" text="hb_user_info.facebook"/></th>
				<th>
						<spring:message code="hb_user_info.twitter" text="hb_user_info.twitter"/></th>
				<th>
						<spring:message code="hb_user_info.wb" text="hb_user_info.wb"/></th>
				<th>
						<spring:message code="hb_user_info.wx" text="hb_user_info.wx"/></th>
				<th>
						<spring:message code="hb_user_info.isopen" text="hb_user_info.isopen"/></th>
				<th>
						<spring:message code="hb_user_info.is_email" text="hb_user_info.is_email"/></th>
				<th>
						<spring:message code="hb_user_info.is_school" text="hb_user_info.is_school"/></th>
				<th>
						<spring:message code="hb_user_info.is_note" text="hb_user_info.is_note"/></th>
				<th>
						<spring:message code="hb_user_info.is_gam" text="hb_user_info.is_gam"/></th>
				<th>
						<spring:message code="hb_user_info.is_hsk" text="hb_user_info.is_hsk"/></th>
				<th>
						<spring:message code="hb_user_info.is_chinese_time" text="hb_user_info.is_chinese_time"/></th>
				<th>
						<spring:message code="hb_user_info.rewards_c" text="hb_user_info.rewards_c"/></th>
				<th>
						<spring:message code="hb_user_info.rewards_u" text="hb_user_info.rewards_u"/></th>
				<th>
						<spring:message code="hb_user_info.notice" text="hb_user_info.notice"/></th>
				<th>
						<spring:message code="hb_user_info.head_pic" text="hb_user_info.head_pic"/></th>
				<th>
						<spring:message code="hb_user_info.is_notice" text="hb_user_info.is_notice"/></th>
				<th>
						<spring:message code="hb_user_info.user_level" text="hb_user_info.user_level"/></th>
				<th>
						<spring:message code="hb_user_info.province" text="hb_user_info.province"/></th>
				<th>
						<spring:message code="hb_user_info.city" text="hb_user_info.city"/></th>
				<th>
						<spring:message code="hb_user_info.area" text="hb_user_info.area"/></th>
				<th>
						<spring:message code="hb_user_info.address" text="hb_user_info.address"/></th>
				<th>
						<spring:message code="hb_user_info.read_time" text="hb_user_info.read_time"/></th>
				<th>
						<spring:message code="hb_user_info.remarks" text="sys.remarks"/></th> --%>
				<shiro:hasPermission name="hb:hbUserInfo:edit"><th><spring:message code="sys.operation"/></th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="hbUserInfo">
			<tr>
				<td>
					${hbUserInfo.userLevel}
				</td>
				<td>
					${hbUserInfo.realName}
				</td>
				<td>
					${fns:getDictLabel(hbUserInfo.parentLang, 'lang', '')}
				</td>
				<td>
					${hbUserInfo.rewardsC}
				</td>
				<td>
					${hbUserInfo.contributeCount }
				</td>
				<td>
					${hbUserInfo.blogCount }
				</td>
				<td>
					<fmt:formatDate value="${hbUserInfo.loginTime}" pattern="yyyy-MM-dd hh:ss:mm"/>
					
				</td>
				<%-- <td><a href="${ctx}/hb/hbUserInfo/form?id=${hbUserInfo.id}">
					${hbUserInfo.id}
				</a></td>
				<td>
					${fns:getDictLabel(hbUserInfo.nationality, 'hb_country', '')}
				</td>
				<td>
					${hbUserInfo.loginName}
				</td>
				<td>
					${hbUserInfo.realName}
				</td>
				<td>
					${fns:getDictLabel(hbUserInfo.parentLang, 'lang', '')}
				</td>
				<td>
					${hbUserInfo.secondLang}
				</td>
				<td>
					${hbUserInfo.updateDate}
				</td>
				<td>
					${hbUserInfo.email}
				</td>
				<td>
					${hbUserInfo.sex}
				</td>
				<td>
					<fmt:formatDate value="${hbUserInfo.birthday}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${hbUserInfo.chineseTime}
				</td>
				<td>
					${hbUserInfo.hskLeve}
				</td>
				<td>
					${hbUserInfo.note}
				</td>
				<td>
					${hbUserInfo.school}
				</td>
				<td>
					${hbUserInfo.major}
				</td>
				<td>
					${hbUserInfo.profession}
				</td>
				<td>
					${hbUserInfo.contactWay}
				</td>
				<td>
					${hbUserInfo.facebook}
				</td>
				<td>
					${hbUserInfo.twitter}
				</td>
				<td>
					${hbUserInfo.wb}
				</td>
				<td>
					${hbUserInfo.wx}
				</td>
				<td>
					${hbUserInfo.isopen}
				</td>
				<td>
					${hbUserInfo.isEmail}
				</td>
				<td>
					${hbUserInfo.isSchool}
				</td>
				<td>
					${hbUserInfo.isNote}
				</td>
				<td>
					${hbUserInfo.isGam}
				</td>
				<td>
					${hbUserInfo.isHsk}
				</td>
				<td>
					${hbUserInfo.isChineseTime}
				</td>
				<td>
					${hbUserInfo.rewardsC}
				</td>
				<td>
					${hbUserInfo.rewardsU}
				</td>
				<td>
					${hbUserInfo.notice}
				</td>
				<td>
					${hbUserInfo.headPic}
				</td>
				<td>
					${hbUserInfo.isNotice}
				</td>
				<td>
					${hbUserInfo.userLevel}
				</td>
				<td>
					${hbUserInfo.province}
				</td>
				<td>
					${hbUserInfo.city}
				</td>
				<td>
					${hbUserInfo.area}
				</td>
				<td>
					${hbUserInfo.address}
				</td>
				<td>
					${hbUserInfo.readTime}
				</td>
				<td>
					${hbUserInfo.remarks}
				</td> --%>
				<shiro:hasPermission name="hb:hbUserInfo:edit"><td>
    				<a href="${ctx}/hb/hbUserInfo/form?id=${hbUserInfo.id}"><spring:message code="sys.view" text="查看详细"/></a>
    				<a href="${ctx}/hb/hbUserInfo/updateNotice?id=${hbUserInfo.id}&isNotice=<c:choose><c:when test="${empty hbUserInfo.isNotice || hbUserInfo.isNotice eq '0'}">1</c:when><c:otherwise>0</c:otherwise></c:choose>"><c:choose><c:when test="${empty hbUserInfo.isNotice || hbUserInfo.isNotice eq '0'}"><spring:message code="hb_user_info.ban_notice"/></c:when><c:otherwise><spring:message code="hb_user_info.allow_notice"/></c:otherwise></c:choose></a>
    				<a href="${ctx}/hb/hbUserInfo/delete?id=${hbUserInfo.id}" onclick="return confirmx('<spring:message code="sys.confirm.delete"/>', this.href)"><spring:message code="sys.delete" text="删除"/></a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>