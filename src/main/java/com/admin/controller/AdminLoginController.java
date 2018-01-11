package com.admin.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.pojo.Administrator;
import com.service.AdministratorService;

@Controller
@RequestMapping("/admin")
public class AdminLoginController {
	
	String msg;
	
	@Autowired
	private AdministratorService administratorService;

	@RequestMapping("/initlogin")
	public String iniLogin(Model model) {
		msg=null;
		model.addAttribute("msg", msg);
		return "admin/login";
	}
	
	@RequestMapping(value="/login",method=RequestMethod.POST)
	public String login(Administrator administrator,Model model,HttpSession session) {
		Administrator admin=administratorService.selectByname(administrator.getName());
		if(admin!=null) {
			if(admin.getPassword().equals(administrator.getPassword())) {
				session.setAttribute("admin", admin);
				return "admin/useradmin";
			}
		}	
		msg="用户名或密码错误";
		model.addAttribute("msg", msg);
		return "admin/login";
	}
	
}
