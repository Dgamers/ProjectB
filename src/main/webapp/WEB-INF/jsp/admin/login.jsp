<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../common.jspf"%>
<title>Login</title>
</head>
<body>

	<div class="container">
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6">
			<h1 align="center">登陆</h1>
			<c:if test="${not empty msg}">
			<div class="alert alert-danger" role="alert" >${msg}</div>
			</c:if>
				<form id="adminlogin" method="post"
					action="${pageContext.request.contextPath }/admin/login">
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon">用户名</span> <input id="name"
								name="name" type="text" class="form-control" />
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon">密&nbsp;&nbsp;&nbsp;码</span> <input id="password"
								name="password" type="password" class="form-control" />
						</div>
					</div>
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