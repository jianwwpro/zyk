<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<link rel="stylesheet" type="text/css" href="${ctxStatic}/assets/global/plugins/bootstrap-gtreetable/bootstrap-gtreetable.min.css"/>
${list }
<div class="row">
				<div class="col-md-12">
					<!-- BEGIN PORTLET-->
					<div class="portlet light bordered">
						<div class="portlet-title">
							<div class="caption font-purple-plum">
								<i class="icon-speech font-purple-plum"></i>
								<span class="caption-subject bold uppercase"> 菜单列表</span>
								<span class="caption-helper"></span>
							</div>
							<div class="actions">
								<a href="javascript:;" class="btn btn-circle red-sunglo btn-sm">
								<i class="fa fa-plus"></i> Add </a>
								<a class="btn btn-circle btn-icon-only btn-default fullscreen" href="javascript:;" data-original-title="" title="">
								</a>
							</div>
						</div>
						<div class="portlet-body">
							<table class="table table-hover table-light gtreetable" id="gtreetable">
								<thead>
								<tr>
									<th>
										 
									</th>
								</tr>
								</thead>
							</table>
						</div>
					</div>
					<!-- END PORTLET-->
				</div>
			</div>
			<!-- END PAGE CONTENT-->



<script src="${ctxStatic}/assets/admin/pages/scripts/table-tree.js"></script>
