package com.admin.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;
import com.pojo.Administrator;
import com.pojo.User;
import com.service.UserService;
import com.utils.TableResult;

@Controller
@RequestMapping("/admin/user")
public class AdminUserController {
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("/inituseradmin")
	public String initUserAdmin(HttpSession session) {
		Administrator administrator=(Administrator) session.getAttribute("admin");
		if(administrator==null)
			return "redirect:/admin/initlogin";
		return "admin/useradmin";
	}
	
	@RequestMapping(value="/getusers",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String getUsers(Integer pageSize,Integer pageNumber,
			@RequestParam(value="search_name",required=false)String search_name,
			@RequestParam(value="search_email",required=false)String search_email,
			@RequestParam(value="search_phone",required=false)String search_phone,
			@RequestParam(value="start_time",required=false)@DateTimeFormat(pattern="yyyy-MM-dd")Date start_time,
			@RequestParam(value="end_time",required=false)@DateTimeFormat(pattern="yyyy-MM-dd")Date end_time) {
		List<User>users=userService.selectByPage(pageSize, pageNumber,search_name,search_email,search_phone,start_time,end_time);
		PageInfo<User>liInfo=new PageInfo<User>(users);
		return JSON.toJSONString(new TableResult<User>(users, liInfo.getTotal()));
	}

	@RequestMapping(value="/changestatus",produces = "application/json; charset=utf-8")
	@ResponseBody
	public String changeStatus(Integer Id) {
        System.out.println(Id);
        User user=userService.selectByPrimaryKey(Id);
        if(user.getStatus()==0)
        user.setStatus(1);
        else
        user.setStatus(0);
        userService.updateByPrimaryKeySelective(user);
        TableResult<User>result=new TableResult<User>();
        result.setRow(user);
		return JSON.toJSONString(result);
	}
}
