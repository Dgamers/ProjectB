<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../common.jspf" %>
		<style>
			body{text-align: center;}		
		</style>
<title>注册成功</title>
</head>
<body>
<%@include file="../header.jsp" %>
<h3>您的账户已经成功注册，请到个人信息页面补充信息</h3>
<div class="container">
<div class="row">
 <div class="col-md-4"></div>
  <div class="col-md-4">
<a id="eurl" href="${pageContext.request.contextPath }/user/initlogin">
<input class="btn btn-primary btn-block" type="button" id="btn" value="前往登陆页面" /><br>
</a>
  </div>
   <div class="col-md-4"></div>
</div>
</div>
</body>
</html>