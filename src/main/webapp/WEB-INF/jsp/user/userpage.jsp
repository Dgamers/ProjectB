<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../common.jspf" %>
	<script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/boostrappagintor/js/bootstrap-paginator.js"></script>
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
	 $('.edit').click(function(){
		 var ss=this.value.split(",");
		 $('#animationid').val(ss[0]);
		 $('#edittitle').val(ss[1]);
		 $('#editcontent').val(ss[2]);
		 $('#editmodel').modal('show');
	 })
	 $('#update').click(function(){
			$.ajax({
				type : 'post',
				url : '${pageContext.request.contextPath }/user/updateainfo',
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				data : $('#editform').serialize(),
				datatype : 'json',
				error : function(request) {
				},
				success : function(data) {
					window.location.reload();
				}
			});
	 })
	 	 $('.remove').click(function(){
		   var id= this.value
	       	 $.confirm({
				    title: '确认下线',
				    content:'如果选择了下线，作品将无法在动画区展示',
				    buttons: {
				        确认: function () {     
							$.ajax({
								type : 'post',
								url : '${pageContext.request.contextPath }/user/changestatus',
								data : {'animationid':id,'status':0},
								error : function(request) {
								},
								success : function(data) {
									window.location.reload();
								}
							});
				        },
				        取消: function () {           
				        },
				    }
				});
	 })
	 	 	 $('.reput').click(function(){
		   var id= this.value
	       	 $.confirm({
				    title: '确认上线',
				    content:'如果选择了上线，作品将重新在动画区展示',
				    buttons: {
				        确认: function () {     
							$.ajax({
								type : 'post',
								url : '${pageContext.request.contextPath }/user/changestatus',
								data : {'animationid':id,'status':1},
								error : function(request) {
								},
								success : function(data) {
									window.location.reload();
								}
							});
				        },
				        取消: function () {           
				        },
				    }
				});
	 })
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
					<c:if test="${not empty  sessionScope.user}">
					<c:if test="${sessionScope.user.id !=upper.id}">
					<span class="glyphicon glyphicon-comment" aria-hidden="true">
					<a href="${pageContext.request.contextPath }/chat/addchatuser?id=${upper.id}">私聊</a>
					</span>
					</c:if> 
					</c:if>
					</div>
					<hr>
				    性别：
				   <c:choose>
				   <c:when test="${upper.sex eq '1' }">男</c:when>
				   <c:when test="${upper.sex eq '2' }">女</c:when>
				   <c:when test="${upper.sex eq '3' }">保密</c:when>
				   </c:choose>
				    <hr>
				    邮箱:
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
<c:choose>
<c:when test="${upper.id==sessionScope.user.id }">
<div  >
  <h2 align="center">您还没有上传过动画</h2>
  <p align="center" >┑(￣Д ￣)┍</p>
</div>
</c:when>
<c:otherwise>
<div  >
  <h2 align="center">抱歉，用户还没有上传过动画</h2>
  <p align="center" >┑(￣Д ￣)┍</p>
</div>
</c:otherwise>
</c:choose>
</c:when>

<c:otherwise>
<div class="row">
<c:forEach items="${animations }" var="animation">
    <div class="col-md-4 ">
   <div class="thumbnail">
<c:if test="${upper.id==sessionScope.user.id }">
<button type="button" class="btn btn-default btn-sm edit" value="${ animation.id},${ animation.title},${animation.content}">
  <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> 
</button>
<c:choose>
<c:when test="${ animation.status==0}">
<button type="button" class="btn btn-default btn-sm reput" value="${ animation.id}">
  <span class="glyphicon glyphicon-ok" aria-hidden="true"></span> 
</button>
</c:when>
<c:otherwise>
<button type="button" class="btn btn-default btn-sm remove" value="${ animation.id}">
  <span class="glyphicon glyphicon-remove" aria-hidden="true"></span> 
</button>
</c:otherwise>
</c:choose>
</c:if>
       <a href="${pageContext.request.contextPath }/animation/page?aid=${animation.id}"><img src="${animation.picture}" style="max-height: 100px;max-width: 150px"></a> 
      <div class="caption">     
        <h4>${animation.title}</h4>
        <span class="glyphicon glyphicon-time" ><fmt:formatDate type="both" value="${animation.createtime}" /></span><br><br>
        <span class="glyphicon glyphicon-download-alt" >${animation.download}</span>
        <span class="glyphicon glyphicon-star" style="left: 30%">${animation.grade}</span>
      </div>
    </div>
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
<div class="modal fade" id="editmodel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">动画信息编辑</h4>
      </div>
      <div class="modal-body">
       <form id="editform">
       <input type="hidden" id="animationid" name="animationid">
          <div class="form-group">
            <label for="title" class="control-label">动画名称</label>
            <input type="text" name="title" class="form-control" id="edittitle">
          </div>
          <div class="form-group">
            <label for="editcontent" class="control-label">动画简介</label><br>
           <textarea rows="3" style="width: 100%;resize: none;max-width: 100%;" id="editcontent" form="editform" name="content"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="update">修改</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>