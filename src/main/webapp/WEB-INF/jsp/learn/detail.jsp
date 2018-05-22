<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../common.jspf" %>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/boostrappagintor/js/bootstrap-paginator.js"></script>
		<title>广东药科大学动画网站</title>
		
<script type="text/javascript">

</script>
</head>
<body>
<%@include file="../header.jsp" %>
<div class="container">
		<div class="row">
		<div class="col-md-8">
		<h3>${article.title }</h3>
		${article.content }
		</div>
		<div class="col-md-4" style="border-left: 1px solid #eee;">
		<img src="${article.picture}" style="max-width: 100%;">
		<hr>
		本文编辑：${article.editname}
		<hr>
		编辑时间：<fmt:formatDate type="both" value="${article.createtime}" />
		<hr>
		本文类别：${category.name}
		</div>
		</div>
</div>
</body>
</html>