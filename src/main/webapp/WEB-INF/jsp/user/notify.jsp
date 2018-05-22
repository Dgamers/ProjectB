<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html style="height: 100%;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系统信息</title>
<%@include file="../common.jspf"%>
<script type="text/javascript">
</script>
</head>
<body style="height: 100%;overflow-x: hidden;overflow-y: hidden; ">
<%@include file="../header.jsp"%>
<div class="container" style="height: 100%;">
<div class="panel panel-default" style="height: 100%">
  <div class="panel-heading">系统信息</div>
  <div class="panel-body" style="overflow-y:auto;height: 80%">
  <c:forEach items="${notifies }" var="notify">
      <div class="media" style="border: 1px solid #EEEEEE;border-radius: 10px; min-height: 75px">
    <div class="media-body">
    <h4 class="media-heading" style="margin-left: 2%">${notify.title}<span style="font-size: 10px;margin-left: 2%"><fmt:formatDate type="both" value="${notify.createtime}" /></span></h4>
    <div style="margin-left: 2%">
     ${notify.content}
    </div>
    </div>
    </div>
</c:forEach>

  </div>
</div>
</div>
</body>
</html>