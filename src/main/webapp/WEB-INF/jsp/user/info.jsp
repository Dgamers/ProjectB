<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../common.jspf"%>
<style>
</style>
<script type="text/javascript">

	$(function() {
		$('#save').click(function() {
			$.ajax({
				type : 'post',
				url : '${pageContext.request.contextPath }/user/saveuserinfo',
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				data : $('#info').serialize(),
				datatype : 'json',
				error : function(request) {
					$.confirm({
					    title: '信息保存失败',
					    content: '请稍后重试',
					    buttons: {
					        确认: function () {           
					        },
					    }
					});
				},
				success : function(data) {
					$.confirm({
					    title: '信息保存成功',
					    content: '若页面显示没有更新请刷新',
					    buttons: {
					        确认: function () {           
					        },
					    }
					});
                  alert(data['data']['name'])
                  $("#username").text(data['data']['name']);
				}
			});
		})		
	});
	
	$(document).ready(function(){
		$('form')
		.bootstrapValidator(
				{
					message : 'This value is not valid',
					feedbackIcons : {
						valid : 'glyphicon glyphicon-ok',
						invalid : 'glyphicon glyphicon-remove',
						validating : 'glyphicon glyphicon-refresh'
					},
					fields : {
		                name: {
		                    validators: {
		                        notEmpty: {
		                            message: '<div class="alert alert-danger" role="alert"  height: 10px; ">用户名不能为空</div>'
		                        },
		                        stringLength: {
		                            /*长度提示*/
		                            min: 6,
		                            max: 30,
		                            message: '<div class="alert alert-danger" role="alert"  height: 10px; ">用户名长度必须在6到30之间</div>'
		                        }
		                    }
		                },            
					}
				});	        	
 	})
</script>
<title>个人信息</title>
</head>
<body>

	<%@include file="../header.jsp"%>

<ul class="nav nav-tabs nav-justified">
  <li role="presentation" class="active"><a href="${pageContext.request.contextPath }/user/inituserinfo">基础信息</a></li>
  <li role="presentation"><a href="${pageContext.request.contextPath }/user/initcontact">联系方式</a></li>
  <li role="presentation"><a href="${pageContext.request.contextPath }/user/inithead">我的头像</a></li>
</ul>
<br><br>
	<div class="container">
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6">
				<form  id="info" class="form-horizontal" method="post" >
				<input type="hidden" name="id" id="id" value="${sessionScope.user.id }">
					<div class="form-group">
						<label for="name" class="col-sm-2 control-label">真实姓名</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="name" id="name" value="${sessionScope.user.name }">
						</div>
					</div>
					<div class="form-group">
						<label for="sex" class="col-sm-2 control-label">性别</label>
						<div class="col-sm-10">
							<label class="radio-inline"> <input type="radio"
								id="sex1" name="sex" value="1" <c:if test="${sessionScope.user.sex eq '1'}"> checked</c:if>> 男
							</label> <label class="radio-inline"> <input
								type="radio" name="sex" id="sex2" value="2" <c:if test="${sessionScope.user.sex eq '2'}"> checked</c:if>> 女
							</label> <label class="radio-inline"> <input
								type="radio" name="sex" id="sex3" value="3" <c:if test="${sessionScope.user.sex eq '3'}"> checked</c:if>> 保密
							</label>
						</div>
					</div>
					<br>
					<div class="form-group">
						<label for="realname" class="col-sm-2 control-label">真实姓名</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="realname" id="realname" value="${sessionScope.user.realname }">
						</div>
					</div>
					<br>


					<div class="form-group">
						<label for="remarks" class="col-sm-2 control-label">公开备注</label>
						<div class="col-sm-10">
							<textarea class="form-control" rows="4" form="info"
								name="remarks" id="remarks" >${sessionScope.user.remarks}</textarea>
						</div>
					</div>

					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="button" class="btn btn-default" id="save">保存修改</button>
						</div>
					</div>
				</form>

			</div>
			<div class="col-md-3"></div>
		</div>
	</div>

</body>
</html>