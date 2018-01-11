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
<title>上传成功</title>
</head>
<body>
<%@include file="../header.jsp" %>
<h3>您的动画视频已经成功上传，请等待审核</h3>
<div class="container">
<div class="row">
 <div class="col-md-4"></div>
  <div class="col-md-4">
<a id="eurl" href="${pageContext.request.contextPath }/animation/index">
<input class="btn btn-primary btn-block" type="button" id="btn" value="前往主页" /><br>
</a>
  </div>
   <div class="col-md-4"></div>
</div>
</div>
</body>
</html>