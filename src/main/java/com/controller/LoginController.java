package com.controller;

import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.pojo.User;
import com.pojo.UserOperation;
import com.service.UserOperationService;
import com.service.UserService;

@Controller
@RequestMapping("/user")
public class LoginController {
	
	String msg = null;
	
	@Autowired
	private UserService userService;
	
	@Autowired 
	private UserOperationService userOperationService;
	
	@RequestMapping("/initlogin")
	public String initlogin(Model model) {
		msg=null;
		model.addAttribute("msg", msg);
		return "login";
	}
	
	@RequestMapping(value="/login",method=RequestMethod.POST)
	public String login(User user, @RequestParam(value="autologin",required=false,defaultValue="false")Boolean autologin,HttpSession session,HttpServletResponse response,Model model) {
		User checkuser = userService.findByEmail(user.getEmail());
		if (checkuser == null) {
			msg = "该用户不存在";
			model.addAttribute("msg", msg);
			return "login";
		}
		if (!checkuser.getPassword().equals(user.getPassword())) {
			msg = "用户名或密码错误";
			model.addAttribute("msg", msg);
			return "login";
		}
		if (checkuser.getStatus() == 0) {
			msg = "您的账户已被冻结,请联系客服";
			model.addAttribute("msg", msg);
			return "login";
		}
		if(autologin) {
			Cookie cookie1 =new Cookie("GDYKDHemail", user.getEmail());
			cookie1.setMaxAge(60*60*24*7);
			cookie1.setPath("/");
			Cookie cookie2 =new Cookie("GDYKDHpassword", user.getPassword());
			cookie2.setMaxAge(60*60*24*7);
			cookie2.setPath("/");
			response.addCookie(cookie1);
			response.addCookie(cookie2);
		}
		UserOperation userOperation=userOperationService.selectByUserId(checkuser.getId());
		userOperation.setLogintime(new Date());
		userOperation.setUpdatetime(new Date());
		userOperationService.updateByPrimaryKeySelective(userOperation);
		session.setAttribute("user", checkuser);
		return "redirect:/animation/index";
	}

	@RequestMapping(value="/loginout")
	public String loginout(HttpSession session,HttpServletResponse response,HttpServletRequest request) throws Exception {
		session.removeAttribute("user");
		Cookie[] cookies = request.getCookies();
        if (null==cookies) {
            System.out.println("没有cookie");
        } else {
            for(Cookie cookie : cookies){
                if(cookie.getName().equals("GDYKDHemail")){
                    cookie.setValue(null);
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                }
                if(cookie.getName().equals("GDYKDHpassword")){
                    cookie.setValue(null);
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                }
            }
        }
		return "redirect:/animation/index";
	}
}
