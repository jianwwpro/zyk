<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>自定义菜单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
	
	<style type="text/css">
		.news_add{
			background: url('../../../static/images/wx_add.png') no-repeat 182px 82px;
			min-height:200px;
			width:400px;
			border: 2px dashed #e7e7eb;
			cursor: pointer;
		}
	
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/wx/wxWeixin/">新建群发</a></li>
	</ul>
	</br>
	
	<form id="inputForm"  action="${ctx}/wx/wxWeixin/save" method="post" style="margin: 20px 0 0 30px" >
		
		<div class="tabbable tabs-left container">
		  <ul class="nav nav-tabs">
		     <li class="active">
				    <a href="#news" data-toggle="tab">图文消息</a>
			  </li>
			   <li >
			    <a href="#text" data-toggle="tab">文字</a>
			  </li>
			   <li >
			    <a href="#image" data-toggle="tab">图片</a>
			  </li>
		  </ul>
		  <div class="tab-content">
	    	<div class="tab-pane active" id="news">
				<div class="span4 news_add">
					
				</div>
            </div>
            <div class="tab-pane" id="text">
				<div class="span4">
              		<textarea class="input-xxlarge" rows="8"></textarea>					
				</div>
            </div>
            <div class="tab-pane" id="image">
              <p>What up girl, this is Section C.</p>
            </div>

		  </div>
		</div>
	</form>	
	
	<script type="text/javascript">
	$(".news_add").click(function(){
		var url = '${ctx}/wx/material/news/list?to=Select';
		top.$.jBox("iframe:"+url, {title: "选择图片", width: 1000, height: 500, buttons:{'关闭': true,'确定':'ok'},
			submit:function(v, h, f){
				if(v=='ok'){
    				var imgs = top.$("#jbox-iframe").contents().find(".selected_mask_icon");
    				$.each(imgs,function(i,item){
    					editor.insertHtml('<img src="'+$(item).attr("url")+'"/>');
    				})
				}
			}
		
		});
	});	
	</script>
</body>
</html>