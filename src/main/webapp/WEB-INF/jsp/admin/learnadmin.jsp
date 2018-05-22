<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="../common.jspf"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/plugins/boostraptable/css/bootstrap-table.min.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/wangEditor-fullscreen-plugin.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/plugins/fileinput/css/fileinput.min.css" />	
<script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/boostraptable/js/bootstrap-table.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/boostraptable/js/bootstrap-table-zh-CN.min.js"></script>
<script type="text/javascript" 
	src="${pageContext.request.contextPath}/plugins/wangEditor/js/wangEditor.min.js"></script>	
<script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/wangEditor/js/wangEditor-fullscreen-plugin.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/fileinput/js/fileinput.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/fileinput/js/locales/zh.js"></script>	
<title>学习专题管理</title>
<script type="text/javascript">
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
	editor.customConfig.uploadImgServer = '${pageContext.request.contextPath}/admin/learn/uploadcontentpicture'
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
	E.fullscreen.init('#editor');
	$('#content').val(editor.txt.html());
	
	$('#view').click(function(){
		$('.modal-body').html(editor.txt.html());
	})
	$('#image').fileinput({
		language: 'zh',
		uploadUrl: "${pageContext.request.contextPath}/admin/learn/uploadtitlepicture",
		maxFileCount:1,
		dropZoneEnabled: false,
		allowedFileExtensions: ['jpg', 'gif', 'png'],
		uploadAsync: true,
	    showUpload : true, //是否显示上传按钮,跟随文本框的那个
	    showRemove : false, //显示移除按钮,跟随文本框的那个
	    showCaption : false,//是否显示标题,就是那个文本框
	});
	$("#image").on("fileuploaded", function(event, data, previewId, index) {
		var paddress=data.response.message;
		alert(paddress)
		$('#picture').val(paddress)
		});
		
	$('#image').on('filesuccessremove', function(event, id) {
		$('#picture').val("")
	});
	$('#save').click(function() {
		var message="";
		var issue=0;
		if($('#title').val()==""){
			message=message+"文章标题不能为空<br>";
			issue=1;
			}
		if($('#picture').val()==""){
			message=message+"标题封面没有上传<br>";	
			issue=1;
		}
       if(editor.txt.html()==""){
			message=message+"没有文章内容<br>";	
			issue=1;
       }
		if(issue==1){
			$.confirm({
			    title: '提交失败',
			    content: message,
			    buttons: {
			        确认: function () {           
			        },
			    }
			});
		}else{
	        $('#learnarticle').submit();
		}
			
	});
	
    $('#learningarticlesinfo').bootstrapTable({
        url: '${pageContext.request.contextPath}/admin/learn/getlearningarticles',  //请求后台的URL（*）
        contentType : 'application/x-www-form-urlencoded',
        method: 'get',                      //请求方式（*）
        toolbar: '#toolbar',                //工具按钮用哪个容器
        striped: true,                      //是否显示行间隔色
        cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
        pagination: true,                   //是否显示分页（*）
        sortable: true,                     //是否启用排序
        sortOrder: "asc",                   //排序方式
        queryParams: queryParams,
        queryParamsType : "",//传递参数（*）
        sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
        pageNumber:1,                       //初始化加载第一页，默认第一页
        pageSize: 10,                       //每页的记录行数（*）
        pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
        showColumns: false,                  //是否显示所有的列
        clickToSelect: true,                //是否启用点击选中行
        uniqueId: "id",                     //每一行的唯一标识，一般为主键列
        columns: [
        	{
                field: 'id',
                title: 'ID'
            },{
            field: 'title',
            title: '文章标题'
        }, {
            field: 'content',
            title: '文章内容',
            formatter : function (value, row, index) {
                return '<button type="button" id="show" class="btn btn-default"  data-toggle="modal" data-target="#Modal">点击观看</button>';
            },
        cellStyle : function (value, row, index) {
                return {
                    css: {
                    	"text-align": "center",
                    	"vertical-align":"middle"
                    }
                };
            },
            events: window.operateEvents = {
            	    'click #show':function (e, value, row, index){
            	    	 $('#Modal .modal-body').html(value);
            	    }     	    		
      },

        }, {
            field: 'picture',
            title: '文章封面',
            formatter : function (value, row, index) {
                return "<input id='link' type=image src="+value+" style='height:60px;'/>"             
        },  
                 events: window.operateEvents = {
        	    'click #link':function (e, value, row, index){
       	    	 var html="<div class='embed-responsive embed-responsive-16by9' ><iframe  class='embed-responsive-item' id='preview'src="+value+" ></iframe></div>";
       	    	 $('#Modal .modal-body').html(html);
       	    	 $('#Modal').modal('show');
       	    }     	    		
       	    },
        }, {
            field: 'editname',
            title: '编辑员'
        },
        {
            field: 'createtime',
            title: '创建时间',
            formatter: function (value, row, index) {
                return changeDateFormat(value)
            }
        },
        {
            field: 'categoryname',
            title: '类别',
        },{
        	field:'status',
        	title:'状态',
            formatter : function (value, row, index) {
                if (value == 1) {
                    return '正常';
                }
                if (value== 0) {
                    return '下线';
                }
                return value;   
        }
        },        {
            field: 'action',
            title: '操作',
            events: window.operateEvents = {
            	    'click .btn-xs':function (e, value, row, index){
						$.confirm({
						    title: '确认改变此文章状态？',
						    content: '',
						    buttons: {
						          确认: function () {
			            	        $.ajax({
			            	            type : "get",
			            	            url : "${pageContext.request.contextPath}/admin/learn/changestatus",
			            	            data : {
			            	                Id : row['id']
			            	            },
			            	            dataType : 'JSON',
			            	            success : function (data) {
			            	            	row=data['row'];
			            	                $("#learningarticlesinfo").bootstrapTable('updateRow', {
			            	                	 index:index,
			            	                     row:row,
			            	                });
			            	            }
			            	        });
						        },
						       关闭: function () { }
						    }
						});

            	    }     	    		
            	    },
            formatter : function (value, row, index) {
                if (row['status']== 1) {
                    return '<button type="button" class="btn btn-default btn-xs">下线文章</button>';
                }
                if (row['status']== 0) {
                    return '<button type="button" class="btn btn-default btn-xs">恢复文章状态</button>';
                }
                return value;
            }
        }]
    });
    function queryParams(params) {
        return {
        	pageSize:params.pageSize,
        	pageNumber:params.pageNumber,
        	search_title:$("#search_title").val(),
        	search_user:$("#search_edit").val(),
        	search_category:$("#search_category ").val(),
        	start_time:$("#start_time").val(),
        	end_time:$("#end_time").val(),
        	search_status:$("#search_status").val()
        };
    }
    $("#start_search").click(function(){
    	$("#learningarticlesinfo").bootstrapTable('removeAll');
    	$('#learningarticlesinfo').bootstrapTable('refresh');  
    });
    $("#close").click(function(){
    	$('#Modal .modal-body').html("");
    });
})
</script>


</head>
<body>
<%@include file="header.jsp"%>
	<div class="panel-body" style="padding-bottom: 0px;">
		<div class="panel panel-default">
			<div class="panel-heading">查询条件</div>
			<div class="panel-body">
				<form id="formSearch" class="form-horizontal">
					<div class="form-group" style="margin-top: 15px">
						<label class="control-label col-sm-1"
							for="search_title">文章标题</label>
						<div class="col-sm-3">
							<input type="text" class="form-control"
								id="search_title">
						</div>
						<label class="control-label col-sm-1" for="search_edit">编辑员</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="search_user">
						</div>
						
			            <label class="control-label col-sm-1" for="search_category">文章类别</label>
						<div class="col-sm-3">
						<select id="search_category" name="search_category"
								class="selectpicker show-tick form-control" 
								data-live-search="false">
								<option value="0">请选择一项类别</option>
								<c:forEach items="${cList }" var="category">
								<option value="${category.id}">${category.name}</option>
								</c:forEach>
							</select>
						</div>
						<br><br><br>
						<label class="control-label col-sm-1" for="start_time">开始时间</label>
						<div class="col-sm-3">
							<input type="date" class="form-control" id="start_time">
						</div>
						<label class="control-label col-sm-1" for="end_time">结束时间</label>
						<div class="col-sm-3">
							<input type="date" class="form-control" id="end_time">
						</div>
						 <label class="control-label col-sm-1" for="search_status">文章状态</label>
					 <div class="col-sm-1">
						<select id="search_status" name="search_status"
								class="selectpicker show-tick form-control" 
								data-live-search="false">
								<option value="3">无</option>
								<option value="1">正常</option>
                                <option value="0">下线</option>
							</select>
						</div>
						<div class="col-sm-1" style="text-align: left;">
							<button type="button" style="margin-left: 100px" id="start_search"
								class="btn btn-primary">查询</button>
						</div>
					</div>
				</form>
			</div>
		</div>
<table id="learningarticlesinfo"></table>
</div>
<hr>
<div class="container">
<div class="row">
<form action="${pageContext.request.contextPath}/admin/learn/savearticle" id="learnarticle" method="post">
				<div class="form-group">
						<label for="title" class="col-sm-1 control-label">文章标题</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="title" id="title" >
						</div>
					</div>
<br><br><br>
					<div class="form-group">
						<label class="col-sm-1 control-label">标题封面</label>
						<div class="col-sm-3">
							<input id="image" type="file" name="image"  />
							
						</div>
					</div>
<br>
<br>
						<div class="form-group">
					<label for="category" class="col-sm-1 control-label">动画类别</label>
						<div class="col-sm-3">
							<select id="category" name="category"
								class="selectpicker show-tick form-control" 
								data-live-search="false">
								<c:forEach items="${cList }" var="category">
								<option value="${category.id}">${category.name}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<br><br><br>
<div class="form-group">
<div id="editor" class="col-sm-12" ></div>
</div>
<input type="hidden" id="content" name="content" />
<input id="picture" type="hidden" name="picture"/>
<div class="form-group">
<div class="col-sm-3">
<button type="button" id="save" class="btn btn-primary">发表</button>
</div>
</div>
</form>
</div>
</div>
<div class="modal fade bs-example-modal-lg" id="Modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-body">

      </div>
      <div class="modal-footer">
        <button type="button" id="close" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>