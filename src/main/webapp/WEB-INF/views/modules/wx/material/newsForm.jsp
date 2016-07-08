<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>编辑图文消息</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	
	<script type="text/javascript" src="${ctxStatic }/vue/vue.js"></script>
	<script type="text/javascript" src="${ctxStatic }/vue/resource.js"></script>
	<style type="text/css">
	.clearfix:after {
		content: '\20';
		display: block;
		height: 0;
		clear: both;
		visibility: hidden;
	}
	
	.appmsg_thumb_wrp {
		width:210px;
	    height: 120px;
	    margin:1px auto;
	    overflow: hidden;
	    background-repeat: no-repeat;
	    background-position: center center;
	    background-size: cover;
	}
	.article-title{
		
		margin-left:10px;
		width:210px;
		position:absolute; 
		top: 100px;
		overflow:hidden;
		white-space:nowrap;
		text-overflow:ellipsis;
		display: block;
		
		text-align: left;
		height: 20px;
		background: rgba(0,0,0,0.7);
		line-height: 20px;
		
	}
	.article-title{
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
	 	width: 60%;
	 	line-height: 24px;
	    max-height: 48px;
	    overflow: hidden;
	    margin-top: 14px;
	 }.article-title-d-1 a{
		color: black;
	 }
	 
	.news{
		margin:5px auto;
		width:230px;
		position: relative;//相对定位
		
		
	}
	.appmsg_item {
		float:right;
		margin-top:2px;
	    width: 78px;
	    height: 78px;
	        overflow: hidden;
		    background-repeat: no-repeat;
		    background-position: center center;
		    background-size: cover;
	}
	.duo_dier{
		margin:0 auto;
		padding-top:6px;
		padding-bottom:6px;
		
		width:210px;
		clear: both;
		border: 1px solid #e7e7eb;
		
		border-bottom: none;
		position: relative;
	}
	
	.lastest_add{
		border: 2px dashed #e7e7eb;
		border-top: 1px solid #e7e7eb;
		height: 78px;
		background: url('../../../../static/images/wx_add.png') no-repeat 87.5px 21.5px;
		
	}
	.lastest_add:HOVER{
		cursor: pointer;
	}
	.article_item:HOVER{
		cursor: pointer;
		
	}
	
	.zhaozi-first {
		margin-left:10px;
		width:210px;
		position:absolute; 
		top: 80px;
		overflow:hidden;
		white-space:nowrap;
		text-overflow:ellipsis;
		display: block;
		text-align: left;
		height: 40px;
		background: rgba(0,0,0,0.7);
		line-height: 40px;
		display: none;
	}
	
	
	.zhaozi {
		width:210px;
		position:absolute; 
		top: 50px;
		overflow:hidden;
		white-space:nowrap;
		text-overflow:ellipsis;
		display: block;
		text-align: left;
		height: 40px;
		background: rgba(0,0,0,0.7);
		line-height: 40px;
		display: none;
	}
	.double-border{
		border: 2px solid #45aeea;
	}
	.left_conent {
		overflow:auto;
		margin-top:10px;
		padding:1px 0 0 1px;
		height: 93%;
		}
		
		
		.edit_forms{
				margin: 5px auto;
				height: 100%;
			}
			.edit_form{
				margin: 0 0 0 50px;
				
				height:100%;
				overflow:auto;
			}
			.row{
			height:100%;
			}
	</style>
		
	
</head>
<body>
	<sys:message content="${message}"/>
	<div id="content" class="row-fluid">
	
		<div id="left" class="accordion-group">
			<div class="accordion-heading">
		    	<a class="accordion-toggle">图文列表</a>
		    </div>
			<div  class="left_conent" >
				<div class="news" id="news"><!-- news start -->
					<div id="article_items">
						
			    		<%-- 第一个文章 --%>
			    		<div v-bind:class="{ 'double-border': editIndex==0}" class="article_item duo_first" @click="editItem(0)">
				    		<div class="appmsg_thumb_wrp " style="background-image:url('{{items[0].thumb_url | getImagePoster}}');"></div>
				      		<div class="article-title">{{items[0].title}}</div>
				      		<span class="zhaozi-first"></span>
			    		</div>
						<div class="duo_dier clearfix article_item" v-bind:class="{ 'double-border': $index==editIndex}" @click="editItem($index)" v-if="$index != 0" v-for="item in items">
							<div class="article-title-d-1" >{{item.title}}</div>
			    			<div  class="appmsg_item " style="background-image:url('{{item.thumb_url | getImagePoster}}');"></div>
			    			<span class="zhaozi"></span>
		      			</div>
						
		   			</div>
		   			<div id="wx_add" class="duo_dier clearfix lastest_add" @click="addItem">
				    </div>
		    	</div><!-- news end  -->
			</div>
		</div>
		
		<div id="openClose" class="close">&nbsp;</div>
		
		<div id="right" >
			
			
			
			<div class="row edit_form" >
				<div class="span7"><!-- 左侧 -->
					<div class="control-group">
						<label class="control-label">正文:</label>
						<div class="controls">
						<textarea id="content_11" name="content_11" v-model="item.content"></textarea>					
						</div>
					</div>
				</div>
			
			
				<div class="span5"><!-- 右侧 -->					
						<div class="control-group">
							<label class="control-label">标题:</label>
							<div class="controls">
								<input class="input-xlarge measure-input required" v-model="item.title"/>
								
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">作者:</label>
							<div class="controls">
								<input maxlength="200" class="input-xlarge " v-model="item.author"/>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">摘要:</label>
							<div class="controls">
								<textarea  rows="4" maxlength="200" class="input-xlarge "  v-model="item.digest" ></textarea>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">原文链接:</label>
							<div class="controls">
								<input  maxlength="200" class="input-xlarge "   v-model="item.content_source_url" />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">封面:</label>
							<div class="controls">
								<input  maxlength="200" class="input-xlarge " <%-- ${article.thumb_media_id } --%>/>
								<br><em>大图片建议尺寸：900像素 * 500像素</em>
							</div>
						</div>	
						<div class="control-group">
							<shiro:hasPermission name="wx:material:news:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
						<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
						</div>					
						
					</div>	    	
   				</div>
					    	
   				
   				
   			
   				
		</div><!--、right end -->
	</div>
	
	<script type="text/javascript">include('ckeditor_lib','${ctxStatic}/ckeditor/',['ckeditor.js']);</script>
	<script type="text/javascript">
	

		Vue.filter('getImagePoster', function (string) {
			if(string&&string.startWith('${ctxBase}')){
				return string;
			}else 
				return string ? '${ctxBase}/wx/image?uri='+string:'';
		});
		var app = new Vue({
		  el: '#content',
		  data: {
		    items: [],
		    item:{},
		    media_id:'${param.media_id}',
		    editIndex:0,
		    ck:null
		  },ready:function(){
				  this.$http.get('${ctx}/wx/material/news/info', { media_id: '${param.media_id}' }).then(function(res){
				  this.items=res.data.news_item;
				  this.item=this.items[0];
				  
				  //ckedit事件
				 this.ck=CKEDITOR.replace("content_11",{
					toolbar:'weixin',
				  });
				  CKEDITOR.config.contextPath="${ctx}";
				  
			     this.ck.on('key', this.ckEditChanged);
			     this.ck.on('paste', this.ckEditChanged);
			     this.ck.on('afterCommandExec', this.ckEditChanged);
			  },function(err){
				  alert("接口错误");
			  });
		  },
		  methods:{
			  addItem:function(){
				 if(this.items.length>=10){
					 alert("文章数目不允许超过10个");
					 return;
				 }
				 this.items.push({title:'新增标题',thumb_url:'${ctxStatic}/images/photo.png',content:""});
			  },
			  editItem:function(index){
				  console.log("click item");
				  this.item.content=this.ck.getData();
				  this.item=this.items[index];
				  this.editIndex=index;
				  //this.ck.setData(this.item.conten);

			  },ckEditChanged:function(){
				  console.log("ckedit be changed");
				  this.item.content = this.ck.getData();
			  }
		  }
		});
		app.$watch("item",function(newValue,oldValue){
			console.log("item changed");
			app.ck.setData(newValue.content);
		});
		
		
	
	var registerEvent = function(){
		/**罩子层*/
		$(".duo_first").hover(function(){
			$(".zhaozi-first").css("display","block");
		},function(){
			$(".zhaozi-first").css("display","none");
		});
		
		$(".duo_dier").hover(function(){
			$(this).children(".zhaozi").css("display","block");
		},function(){
			$(this).children(".zhaozi").css("display","none");
		});
		/**罩子层结束*/
		
		
		/*文章点击
		$(".article_item").click(function(){
			$(".article_item").removeClass("double-border");
			$(this).addClass("double-border");
			var index = $(this).attr("index");
			
			$(".edit_form").css("display","none");
			
			$("#article_"+index).css("display","block");
		}); */
		/**文章点击结束*/
	}
	
	//重新加载事件
	/* registerEvent(); */
	/**点击新增**/
	/* $("#wx_add").click(function(){
		if($(".article_item").length>9){
			alert("最多只允许增加十个");
			return;	
		}
		var ele = $('<div class="duo_dier clearfix article_item"><div class="article-title-d-1" >标题</div><div  class="appmsg_item " style="background-image:url(\'../../../../static/images/photo.png\');"></div><span class="zhaozi"></span></div>');
		$("#article_items").append(ele);
		
		
		//重新加载事件
		registerEvent();
	}); */
	
	
	
		/**点击新增结束**/
		
		 
		var leftWidth = 250; // 左侧窗口大小
		var htmlObj = $("html"), mainObj = $("#main");
		var frameObj = $("#left, #openClose");
	
		function wSize(){
			var strs = getWindowSize().toString().split(",");
			htmlObj.css({"overflow-x":"hidden", "overflow-y":"hidden"});
			mainObj.css("width","auto");
			frameObj.height(strs[0]-10);
			var leftWidth = ($("#left").width() < 0 ? 0 : $("#left").width());
			$("#right").width($("#content").width()- leftWidth - $("#openClose").width() -5);
			$("#right").height(strs[0]	);
			CKEDITOR.config.height=strs[0]-130+"px";

		}
		$(function(){
			var strs = getWindowSize().toString().split(",");		
			/* $.each($(".edit_form"),function(i,item){
				eval("content_"+i+"Ckeditor.config.height="+(strs[0]-200)+";");
				//eval("content_"+i+"Ckeditor.config.height=500;");
			}); */
		})
	</script>
	<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>