<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../common.jspf"%>
    <link rel="stylesheet"
	href="${pageContext.request.contextPath}/plugins/boostrapselect/css/bootstrap-select.min.css" />	
    <script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/boostrapselect/js/bootstrap-select.js"></script>
	<script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/boostrapselect/i18n/defaults-ar_AR.js"></script>
	<link rel="stylesheet"
	href="${pageContext.request.contextPath}/plugins/fileinput/css/fileinput.min.css" />	
	<script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/fileinput/js/fileinput.min.js"></script>
	<script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/fileinput/js/locales/zh.js"></script>
	
<script type="text/javascript">
$(function(){ 
	
$('#image').fileinput({
	language: 'zh',
	uploadUrl: "${pageContext.request.contextPath}/animation/uploadpicture",
	maxFileCount:1,
	dropZoneEnabled: false,
	allowedFileExtensions: ['jpg', 'gif', 'png'],
	uploadAsync: true,
    showUpload : true, //是否显示上传按钮,跟随文本框的那个
    showRemove : false, //显示移除按钮,跟随文本框的那个
    showCaption : false,//是否显示标题,就是那个文本框
});
$("#image").on("fileuploaded", function(event, data, previewId, index) {
	var paddress=data.response.message;
	$('#picture').val(paddress)
	});
	
$('#image').on('filesuccessremove', function(event, id) {
	$('#picture').val("")
});

$('#video').fileinput({
	language: 'zh',
	uploadUrl: "${pageContext.request.contextPath}/animation/uploadanimation",
	maxFileCount:1,
	dropZoneEnabled: false,
	allowedFileExtensions: ['swf'],
	showPreview :false,
	uploadAsync: true,
    showUpload : true, //是否显示上传按钮,跟随文本框的那个
    showRemove : true, //显示移除按钮,跟随文本框的那个
    showCaption : true,//是否显示标题,就是那个文本框
});
$("#video").on("fileuploaded", function(event, data, previewId, index) {
	var vaddress=data.response.message;
	$('#address').val(vaddress)
	});
	
$('#video').on('filesuccessremove', function(event, id) {
	$('#address').val("")
});
	
$('#save').click(function() {
	var message="";
	var issue=0;
	if($('#title').val()==""){
		message=message+"动画标题不能为空<br>";
		issue=1;
		}
	if($('#category').val()==0){
		message=message+"动画类别不能为空<br>";
		issue=1;
	}
	if($('#picture').val()==""){
		message=message+"动画封面没有上传<br>";	
		issue=1;
	}
	if($('#address').val()==""){
		message=message+"动画资源没有上传<br>";	
		issue=1;
	}

	if(issue==1){
		$.confirm({
		    title: '提交失败',
		    content: message,
		    buttons: {
		        确认: function () {           
		        },
		    }
		});
	}else{
        $('#savevideo').submit();
	}
		
});
});
	


</script>
<title>上传动画</title>
</head>
<body>


	<%@include file="../header.jsp"%>

	<div class="container">
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6">
					<h2 align="center">投稿</h2>
					<br>
				<form  id="savevideo" class="form-horizontal" method="post" action="${pageContext.request.contextPath }/animation/saveanimation">
					<div class="form-group">
						<label for="title" class="col-sm-2 control-label">动画标题</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="title" id="title" >
						</div>
					</div>

					<div class="form-group">
					<label for="category" class="col-sm-2 control-label">动画类别</label>
						<div class="col-sm-10">
							<select id="category" name="category"
								class="selectpicker show-tick form-control" 
								data-live-search="false">
								<option value="0">请选择一项类别</option>
								<c:forEach items="${categorys }" var="category">
								<option value="${category.id}">${category.name}</option>
								</c:forEach>
							</select>
						</div>
					</div>


					<div class="form-group">
						<label class="col-sm-2 control-label">动画封面</label>
						<div class="col-sm-10">
							<input id="image" type="file" name="image"  />
							<input id="picture" type="hidden" name="picture"/>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label">动画资源</label>
						<div class="col-sm-10">
							<input id="video" type="file" name="video" /> 
							<input id="address" type="hidden" name="address"/>
						</div>
					</div>

					<div class="form-group">
						<label for="content" class="col-sm-2 control-label">动画简介</label>
						<div class="col-sm-10">
							<textarea class="form-control" rows="4" form="savevideo"
								name="content" id="content" ></textarea>
						</div>
					</div>

					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="button" class="btn btn-default" id="save">提交</button>
						</div>
					</div>
				</form>

			</div>
			<div class="col-md-3"></div>
		</div>
	</div>

</body>
</html>