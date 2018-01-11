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
			<a class="navbar-brand" href="#">管理中心</a>
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="${pageContext.request.contextPath }/admin/user/inituseradmin">用户管理 </a></li>
				<li><a href="${pageContext.request.contextPath }/admin/panimation/initpanimationsadmin">投稿管理</a></li>
				<li><a href="#">动画管理</a></li>
			</ul>

			<ul class="nav navbar-nav navbar-right">
						<li class="dropdown">
          <a  href="#" class="dropdown-toggle" data-toggle="dropdown"><span id="username">${admin.name}</span><span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="#">个人信息</a></li>
            <li role="separator" class="divider"></li>
            <li><a href="#">退出登陆</a></li>
          </ul>
        </li>
			</ul>
		</div>
	</div>
</nav>
