package com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageInfo;
import com.pojo.LearningArticle;
import com.pojo.LearningCategory;
import com.service.LearningArticleService;
import com.service.LearningCategoryService;


@Controller
@RequestMapping(value="/learn")
public class LearnController {

	@Autowired
	private LearningArticleService learningArticleService;
	
	@Autowired
	private LearningCategoryService learningCategoryService;
	
	@RequestMapping("/initlearn")
	public String initlearn(Model model,
			@RequestParam(value="Pagenum",required=false,defaultValue="1") int Pagenum,
			@RequestParam(value="searchcategory",required=false,defaultValue="0") int category,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword) {
	    List<LearningArticle>articles=learningArticleService.getarticles(Pagenum, 1,keyword,category);
	    List<LearningCategory>categories=learningCategoryService.selectAllLearningCategory();
	    PageInfo<LearningArticle>info=new PageInfo<LearningArticle>(articles);
	    model.addAttribute("articles", articles);
	    model.addAttribute("info", info);
	    model.addAttribute("categories", categories);
	    model.addAttribute("searchcategory", category);
		return "learn/list";
	}
	
	@RequestMapping("/detail")
	public String detail(Model model,Integer id) {
        LearningArticle learningArticle=learningArticleService.selectByPrimaryKey(id);
        LearningCategory category=learningCategoryService.selectByPrimaryKey(learningArticle.getCategory());
        model.addAttribute("article", learningArticle);
        model.addAttribute("category", category);
		return "learn/detail";
	}
}
