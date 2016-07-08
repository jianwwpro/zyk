<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>



<link href="${ctxStatic}/assets/global/plugins/fullcalendar/fullcalendar.min.css" rel="stylesheet"/>

			<div class="row">
				<div class="col-md-12">
					<div class="portlet box green-meadow calendar">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-gift"></i>日历
							</div>
						</div>
						<div class="portlet-body">
							<div class="row">
								<div class="col-md-3 col-sm-12">
									<!-- BEGIN DRAGGABLE EVENTS PORTLET-->
									<h3 class="event-form-title">创建事件</h3>
									<div id="external-events">
										<form class="inline-form">
											<input type="text" value="" class="form-control" placeholder="事件标题..." id="event_title"/><br/>
											<a href="javascript:;" id="event_add" class="btn default">
											添加事件 </a>
										</form>
										<hr/>
										<div id="event_box">
										</div>
										<label for="drop-remove">
										<input type="checkbox" checked="checked" id="drop-remove"/>删除拖走的事件标题 </label>
										<hr class="visible-xs"/>
									</div>
									<!-- END DRAGGABLE EVENTS PORTLET-->
								</div>
								<div class="col-md-9 col-sm-12">
									<div id="calendar" class="has-toolbar">
									</div>
								</div>
							</div>
							<!-- END CALENDAR PORTLET-->
						</div>
					</div>
				</div>
			</div>



<script src="${ctxStatic}/assets/global/plugins/moment.min.js"></script>
<script src="${ctxStatic}/assets/global/plugins/fullcalendar/fullcalendar.min.js"></script>
<script src="${ctxStatic}/assets/global/plugins/fullcalendar/lang/zh-cn.js"></script>

<script src="${ctxStatic}/assets/admin/pages/scripts/calendar.js"></script>
<script>
jQuery(document).ready(function() {       
   Calendar.init();
});
</script>

	