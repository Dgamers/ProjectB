<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-default">
	<div class="container-fluid">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="${pageContext.request.contextPath }/animation/index">广东药科大学动画网站</a>
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="#">动画区 </a></li>
				<li><a href="#">专题学习区</a></li>
				<li><a href="#">论坛区</a></li>
			</ul>

			<form class="navbar-form navbar-left">
				<div class="form-group">
					<input type="text" class="form-control" placeholder="Search">
				</div>
				<button type="submit" class="btn btn-default">Submit</button>
			</form>

			<ul class="nav navbar-nav navbar-right">
				<c:choose>
					<c:when test="${empty sessionScope.user }">
						<li><a
							href="${pageContext.request.contextPath}/user/initlogin">登陆</a></li>
						<li><a
							href="${pageContext.request.contextPath}/user/register1">注册</a></li>
					</c:when>
					<c:otherwise>
						<li><img class="img-rounded"
							src="${sessionScope.user.picture}" alt="头像" style="width: 50px;" id="userpicture"/></li>
						<li class="dropdown">
          <a  href="#" class="dropdown-toggle" data-toggle="dropdown"><span id="username">${sessionScope.user.name }</span><span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="${pageContext.request.contextPath}/user/inituserinfo">个人信息</a></li>
            <li><a href="${pageContext.request.contextPath}/animation/initupload">投稿</a></li>
            <li><a href="${pageContext.request.contextPath }/user/notify">系统信息<span class="badge pull-right"><c:if test="${ not empty sessionScope.countnotify and sessionScope.countnotify!=0}">${sessionScope.countnotify }</c:if></span></a></li>
            <li role="separator" class="divider"></li>
            <li><a href="${pageContext.request.contextPath}/user/loginout">退出登陆</a></li>
          </ul>
        </li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid -->
</nav>
