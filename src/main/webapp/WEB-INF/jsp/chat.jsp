<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html >
<html style="height: 100%">
<head>
    <style type="text/css">
.bubbleDiv{  
    width: 1000px;  
    margin: 0 auto;  
    height: 1000px;  
    border: 1px solid #4a4f58;  
}  
.bubbleItem{  
    width: 100%;  
}  
.bubble{  
    max-width: 655px;  
    position: relative;  
    line-height: 30px;  
    padding-left: 10px;  
    padding-top: 3px;  
    padding-bottom: 3px;  
    border-radius: 7px;  
    margin-top: 15px;  
    padding-right: 10px;  
    display: inline-block;  
}  

.leftBubble{  
    position: relative;  
    margin-left: 25px;  
    border: 1px solid #aaa;  
}  
.leftBubble .bottomLevel{  
    position: absolute;  
    top: 10px;  
    left: -10px;  
    border-top: 10px solid #aaa;  
    border-left: 10px solid transparent;  
}  

.leftBubble .topLevel{  
    position: absolute;  
    top: 11px;  
    left: -8px;  
    border-top: 10px solid #fff;  
    border-left: 10px solid transparent;  
    z-index: 100;  
}  
.rightBubble{  
    position: relative;  
    margin-right: 25px;  
    float: right;  
    border: 1px solid #aaa;  
}  

.rightBubble .bottomLevel{  
    position: absolute;  
    top: 10px;  
    right: -10px;  
    border-top: 10px solid #aaa;  
    border-right: 10px solid transparent;  
}  
.rightBubble .topLevel{  
    position: absolute;  
    top: 11px;  
    right: -8px;  
    border-top: 10px solid #fff;  
    border-right: 10px solid transparent;  
    z-index: 100;  
}  
.clearfix:after {  
    visibility: hidden;  
    display: block;  
    font-size: 0;  
    content: " ";  
    clear: both;  
    height: 0;  
}  
    </style>
<%@include file="common.jspf" %>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/sockjs/sockjs.js"></script>
<script type="text/javascript">
var acceptuser;
var acceptuserpicture;
$(function(){
	var wsServer = "ws://" + location.host+"${pageContext.request.contextPath}" + "/myHandler";
	 var ws = new WebSocket(wsServer)
     ws.onopen = function () {
      console.log("onpen");
     }
     ws.onclose = function () {
      console.log("onclose");
     }

    ws.onmessage = function (msg) {
		var html="<div><img class='img-circle' style='width: 50px;float:left; ' src='"+acceptuserpicture+"'>"+
	    "<div class='bubbleItem'><div class='bubble leftBubble'>"+
	    msg.data+ 
	    "<div class='bottomLevel'></div><div class='topLevel'></div</div></div></div><br>";
		$('#chatview').append(html);
        var chat = $("#chatview");
        chat.scrollTop(chat[0].scrollHeight);  

     }
	
$('#sendchat').click(function(){
	sendmessage();	
})
adduser();
if("${choose}"){
	acceptuser="${choose}";
	getchatrecord("${choose}");
}

$('#userlist').on('click','.turnuser',function(){
	$('.userdiv').css('background-color','#E6E6E6');
	$('#'+this.id+'div').css('background-color','#AAAAAA');
	$("#chatview").empty();
	getchatrecord(this.id);
})

$('.close').click(function(){
	var userid=$(this).val();
	var html;
  	 $.confirm({
		    title: '确认删除联系人',
		    content:'如果删除联系人，信息记录也会清空',
		    buttons: {
		        确认: function () {      
		        	$.ajax({
		        		type : 'get',
		        		url : '${pageContext.request.contextPath }/chat/deleteuser',
		        		data : {'chooseuserid':acceptuser},
		        		error : function(request) {
		        		},
		        		success : function(data) {
		        			$('#userlist').empty();
		        			$(data).each(function(i,d){
		        				console.log(d);
		        				if(i==0){
		        					html="<div id='"+d['id']+"div'class='userdiv' style='height: 10%;width: 100%;background-color: #AAAAAA' ><a href='#' class='turnuser' id='"+d['id']+"''><img class='img-circle' style='width: 40px;' src='"+d['picture']+"'></a>"+
		        					d['name']+"<button type='button' class='close' value='"+d['id']+"'><span aria-hidden='true'>&times;</span></button></div>";
		        					$('#userlist').append(html);
		        					$("#chatview").empty();
		        					getchatrecord(d['id']);
		        				}else{
		        					html="<div id='"+d['id']+"div'class='userdiv' style='height: 10%;width: 100%;background-color: #E6E6E6' ><a href='#' class='turnuser' id='"+d['id']+"''><img class='img-circle' style='width: 40px;' src='"+d['picture']+"'></a>"+
		        					d['name']+"<button type='button' class='close' value='"+d['id']+"'><span aria-hidden='true'>&times;</span></button></div>";
		        					$('#userlist').append(html);
   		        				}
		        			});
		        			
		        		}
		        	});
		        },
		        取消: function () {      
		        },
		    }
		});
})
$('#message').keyup(function(){
	var number=$(this).val().length;
	if(number>0){
		$('#sendchat').attr("disabled",false);
	}else{
		$('#sendchat').attr("disabled",true);
	}
})
})
function adduser(){
	
	if("${adduser}"){
		$('#userlist').append("<div style='height: 10%;width: 100%;background-color: #D5D5D5' ><a href='#' class='turnuser'id='${adduser.id}'><img class='img-circle' style='width: 40px;' src='${adduser.picture}'>"+
				"${adduser.name}<button type='button' class='close'><span aria-hidden='true'>&times;</span></button></div>");
	}
	
	acceptuser="${adduser.id}";
}
function sendmessage(){
	var message=$('#message').val();
	$('#message').val("");
	$.ajax({
		type : 'get',
		url : '${pageContext.request.contextPath }/chat/sendmessage',
		data : {'toid':acceptuser,'content':message},
		error : function(request) {
		},
		success : function(data) {
			console.log(data)
			var html="<div><img class='img-circle' style='width: 50px;float:right ' src='${sessionScope.user.picture}'><div class='bubbleItem clearfix'><span style='font-family: Arial, Helvetica, sans-serif;'></span>"+  
			"<span class='bubble rightBubble'>"+data+ 
			"<span class='bottomLevel'></span><span class='topLevel'></span></span></div></div><br>";
			$('#chatview').append(html);
	        var chat = $("#chatview");
	        chat.scrollTop(chat[0].scrollHeight);  
		}
	});
}

function getchatrecord(chooseuserid){
	$.ajax({
	type : 'get',
	url : '${pageContext.request.contextPath }/chat/getchatrecord',
	data : {'chooseuserid':chooseuserid},
	error : function(request) {
	},
	success : function(data) {
		var html;
		acceptuserpicture=data['chooseuser']['picture'];
		$('#chatuser').html(data['chooseuser']['name']);
		$(data['chatRecords']).each(function(i,d){
			if(d['sender']=="${sessionScope.user.id}"){
				html="<div><img class='img-circle' style='width: 50px;float:right ' src='${sessionScope.user.picture}'><div class='bubbleItem clearfix'><span style='font-family: Arial, Helvetica, sans-serif;'></span>"+  
				"<span class='bubble rightBubble'>"+d['record']+ 
				"<span class='bottomLevel'></span><span class='topLevel'></span></span></div></div><br>";
				$('#chatview').append(html);
			}else{		
				html="<div><img class='img-circle' style='width: 50px;float:left; ' src='"+data['chooseuser']['picture']+"'>"+
			    "<div class='bubbleItem'><div class='bubble leftBubble'>"+
			    d['record']+ 
			    "<div class='bottomLevel'></div><div class='topLevel'></div</div></div></div><br>";
				$('#chatview').append(html);
			}
		})
        var chat = $("#chatview");
        chat.scrollTop(chat[0].scrollHeight); 
	}
});
	
}


</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的信息</title>
</head>
<body style="height: 85%">
<%@include file="header.jsp" %>
<div class="container" style="height: 100%">
<div class="row" style="height: 100%">
<div  style="border: 1px solid;border-right:1px solid #CCCCCC;height: 100%;width:15%;float: left;border-top-left-radius:20px;border-bottom-left-radius:20px" >
<div style="height: 5%;width: 100%;background-color: #EEEEEE;border-top-left-radius:20px;border-bottom: 1px solid;"align="center">聊天记录</div>
<div id="userlist" style="height: 93%;width: 100%;">
<c:forEach items="${userlist}" var="user">
<c:choose>
<c:when test="${user.id==choose }">
<div id="${user.id}div"class="userdiv" style="height: 10%;width: 100%;background-color: #AAAAAA" ><a href="#" class="turnuser"id="${user.id }"><img class='img-circle' style='width: 40px;' src='${user.picture}'></a>
${user.name}<button type='button' class='close' value="${user.id}"><span aria-hidden='true'>&times;</span></button></div>
</c:when>
<c:otherwise>
<div id="${user.id}div" class="userdiv" style='height: 10%;width: 100%;background-color: #E6E6E6' ><a href="#" class="turnuser"id="${user.id }"><img class='img-circle' style='width: 40px;' src='${user.picture}'></a>
${user.name}<button type='button' class='close' value="${user.id}"><span aria-hidden='true'>&times;</span></button></div>
</c:otherwise>
</c:choose>
</c:forEach>
</div>
</div>
<div style="border: 1px solid;border-left:none; height: 100%;width:70%;float: left;border-top-right-radius:20px;border-bottom-right-radius:20px">
<div id="chatuser"style="height: 5%;width: 100%;background-color: #EEEEEE;border-top-right-radius:20px;"align="center"></div>
<div id="chatview" style="height: 63%;width: 100%;border: 1px solid;border-left:none;border-right:none; overflow: auto;">
</div>
<textarea id="message" style="width: 100%;height:25%;resize: none;max-height: 25%;max-width: 100%"></textarea>
<button class="btn btn-primary btn-sm" id="sendchat" style="float: right;margin-right:20px;"disabled="true">发送信息</button>
</div>
</div>

</div>


</body>
</html>