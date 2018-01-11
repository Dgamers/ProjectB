package com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageInfo;
import com.pojo.Animation;
import com.pojo.Animationcategory;
import com.service.AnimationService;
import com.service.AnimationcategoryService;

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
			@RequestParam(value="Pagenum",required=false,defaultValue="1") int Pagenum) {
		List<Animationcategory>category=animationcategoryService.selectAllCatagory();
		model.addAttribute("categorys", category);
		List<Animation>animations=animationService.selectByPage(Pagenum,type, order);
		PageInfo<Animation>liInfo=new PageInfo<Animation>(animations);
		model.addAttribute("animations", animations);
		model.addAttribute("type",type);		
		model.addAttribute("order",order);
		model.addAttribute("liInfo", liInfo);
		return "index";
	}
	
}
