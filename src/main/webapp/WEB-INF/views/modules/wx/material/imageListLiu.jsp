<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>图片素材</title>
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
		.span4{
			position: relative;
		}
	
	</style>
	<script type="text/javascript">
				function selectAction(fileUrl, data, allFiles){
					$.post('${ctx}/wx/material/image/save',{url:fileUrl},function(data){
						if(data.success){
							window.location.reload();
						}else {
							alert("出现错误");
						}
					},'json');
					
					
					//weixinPreview();
					//top.$.jBox.close();
				}
				
				function preview(){
					console.log(preview);
				}
				function thumbSelectAction(){}
				function callback(){
					
				}
				function finderOpen(){
					var date = new Date(), year = date.getFullYear(), month = (date.getMonth()+1)>9?date.getMonth()+1:"0"+(date.getMonth()+1);
					var url = "${ctxStatic}/ckfinder/ckfinder.html?type=images&start=images:/photo/"+year+"/"+month+
						"/&action=js&func=selectAction&thumbFunc=thumbSelectAction&cb=callback&dts=0&sm=0";
					windowOpen(url,"文件管理",1000,700);
				}
				</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/wx/material/image/list">图片素材</a></li>
		<li>
		
				
				<a href="javascript:" onclick="finderOpen();" class="btn btn-primary">添加图片</a>
				
				
				<%-- <sys:wxckfinder name="添加图片" id="weixin" type="images" uploadPath="/photo" selectMultiple="false" /> --%>
				
		</li>
		
	</ul>
	
	<sys:message content="${message}"/>
	
		<c:forEach step="1" begin="0" end="2" var="index" >
	
		<ul class="thumbnails span4" style="margin-left: 10px; " >
	
		<c:forEach items="${yjList.item}" var="item" varStatus="status">
			<c:if test="${status.index%3==index }">
					<li class="span4">
						<ul class="thumbnails">
						  <li class="span4">
							    <a href="javascript:return false;"  class="thumbnail ">
								<%-- <img class="thumb" data-toggle="popover" width="50px" height="50px" src="${item.url}" /> --%>
							      <img src="${item.url}" data-src="holder.js/300x200" alt="${item.name }">
								  <div class="" style="display:none " url="${item.url }">
								  	<img alt="" style="position: absolute; left: 50%;margin-left: -23px;top: 50%;margin-top: -23px; " src="https://res.wx.qq.com/mpres/htmledition/images/icon/common/icon_card_selected218877.png">
								  </div>
							    </a>
						  </li>
						</ul>
					</li>
			</c:if>	
		</c:forEach>	
		
		</ul>		
		</c:forEach>
		
	<div class="pagination">${page}</div>
	<script type="text/javascript">
	 $(".thumbnail").click(function(){
		 $(this).children("div").toggleClass("selected_mask_icon");
	 });
	</script>
	
</body>

</html>