package com.admin.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pojo.Animationcategory;
import com.pojo.ForumCategory;
import com.pojo.LearningCategory;
import com.service.AnimationcategoryService;
import com.service.ForumCategoryService;
import com.service.LearningCategoryService;

@RequestMapping("/admin/category")
@Controller
public class AdminCategoryController {

	@Autowired
	private AnimationcategoryService animationcategoryService;
	
	@Autowired
	private ForumCategoryService forumCategoryService;
	
	@Autowired
	private LearningCategoryService learningCategoryService;
	
	@RequestMapping("/initcategory")
	public String initinitcategory(Model model) {
		List<Animationcategory> acategorylist=animationcategoryService.selectAllCatagory();
		List<ForumCategory>fcategorylist=forumCategoryService.selectAllForumCategory();
		List<LearningCategory>lcategroylist=learningCategoryService.selectAllLearningCategory();
		model.addAttribute("acategorylist", acategorylist);
		model.addAttribute("fcategorylist", fcategorylist);
		model.addAttribute("lcategroylist", lcategroylist);
		return "admin/categoryadmin";
	}
	
	@RequestMapping("/updatecategory")
	@ResponseBody
	public String updatecategory(Integer categoryid,String name,Integer type)throws Exception {
		name=new String(name.getBytes("ISO8859-1"), "UTF-8");
		if(type==1) {
			Animationcategory animationcategory=new Animationcategory();
			animationcategory.setId(categoryid);
			animationcategory.setName(name);
			animationcategory.setUpdatetime(new Date());
			animationcategoryService.updateByPrimaryKeySelective(animationcategory);
		}
		if(type==2) {
			ForumCategory forumCategory=new ForumCategory();
			forumCategory.setId(categoryid);
			forumCategory.setName(name);
			forumCategory.setUpdatetime(new Date());
			forumCategoryService.updateByPrimaryKeySelective(forumCategory);
		}
		if(type==3) {
			LearningCategory learningCategory=new LearningCategory();
			learningCategory.setId(categoryid);
			learningCategory.setName(name);
			learningCategory.setUpdatetime(new Date());
			learningCategoryService.updateByPrimaryKeySelective(learningCategory);
		}
		return "success";
	}
	
	@RequestMapping("/deletecategory")
	@ResponseBody
	public String deletecategory(Integer categoryid,Integer type)throws Exception {
		if(type==1) {
			animationcategoryService.deleteByPrimaryKey(categoryid);
		}
		if(type==2) {
			forumCategoryService.deleteByPrimaryKey(categoryid);
		}
		if(type==3) {
			learningCategoryService.deleteByPrimaryKey(categoryid);
		}
		return "success";
	}
	
	@RequestMapping("/insertcategory")
	@ResponseBody
	public String insertcategory(String name,Integer type)throws Exception {
		name=new String(name.getBytes("ISO8859-1"), "UTF-8");
		if(type==1) {
			Animationcategory animationcategory=new Animationcategory();
			animationcategory.setName(name);
			animationcategory.setUpdatetime(new Date());
			animationcategory.setCreatetime(new Date());
			animationcategoryService.insert(animationcategory);
		}
		if(type==2) {
			ForumCategory forumCategory=new ForumCategory();
			forumCategory.setName(name);
			forumCategory.setUpdatetime(new Date());
			forumCategory.setCreatetime(new Date());
			forumCategoryService.insert(forumCategory);
		}
		if(type==3) {
			LearningCategory learningCategory=new LearningCategory();
			learningCategory.setName(name);
			learningCategory.setUpdatetime(new Date());
			learningCategory.setCreatetime(new Date());
			learningCategoryService.insert(learningCategory);
		}
		return "success";
	}
}
