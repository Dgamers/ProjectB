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
<script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/boostraptable/js/bootstrap-table.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/plugins/boostraptable/js/bootstrap-table-zh-CN.min.js"></script>
<title>动画管理</title>
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
$(function() {
    $('#animationsinfo').bootstrapTable({
        url: '${pageContext.request.contextPath}/admin/animation/getanimations',  //请求后台的URL（*）
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
            title: '动画标题'
        }, {
            field: 'content',
            title: '动画介绍',
            cellStyle : function (value, row, index) {
                return {
                    css: {
                    	"max-width":"250px",
                        "word-wrap": "break-word",
                        "word-break": "normal"
                    }
                };
            },
            formatter : function (value, row, index) {
                return "<div style=' overflow-y:auto; overflow-x:auto;  height:60px;'>"+value+"</div>"                
        },
        }, {
            field: 'address',
            title: '动画作品',
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
                	    	 $('#Modal iframe').attr('src', value);
                	    }     	    		
                	    },
        }, {
            field: 'picture',
            title: '封面',
            formatter : function (value, row, index) {
                return "<input id='link' type=image src="+value+" style='height:60px;'/>"             
        },  
                 events: window.operateEvents = {
        	    'click #link':function (e, value, row, index){
       	    	 $('#Modal iframe').attr('src', value);
       	    	 $('#Modal').modal('show');
       	    }     	    		
       	    },
        }, {
            field: 'username',
            title: '上传用户'
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
						    title: '确认改变此动画状态？',
						    content: '',
						    buttons: {
						          确认: function () {
			            	        $.ajax({
			            	            type : "get",
			            	            url : "${pageContext.request.contextPath}/admin/animation/changestatus",
			            	            data : {
			            	                Id : row['id']
			            	            },
			            	            dataType : 'JSON',
			            	            success : function (data) {
			            	            	row=data['row'];
			            	                $("#animationsinfo").bootstrapTable('updateRow', {
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
                    return '<button type="button" class="btn btn-default btn-xs">下线作品</button>';
                }
                if (row['status']== 0) {
                    return '<button type="button" class="btn btn-default btn-xs">恢复作品状态</button>';
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
        	search_user:$("#search_user").val(),
        	search_category:$("#search_category ").val(),
        	start_time:$("#start_time").val(),
        	end_time:$("#end_time").val(),
        	search_status:$("#search_status").val()
        };
    }
$("#close").click(function(){
	$('#Modal iframe').removeAttr('src');
});
$("#start_search").click(function(){
	$("#animationsinfo").bootstrapTable('removeAll');
	$('#animationsinfo').bootstrapTable('refresh');  
});
});

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
							for="search_title">动画标题</label>
						<div class="col-sm-3">
							<input type="text" class="form-control"
								id="search_title">
						</div>
						<label class="control-label col-sm-1" for="search_user">上传用户</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="search_user">
						</div>
						
			            <label class="control-label col-sm-1" for="search_category">动画类别</label>
						<div class="col-sm-3">
						<select id="search_category" name="search_category"
								class="selectpicker show-tick form-control" 
								data-live-search="false">
								<option value="0">请选择一项类别</option>
								<c:forEach items="${categorys }" var="category">
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
						 <label class="control-label col-sm-1" for="search_status">动画状态</label>
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
<table id="animationsinfo"></table>
</div>
<div class="modal fade bs-example-modal-lg" id="Modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-body">
     	<div class="embed-responsive embed-responsive-16by9" >
		 <iframe  class="embed-responsive-item" id="preview" ></iframe>
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" id="close" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>