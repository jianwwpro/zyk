<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html>

<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
<meta charset="utf-8"/>
<title>管理后台</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta content="" name="description"/>
<meta content="" name="author"/>
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic }/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic }/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic }/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic }/assets/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic }/assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css"/>
<!-- END GLOBAL MANDATORY STYLES -->
<!-- BEGIN PAGE LEVEL STYLES -->
<link rel="stylesheet" type="text/css" href="${ctxStatic }/assets/global/plugins/select2/select2.css"/>
<!-- END PAGE LEVEL STYLES -->
<!-- BEGIN THEME STYLES -->
<link href="${ctxStatic }/assets/global/css/components.css" id="style_components" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic }/assets/global/css/plugins.css" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic }/assets/admin/layout/css/layout.css" rel="stylesheet" type="text/css"/>
<link id="style_color" href="${ctxStatic }/assets/admin/layout/css/themes/darkblue.css" rel="stylesheet" type="text/css"/>
<link href="${ctxStatic }/assets/admin/layout/css/custom.css" rel="stylesheet" type="text/css"/>
<!-- END THEME STYLES -->
<link rel="shortcut icon" href="favicon.ico"/>
</head>
<!-- END HEAD -->

<body class="page-header-fixed page-quick-sidebar-over-content ">
<!-- BEGIN HEADER -->
<div class="page-header -i navbar navbar-fixed-top">
	<!-- BEGIN HEADER INNER -->
	<div class="page-header-inner">
		<!-- BEGIN LOGO -->
		<div class="page-logo">
			<a href="index.html">
			<%-- <img src="${ctxStatic }/assets/admin/layout/img/logo.png" alt="logo" class="logo-default"/> --%>
			</a>
			<div class="menu-toggler sidebar-toggler">
			</div>
		</div>
		<!-- END LOGO -->
		<!-- BEGIN RESPONSIVE MENU TOGGLER -->
		<a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse">
		</a>
		<!-- END RESPONSIVE MENU TOGGLER -->
		<!-- BEGIN TOP NAVIGATION MENU -->
		<div class="top-menu">
			<ul class="nav navbar-nav pull-right">
				<!-- BEGIN NOTIFICATION DROPDOWN -->
				<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
				<li class="dropdown dropdown-extended dropdown-notification" id="header_notification_bar">
					<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
					<i class="icon-bell"></i>
					<span class="badge badge-default">
					3 </span>
					</a>
					<ul class="dropdown-menu">
						<li class="external">
							<h3><span class="bold">3 条</span> 提醒</h3>
							<a href="extra_profile.html">查看全部</a>
						</li>
						<li>
							<ul class="dropdown-menu-list scroller" style="height: 250px;" data-handle-color="#637283">
								<li>
									<a href="javascript:;">
									<span class="time">刚刚</span>
									<span class="details">
									<span class="label label-sm label-icon label-success">
									<i class="fa fa-plus"></i>
									</span>
									新用户注册. </span>
									</a>
								</li>
								<li>
									<a href="javascript:;">
									<span class="time">3 分钟前</span>
									<span class="details">
									<span class="label label-sm label-icon label-danger">
									<i class="fa fa-bolt"></i>
									</span>
									服务器2过载 </span>
									</a>
								</li>
								<li>
									<a href="javascript:;">
									<span class="time">10 分钟前</span>
									<span class="details">
									<span class="label label-sm label-icon label-warning">
									<i class="fa fa-bell-o"></i>
									</span>
									服务器2无响应. </span>
									</a>
								</li>
								
							</ul>
						</li>
					</ul>
				</li>
				<!-- END NOTIFICATION DROPDOWN -->
				<!-- BEGIN INBOX DROPDOWN -->
				<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
				<li class="dropdown dropdown-extended dropdown-inbox" id="header_inbox_bar">
					<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
					<i class="icon-envelope-open"></i>
					<span class="badge badge-default">
					2 </span>
					</a>
					<ul class="dropdown-menu">
						<li class="external">
							<h3>您有 <span class="bold">2 条</span> 新消息</h3>
							<a href="page_inbox.html">查看全部</a>
						</li>
						<li>
							<ul class="dropdown-menu-list scroller" style="height: 275px;" data-handle-color="#637283">
								<li>
									<a href="inbox.html?a=view">
									<span class="photo">
									<img src="${ctxStatic }/assets/admin/layout3/img/avatar2.jpg" class="img-circle" alt="">
									</span>
									<span class="subject">
									<span class="from">
									张三 </span>
									<span class="time">刚刚 </span>
									</span>
									<span class="message">
									Hi，今天下午的新人培训会请准时参加哦... </span>
									</a>
								</li>
								<li>
									<a href="inbox.html?a=view">
									<span class="photo">
									<img src="${ctxStatic }/assets/admin/layout3/img/avatar3.jpg" class="img-circle" alt="">
									</span>
									<span class="subject">
									<span class="from">
									Richard Doe </span>
									<span class="time">16 分钟前 </span>
									</span>
									<span class="message">
									Vivamus sed congue nibh auctor nibh congue nibh. auctor nibh auctor nibh... </span>
									</a>
								</li>
								
							</ul>
						</li>
					</ul>
				</li>
				<!-- END INBOX DROPDOWN -->
				<!-- BEGIN TODO DROPDOWN -->
				<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
				<li class="dropdown dropdown-extended dropdown-inbox" id="header_task_bar">
					<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
					<i class="icon-rocket"></i>
					<span class="badge badge-default">
					3 </span>
					</a>
					<ul class="dropdown-menu">
						<li class="external">
							<h3><span class="bold">3 条</span> 待办任务</h3>
							<a href="extra_profile.html">查看全部</a>
						</li>
						<li>
							<ul class="dropdown-menu-list scroller" style="height: 275px;" data-handle-color="#637283">
								<li>
									<a href="inbox.html?a=view">
									<span class="photo">
									<img src="${ctxStatic }/assets/admin/layout3/img/avatar2.jpg" class="img-circle" alt="">
									</span>
									<span class="subject">
									<span class="from">
									张三 </span>
									<span class="time">刚刚 </span>
									</span>
									<span class="message">
									【请假】-产假申请</span>
									</a>
								</li>
								<li>
									<a href="inbox.html?a=view">
									<span class="photo">
									<img src="${ctxStatic }/assets/admin/layout3/img/avatar3.jpg" class="img-circle" alt="">
									</span>
									<span class="subject">
									<span class="from">
									Richard Doe </span>
									<span class="time">16 分钟前 </span>
									</span>
									<span class="message">
									【投稿】-我的中国根 </span>
									</a>
								</li>
								<li>
									<a href="inbox.html?a=view">
									<span class="photo">
									<img src="${ctxStatic }/assets/admin/layout3/img/avatar3.jpg" class="img-circle" alt="">
									</span>
									<span class="subject">
									<span class="from">
									Richard Doe </span>
									<span class="time">30 天前</span>
									</span>
									<span class="message">
									【投诉】-关于客服渎职的投诉 </span>
									</a>
								</li>
							</ul>
						</li>
					</ul>
				</li>
				<!-- END TODO DROPDOWN -->
				<!-- BEGIN USER LOGIN DROPDOWN -->
				<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
				<li class="dropdown dropdown-user ">
					<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
					<img alt="" class="img-circle" src="${ctxStatic }/assets/admin/layout/img/avatar3_small.jpg"/>
					<span class="username username-hide-on-mobile">
					王小明 </span>
					<i class="fa fa-angle-down"></i>
					</a>
					<ul class="dropdown-menu dropdown-menu-default">
						<li>
							<a href="extra_profile.html">
							<i class="icon-user"></i> 个人中心 </a>
						</li>
						
						<li>
							<a href="inbox.html">
							<i class="icon-envelope-open"></i> 收件箱 <span class="badge badge-danger">
							3 </span>
							</a>
						</li>
						<li>
							<a href="page_todo.html">
							<i class="icon-rocket"></i> 我的任务 <span class="badge badge-success">
							3 </span>
							</a>
						</li>
						<li class="divider">
						</li>
						
						<li>
							<a href="${ctx }/logout">
							<i class="icon-key"></i> 登出 </a>
						</li>
					</ul>
				</li>
				<!-- END USER LOGIN DROPDOWN -->
				<!-- BEGIN QUICK SIDEBAR TOGGLER -->
				<!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
				<li class="dropdown dropdown-quick-sidebar-toggler">
					<a href="javascript:;" class="dropdown-toggle">
					<i class="glyphicon glyphicon-cog"></i>
					</a>
				</li>
				<!-- END QUICK SIDEBAR TOGGLER -->
			</ul>
		</div>
		<!-- END TOP NAVIGATION MENU -->
	</div>
	<!-- END HEADER INNER -->
</div>
<!-- END HEADER -->
<div class="clearfix">
</div>
<!-- BEGIN CONTAINER -->
<div class="page-container">
	
	<!-- BEGIN SIDEBAR1 -->
	<div class="page-sidebar-wrapper">
		<!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
		<!-- DOC: Change data-auto-speed="200" to adjust the sub menu slide up/down speed -->
		<div class="page-sidebar navbar-collapse collapse">
			<!-- BEGIN SIDEBAR MENU1 -->
			<ul class="page-sidebar-menu" data-slide-speed="200" data-auto-scroll="true" data-auto-scroll="true" data-slide-speed="200">
				<!-- DOC: To remove the search box from the sidebar you just need to completely remove the below "sidebar-search-wrapper" LI element -->
				<li class="sidebar-search-wrapper">
					<!-- BEGIN RESPONSIVE QUICK SEARCH FORM -->
					<!-- DOC: Apply "sidebar-search-bordered" class the below search form to have bordered search box -->
					<!-- DOC: Apply "sidebar-search-bordered sidebar-search-solid" class the below search form to have bordered & solid search box -->
					<form class="sidebar-search sidebar-search-bordered" action="extra_search.html" method="POST">
						<a href="javascript:;" class="remove">
						<i class="icon-close"></i>
						</a>
						<div class="input-group">
							<input type="text" class="form-control" placeholder="Search...">
							<span class="input-group-btn">
							<a href="javascript:;" class="btn submit"><i class="icon-magnifier"></i></a>
							</span>
						</div>
					</form>
					<!-- END RESPONSIVE QUICK SEARCH FORM -->
				</li>
				<li class="start">
					<a class="ajaxify start" href="${ctx }/sys/calendar">
					<i class="fa fa-home"></i>
					<span class="title">
					主面板 </span>
					<span class="selected">
					</span>
					</a>
				</li>
				<li>
					<a href="javascript:;">
						<i class="fa fa-cogs"></i>
						<span class="title">系统管理 </span>
						<span class="arrow"></span>
					</a>
					<ul class="sub-menu">
						<li>
							<a href="javascript:;">
							<i class="icon-settings"></i>系统设置<span class="arrow"></span>
							</a>
							<ul class="sub-menu">
								<li>
									<a class="ajaxify"  href="${ctx }/sys/menu"><i class="icon-power"></i>菜单管理</a>
								</li>
								<li>
									<a class="ajaxify"  href="#"><i class="icon-paper-plane"></i>角色管理</a>
								</li>
								<li>
									<a class="ajaxify"  href="#"><i class="icon-star"></i>字典管理</a>
								</li>
							</ul>
							
						</li>
						
					</ul>
				</li>
				<li>
					<a href="javascript:;">
					<i class="fa fa-cogs"></i>
					<span class="title">
					内容管理 </span>
					<span class="selected">
					</span>
					<span class="arrow">
					</span>
					</a>
					<ul class="sub-menu">
						<li>
							<a class="ajaxify" href="layout_ajax_content_2.html">
							文库管理 </a>
						</li>
						<li>
							<a class="ajaxify" href="layout_ajax_content_3.html">
							期刊管理 </a>
						</li>
						
					</ul>
				</li>
				
			</ul>
			<!-- END SIDEBAR MENU1 -->
		</div>
	</div>
	<!-- END SIDEBAR1 -->
	<!-- BEGIN CONTENT -->
	<div class="page-content-wrapper">
		<div class="page-content">
			
			<div class="page-content-body">
				<!-- HERE WILL BE LOADED AN AJAX CONTENT -->
			</div>
		</div>
		<!-- BEGIN CONTENT -->
	</div>
	<!-- END CONTENT -->
	<!-- BEGIN QUICK SIDEBAR -->
	<a href="javascript:;" class="page-quick-sidebar-toggler"><i class="icon-close"></i></a>
	<div class="page-quick-sidebar-wrapper">
		<div class="page-quick-sidebar">
			<div class="nav-justified">
							<!-- BEGIN STYLE CUSTOMIZER -->
			      <div class="theme-panel hidden-xs hidden-sm">
			        
			        <div class="theme-options" style="display: block;">
			          <div class="theme-option theme-colors clearfix">
			            <span>
			            主题颜色 </span>
			            <ul>
			              <li class="color-default current tooltips" data-style="default" data-container="body" data-original-title="Default">
			              </li>
			              <li class="color-darkblue tooltips" data-style="darkblue" data-container="body" data-original-title="Dark Blue">
			              </li>
			              <li class="color-blue tooltips" data-style="blue" data-container="body" data-original-title="Blue">
			              </li>
			              <li class="color-grey tooltips" data-style="grey" data-container="body" data-original-title="Grey">
			              </li>
			              <li class="color-light tooltips" data-style="light" data-container="body" data-original-title="Light">
			              </li>
			              <li class="color-light2 tooltips" data-style="light2" data-container="body" data-html="true" data-original-title="Light 2">
			              </li>
			            </ul>
			          </div>
			          <div class="theme-option">
			            <span>
			            布局 </span>
			            <select class="layout-option form-control input-sm">
			              <option value="fluid" selected="selected">流式布局</option>
			              <option value="boxed">固定宽度</option>
			            </select>
			          </div>
			          <div class="theme-option">
			            <span>
			            头部 </span>
			            <select class="page-header-option form-control input-sm">
			              <option value="fixed" selected="selected">固定位置</option>
			              <option value="default">默认</option>
			            </select>
			          </div>
			          <div class="theme-option">
			            <span>
			            头部菜单下拉</span>
			            <select class="page-header-top-dropdown-style-option form-control input-sm">
			              <option value="light" selected="selected">亮白</option>
			              <option value="dark">填充色</option>
			            </select>
			          </div>
			          <div class="theme-option">
			            <span>
			            菜单模式</span>
			            <select class="sidebar-option form-control input-sm">
			              <option value="fixed">固定位置</option>
			              <option value="default" selected="selected">默认</option>
			            </select>
			          </div>
			          <div class="theme-option">
			            <span>
			            菜单显示 </span>
			            <select class="sidebar-menu-option form-control input-sm">
			              <option value="accordion" selected="selected">点击显示</option>
			              <option value="hover">滑动显示</option>
			            </select>
			          </div>
			          <div class="theme-option">
			            <span>
			            菜单样式 </span>
			            <select class="sidebar-style-option form-control input-sm">
			              <option value="default" selected="selected">默认</option>
			              <option value="light">高亮</option>
			            </select>
			          </div>
			          <div class="theme-option">
			            <span>
			            菜单位置 </span>
			            <select class="sidebar-pos-option form-control input-sm">
			              <option value="left" selected="selected">左边</option>
			              <option value="right">右边</option>
			            </select>
			          </div>
			          <div class="theme-option">
			            <span>
			            底部 </span>
			            <select class="page-footer-option form-control input-sm">
			              <option value="fixed">固定底部</option>
			              <option value="default" selected="selected">默认</option>
			            </select>
			          </div>
			        </div>
			      </div>
			      <!-- END STYLE CUSTOMIZER -->
				
			</div>
		</div>
	</div>
	<!-- END QUICK SIDEBAR -->
</div>
<!-- END CONTAINER -->
<!-- BEGIN FOOTER -->
<div class="page-footer">
	<div class="page-footer-inner">
		 2016 &copy; By Artron.
	</div>
	<div class="scroll-to-top">
		<i class="icon-arrow-up"></i>
	</div>
</div>
<!-- END FOOTER -->
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<!--[if lt IE 9]>
<script src="${ctxStatic }/assets/global/plugins/respond.min.js"></script>
<script src="${ctxStatic }/assets/global/plugins/excanvas.min.js"></script> 
<![endif]-->
<script src="${ctxStatic }/assets/global/plugins/jquery.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/assets/global/plugins/jquery-migrate.min.js" type="text/javascript"></script>
<!-- IMPORTANT! Load jquery-ui.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
<script src="${ctxStatic }/assets/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/assets/global/plugins/jquery.cokie.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/assets/global/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<script type="text/javascript" src="${ctxStatic }/assets/global/plugins/select2/select2.min.js"></script>
<script src="${ctxStatic }/assets/global/scripts/metronic.js" type="text/javascript"></script>
<script src="${ctxStatic }/assets/admin/layout/scripts/layout.js" type="text/javascript"></script>
<script src="${ctxStatic }/assets/admin/layout/scripts/quick-sidebar.js" type="text/javascript"></script>
<script src="${ctxStatic }/assets/admin/layout/scripts/demo.js" type="text/javascript"></script>
<script>
jQuery(document).ready(function() {    
   Metronic.init(); // init metronic core components
Layout.init(); // init current layout
QuickSidebar.init(); // init quick sidebar
Demo.init(); // init demo features
   $('.page-sidebar .ajaxify.start').click() // load the content for the dashboard page.
});
</script>
<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>