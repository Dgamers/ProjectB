package com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.pojo.Animation;
import com.pojo.User;
import com.service.AnimationService;
import com.service.UserService;

@Controller
@RequestMapping("/user")
public class UserPageController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private AnimationService animationService;
	
	@RequestMapping("/userpage")
	public String inituserpage(Model model,Integer userid,
			@RequestParam(value="order",required=false,defaultValue="1") int order,
			@RequestParam(value="Pagenum",required=false,defaultValue="1") int Pagenum) {
		User user=userService.selectByPrimaryKey(userid);
		List<Animation> animations=animationService.selectByuserId(userid, Pagenum, order);
		PageInfo<Animation>liInfo=new PageInfo<Animation>(animations);
		model.addAttribute("upper", user);
		model.addAttribute("animations", animations);
		model.addAttribute("order",order);
		model.addAttribute("liInfo", liInfo);
		return "user/userpage";
	}
	
	@RequestMapping("/updateainfo")
	@ResponseBody
	public String inituserpage(Integer animationid,String title,String content) {
		Animation animation=new Animation();
		animation.setId(animationid);
		animation.setTitle(title);
		animation.setContent(content);
		animationService.updateByPrimaryKeySelective(animation);
		return "success";	
	}
	
	@RequestMapping("/changestatus")
	@ResponseBody
	public String inituserpage(Integer animationid,Integer status) {
		Animation animation=new Animation();
		animation.setId(animationid);
        animation.setStatus(status);
		animationService.updateByPrimaryKeySelective(animation);
		return "success";	
	}
}
