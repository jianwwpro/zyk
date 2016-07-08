<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title><spring:message code="hb_journal.table.title"/><spring:message code="sys.manager"/></title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
	.selected_mask_icon{
		    background-position: 50% 50%;
		    border: 1px solid red;
		    background: rgba(0,0,0,0.7);
		    z-index: 100;
		    height: 100%;
		    width:100%;
		    position: absolute;
		    top:0;
		    left:0;
		    display: block !important;
		}
		.span3{
			position: relative;
		}
	
	</style>
	
	
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	
	<form:form id="searchForm" modelAttribute="hbJournal" action="${ctx}/hb/hbJournal/picList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="journalV" name="journalV" type="hidden" value="${param.journalV}"/>
		
		<input type="hidden" id="basePath" name="basePath" value="${basePath }">
		<form:hidden path="id"/>
	</form:form>
	<sys:message content="${message}"/>
	<div class="container">
	<ul style="list-style: none">
	<c:forEach items="${page.list }" var="pic">
			<li class="span3">
			    <div class="thumbnail news" style="height:300px;">
		    		<div onclick=""  class="appmsg_thumb_wrp" style="text-align:center;vertical-align: middle;">
		    			<img style="display: black;" style="" alt="图片" onerror="" src="/resize_350x350${ctxBase}/userfiles${basePath }/${pic}" onload="">
		    		</div>
		    		<p style="margin-top: 5px;text-align: center;">${pic }</p>
		    		<p style="position:absolute;bottom:0px;">
		    		</p>
		    		<span class="" style="display: none"  id="${pic }" >
						<img alt="" style="position: relative; left: 50%;margin-left: -23px;top: 50%;margin-top: -23px; " src="https://res.wx.qq.com/mpres/htmledition/images/icon/common/icon_card_selected218877.png">
					</span>
			     </div>
			     
			</li>
			</c:forEach>
		</ul>
	
	</div>
	<div class="pagination">${page}</div>
	<script type="text/javascript">
	 $(".thumbnail").click(function(){
		 var len  =  $(".selected_mask_icon").length;
		 console.log(len)
		 if(len == '0'  ){
				$(this).children("span").toggleClass("selected_mask_icon");
			}else  if(len == '1'  ){
				$("span").attr("class"," ")
				$(this).children("span").toggleClass("selected_mask_icon");
			}  
		 console.log($(this).children("span").attr("class"))
		 
	 });
	</script>
</body>
</html>