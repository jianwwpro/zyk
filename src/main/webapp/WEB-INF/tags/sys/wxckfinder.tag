<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="输入框"%>
<%@ attribute name="name" type="java.lang.String" required="false" description="名称"%>

<%@ attribute name="type" type="java.lang.String" required="true" description="files、images、flash、thumb"%>
<%@ attribute name="uploadPath" type="java.lang.String" required="true" description="打开文件管理的上传路径"%>
<%@ attribute name="selectMultiple" type="java.lang.Boolean" required="false" description="是否允许多选"%>
<a href="javascript:" onclick="${id}FinderOpen();" class="btn btn-primary">
<c:choose>
<c:when test="${not empty name }">
${name }
</c:when>
<c:otherwise>
${selectMultiple?'添加':'选择' }
</c:otherwise>
</c:choose>
</a>
<script type="text/javascript">
	function ${id}FinderOpen(){//<c:if test="${type eq 'thumb'}"><c:set var="ctype" value="images"/></c:if><c:if test="${type ne 'thumb'}"><c:set var="ctype" value="${type}"/></c:if>
		var date = new Date(), year = date.getFullYear(), month = (date.getMonth()+1)>9?date.getMonth()+1:"0"+(date.getMonth()+1);
		var url = "${ctxStatic}/ckfinder/ckfinder.html?type=${ctype}&start=${ctype}:${uploadPath}/"+year+"/"+month+
			"/&action=js&func=${id}SelectAction&thumbFunc=${id}ThumbSelectAction&cb=${id}Callback&dts=${type eq 'thumb'?'1':'0'}&sm=${selectMultiple?1:0}";
		windowOpen(url,"文件管理",1000,700);
		//top.$.jBox("iframe:"+url+"&pwMf=1", {title: "文件管理", width: 1000, height: 500, buttons:{'关闭': true}});
	}
	function ${id}SelectAction(fileUrl, data, allFiles){		
		var url="", files=ckfinderAPI.getSelectedFiles();
		for(var i=0; i<files.length; i++){//<c:if test="${type eq 'thumb'}">
			url += files[i].getThumbnailUrl();//</c:if><c:if test="${type ne 'thumb'}">
			url += files[i].getUrl();//</c:if>
			if (i<files.length-1) url+="|";
		}//<c:if test="${selectMultiple}">
		$("#${id}").val($("#${id}").val()+($("#${id}").val(url)==""?url:"|"+url));//</c:if><c:if test="${!selectMultiple}">
		$("#${id}").val(url);//</c:if>
		${id}Preview();
		//top.$.jBox.close();
	}
	function ${id}ThumbSelectAction(fileUrl, data, allFiles){
		alert("ThumbSelectAction");
		var url="", files=ckfinderAPI.getSelectedFiles();
		for(var i=0; i<files.length; i++){
			url += files[i].getThumbnailUrl();
			if (i<files.length-1) url+="|";
		}//<c:if test="${selectMultiple}">
		$("#${id}").val($("#${id}").val()+($("#${id}").val(url)==""?url:"|"+url));//</c:if><c:if test="${!selectMultiple}">
		$("#${id}").val(url);//</c:if>
		${id}Preview();
		//top.$.jBox.close();
	}
	function ${id}Callback(api){
		ckfinderAPI = api;
	}
	function ${id}Del(obj){
		var url = $(obj).prev().attr("url");
		$("#${id}").val($("#${id}").val().replace("|"+url,"","").replace(url+"|","","").replace(url,"",""));
		${id}Preview();
	}
	function ${id}DelAll(){
		$("#${id}").val("");
		${id}Preview();
	}
	function ${id}Preview(){
		var li, urls = $("#${id}").val().split("|");
		$("#${id}Preview").children().remove();
		for (var i=0; i<urls.length; i++){
			if (urls[i]!=""){//<c:if test="${type eq 'thumb' || type eq 'images'}">
				li = "<li><img src=\""+urls[i]+"\" url=\""+urls[i]+"\" style=\"max-width:${empty maxWidth ? 200 : maxWidth}px;max-height:${empty maxHeight ? 200 : maxHeight}px;_height:${empty maxHeight ? 200 : maxHeight}px;border:0;padding:3px;\">";//</c:if><c:if test="${type ne 'thumb' && type ne 'images'}">
				li = "<li><a href=\""+urls[i]+"\" url=\""+urls[i]+"\" target=\"_blank\">"+decodeURIComponent(urls[i].substring(urls[i].lastIndexOf("/")+1))+"</a>";//</c:if>
				li += "&nbsp;&nbsp;<c:if test="${!readonly}"><a href=\"javascript:\" onclick=\"${id}Del(this);\">×</a></c:if></li>";
				$("#${id}Preview").append(li);
			}
		}
		if ($("#${id}Preview").text() == ""){
			$("#${id}Preview").html("<li style='list-style:none;padding-top:5px;'>无</li>");
		}
	}
	${id}Preview();
</script>