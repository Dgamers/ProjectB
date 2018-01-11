<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../common.jspf" %>
	<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
		<title></title>
		
<script type="text/javascript">
var options = {
        currentPage:'${liInfo.pageNum}', //设置当前页，默认起始页为第一页
        totalPages:'${liInfo.pages}', //总页数
        numberOfPages:5, //设置控件显示的页码数,跟后台计算出来的总页数没多大关系
        bootstrapMajorVersion:3,//如果是bootstrap3版本需要加此标识，并且设置包含分页内容的DOM元素为UL,如果是bootstrap2版本，则DOM包含元素是DIV
        useBootstrapTooltip:'true',//是否显示tip提示框
        pageUrl:function(type,page, current){
         return '${pageContext.request.contextPath }/user/userpage?Pagenum='+page+'&order=${order}&userid=${upper.id}' //为每个页码设置url访问请求链接，page为页码数
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
	<%@include file="../header.jsp"%>
<div class="container">
<div class="row">
<div class="col-md-3">
			<div class="media">
					<div class="media-left"> <img class="img-rounded"
							src="${upper.picture }"
							alt="头像" style="width: 100px;" />
					</div>
					<div class="media-body">
					<h4 >${upper.name }</h4>
					</div>
					<hr>
				    性别：
				   <c:choose>
				   <c:when test="${upper.sex eq '1' }">男</c:when>
				   <c:when test="${upper.sex eq '2' }">女</c:when>
				   <c:when test="${upper.sex eq '3' }">保密</c:when>
				   </c:choose>
				    <hr>
				    邮箱
				   <c:choose>
				   <c:when test="${upper.emailshow eq '1' }">
				   ${upper.email}
				   </c:when>
				   <c:otherwise>
				       保密
				   </c:otherwise>
				   </c:choose>
				   <hr>
				    联系电话：				   
				    <c:choose>
				   <c:when test="${upper.phoneshow eq '1' }">
				   ${upper.phone}
				   </c:when>
				   <c:otherwise>
				       保密
				   </c:otherwise>
				   </c:choose><hr>
				        注册时间：<fmt:formatDate type="date" 
            value="${upper.createtime}" /></p><hr>
				        备注：${upper.remarks}<hr>
				    
				</div>

</div>
<div class="col-md-8">
<ul class="nav nav-tabs" role="tablist">
  <li <c:if test="${order ==1 }">class="active"</c:if>><a href="${pageContext.request.contextPath }/user/userpage?order=1&userid=${upper.id }">时间排序</a></li>
  <li <c:if test="${order ==2 }">class="active"</c:if>><a href="${pageContext.request.contextPath }/user/userpage?order=2&userid=${upper.id }">最多下载</a></li>
  <li <c:if test="${order ==3 }">class="active"</c:if>><a href="${pageContext.request.contextPath }/user/userpage?order=3&userid=${upper.id }">评分最高</a></li>
</ul>
<br>

<c:choose>
<c:when test="${liInfo.pages==0}">
<div class="jumbotron" >
  <h2 align="center">抱歉，该用户还没有上传过动画</h2>
  <p align="center" >┑(￣Д ￣)┍</p>
</div>
</c:when>

<c:otherwise>
<div class="row">
<c:forEach items="${animations }" var="animation">
    <div class="col-md-3">
    <a href="${pageContext.request.contextPath }/animation/page?aid=${animation.id}" class="thumbnail">
      <img src="${animation.picture}" alt="...">
       <div class="caption">
      	<h3>${animation.title}</h3>
      </div>
    </a>
  </div>
</c:forEach>
</div>
<div class="navbar-fixed-bottom" align="center">
<ul class="pagination"></ul>
</div>
</c:otherwise>
</c:choose>

</div>
</div>
</div>

</body>
</html>