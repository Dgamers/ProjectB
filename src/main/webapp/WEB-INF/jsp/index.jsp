<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="common.jspf" %>
	<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
		<title>广东药科大学动画网站</title>
		
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
<div >
<ul class="nav nav-pills">  
  <li role="presentation" <c:if test="${type ==0 }">class="active"</c:if>><a href="${pageContext.request.contextPath }/animation/index?type=0&order=${order}">全部分类</a></li>
<c:forEach items="${categorys}" var="category">
 <li role="presentation" <c:if test="${type ==category.id }">class="active"</c:if>><a href="${pageContext.request.contextPath }/animation/index?type=${category.id }&order=${order}">${category.name}</a></li>
</c:forEach>
</ul>
</div>
<br>
<ul class="nav nav-tabs" role="tablist">
  <li <c:if test="${order ==1 }">class="active"</c:if>><a href="${pageContext.request.contextPath }/animation/index?type=${type}&order=1">时间排序</a></li>
  <li <c:if test="${order ==2 }">class="active"</c:if>><a href="${pageContext.request.contextPath }/animation/index?type=${type}&order=2">最多下载</a></li>
  <li <c:if test="${order ==3 }">class="active"</c:if>><a href="${pageContext.request.contextPath }/animation/index?type=${type}&order=3">评分最高</a></li>
</ul>
<br>
<c:choose>
<c:when test="${totalPages==0}">
<div class="jumbotron" >
  <h2 align="center">抱歉，没有您要找到的内容</h2>
  <p align="center" >┑(￣Д ￣)┍</p>
</div>
</c:when>

<c:otherwise>
<div class="row">
<c:forEach items="${animations }" var="animation">
    <div class="col-md-2 col-sm-4 col-xs-12">
    <a href="${pageContext.request.contextPath }/animation/page?aid=${animation.id}" class="thumbnail">
      <img src="${animation.picture}" alt="...">
       <div class="caption">
      	<h3>${animation.title}</h3>
      </div>
    </a>
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