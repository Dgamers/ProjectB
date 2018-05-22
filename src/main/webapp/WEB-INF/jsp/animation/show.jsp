<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../common.jspf"%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/boostrapstars/js/star-rating.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/plugins/boostrapstars/css/star-rating.min.css" />
<script src="${pageContext.request.contextPath}/plugins/boostrapstars/js/locales/zh.js"></script>
<script type="text/javascript">
function jsonDateFormat(jsonDate) {
    try {
        var date = new Date(jsonDate);
        var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
        var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
        var hours = date.getHours();
        var minutes = date.getMinutes()<10? "0"+date.getMinutes():date.getMinutes();
        var seconds = date.getSeconds()<10? "0"+date.getSeconds():date.getSeconds();
        return date.getFullYear() + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;
    } catch (ex) {
        return "";
    }
}
function bindclick(){
	$('.btn-link').click(function() {
		var ss=this.value.split(",");
	if($("#"+ss[0]).children("#rereview").length>0)
		$("#rereview").remove();		
	if($("#"+ss[0]).children("#rereview").length<=0){		
	$("#rereview").remove();
	$("#"+ss[0]
	).append("<form id='rereview' >"+
		"<div class='form-group'><div >"+
		"<input type='hidden' name='reuserid' value="+ss[2]+">"+	
		"<input type='hidden' name='rid' value="+ss[0]+">"+
"<textarea class='form-control'  rows='4' form='rereview' name='content' id='recontent' placeholder=回复"+ss[1]+"></textarea>"+			
"</div></div>"+
"<div class='form-group'><div >"+
"<button type='button' class='btn btn-default' id='sendsecondreview'>回复</button>"+
"</div></div></form>");
	
	$('#sendsecondreview').click(function() {
		if($("#recontent").val().length<5)
			{
       	 $.confirm({
			    title: '回复失败',
			    content:'回复字数不能少于5个字',
			    buttons: {
			        确认: function () {           
			        },
			    }
			});
			}else{
				$.ajax({
					type : 'post',
					url : '${pageContext.request.contextPath }/animation/savesecondreview',
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					data : $('#rereview').serialize(),
					datatype : 'json',
					error : function(request) {
					},
					success : function(data) {
						if(data['state']==100){
					       	 $.confirm({
								    title: '回复失败',
								    content:data['message'],
								    buttons: {
								        确认: function () {           
								        },
								    }
								});
						}else{
							$("#rereview").remove();
							$("#"+data['rid']+"body").append("<div class='media'><div class='media-left'><a href='#'> <img class='media-object' src="+data['userpicture']+" style='width: 30px;'></a></div><div class='media-body'><h5 class='media-heading'>"+data['username']+" 回复 "+data['reusername']+"</h5>"+data['content']+"<br>"+jsonDateFormat(data['time'])+"<button class='btn btn-link' id='reply' value="+data['rid']+","+data['username']+","+data['userid']+" style='font-size:5px'> 回复</button></div></div>");
							$('.btn-link').unbind('click');
							bindclick();
						}

					}
				});
			}

	});
	}
	});

}
	$(function() {
		bindclick();
		$('#refresh').click(function() {
			window.location.reload();
		});
		$('#stars').rating({language:'zh', min:0, max:5, step:0.5, size:'xs',showClear:false,showCaption:true});
		$('#stars').on('rating:change', function(event, value, caption) {
				$.ajax({
					type : 'get',
					url : '${pageContext.request.contextPath }/animation/insertgrade',
					contentType : "application/json; charset=utf-8",
					data : {'aid':"${animation.id}",'grade':value},
					datatype : 'json',
					async: false,
					error : function(request) {

					},
					success : function(data) {
	                     if(data['state']==100){                   	
	                    	 $.confirm({
		          				    title: '评分失败',
		          				    content:'请登陆后再评分',
		          				    buttons: {
		          				        确认: function () {           
		          				        },
		          				    }
		          				});
	                    	 $('#stars').rating('clear');
	                     }else if(data['state']==200){
	                    	 $.confirm({
		          				    title: '评分失败',
		          				    content:'您已经为该作品评分',
		          				    buttons: {
		          				        确认: function () {           
		          				        },
		          				    }
		          				});
	                     }else{
	                    	 $("#span1").html("目前"+data['count']+"位用户综合评分:");
	                    	 $("#span2").html(data['grade']);
	                    	 $.confirm({
	          				    title: '评分成功',
	          				    content:'感谢您对作品的评价',
	          				    buttons: {
	          				        确认: function () {           
	          				        },
	          				    }
	          				});
	                     }
					}
				});
		});
		$("#content").focus(function(){
			$("#rereview").remove();
		});
		
		$('#sendreview').click(function() {
			if($("#content").val().length<5){
		       	 $.confirm({
					    title: '回复失败',
					    content:'回复字数不能少于5个字',
					    buttons: {
					        确认: function () {           
					        },
					    }
					});
			}else{
				$.ajax({
					type : 'post',
					url : '${pageContext.request.contextPath }/animation/savereview',
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					data : $('#review').serialize(),
					datatype : 'json',
					error : function(request) {
					},
					success : function(data) {
						if(data['state']==100)
						{
					       	 $.confirm({
								    title: '评论失败',
								    content:data['message'],
								    buttons: {
								        确认: function () {           
								        },
								    }
								});
						}else{
							$('#reviews').prepend("<div class='media' id="+data['id']+"><div class='media-left'><a href='#'> <img class='media-object' src="+data['userpicture']+" style='width: 50px;'></a></div><div class='media-body' id="+data['id']+"body><h4 class='media-heading'>"+data['username']+"</h4>"+data['content']+"<br>"+jsonDateFormat(data['time'])+"<button class='btn btn-link' id='reply' value="+data['id']+","+data['username']+","+data['userid']+"> 回复</button></div></div><hr>");
							$('.btn-link').unbind('click');
							bindclick();
						}

					}
				});
				$('#content').val("");
			}
		});
	});


</script>
<title>${animation.title}</title>
</head>
<body>

	<%@include file="../header.jsp"%>

	<div class="container">
		<div class="row">
			<div class="col-md-9" style=" border:1px solid #EEEEEE">
			<h2>${animation.title}</h2>
		<span class="glyphicon glyphicon-time" ><fmt:formatDate type="both" value="${animation.createtime}" /></span>
        <span class="glyphicon glyphicon-download-alt" >${animation.download}</span>
				<div class="embed-responsive embed-responsive-16by9" >
				  <iframe  class="embed-responsive-item" src="${animation.address}"></iframe>
				</div>

			</div>
			<div class="col-md-3">
			<div class="media">
					<a href="${pageContext.request.contextPath }/user/userpage?userid=${uper.id}"><div class="media-left"> <img class="img-rounded"
							src="${uper.picture}"
							alt="头像" style="width: 70px;" />
							</a>
					</div>
					<div class="media-body">
						<h4 class="media-heading">${uper.name}</h4>
						${uper.remarks}
					</div>
					<hr>
					该用户最近作品:			
					<c:forEach items="${otherinfo.list }" var="other">
										<div class="media">
										
						<div class="media-left">
						<a href="${pageContext.request.contextPath }/animation/page?aid=${other.id}">
							 <img class="media-object" src="${other.picture}"  style="width: 120px;">
							</a>
						</div>
						<div class="media-body">
							<h4 class="media-heading">${other.title}</h4>
							下载量:${other.download} 评分:${other.grade}
						</div>
						
					</div>
					</c:forEach>					
				</div>
		</div>
	</div>
	</div>
					<div class="container">
			<div class="row">
			<div class="col-md-1">		
				<a href="${pageContext.request.contextPath }/animation/download?file=${animation.address}&aid=${animation.id}">
					<button id="download" type="button" class="btn btn-default ">
					<span class="glyphicon glyphicon-save" aria-hidden="true"></span>
					下载
				</button>
				</a>
				</div>
				<div class="col-md-1">	
				<button id="refresh" type="button" class="btn btn-default ">
					<span class="glyphicon glyphicon-refresh" aria-hidden="true"></span>
					刷新
				</button>
				</div>
				<div class="col-md-2" >
				<input id="stars"value="${yourgrade}">
				</div>
				<div class="col-md-4">
				<span id="span1" style="font-family:SimHei;font-size: 20px">目前${scorecount}位用户综合评分:</span>
				<span id="span2"style="font-family:SimHei;font-size: 20px;color: #FFCC00;">${animation.grade}</span>
				</div>
				</div>
				</div>
	<hr>

	<div class="container">
			<div class="row">
			<div class="col-md-9">
				<h3>评论</h3>
				<form id="review" >
				<input type="hidden" name="userid" value="${sessionScope.user.id}">
				<input type="hidden" name="aid" value="${animation.id}">
					<div class="form-group">
						<div >
							<textarea class="form-control"  rows="4" form="review"
								name="content" id="content" ></textarea>			
						</div>
					</div>
					<div class="form-group">
						<div >
							<button type="button" class="btn btn-default" id="sendreview">提交评论</button>
						</div>
					</div>
				</form>
				<hr>
				<div id="reviews" >
					<c:forEach items="${reviews}" var="review">
						<div class="media" id="${review.id}">
							<div class="media-left">
								<a href="${pageContext.request.contextPath }/user/userpage?userid=${review.userid}"> <img class="media-object"
									src="${review.userpicture}" style="width: 50px;">
								</a>
							</div>
							<div class="media-body" id="${review.id}body">
								<h4 class="media-heading">${review.username}</h4>
								${review.content}<br>
								<fmt:formatDate type="both" value="${review.time}" />
								<button class="btn btn-link" id="reply" value="${review.id},${review.username},${review.userid}" >回复</button>
								<c:forEach items="${review.secondreviews }" var="secondreview">
									<div class="media">
										<div class="media-left">
											<a href="${pageContext.request.contextPath }/user/userpage?userid=${secondreview.userid}"> <img class="media-object"
												src="${secondreview.userpicture}" style="width: 30px;"></a>
										</div>
										<div class="media-body">
											<h5 class="media-heading">${secondreview.username } 回复 ${secondreview.reusername }</h5>
											${secondreview.content }<br>
											<fmt:formatDate type="both" value="${secondreview.time}" />
											<button class="btn btn-link" id="reply" value="${secondreview.rid},${secondreview.username},${secondreview.userid}" style="font-size: 5px">
												回复</button>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
						<hr>
					</c:forEach>
				</div>
				<div class="col-md-4"></div>
		</div>
	</div>
	</div>
</body>
</html>