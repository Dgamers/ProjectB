<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../common.jspf"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/plugins/bootstrapvalidator/dist/css/bootstrapValidator.css" />
	<script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/bootstrapvalidator/dist/js/bootstrapValidator.js"></script>
<style>
body {
	text-align: center;
}
</style>
<script type="text/javascript">
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
				                name: {
				                    validators: {
				                        notEmpty: {
				                            message: '<div class="alert alert-danger" role="alert"  height: 10px; ">用户名不能为空</div>'
				                        },
				                        stringLength: {
				                            /*长度提示*/
				                            min: 6,
				                            max: 30,
				                            message: '<div class="alert alert-danger" role="alert"  height: 10px; ">用户名长度必须在6到30之间</div>'
				                        }
				                    }
				                },
				                password: {
				                    validators: {
				                        notEmpty: {
				                            message: '<div class="alert alert-danger" role="alert"  height: 10px; ">密码不能为空</div>'
				                        },
				                        stringLength: {
				                            /*长度提示*/
				                            min: 6,
				                            max: 30,
				                            message: '<div class="alert alert-danger" role="alert"  height: 10px; ">密码长度必须在6到30之间</div>'
				                        },
				                        regexp: {
				                            regexp: /^[a-zA-Z0-9_\.]+$/,
				                            message: '<div class="alert alert-danger" role="alert"  height: 10px; ">密码由数字字母下划线和.组成</div>'
				                        },
				                        different:{
				                        	field:'name',
				                        	message:'<div class="alert alert-danger" role="alert"  height: 10px; ">密码不能与用户名相同</div>'
				                        }
				                    }
				                },
				                repassword: {
				                    validators: {
				                        identical: {//相同
				                            field: 'password',
				                            message: '<div class="alert alert-danger" role="alert"  height: 10px; ">两次密码不一致</div>'
				                        },
				                    }
				                }	                
							}
						});	        	
         	})
         </script>
<title>注册</title>
</head>
<body>
	<%@include file="../header.jsp"%>
	<h1>注册</h1>
	<div class="container">
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6">
				<form id="register2" method="get"
					action="${pageContext.request.contextPath }/user/insertuser">
				 	<input type="hidden" name="email" value="${email}"> 
				<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon">用户名</span> <input id="name"
								name="name" type="text" class="form-control" />
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon">密码</span> <input id="password"
								name="password" type="text" class="form-control" />
						</div>
					</div>
						<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon">确认密码</span> <input
								id="repassword" name="repassword" type="text"
								class="form-control" />
						</div>
						</div>
					<div class="form-group">
						<input class="btn btn-primary btn-block" type="submit" value="注册" />
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="col-md-3"></div>
</body>
</html>