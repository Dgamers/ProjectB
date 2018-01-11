<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../common.jspf" %>
		<style>
			body{text-align: center;}		
		</style>
<script>
var map={"qq":"https://mail.qq.com/","163":"http://mail.163.com/"};
$(function(){ 
	  var str1='${email}';
	  var str2=str1.substring(str1.indexOf("@")+1,str1.indexOf("."));
	　$('#eurl').attr('href',map[str2]); 
	}); 
	
	function sendemail(){
		$.ajax({
            type: "GET", 
            dataType: "text", 
            cache:"false",
            url: '${pageContext.request.contextPath }/user/sendagain',
            data:{email:'${email}'}, 
            error: function (XMLHttpRequest, textStatus, errorThrown) {
				$.confirm({
				    title: '邮件发送失败',
				    content: '请与客服联系',
				    buttons: {
				        确认: function () {           
				        },
				    }
				});
            },
            success: function () {
				$.confirm({
				    title: '邮件发送成功',
				    content: '请到邮箱确认',
				    buttons: {
				        确认: function () {           
				        },
				    }
				});
            }
        });
    }
	
	 $(function () {
         $('#btn').click(function () {
             var count = 60;
             var countdown = setInterval(CountDown, 1000);
             sendemail();
             function CountDown() {
                 $("#btn").attr("disabled", true);
                 $("#btn").val("请稍等 " + count + " 秒后再点击!");
                 if (count == 0) {
                     $("#btn").val("没有收到邮件？点击在发送一次").removeAttr("disabled");
                     clearInterval(countdown);
                 }
                 count--;
             }
         })
     });
</script>
<title>欢迎注册</title>
</head>
<body>
<%@include file="../header.jsp" %>
<h3>已向你的邮箱 ${email}发送了一份验证邮件发送验证信息，请到邮箱查看</h3>
<div class="container">
<div class="row">
 <div class="col-md-4"></div>
  <div class="col-md-4">
  <input class="btn btn-primary btn-block" type="button" id="btn" value="没有收到邮件？点击在发送一次" /><br>
<a id="eurl" href="#">
<input class="btn btn-primary btn-block" type="button" id="btn" value="前往查看邮箱" /><br>
</a>
  </div>
   <div class="col-md-4"></div>
</div>
</div>
</body>
</html>