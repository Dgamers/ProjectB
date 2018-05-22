<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../common.jspf"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/plugins/bootstrapvalidator/dist/css/bootstrapValidator.css" />
	<script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/bootstrapvalidator/dist/js/bootstrapValidator.js"></script>
<script type="text/javascript">

	$(function() {
		$('#save').click(function() {
			var newemail=$('#email').val();
			var oldemail="${sessionScope.user.email }"
				$.ajax({
					type : 'post',
					url : '${pageContext.request.contextPath }/user/saveuserinfo',
					contentType : "application/x-www-form-urlencoded",
					data : $('#contact').serialize(),
					datatype : 'text',
					error : function(request) {
						$.confirm({
						    title: '信息保存失败',
						    content: '请稍后重试',
						    buttons: {
						        确认: function () {           
						        },
						    }
						});
					},
					success : function(data) {
						if(newemail!=oldemail){
							$.ajax({
								type : 'get',
								url : '${pageContext.request.contextPath }/user/sendchangemail',
								data : {"newemail":newemail},
								datatype : 'text',
								error : function(request) {
									$.confirm({
									    title: '信息保存失败',
									    content: '请稍后重试',
									    buttons: {
									        确认: function () {           
									        },
									    }
									});
								},
								success : function(data) {
									if(data=="success"){
										$.confirm({
										    title: '信息保存成功',
										    content: '您的邮箱信息已改变,请到新绑定邮箱查看验证码并完成验证<br><input type="text" id="checkcode" class="tele form-control" placeholder="请输入验证码">',
										    buttons: {
										        确认: function () {  
										        	var code=$('#checkcode').val();
													$.ajax({
														type : 'get',
														url : '${pageContext.request.contextPath }/user/updateemail',
														data : {"oldemail":oldemail,"newemail":newemail,"checkCode":code},
														datatype : 'text',
														error : function(request) {
															$.confirm({
															    title: '信息保存失败',
															    content: '请稍后重试',
															    buttons: {
															        确认: function () {           
															        },
															    }
															});
														},
														success : function(data) {
															if(data=="success"){
																$.confirm({
																    title: '信息保存成功',
																    content: '邮箱更新成功',
																    buttons: {
																        确认: function () {           
																        },
																    }
																});
															}else{
																$.confirm({
																    title: '信息保存失败',
																    content: '验证码错误或过期',
																    buttons: {
																        确认: function () {           
																        },
																    }
																});
															}
														}
													});
										        },
										    }
										});
									}else{
										$.confirm({
										    title: '信息保存成功',
										    content: '你保存的新邮箱已被绑定，请输入其他邮箱',
										    buttons: {
										        确认: function () {           
										        },
										    }
										});
									}
								}
							});
						}else{
							$.confirm({
							    title: '信息保存成功',
							    content: '若页面显示没有更新请刷新',
							    buttons: {
							        确认: function () {           
							        },
							    }
							});
						}

					}
				});

		})		
	});
	
	$(document).ready(function(){
		$('form')
		.bootstrapValidator(
				{
					message : 'This value is not valid',
					feedbackIcons : {
						valid : 'glyphicon glyphicon-ok',
						invalid : 'glyphicon glyphicon-remove',
						validating : 'glyphicon glyphicon-refresh'
					},
					fields : {
						newemail : {
							validators : {
								notEmpty : {
									message : '<div class="alert alert-danger" role="alert"  height: 10px; ">邮箱不能为空</div>'
								},
								emailAddress : {
									message : '<div class="alert alert-danger" role="alert"  height: 10px; ">邮箱地址格式有误</div>'
								}
							}
						}           
					}
				});	        	
 	})
</script>
<title>个人信息</title>
</head>
<body>

	<%@include file="../header.jsp"%>

<ul class="nav nav-tabs nav-justified">
  <li role="presentation" ><a href="${pageContext.request.contextPath }/user/inituserinfo">基础信息</a></li>
  <li role="presentation" class="active"><a href="${pageContext.request.contextPath }/user/initcontact">联系方式</a></li>
  <li role="presentation"><a href="${pageContext.request.contextPath }/user/inithead">我的头像</a></li>
</ul>
<br><br>
	<div class="container">
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6">
				<form  id="contact" class="form-horizontal" method="post" >
				<input type="hidden" name="id" id="id" value="${sessionScope.user.id }">
				
				<div class="form-group">
						<label for="email" class="col-sm-2 control-label">邮箱</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="newemail" id="email" value="${sessionScope.user.email }" >
						</div>
					</div>

					<div class="form-group">
						<label for="sex" class="col-sm-2 control-label">公开邮箱</label>
						<div class="col-sm-10">
							<label class="radio-inline"> <input type="radio"
								id="emailshow1" name="emailshow" value="1" <c:if test="${sessionScope.user.emailshow eq '1'}"> checked</c:if>> 公开
							</label> <label class="radio-inline"> <input type="radio"
								name="emailshow" id="emailshow2" value="0" <c:if test="${sessionScope.user.emailshow eq '0'}"> checked</c:if>> 保密
							</label> 
						</div>
					</div><br>

					<div class="form-group">
						<label for="phone" class="col-sm-2 control-label">联系电话</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="phone" id="phone" value="${sessionScope.user.phone }">
						</div>
					</div>

					<div class="form-group">
						<label for="sex" class="col-sm-2 control-label">公开电话</label>
						<div class="col-sm-10">
							<label class="radio-inline"> <input type="radio"
								id="phoneshow1" name="phoneshow" value="1" <c:if test="${sessionScope.user.phoneshow eq '1'}"> checked</c:if>> 公开
							</label> <label class="radio-inline"> <input type="radio"
								name="phoneshow" id="phoneshow2" value="0" <c:if test="${sessionScope.user.phoneshow eq '0'}"> checked</c:if>> 保密
							</label>
						</div>
					</div><br>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="button" class="btn btn-default" id="save">保存修改</button>
						</div>
					</div>
				</form>

			</div>
			<div class="col-md-3"></div>
		</div>
	</div>

</body>
</html>