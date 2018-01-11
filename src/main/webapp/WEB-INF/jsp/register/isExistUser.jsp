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
<title>注册错误</title>
</head>
<body>
<%@include file="../header.jsp" %>
<h3>此邮件已经绑定一个账号,若需解绑请登陆后到个人中心</h3>
<div class="container">
<div class="row">
 <div class="col-md-4"></div>
  <div class="col-md-4">
  <input class="btn btn-primary btn-block" onclick="javascript:history.back(-1);" type="button" id="btn" value="点击连接回到上一页面" /><br>
  </div>
   <div class="col-md-4"></div>
</div>
</div>
</body>
</html>