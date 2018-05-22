package com.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageInfo;
import com.pojo.Animation;
import com.pojo.Animationcategory;
import com.pojo.ChatRoom;
import com.service.AnimationService;
import com.service.AnimationcategoryService;
import com.service.ChatRoomService;
import com.serviceImpl.ChatRoomServiceImpl;

@Controller
@RequestMapping("/animation")
public class AnimationIndexController {
	
	@Autowired
	private AnimationcategoryService animationcategoryService;
	@Autowired
	private AnimationService animationService;
	@RequestMapping("/index")
	public String initindex(Model model,
			@RequestParam(value="type",required=false,defaultValue="0")int type,
			@RequestParam(value="order",required=false,defaultValue="1") int order,
			@RequestParam(value="Pagenum",required=false,defaultValue="1") int Pagenum,
			@RequestParam(value="keyword",required=false,defaultValue="")String keyword)throws Exception {
		keyword  = new String(keyword.getBytes("ISO8859-1"), "UTF-8");
		System.out.println(keyword);
		List<Animationcategory>category=animationcategoryService.selectAllCatagory();
		model.addAttribute("categorys", category);
		List<Animation>animations=animationService.selectByPage(keyword,Pagenum,type, order);
		PageInfo<Animation>liInfo=new PageInfo<Animation>(animations);
		model.addAttribute("keyword", keyword);
		model.addAttribute("animations", animations);
		model.addAttribute("type",type);		
		model.addAttribute("order",order);
		model.addAttribute("liInfo", liInfo);
		return "index";
	}
	
}
