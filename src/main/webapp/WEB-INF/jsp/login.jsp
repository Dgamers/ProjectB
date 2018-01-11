<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="common.jspf"%>
<style>
body {
	text-align: center;
}
</style>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						function randomNumber(min, max) {
							return Math.floor(Math.random() * (max - min + 1)
									+ min);
						}
						;
						function generteCaptcha() {
							$('#captchaOperation')
									.html(
											[ randomNumber(1, 2), '+',
													randomNumber(1, 2), '=' ]
													.join(' '));
						}
						;

						generteCaptcha();

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
												captcha : {
													validators : {
														callback : {
															message : '	<div class="alert alert-danger" role="alert"  height: 10px; ">验证码错误</div>',
															callback : function(
																	value,
																	validator) {
																var items = $(
																		'#captchaOperation')
																		.html()
																		.split(
																				' '), sum = parseInt(items[0])
																		+ parseInt(items[2]);
																return value == sum;
															}
														}
													}
												}
											}
										});
					})
</script>
<title>登陆</title>
</head>
<body>
	<%@include file="header.jsp"%>
	<h1>登陆</h1>
	<div class="container">
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6">
			<c:if test="${not empty msg}">
			<div class="alert alert-danger" role="alert" >${msg}</div>
			</c:if>
				<form id="login" method="post"
					action="${pageContext.request.contextPath }/user/login">
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon">邮箱</span> <input id="email"
								name="email" type="text" class="form-control" />
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon">密码</span> <input id="password"
								name="password" type="text" class="form-control" />
						</div>
					</div>

					<div class="checkbox" align="left">
						<label> <input type="checkbox" name="autologin" value="true"> 1周内自动登陆
						</label>
					</div>
					<h5 align="left">请将如下计算记过填入文本框内：</h5>
					<div class="form-group form-horizontal">
						<label class="col-lg-3 control-label" id="captchaOperation"
							style="font-size: 20px;"></label>
						<div class="col-lg-9">
							<input type="text" class="form-control" name="captcha" />
						</div>
					</div>
					<br>

					<div class="form-group">
						<input class="btn btn-primary btn-block" type="submit" value="登陆" />
					</div>
				</form>
			</div>
			<div class="col-md-3"></div>
		</div>
	</div>
</body>
</html>