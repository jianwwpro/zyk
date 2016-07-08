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
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/wx/material/image/list">图片素材</a></li>
		<li>
				<sys:wxckfinder name="添加图片" id="weixin" type="images" uploadPath="/photo" selectMultiple="false" />
				<script type="text/javascript">
				function weixinSelectAction(fileUrl, data, allFiles){
					var url="", files=ckfinderAPI.getSelectedFiles();
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
				
				function weixinPreview(){
					console.log(preview);
				}
				</script>
		</li>
		
	</ul>
	
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
	

		<thead><tr><th>缩略图</th><th>名称</th><th>更新时间</th></tr></thead>
		<tbody>
		<c:forEach items="${yjList.item}" var="item">
	
			<tr>
				<td><img class="thumb" data-toggle="popover" width="50px" height="50px" src="${item.url}" /></td>
				
				<td>${item.name}</td>
				
				<td>
				<sys:formatTimestimp timestimp="${item.update_time }" partten="yyyy-MM-dd HH:mm:ss"></sys:formatTimestimp>
				</td>
				
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript">
	 $('[data-toggle="popover"]').each(function () {
	        var element = $(this);
	        var src = element.attr('src');
	        element.popover({
	        trigger:'manual',
	        placement : 'right', //placement of the popover. also can use top, bottom, left or right
	       // title : '<div style="text-align:center; color:red; text-decoration:underline; font-size:14px;"> Muah ha ha</div>', //this is the top title bar of the popover. add some basic css
	        html: 'true', //needed to show html of course
	        content : '<div id="popOverBox"><img id="xx" src="'+src+'" width="251" height="201" /></div>', //this is the content of the html box. add the image here or anything you want really.
	        animation: false
	    }).on("mouseenter", function () {
	                var _this = this;
	                
	                $(this).popover("show");
	                $(this).siblings(".popover").on("mouseleave", function () {
	                    $(_this).popover('hide');
	                });
	            }).on("mouseleave", function () {
	                var _this = this;
	                setTimeout(function () {
	                    if (!$(".popover:hover").length) {
	                        $(_this).popover("hide")
	                    }
	                }, 100);
	     });
	 });
	</script>
	
</body>

</html>