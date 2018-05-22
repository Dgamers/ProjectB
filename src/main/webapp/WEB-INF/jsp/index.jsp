<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="common.jspf" %>
	<script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/boostrappagintor/js/bootstrap-paginator.js"></script>
		<title>广东药科大学医学动画网站</title>
		
<script type="text/javascript">
var options = {
        currentPage:'${liInfo.pageNum}', //设置当前页，默认起始页为第一页
        totalPages:'${liInfo.pages}', //总页数
        numberOfPages:5, //设置控件显示的页码数,跟后台计算出来的总页数没多大关系
        bootstrapMajorVersion:3,//如果是bootstrap3版本需要加此标识，并且设置包含分页内容的DOM元素为UL,如果是bootstrap2版本，则DOM包含元素是DIV
        useBootstrapTooltip:'true',//是否显示tip提示框
        pageUrl:function(type,page, current){
         return '${pageContext.request.contextPath }/animation/index?Pagenum='+page+'&type=${type}&order=${order}' //为每个页码设置url访问请求链接，page为页码数
        },
        itemTexts:function(type,page, current){//文字翻译
            switch (type) {
                case "first":
                    return "首页";
                case "prev":
                    return "上一页";
                case "next":
                    return "下一页";
                case "last":
                    return "尾页";
                case "page":
                    return page;
            }
        }
   }
 $(function(){
	 $('.pagination').bootstrapPaginator(options);
 });

</script>
</head>
<body>
<%@include file="header.jsp" %>
<div style="width: 100%" align="center">
<form class="form-inline" action="${pageContext.request.contextPath }/animation/index" method="get">
    <input type="hidden" value="${type}" name="type">
    <input type="hidden" value="${order}" name="order">
    <input type="text" class="form-control" name="keyword" value="${keyword }" placeholder="请输入要搜索的动画关键字" style="width:30%">
    <button type="submit" class="btn btn-primary">搜索</button>
</form>
</div>
<br>
<div >
<ul class="nav nav-pills">  
  <li role="presentation" <c:if test="${type ==0 }">class="active"</c:if>><a href="${pageContext.request.contextPath }/animation/index?type=0&order=${order}&keyword=${keyword }">全部分类</a></li>
<c:forEach items="${categorys}" var="category">
 <li role="presentation" <c:if test="${type ==category.id }">class="active"</c:if>><a href="${pageContext.request.contextPath }/animation/index?type=${category.id }&order=${order}&keyword=${keyword }">${category.name}</a></li>
</c:forEach>
</ul>
</div>
<br>
<ul class="nav nav-tabs" role="tablist">
  <li <c:if test="${order ==1 }">class="active"</c:if>><a href="${pageContext.request.contextPath }/animation/index?type=${type}&order=1&keyword=${keyword }">最新发布</a></li>
  <li <c:if test="${order ==2 }">class="active"</c:if>><a href="${pageContext.request.contextPath }/animation/index?type=${type}&order=2&keyword=${keyword }">最多下载</a></li>
  <li <c:if test="${order ==3 }">class="active"</c:if>><a href="${pageContext.request.contextPath }/animation/index?type=${type}&order=3&keyword=${keyword }">评分最高</a></li>
</ul>
<br>
<c:choose>
<c:when test="${liInfo.pages==0}">
<div>
  <h2 align="center">抱歉，没有您要找到的内容</h2>
  <p align="center" >┑(￣Д ￣)┍</p>
</div>
</c:when>

<c:otherwise>
<div class="row">
<c:forEach items="${animations }" var="animation">
    <div class="col-md-2 col-sm-4 col-xs-12">
   <div class="thumbnail">
       <a href="${pageContext.request.contextPath }/animation/page?aid=${animation.id}"><img src="${animation.picture}" style="max-height: 100px;max-width: 150px"></a> 
      <div class="caption">     
        <h4>${animation.title}</h4>
        <span class="glyphicon glyphicon-user" >${animation.username}</span>
        <span class="glyphicon glyphicon-time" ><fmt:formatDate type="date" value="${animation.createtime}" /></span><br>
        <span class="glyphicon glyphicon-download-alt" >${animation.download}</span>
        <span class="glyphicon glyphicon-star" style="left: 30%">${animation.grade}</span>
      </div>
    </div>
  </div>
</c:forEach>
</div>

<nav class="navbar-fixed-bottom">
    <div align="center" >
<ul class="pagination"></ul>
</div>
</nav>
</c:otherwise>
</c:choose>

</body>
</html>