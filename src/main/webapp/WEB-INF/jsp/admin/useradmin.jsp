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
<title>用户管理</title>
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
    $('#usersinfo').bootstrapTable({
        url: '${pageContext.request.contextPath}/admin/user/getusers',  //请求后台的URL（*）
        contentType : 'application/x-www-form-urlencoded',
        method: 'get',                      //请求方式（*）
        toolbar: '#toolbar',                //工具按钮用哪个容器
        striped: true,                      //是否显示行间隔色
        cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
        pagination: true,                   //是否显示分页（*）
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
            field: 'name',
            title: '用户名'
        }, {
            field: 'realname',
            title: '真实姓名'
        }, {
            field: 'sex',
            title: '性别',
            formatter : function (value, row, index) {
                if (value == 1) {
                    return '男';
                }
                if (value == 2) {
                    return '女';
                }
                if (value == 3) {
                    return '保密';
                }
                return value;
            }
        }, {
            field: 'email',
            title: '邮箱'
        }, {
            field: 'phone',
            title: '联系电话'
        },
        {
            field: 'createtime',
            title: '创建时间',
            formatter: function (value, row, index) {
                return changeDateFormat(value)
            }
        },
        {
            field: 'status',
            title: '状态',
            formatter : function (value, row, index) {
                if (value == 1) {
                    return '正常';
                }
                if (value== 0) {
                    return '冻结';
                }
                return value;
            }
        },
        {
            field: 'action',
            title: '操作',
            events: window.operateEvents = {
            	    'click .btn-xs':function (e, value, row, index){
						$.confirm({
						    title: '确认改变此账号状态？',
						    content: '',
						    buttons: {
						          确认: function () {
			            	        $.ajax({
			            	            type : "get",
			            	            url : "${pageContext.request.contextPath}/admin/user/changestatus",
			            	            data : {
			            	                Id : row['id']
			            	            },
			            	            dataType : 'JSON',
			            	            success : function (data) {
			            	            	row=data['row'];
			            	                $("#usersinfo").bootstrapTable('updateRow', {
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
                    return '<button type="button" class="btn btn-default btn-xs">冻结账号</button>';
                }
                if (row['status']== 0) {
                    return '<button type="button" class="btn btn-default btn-xs">解除冻结</button>';
                }
                return value;
            }
        },]
    });
	
    function queryParams(params) {
        return {
        	pageSize:params.pageSize,
        	pageNumber:params.pageNumber,
        	search_name:$("#search_name").val(),
        	search_email:$("#search_email").val(),
        	search_phone:$("#search_phone").val(),
        	start_time:$("#start_time").val(),
        	end_time:$("#end_time").val(),
        	search_status:$("#search_status").val()
        };
    }
    $("#start_search").click(function(){
    	$("#usersinfo").bootstrapTable('removeAll');
    	$('#usersinfo').bootstrapTable('refresh');  
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
							for="search_name">用户名</label>
						<div class="col-sm-3">
							<input type="text" class="form-control"
								id="search_name">
						</div>
						<label class="control-label col-sm-1" for="search_email">邮件</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="search_email">
						</div>
						
			            <label class="control-label col-sm-1" for="search_phone">联系电话</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" id="search_phone">
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
                                <option value="0">冻结</option>
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
<table id="usersinfo"></table>
</div>
</body>
</html>