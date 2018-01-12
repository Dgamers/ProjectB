package com.admin.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;
import com.pojo.Animation;
import com.pojo.Animationcategory;
import com.service.AnimationService;
import com.service.AnimationcategoryService;
import com.utils.TableResult;

@Controller
@RequestMapping("/admin/animation")
public class AdminAnimationController
{

	@Autowired
	private AnimationcategoryService animationcategoryService;

	@Autowired
	private AnimationService animationService;

	@RequestMapping(value = "/getanimations", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String getPAnimations(Integer pageSize, Integer pageNumber,
	        @RequestParam(value = "search_title", required = false) String search_title,
	        @RequestParam(value = "search_user", required = false) String search_user,
	        @RequestParam(value = "search_category", required = false) Integer search_category,
	        @RequestParam(value = "start_time", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date start_time,
	        @RequestParam(value = "end_time", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date end_time)
	{
		List<Animation> animations = animationService.selectBySearch(pageSize, pageNumber, search_title, search_user,
		        search_category, start_time, end_time);
		PageInfo<Animation> info = new PageInfo<Animation>(animations);
		return JSON.toJSONString(new TableResult<Animation>(animations, info.getTotal()));
	}

	@RequestMapping("/initanimationsadmin")
	public String initPAnimationsAdmin(HttpSession session, Model model)
	{
		/*		Administrator administrator=(Administrator) session.getAttribute("admin");
		if(administrator==null)
			return "redirect:/admin/initlogin";*/
		List<Animationcategory> category = animationcategoryService.selectAllCatagory();
		model.addAttribute("categorys", category);
		return "admin/animationadmin";
	}

}
