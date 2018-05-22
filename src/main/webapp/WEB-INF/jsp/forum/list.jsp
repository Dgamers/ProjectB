<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../common.jspf" %>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/plugins/boostrapselect/css/bootstrap-select.min.css" />	
<script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/boostrapselect/js/bootstrap-select.js"></script>
	<script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/boostrappagintor/js/bootstrap-paginator.js"></script>
		<title>广东药科大学动画网站</title>
		<script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/wangEditor/js/wangEditor.min.js"></script>	
<script type="text/javascript">
var options = {
        currentPage:'${info.pageNum}', //设置当前页，默认起始页为第一页
        totalPages:'${info.pages}', //总页数
        numberOfPages:5, //设置控件显示的页码数,跟后台计算出来的总页数没多大关系
        bootstrapMajorVersion:3,//如果是bootstrap3版本需要加此标识，并且设置包含分页内容的DOM元素为UL,如果是bootstrap2版本，则DOM包含元素是DIV
        useBootstrapTooltip:'true',//是否显示tip提示框
        pageUrl:function(type,page, current){
         return '${pageContext.request.contextPath }/forum/initlist?PageNum='+page //为每个页码设置url访问请求链接，page为页码数
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
function changeDateFormat(cellval) {
    var dateVal = cellval + "";
    if (cellval != null) {
        var date = new Date(parseInt(dateVal.replace("/Date(", "").replace(")/", ""), 10));
        var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
        var currentDate = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
        
        var hours = date.getHours() < 10 ? "0" + date.getHours() : date.getHours();
        var minutes = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
        var seconds = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();
        
        return date.getFullYear() + "-" + month + "-" + currentDate + " " + hours + ":" + minutes + ":" + seconds;
    }
}
$(function(){
	var E = window.wangEditor;
	var editor = new E('#editor');
	editor.customConfig.uploadImgServer = '${pageContext.request.contextPath}/forum/uploadpicture'
    editor.customConfig.uploadImgMaxSize = 3 * 1024 * 1024;
	editor.customConfig.uploadFileName = 'picturename';
	editor.customConfig.uploadImgHooks = {
		    success: function (xhr, editor, result) {
		    	console.log(result);
		    },
		    };
	editor.customConfig.debug = true;
    editor.customConfig.onchange = function (html) {
        // 监控变化，同步更新到 textarea
        $('#content').val(html);
    }
    editor.customConfig.zIndex = 1
	editor.create();
	$('#content').val(editor.txt.html());
	
    $('#saveTheme').click(function(){
    	if("${sessionScope.user}"){
    		if($('#title').val().length<5){
    	       	 $.confirm({
    				    title: '回复失败',
    				    content:'主题标题不能少于5个字',
    				    buttons: {
    				        确认: function () {           
    				        },
    				    }
    				});
    		}else if($('#content').val().length<5){
   	       	 $.confirm({
				    title: '回复失败',
				    content:'主题内容不能少于5个字',
				    buttons: {
				        确认: function () {           
				        },
				    }
				});
    		}else{
    			$('#Theme').submit();
    		}
    	}else{
          	 $.confirm({
 			    title: '发表失败',
 			    content:'请登陆后再发表主题',
 			    buttons: {
 			        确认: function () {           
 			        },
 			    }
 			});
    	}
    	
    })
    
	 $('.pagination').bootstrapPaginator(options);

    $('.remove').click(function(){
    	var id=this.value;
    	console.log(id);
     	 $.confirm({
			    title: '确认删除主题',
			    content:'注意：此操作不可逆！',
			    buttons: {
			        确认: function () {     
			           	$.ajax({
			          		type : 'get',
			          		url : '${pageContext.request.contextPath }/forum/deleteforumtheme',
			          		data : {'themeid':id},
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
<%@include file="../header.jsp" %>
<div class="container">
<div class="row">
<div style="width: 100%" align="center">
<form class="form-inline" action="${pageContext.request.contextPath }/forum/initlist" method="get">
    <input type="hidden" value="${order}" name="order">
<select id="searchcategory "class="form-control" name="searchcategory" >
<option value="0">全部</option>
<c:forEach items="${categories }" var="category">
  <option value="${category.id }" ${category.id==searchcategory?'selected':''}>${category.name }</option>
</c:forEach>
</select>
    <input type="text" class="form-control" name="keyword" value="${keyword}" placeholder="请输入要搜索的主题关键字" style="width:30%">
    <button type="submit" class="btn btn-primary">搜索</button>
</form>
</div>
<br>
<ul class="nav nav-tabs" role="tablist">
  <li <c:if test="${order ==1 }">class="active"</c:if>><a href="${pageContext.request.contextPath }/forum/initlist?order=1&searchcategory=${searchcategory}&keyword=${keyword}">创建时间</a></li>
  <li <c:if test="${order ==2 }">class="active"</c:if>><a href="${pageContext.request.contextPath }/forum/initlist?order=2&searchcategory=${searchcategory}&keyword=${keyword}">最近回复</a></li>
   <c:if test="${not empty sessionScope.user }">
   <li <c:if test="${order ==0 }">class="active"</c:if>><a href="${pageContext.request.contextPath }/forum/initlist?order=0&searchcategory=${searchcategory}&keyword=${keyword}">我的帖子</a></li>
   </c:if>
</ul>

<c:choose>
<c:when test="${info.pages==0}">
<div>
  <h2 align="center">抱歉，没有您要找到的内容</h2>
  <p align="center" >┑(￣Д ￣)┍</p>
</div>
</c:when>
<c:otherwise>
<div>
<table id="themesinfo" class="table">
<tr><th>主题</th><th>发表用户</th><th>创建时间</th><th>最后回复时间</th><tr>
<c:forEach items="${list}" var="theme">
<tr><td><a href="${pageContext.request.contextPath}/forum/detail?id=${theme.id }">[${theme.categoryname }]${theme.title }</a></td>
<td>${theme.username }</td>
<td><fmt:formatDate type="both" value="${theme.createtime}" /></td>
<td><fmt:formatDate type="both" value="${theme.updatetime}" />
<c:if test="${not empty sessionScope.user }">
<c:if test="${sessionScope.user.id==theme.userid }">
<button type="button" class="btn btn-link btn-sm remove" value="${theme.id }" style="float: right;">
<span class="glyphicon glyphicon-remove" ></span></button>
</c:if>

</c:if>
</td><tr>
</c:forEach>
</table>
</div>
<div align="left"  >
<ul class="pagination"></ul>
</div>
</c:otherwise>
</c:choose>


<br>
<hr>
<form id="Theme" action="${pageContext.request.contextPath}/forum/publish" method="post" >
    					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon">主題名</span> <input id="title"
								name="title" type="text" class="form-control" />
						</div>
					</div>
					  					<div class="form-group">
						<div class="input-group" style="z-index: 100">
							<span class="input-group-addon">主題类别</span> 
								<select id="category" name="category"
								class="selectpicker show-tick form-control"  data-size="3" dropupAuto="false" >
								<c:forEach items="${categories }" var="category">
								<option value="${category.id}">${category.name}</option>
								</c:forEach>

							</select>
						</div>
					</div>
	<div class="form-group">			
    <div id="editor" class="col-sm-12"></div>
    </div>
  <input type="hidden" id="content" name="content" />
   					<div class="form-group">
						<button class="btn btn-primary btn-block" type="button"  style="width: 10%" id="saveTheme">发表主题</button>
					</div>
</form>
</div>
</div>
</body>
</html>