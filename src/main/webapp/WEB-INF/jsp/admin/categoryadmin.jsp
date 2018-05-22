<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html >
<html style="height: 100%">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../common.jspf"%>
<title>类别管理</title>
<script type="text/javascript">
$(function(){
	$(".container").on("click",".update",function(){
		var ss=this.value.split(",");
		 $(this).parent('td').prepend("<button type='button' class='btn btn-link btn-sm save' value='"+ss[0]+","+ss[1]+","+ss[2]+"'><span class='glyphicon glyphicon-ok' ></span></button><button type='button' class='btn btn-link btn-sm cancel' value='"+ss[0]+","+ss[1]+","+ss[2]+"'><span class='glyphicon glyphicon-remove' ></span></button>");
		 $(this).remove();
		 $('#'+ss[0]+'T'+ss[2]).attr("disabled",false);
		 
	})
	$(".container").on("click",".save",function(){
		 var ss=this.value.split(",");
		 var name=$('#'+ss[0]+'T'+ss[2]).val();
     	$.ajax({
    		type : 'get',
    		url : '${pageContext.request.contextPath }/admin/category/updatecategory',
    		data : {'categoryid':ss[0],'name':name,'type':ss[2]},
    		error : function(request) {
    		},
    		success : function(data) {		
    		}
    	});
		 $(this).parent('td').prepend("<button type='button' class='btn btn-link btn-sm update' value='"+ss[0]+","+ss[1]+","+ss[2]+"'><span class='glyphicon glyphicon-pencil' ></span></button>");
		 $(this).siblings(".cancel").remove();
		 $(this).remove();
		 $('#'+ss[0]+'T'+ss[2]).attr("disabled",true);
		
	});
	
	$(".container").on("click",".cancel",function(){
		 var ss=this.value.split(",");
		 $(this).siblings(".save").remove();
		 $(this).parent('td').prepend("<button type='button' class='btn btn-link btn-sm update' value='"+ss[0]+","+ss[1]+","+ss[2]+"'><span class='glyphicon glyphicon-pencil' ></span></button>");
		 $(this).remove();
		 $('#'+ss[0]+'T'+ss[2]).attr("disabled",true);
	});
	
	$(".container").on("click",".remove",function(){
		 var ss=this.value.split(",");
		 console.log(ss);
    	$.ajax({
   		type : 'get',
   		url : '${pageContext.request.contextPath }/admin/category/deletecategory',
   		data : {'categoryid':ss[0],'type':ss[1]},
   		error : function(request) {
   		},
   		success : function(data) {	
   			window.location.reload();
   		}
   	});
	});
	$(".container").on("click",".insert",function(){
		 var type=this.value;
		 var name;
		 if(type==1){
			 name=$('#aname').val();
			 $('#aname').val("");
		 }else if(type==2){
			 name=$('#fname').val();
			 $('#fname').val("");
		 }else if(type==3){
			 name=$('#lname').val();
			 $('#lname').val("");
		 }
   	$.ajax({
  		type : 'get',
  		url : '${pageContext.request.contextPath }/admin/category/insertcategory',
  		data : {'name':name,'type':type},
  		error : function(request) {
  		},
  		success : function(data) {	
  			window.location.reload();
  		}
  	});
	});
})
</script>


</head>
<body style="height: 80%">
<%@include file="header.jsp"%>
		<div class="container" style="height: 100%">
		<div class="row" style="height: 100%">
			<div class="col-md-4" style="height: 100%">
			动画类别：<br>
			新增类型：<input type="text" id="aname">
			<button type="button" class="btn btn-link btn-sm insert" value="1">
                <span class="glyphicon glyphicon-plus" ></span></button>
			<div style="height: 80%;border: 1px solid;overflow: auto;">
			<table class="table">
			<tr>
			<th>id</th><th>名称</th><th>操作</th>
			</tr>
			<c:forEach items="${acategorylist }" var="acategory">
			<tr>
			<td>${acategory.id }</td>
			<td>
			<input id="${acategory.id }T1" type="text" value="${acategory.name }" disabled="true"> 
			<td><button type="button" class="btn btn-link btn-sm update" value="${acategory.id },${acategory.name },1">
                <span class="glyphicon glyphicon-pencil" ></span></button>
                <button type="button" class="btn btn-link btn-sm remove" value="${acategory.id },1">
                <span class="glyphicon glyphicon-minus" ></span></button>
            </td>
			</tr>
			</c:forEach>
			</table>
			</div>
			</div>
			<div class="col-md-4" style="height: 100%">
			主题类别：<br>
			新增类型：<input type="text" id="fname">
			<button type="button" class="btn btn-link btn-sm insert" value="2">
                <span class="glyphicon glyphicon-plus" ></span></button>
			<div style="height: 80%;border: 1px solid;overflow: auto;">
			<table class="table">
			<tr>
			<th>id</th><th>名称</th><th>操作</th>
			</tr>
			<c:forEach items="${fcategorylist }" var="fcategory">
			<tr>
			<td>${fcategory.id }</td>
			<td>
			<input id="${fcategory.id }T2" type="text" value="${fcategory.name }" disabled="true"> 
			<td><button type="button" class="btn btn-link btn-sm update" value="${fcategory.id },${fcategory.name },2">
                <span class="glyphicon glyphicon-pencil" ></span></button>
                <button type="button" class="btn btn-link btn-sm remove" value="${fcategory.id },2">
                <span class="glyphicon glyphicon-minus" ></span></button>
            </td>
			</tr>
			</c:forEach>
			</table>
			</div>
			</div>
			<div class="col-md-4" style="height: 100%">
			学习主题类别：<br>
			新增类型：<input type="text" id="lname">
			<button type="button" class="btn btn-link btn-sm insert" value="3">
                <span class="glyphicon glyphicon-plus" ></span></button>
			<div style="height: 80%;border: 1px solid;overflow: auto;">
			<table class="table">
			<tr>
			<th>id</th><th>名称</th><th>操作</th>
			</tr>
			<c:forEach items="${lcategroylist }" var="lcategory">
			<tr>
			<td>${lcategory.id }</td>
			<td>
			<input id="${lcategory.id }T3" type="text" value="${lcategory.name }" disabled="true"> 
			<td><button type="button" class="btn btn-link btn-sm update" value="${lcategory.id },${lcategory.name },3">
                <span class="glyphicon glyphicon-pencil" ></span></button>
                <button type="button" class="btn btn-link btn-sm remove" value="${lcategory.id },3">
                <span class="glyphicon glyphicon-minus" ></span></button>
            </td>
			</tr>
			</c:forEach>
			</table>
			</div>
			</div>
		</div>
		</div>
</body>
</html>