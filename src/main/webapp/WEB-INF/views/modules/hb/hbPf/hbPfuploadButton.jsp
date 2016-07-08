<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link href="${ctxStatic}/stream/stream-v1.css?version=${appVersion}" rel="stylesheet">
<script type="text/javascript" src="${ctxStatic}/stream/stream-v1.js"></script>
</head>
<body>
	<div id="i_select_files">
	</div>
<br>


<script type="text/javascript">
String.prototype.replaceAll = function(reallyDo, replaceWith, ignoreCase) {  
    if (!RegExp.prototype.isPrototypeOf(reallyDo)) {  
        return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi": "g")), replaceWith);  
    } else {  
        return this.replace(reallyDo, replaceWith);  
    }  
}  
var config = {
		browseFileId : "i_select_files", /** 选择文件的ID, 默认: i_select_files */
		browseFileBtn : "<div>请选择文件</div>", /** 显示选择文件的样式, 默认: `<div>请选择文件</div>` */
		dragAndDropArea: "i_select_files", /** 拖拽上传区域，Id（字符类型"i_select_files"）或者DOM对象, 默认: `i_select_files` */
		dragAndDropTips: "<span>把文件(文件夹)拖拽到这里</span>", /** 拖拽提示, 默认: `<span>把文件(文件夹)拖拽到这里</span>` */
		filesQueueId : "i_stream_files_queue", /** 文件上传容器的ID, 默认: i_stream_files_queue */
		filesQueueHeight : 450, /** 文件上传容器的高度（px）, 默认: 450 */
		messagerId : "i_stream_message_container", /** 消息显示容器的ID, 默认: i_stream_message_container */
		multipleFiles: true, /** 多个文件一起上传, 默认: false */
		autoUploading: true, /** 选择文件后是否自动上传, 默认: true */
//		autoRemoveCompleted : true, /** 是否自动删除容器中已上传完毕的文件, 默认: false */
		maxSize: 21474836480, //20G, /** 单个文件的最大大小，默认:2G */
		retryCount : 5, /** HTML5上传失败的重试次数 */
		postVarsPerFile : {pfType:'${param.type}'},
//		swfURL : "/swf/FlashUploader.swf", /** SWF文件的位置 */
		tokenURL : "${ctx}/stream/upload/token?r="+new Date().getTime(), /** 根据文件名、大小等信息获取Token的URI（用于生成断点续传、跨域的令牌） */
//		frmUploadURL : "/fd;", /** Flash上传的URI */
		uploadURL : "${ctx}/stream/upload/stream", /** HTML5上传的URI */
		simLimit: 10000000000, /** 单次最大上传文件个数 */
		extFilters:[], /** 允许的文件扩展名, 默认: [] */
//		onSelect: function(list) {alert('onSelect')}, /** 选择文件后的响应事件 */
//		onMaxSizeExceed: function(size, limited, name) {alert('onMaxSizeExceed')}, /** 文件大小超出的响应事件 */
//		onFileCountExceed: function(selected, limit) {alert('onFileCountExceed')}, /** 文件数量超出的响应事件 */
//		onExtNameMismatch: function(name, filters) {alert('onExtNameMismatch')}, /** 文件的扩展名不匹配的响应事件 */
//		onCancel : function(file) {alert('Canceled:  ' + file.name)}, /** 取消上传文件的响应事件 */
		onComplete: function(file) {}, /** 单个文件上传完毕的响应事件 */
//		onQueueComplete: function() {alert('onQueueComplete')}, /** 所以文件上传完毕的响应事件 */
//		onUploadError: function(status, msg) {alert('onUploadError')} /** 文件上传出错的响应事件 */
	};
	
	var _t = new Stream(config);
	$(function(){
		
	})
</script>
</body>
</html>