<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../common.jspf"%>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/cropper.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/main.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cropper.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"> 
<style>
</style>

<title>个人信息</title>
</head>
<body>

	<%@include file="../header.jsp"%>

<ul class="nav nav-tabs nav-justified">
  <li role="presentation" ><a href="${pageContext.request.contextPath }/user/inituserinfo">基础信息</a></li>
  <li role="presentation" ><a href="${pageContext.request.contextPath }/user/initcontact">联系方式</a></li>
  <li role="presentation" class="active"><a href="${pageContext.request.contextPath }/user/inithead">我的头像</a></li>
</ul>
 <div class="container" id="crop-avatar">
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6">
				<!-- Current avatar -->
				<div class="avatar-view" title="更改头像">
					<img
						src="${sessionScope.user.picture}"
						alt="Avatar">
				</div>
				<p align="center">点击头像更改,支持jpg,jpeg,png,/gif格式的图片<p>
			</div>
			<div class="col-md-3"></div>
		</div>
   <!-- Cropping modal -->
    <div class="modal fade" id="avatar-modal" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <form class="avatar-form" action="${pageContext.request.contextPath}/user/uploadhead" enctype="multipart/form-data" method="post">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal">&times;</button>
              <h4 class="modal-title" id="avatar-modal-label">更改头像</h4>
            </div>
            <div class="modal-body">
              <div class="avatar-body">

                <!-- Upload image and data -->
                <div class="avatar-upload">
                  <input type="hidden" name="id" id="id" value="${sessionScope.user.id }">
                  <input type="hidden" class="avatar-src" name="avatar_src">
                  <input type="hidden" class="avatar-data" name="avatar_data">
                  <label for="avatarInput">本地上传</label>
                  <input type="file" class="avatar-input" id="avatarInput" name="avatar_file">
                </div>

                <!-- Crop and preview -->
                <div class="row">
                  <div class="col-md-9">
                    <div class="avatar-wrapper"></div>
                  </div>
                  <div class="col-md-3">
                    <div class="avatar-preview preview-lg"></div>
                    <div class="avatar-preview preview-md"></div>
                    <div class="avatar-preview preview-sm"></div>
                  </div>
                </div>

                <div class="row avatar-btns">
                  <div class="col-md-9">
                    <div class="btn-group">
                      <button type="button" class="btn btn-primary" data-method="rotate" data-option="-90" title="逆时针旋转90°">左旋转90°</button>
                      <button type="button" class="btn btn-primary" data-method="rotate" data-option="-15">15°</button>
                      <button type="button" class="btn btn-primary" data-method="rotate" data-option="-30">-30°</button>
                      <button type="button" class="btn btn-primary" data-method="rotate" data-option="-45">-45°</button>
                    </div>
                    <div class="btn-group">
                      <button type="button" class="btn btn-primary" data-method="rotate" data-option="90" title="顺时针旋转90°">右旋转90°</button>
                      <button type="button" class="btn btn-primary" data-method="rotate" data-option="15">15°</button>
                      <button type="button" class="btn btn-primary" data-method="rotate" data-option="30">30°</button>
                      <button type="button" class="btn btn-primary" data-method="rotate" data-option="45">45°</button>
                    </div>
                  </div>
                  <div class="col-md-3">
                    <button type="submit" class="btn btn-primary btn-block avatar-save">提交</button>
                  </div>
                </div>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>

		<!-- Loading state -->
    <div class="loading" aria-label="Loading" role="img" tabindex="-1"></div>
  </div>

</body>
</html>