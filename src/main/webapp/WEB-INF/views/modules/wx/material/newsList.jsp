<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="weixin" uri="/weixin" %>
<html>
<head>
	<title>关注用户</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
	
	<style type="text/css">
	.clearfix:after {
		content: '\20';
		display: block;
		height: 0;
		clear: both;
		visibility: hidden;
	}
	
	.appmsg_thumb_wrp {
	    height: 160px;
	    overflow: hidden;
	    background-repeat: no-repeat;
	    background-position: center center;
	    background-size: cover;
	}
	.article-title{
		position:absolute; 
		top: 155px;
		overflow:hidden;
		white-space:nowrap;
		text-overflow:ellipsis;
		display: block;
		width: 97%;
		text-align: left;
		height: 30px;
		background: rgba(0,0,0,0.7);
		line-height: 30px;
		
	}
	.article-title a{
		color: white;
	 }
	 .article-title-1 a{
		color: black;
		overflow:hidden;
		white-space:nowrap;
		text-overflow:ellipsis;
		display: block;
		width: 97%;
		
		
		font-weight: 400;
	    font-style: normal;
	    font-size: 16px;
	    line-height: 28px;
	    max-height: 56px;
	    overflow: hidden;
	    word-wrap: break-word;
	    word-break: break-all;
	 }
	 .article-title-d-1{
	 	float: left;
	 	width: 73%;
	 	
	 	line-height: 24px;
	    max-height: 48px;
	    overflow: hidden;
	    margin-top: 14px;
	 }.article-title-d-1 a{
		color: black;
	 }
	 
	.news{
		position: relative;//相对定位
		
	}
	.appmsg_item {
		float:right;
	    width: 78px;
	    height: 78px;
	        overflow: hidden;
    background-repeat: no-repeat;
    background-position: center center;
    background-size: cover;
	}
	.duo_dier{
		clear: both;
		margin-top: 5px;
		border-top: 1px solid #e7e7eb;
	}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/wx/material/news/list">图文素材列表</a></li>
		<li ><a href="${ctx}/wx/material/news/list">新增图文素材</a></li>
	</ul>
	
	<sys:message content="${message}"/>
	
	<div >
	
	<c:forEach step="1" begin="0" end="2" var="index" >
	
	<ul class="thumbnails span4" style="margin-left: 10px; " >
	<c:forEach items="${newsResult.item}" var="items" varStatus="sss">
		
		
		<c:if test="${sss.index%3==index }">
		<li class="span4">
		
		    <div class="thumbnail news">
		    	
		    	<%--多个 --%>
		    	<c:if test="${fn:length(items.content.news_item)>1 }">
		    		<div class="appmsg_info">
		                <em class="appmsg_date"> <sys:formatTimestimp partten="MM月dd日" timestimp="${items.update_time}"></sys:formatTimestimp>
		                 </em>
	            	</div>
		    
		    	
				    <c:forEach items="${items.content.news_item }" var="item" varStatus="status" >
				    	<c:choose>
				    		
				    		<%-- 第一个文章 --%>
				    		<c:when test="${status.index==0 }">
					    		<div>
						    		<div class="appmsg_thumb_wrp" style="background-image:url('${ctxBase }/wx/image?uri=${item.thumb_url}');width:100%;height:160px;"></div>
						      		
						      		<h5 class="article-title"><a href="${item.url}" target="_blank">${item.title }</a></h5>
					    		</div>
				    		</c:when>
				    			
				    		
				    		<c:otherwise>
								<div class="duo_dier clearfix">
									<div class="article-title-d-1" ><a href="${item.url}" target="_blank">${item.title }</a></div>
					    			<div  class="appmsg_item " style="background-image:url('${ctxBase }/wx/image?uri=${item.thumb_url}');height:78px; width:78px;"></div>
				      			</div>
				    		</c:otherwise>
				    	
				    	</c:choose>
				    
				    	
		   			</c:forEach>	
	   			</c:if>
	   			<%--单个 --%>
	   			<c:if test="${fn:length(items.content.news_item)==1 }">
	   				<div class="article-title-1"><a href="${items.content.news_item[0].url}" target="_blank">${items.content.news_item[0].title }</a></div>
	   				<div class="appmsg_info">
		                <em class="appmsg_date"> <sys:formatTimestimp partten="MM月dd日" timestimp="${items.update_time}"></sys:formatTimestimp>
		                  </em>
		            </div>
	   				<div class="appmsg_thumb_wrp" style="background-image:url('${ctxBase }/wx/image?uri=${items.content.news_item[0].thumb_url}');width:100%;height:160px;"></div>
			      	
			      	<p style="margin-top: 5px">${items.content.news_item[0].digest }</p>
	   			</c:if>
	   			<p><a href="${ctx }/wx/material/news/form?media_id=${items.media_id}" class="btn btn-primary">编辑</a> <a href="#" class="btn">删除</a></p>
	   			
		    </div>
		    
	  	</li>
	  	</c:if>
	</c:forEach>
	</ul>
	
	</c:forEach>
	
	
	
	</div>
	
	<div class="pagination">${page}</div>
	<%  
      out=pageContext.pushBody();
    out.clear();  

     %>  
</body>
</html>