<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../common.jspf" %>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/boostrappagintor/js/bootstrap-paginator.js"></script>
		<title>广东药科大学动画网站</title>
		
<script type="text/javascript">
var options = {
        currentPage:'${info.pageNum}', //设置当前页，默认起始页为第一页
        totalPages:'${info.pages}', //总页数
        numberOfPages:5, //设置控件显示的页码数,跟后台计算出来的总页数没多大关系
        bootstrapMajorVersion:3,//如果是bootstrap3版本需要加此标识，并且设置包含分页内容的DOM元素为UL,如果是bootstrap2版本，则DOM包含元素是DIV
        useBootstrapTooltip:'true',//是否显示tip提示框
        pageUrl:function(type,page, current){
         return '${pageContext.request.contextPath }/learn/initlearn?Pagenum='+page //为每个页码设置url访问请求链接，page为页码数
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
<%@include file="../header.jsp" %>
<div class="container">
<div class="row">
<div style="width: 100%" align="center">
<form class="form-inline" action="${pageContext.request.contextPath }/learn/initlearn" method="get">
    <input type="hidden" value="${order}" name="order">
<select id="searchcategory "class="form-control" name="searchcategory" >
<option value="0">全部</option>
<c:forEach items="${categories }" var="category">
  <option value="${category.id }" ${category.id==searchcategory?'selected':''}>${category.name }</option>
</c:forEach>
</select>
    <input type="text" class="form-control" name="keyword" value="${keyword}" placeholder="请输入要搜索的学习专题关键字" style="width:30%">
    <button type="submit" class="btn btn-primary">搜索</button>
</form>
</div>
<br><br><hr>
<c:choose>
<c:when test="${info.pages==0}">

  <h2 align="center">抱歉，没有您要找到的内容</h2>
  <p align="center" >┑(￣Д ￣)┍</p>

</c:when>

<c:otherwise>

<c:forEach items="${articles }" var="article">
    <div class="col-md-3">
    <div class="thumbnail">
    <a href="${pageContext.request.contextPath }/learn/detail?id=${article.id}" >
      <img src="${article.picture}">
      </a>
       <div class="caption">
      	<h4>${article.title}</h4>
      </div>
    </div>
  </div>
</c:forEach>



<nav class="navbar-fixed-bottom">
    <div align="center" >
<ul class="pagination"></ul>
</div>
</nav>
</c:otherwise>
</c:choose>
</div>
</div>
</body>
</html>