<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_user_info.table.title"/><spring:message code="sys.manager"/></title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('<spring:message code="sys.loadding"/>');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("<spring:message code="sys.input.error"/>");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/hb/hbUserInfo/aboutUserList"><spring:message code="hb_user_info.table.title"/><spring:message code="sys.list"/></a></li>
		<li class="active"><a href="${ctx}/hb/hbUserInfo/form?id=${hbUserInfo.id}"><spring:message code="hb_user_info.table.title"/><shiro:hasPermission name="hb:hbUserInfo:edit">${not empty hbUserInfo.id?sys.update:sys.add}</shiro:hasPermission><shiro:lacksPermission name="hb:hbUserInfo:edit"><spring:message code="sys.view"/></shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="hbUserInfo" action="${ctx}/hb/hbUserInfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<table>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label"><spring:message code="hb_user_info.login_name" text="hb_user_info.login_name"/>：</label>
						<div class="controls">
							<form:input path="loginName" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label"><spring:message code="hb_user_info.school" text="hb_user_info.school"/>：</label>
						<div class="controls">
							<form:input path="school" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="control-group">
						<label class="control-label"><spring:message code="hb_user_info.real_name" text="hb_user_info.real_name"/>：</label>
						<div class="controls">
							<form:input path="realName" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
							<label class="control-label"><spring:message code="hb_user_info.major" text="hb_user_info.major"/>：</label>
						<div class="controls">
							<form:input path="major" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
			</tr>
			<tr><!-- 邮箱  职业 -->
				<td>
					<div class="control-group">
						<label class="control-label"><spring:message code="hb_user_info.email" text="hb_user_info.email"/>：</label>
						<div class="controls">
							<form:input path="email" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label"><spring:message code="hb_user_info.profession" text="hb_user_info.profession"/>：</label>
						<div class="controls">
							<form:input path="profession" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
			</tr>
			<tr><!-- 国籍   联系方式 -->
				<td>
					<div class="control-group">
							<label class="control-label"><spring:message code="hb_user_info.nationality" text="hb_user_info.nationality"/>：</label>
						<div class="controls">
							<form:select path="nationality" class="input-xlarge ">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('hb_country')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label"><spring:message code="hb_user_info.contact_way" text="hb_user_info.contact_way"/>：</label>
						<div class="controls">
							<form:input path="contactWay" htmlEscape="false" maxlength="20" class="input-xlarge "/>
						</div>
					</div>
				</td>
			</tr>
			<tr><!-- 性别，常用地址 -->
				<td>
					<div class="control-group">
						<label class="control-label"><spring:message code="hb_user_info.sex" text="hb_user_info.sex"/>：</label>
						<div class="controls">
							<form:input path="sex" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label"><spring:message code="hb_user_info.address" text="hb_user_info.address"/>：</label>
						<div class="controls">
							<form:input path="address" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
			</tr>
			<tr><!-- 出生日期,facebook -->
				<td>
					<div class="control-group">
						<label class="control-label"><spring:message code="hb_user_info.birthday" text="hb_user_info.birthday"/>：</label>
						<div class="controls">
							<input name="birthday" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
								value="<fmt:formatDate value="${hbUserInfo.birthday}" pattern="yyyy-MM-dd HH:mm:ss"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label"><spring:message code="hb_user_info.Facebook" text="hb_user_info.Facebook"/>：</label>
						<div class="controls">
							<form:input path="facebook" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
			</tr>
			<tr><!-- 学习中文时间,twitter -->
				<td>
					<div class="control-group">
						<label class="control-label"><spring:message code="hb_user_info.chinese_time" text="hb_user_info.chinese_time"/>：</label>
						<div class="controls">
							<form:input path="chineseTime" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label"><spring:message code="hb_user_info.Twitter" text="hb_user_info.Twitter"/>：</label>
						<div class="controls">
							<form:input path="twitter" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
			</tr>
			<tr><!-- hsk等级    instagram-->
				<td>
					<div class="control-group">
						<label class="control-label"><spring:message code="hb_user_info.HSK_LEVE" text="hb_user_info.HSK_LEVE"/>：</label>
						<div class="controls">
							<form:input path="hskLeve" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label"><spring:message code="hb_user_info.instagram" text="hb_user_info.instagram"/>：</label>
						<div class="controls">
							<form:input path="instagram" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
			</tr>
			<tr><!-- 母语  qq -->
				<td>
					<div class="control-group">
						<label class="control-label"><spring:message code="hb_user_info.parent_lang" text="hb_user_info.parent_lang"/>：</label>
						<div class="controls">
							<form:select path="parentLang" class="input-xlarge ">
								<form:option value="" label=""/>
								<form:options items="${fns:getDictList('lang')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</form:select>
						</div>
					</div>		
				</td>
				<td>
					<div class="control-group">
						<label class="control-label"><spring:message code="hb_user_info.qq" text="hb_user_info.qq"/>：</label>
						<div class="controls">
							<div class="controls">
							<form:input path="qq" htmlEscape="false" maxlength="64" class="input-xlarge "/>
							</div>
						</div>
					</div>
				</td>
			</tr>
			<tr><!-- 第一外语  微博 -->
				<td>
					<div class="control-group">
						<label class="control-label"><spring:message code="hb_user_info.first_lang" text="hb_user_info.first_lang"/>：</label>
						<div class="controls">
							<form:select path="firstLang" class="input-xlarge ">
								<form:option value="" label=""/>
								<form:options items="${fns:getDictList('lang')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label"><spring:message code="hb_user_info.wb" text="hb_user_info.wb"/>：</label>
						<div class="controls">
							<form:input path="wb" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
			</tr>
			<tr><!-- 第二外语    微博 -->
				<td>
					<div class="control-group">
						<label class="control-label"><spring:message code="hb_user_info.second_lang" text="hb_user_info.second_lang"/>：</label>
						<div class="controls">
							<form:select path="secondLang" class="input-xlarge ">
								<form:option value="" label=""/>
								<form:options items="${fns:getDictList('lang')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
							</form:select>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label"><spring:message code="hb_user_info.wx" text="hb_user_info.wx"/>：</label>
						<div class="controls">
							<form:input path="wx" htmlEscape="false" maxlength="64" class="input-xlarge "/>
						</div>
					</div>
				</td>
			</tr>
			<tr><!-- 个人说明，头像 -->
				<td>
					<div class="control-group">
						<label class="control-label"><spring:message code="hb_user_info.note" text="hb_user_info.note"/>：</label>
						<div class="controls">
							<form:textarea path="note" htmlEscape="false" maxlength="100" class="input-xlarge "/>
						</div>
					</div>
				</td>
				<td>
					<div class="control-group">
						<label class="control-label"><spring:message code="hb_user_info.head_pic" text="hb_user_info.head_pic"/></label>
						<div class="controls">
							<form:hidden id="headPic" path="headPic" htmlEscape="false" maxlength="255" class="input-xlarge"/>
							<sys:ckfinder input="headPic" type="images" uploadPath="/photo" selectMultiple="false" maxWidth="100" maxHeight="100"/>
						</div>
					</div>
				</td>
			</tr>
		</table>		
		
		
		
		<%-- <div class="control-group">
			<label class="control-label"><spring:message code="hb_user_info.second_lang" text="hb_user_info.second_lang"/>：</label>
			<div class="controls">
				<form:input path="secondLang" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_info.email" text="hb_user_info.email"/>：</label>
			<div class="controls">
				<form:input path="email" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		
		
		
		
		
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_info.major" text="hb_user_info.major"/>：</label>
			<div class="controls">
				<form:input path="major" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_info.profession" text="hb_user_info.profession"/>：</label>
			<div class="controls">
				<form:input path="profession" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		
		
		
		
		
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_info.isopen" text="hb_user_info.isopen"/>：</label>
			<div class="controls">
				<form:input path="isopen" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_info.is_email" text="hb_user_info.is_email"/>：</label>
			<div class="controls">
				<form:input path="isEmail" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_info.is_school" text="hb_user_info.is_school"/>：</label>
			<div class="controls">
				<form:input path="isSchool" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_info.is_note" text="hb_user_info.is_note"/>：</label>
			<div class="controls">
				<form:input path="isNote" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_info.is_gam" text="hb_user_info.is_gam"/>：</label>
			<div class="controls">
				<form:input path="isGam" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_info.is_hsk" text="hb_user_info.is_hsk"/>：</label>
			<div class="controls">
				<form:input path="isHsk" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_info.is_chinese_time" text="hb_user_info.is_chinese_time"/>：</label>
			<div class="controls">
				<form:input path="isChineseTime" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_info.password" text="hb_user_info.password"/>：</label>
			<div class="controls">
				<form:input path="password" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_info.head_pic" text="hb_user_info.head_pic"/>：</label>
			<div class="controls">
				<form:input path="headPic" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_info.is_notice" text="hb_user_info.is_notice"/>：</label>
			<div class="controls">
				<form:input path="isNotice" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_info.user_level" text="hb_user_info.user_level"/>：</label>
			<div class="controls">
				<form:input path="userLevel" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_info.province" text="hb_user_info.province"/>：</label>
			<div class="controls">
				<form:input path="province" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_info.city" text="hb_user_info.city"/>：</label>
			<div class="controls">
				<form:input path="city" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><spring:message code="hb_user_info.area" text="hb_user_info.area"/>：</label>
			<div class="controls">
				<form:input path="area" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label"><spring:message code="sys.remarks" text="sys.remarks"/>：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div> --%>
		<div class="form-actions">
			<%-- <shiro:hasPermission name="hb:hbUserInfo:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="<spring:message code="sys.save"/>"/>&nbsp;</shiro:hasPermission> --%>
			<input id="btnCancel" class="btn" type="button" value="<spring:message code="sys.back"/>" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>