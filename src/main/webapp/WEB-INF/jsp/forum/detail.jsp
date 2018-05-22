<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../common.jspf" %>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/boostrappagintor/js/bootstrap-paginator.js"></script>
		<script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/wangEditor/js/wangEditor.min.js"></script>		
		<title>广东药科大学动画网站</title>
<script type="text/javascript">
var editor;
var options = {
        currentPage:'${info.pageNum}', //设置当前页，默认起始页为第一页
        totalPages:'${info.pages}', //总页数
        numberOfPages:5, //设置控件显示的页码数,跟后台计算出来的总页数没多大关系
        bootstrapMajorVersion:3,//如果是bootstrap3版本需要加此标识，并且设置包含分页内容的DOM元素为UL,如果是bootstrap2版本，则DOM包含元素是DIV
        useBootstrapTooltip:'true',//是否显示tip提示框
        pageUrl:function(type,page, current){
         return '${pageContext.request.contextPath }/forum/detail?PageNum='+page+'&id=${forumTheme.id}' //为每个页码设置url访问请求链接，page为页码数
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
function clickon(){
	$('#replybutton').click(function(){
    	if("${sessionScope.user}"){
    		if($('#content').val().length<5){
   	       	 $.confirm({
				    title: '回复失败',
				    content:'主题内容不能少于5个字',
				    buttons: {
				        确认: function () {           
				        },
				    }
				});
    		}else{
    	    	
    			$.ajax({
    				type : 'post',
    				url : '${pageContext.request.contextPath }/forum/reply',
    				contentType : "application/x-www-form-urlencoded;charset=utf-8",
    				data : $('#replyform').serialize(),
    				datatype : 'json',
    				error : function(request) {
    				},
    				success : function(data) {
    					$('#replycontent').append("<div style='min-height: 300px; border: 1px solid #d6d6d6;border-radius: 20px'><div style='width: 20%;min-height: 300px; float: left;border-right:1px solid #eee; 'align='center'class='"+data['id']+"' id='"+data['id']+"'>"+
    							"<div class='media'><div class='media-left' > <a href='${pageContext.request.contextPath }/user/userpage?userid="+data['userid']+"'><img class='img-rounded'src='"+data['userpicture']+"'alt='头像' style='width: 75px;' /></a></div><hr>用户:"+data['username']+"</div></div>"+
    							"<div style='width: 80%;float: left;min-height: 300px;position: relative;'class='"+data['id']+"'>"+data['content']+"<div style='position: absolute; bottom: 0;width: 100%'><a data-toggle='collapse' data-parent='#accordion' href='#collapse"+data['id']+"'>"+
    							"回复(0)</a><div id='collapse"+data['id']+"' class='panel-collapse collapse'style='width: 100%'><div class='panel-body' style='width: 100%'>"+
    							"<textarea style='width: 100% ;'placeholder='回复"+data['username']+"'></textarea><button class='btn btn-primary btn-block' style='float: right;width: 100px'>发表</button></div>"+
    							"</div></div><br></div><div style='clear: both;'></div></div>");
    					editor.txt.clear();
    					unclickoff();
    					clickon();
    				}
    				
    			});
    		}
    	}else{
          	 $.confirm({
 			    title: '回复失败',
 			    content:'请登陆后再回复主题',
 			    buttons: {
 			        确认: function () {           
 			        },
 			    }
 			});
    	}

})	 
        $('.collapse').on('show.bs.collapse', function () {
        	var id=this.id.substr(8);
             $('.'+id).css('height',$('#'+id).height()+300+"px")
})
         $('.collapse').on('hide.bs.collapse', function () {
        	var id=this.id.substr(8);
        	  $('.'+id).css('height','')
})
$(".btn-link").click(function(){
	var ss=this.value.split(",");
	$("#replyarea"+ss[1]).attr('placeholder',"回复"+ss[0]);
	$("#reuserId").val(ss[2]);
	
	
})
$(".replysecond").click(function(){
	var id=this.value;
	if("${sessionScope.user}"){
		if($('#replyarea'+id).val().length<5){
	       	 $.confirm({
				    title: '回复失败',
				    content:'回复内容不能少于5个字',
				    buttons: {
				        确认: function () {           
				        },
				    }
				});
		}else{
			$.ajax({
				type : 'post',
				url : '${pageContext.request.contextPath }/forum/replysecond',
				contentType : "application/x-www-form-urlencoded;charset=utf-8",
				data : $('#secondreply'+id).serialize(),
				datatype : 'json',
				error : function(request) {
				},
				success : function(data) {
					$('#replysecondcontent'+data['layerid']).append("<div class='media'><div class='media-left'><a href='${pageContext.request.contextPath }/user/userpage?userid="+data['userid']+"'> <img class='media-object'src='"+data['userpicture']+"' style='width: 30px;'></a>"+
							"</div><div class='media-body'><h5 class='media-heading'>"+data['username']+"回复"+data['reusername']+"</h5>"+data['content']+
							"<button class='btn btn-link'   style='font-size: 5px' value='"+data['username']+","+data['layerid']+","+data['userid']+"'>回复</button>"+
							"<span style='float: right;'>"+jsonDateFormat(data['createtime'])+"</span></div></div>");
					unclickoff();
					clickon();
			        var chat = $('#replysecondcontent'+data['layerid']);
			        chat.scrollTop(chat[0].scrollHeight); 
				}
				
			});
		}
	}else{
      	 $.confirm({
			    title: '回复失败',
			    content:'请登陆后再回复主题',
			    buttons: {
			        确认: function () {           
			        },
			    }
			});
	}
		

	$("#replyarea"+id).val("");
})
}

function unclickoff(){
	$('#replybutton').unbind('click');
	$('.collapse').off('show.bs.collapse');
	$('.collapse').off('hide.bs.collapse');
	$(".btn-link").unbind('click');
	$(".replysecond").unbind('click');
}
$(function(){
 	var E = window.wangEditor;
	editor = new E('#editor');
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
	editor.create();
	$('#content').val(editor.txt.html());
	clickon();
	 $('.pagination').bootstrapPaginator(options);
})
</script>
</head>
<body>

<%@include file="../header.jsp" %>
<div class="container">
<div class="row">
<div style="width: 100%;min-height:50px; background-color: #4d79ff;color: white; font-size: 20px;border-radius: 10px" >
[${category.name}]${forumTheme.title }
</div>
<br>
<div id="replycontent">
<c:forEach items="${replylist }" var="reply">
<div style="min-height: 300px;border: 1px solid #d6d6d6;border-radius: 20px">
<div style="width: 20%;min-height: 300px; float: left;border-right:1px solid #eee;"align="center"class="${reply.id }" id="${reply.id }">
<div class="media">
					<div class="media-left" > <a href="${pageContext.request.contextPath }/user/userpage?userid=${reply.userid}"><img class="img-rounded"
							src="${reply.userpicture }"
							alt="头像" style="width: 75px;" /></a>
					</div>
					<hr>
				用户:${reply.username}
				</div>

</div>
<div style="width: 80%;float: left;min-height: 300px;position: relative;"class="${reply.id }">
${reply.content}
<div style="position: absolute; bottom: 0;width: 100%">
				<a data-toggle="collapse" data-parent="#accordion" 
				   href="#collapse${reply.id}">
				回复(${fn:length(reply.forumReplySeconds)})
				</a>
		<div id="collapse${reply.id}" class="panel-collapse collapse"style="width: 100%">
			<div class="panel-body" style="width: 100%">
			<div id="replysecondcontent${reply.id}" style="max-height:250px; overflow: auto">
	<c:forEach items="${reply.forumReplySeconds }" var="secondreply">
							<div class="media">
								<div class="media-left">
									<a href="${pageContext.request.contextPath }/user/userpage?userid=${secondreply.userid}"> <img class="media-object"
										src="${secondreply.userpicture}" style="width: 30px;"></a>
								</div>
								<div class="media-body">
									<h5 class="media-heading">${secondreply.username }回复
										${secondreply.reusername }</h5>
									${secondreply.content }
									<button class="btn btn-link"   style="font-size: 5px" value="${secondreply.username},${reply.id},${secondreply.userid}">回复</button>
									<span style="float: right;"><fmt:formatDate type="both" value="${secondreply.createtime}" /></span>
								</div>
							</div>
						</c:forEach>
						</div>
						<form id="secondreply${reply.id}">
			<input type="hidden" id="layerId" name="layerId" value="${reply.id}"/>
			<input type="hidden" id="reuserId" name="reuserId" value="${reply.userid}"/>
			<input type="hidden" name="themeId" value="${forumTheme.id}"/>
			<textarea name="replysecondcontent" id="replyarea${reply.id}"style="width: 100% ;"placeholder="回复${reply.username}" form="secondreply${reply.id}"></textarea>
			<button class="btn btn-primary btn-block replysecond" style="float: right;width: 100px" value="${reply.id}" type="button">发表</button>
						</form>
			</div> 
		</div>

</div>
<br>




					</div>
<div style="clear: both;"></div>
</div>
<br>
</c:forEach>
</div>
<div align="left" >
<ul class="pagination"></ul>
</div>
<br>
<form id="replyform">
    <div id="editor"></div>
  <input type="hidden" id="content" name="content"/>
  <input type="hidden" name="themeId" value="${forumTheme.id}"/>
<button class="btn btn-primary btn-block"  style="width: 100px" id="replybutton" type="button">发表回复</button>
</form>

</div>
</div>
</body>
</html>