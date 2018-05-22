package com.admin.controller;

import java.io.File;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;
import com.pojo.Administrator;
import com.pojo.Animation;
import com.pojo.LearningArticle;
import com.pojo.LearningCategory;
import com.pojo.Notify;
import com.service.LearningArticleService;
import com.service.LearningCategoryService;
import com.utils.FileUploadUtil;
import com.utils.ForumPictureResult;
import com.utils.Result;
import com.utils.TableResult;

@Controller
@RequestMapping("/admin/learn")
public class AdminLearningController {
	
	@Autowired
	private LearningArticleService learningArticleService;
	
	@Autowired 
	private LearningCategoryService learningCategoryService;

	@RequestMapping("initedit")
	public String initeditlearn(Model model) {
		List<LearningCategory>cList=learningCategoryService.selectAllLearningCategory();
		model.addAttribute("cList", cList);
		return "admin/learnadmin";
	}
	
	@RequestMapping(value = "/getlearningarticles", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String getlearningarticles(Integer pageSize, Integer pageNumber,
	        @RequestParam(value = "search_title", required = false) String search_title,
	        @RequestParam(value = "search_edit", required = false) String search_user,
	        @RequestParam(value = "search_category", required = false) Integer search_category,
	        @RequestParam(value = "start_time", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date start_time,
	        @RequestParam(value = "end_time", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date end_time,
	        Integer search_status)throws Exception

	{
		search_title=new String(search_title.getBytes("ISO8859-1"), "UTF-8");
		List<LearningArticle> articles = learningArticleService.selectBySearch(pageSize, pageNumber, search_title, search_user,
		        search_category, start_time, end_time, search_status);
		PageInfo<LearningArticle> info = new PageInfo<LearningArticle>(articles);
		return JSON.toJSONString(new TableResult<LearningArticle>(articles, info.getTotal()));
	}
	
	@RequestMapping(value = "/changestatus", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String changeStatus(Integer Id, HttpSession session)
	{
		LearningArticle  article = learningArticleService.selectByPrimaryKey(Id);
		if (article.getStatus() == 0)
		{
			article.setStatus(1);
		}
		else
		{
			article.setStatus(0);
		}
		learningArticleService.updateByPrimaryKeySelective(article);
		TableResult<LearningArticle> result = new TableResult<LearningArticle>();
		result.setRow(article);
		return JSON.toJSONString(result);
	}
	
	@RequestMapping(value="/uploadcontentpicture",method=RequestMethod.POST)
	@ResponseBody
	public String uploadcontentpicture(MultipartFile picturename,HttpServletRequest request) {
		String dir = "picture/learn/";
		String path = request.getSession().getServletContext().getRealPath(dir);
		String fileName = FileUploadUtil.rename(picturename.getOriginalFilename());
		File targetFile = new File(path, fileName);
		try {  
	          if(!targetFile.exists()){   
	        	  picturename.transferTo(targetFile);
	          }  
	      } catch (Exception e) {  
	          e.printStackTrace();  
	          JSON.toJSONString(new ForumPictureResult(1, null));
	      }  
		String []data= {request.getSession().getServletContext().getContextPath()+"/"+dir+fileName};
		 return JSON.toJSONString(new ForumPictureResult(0, data));
   
	}
	
	@RequestMapping(value="/uploadtitlepicture",method=RequestMethod.POST)
	@ResponseBody
	public String uploadtitlepicture(MultipartFile image,HttpServletRequest request) {
		String dir = "picture/learntitle/";
		String path = request.getSession().getServletContext().getRealPath(dir);
		String fileName = FileUploadUtil.rename(image.getOriginalFilename());
		File targetFile = new File(path, fileName);
		try {  
	          if(!targetFile.exists()){   
	           image.transferTo(targetFile);
	          }  
	      } catch (Exception e) {  
	          e.printStackTrace();  
	          return JSON.toJSONString(new Result("failed", 100));
	      }  
        return JSON.toJSONString(new Result(request.getSession().getServletContext().getContextPath()+"/"+dir+fileName, 100));
	}
	
	@RequestMapping(value="/savearticle",method=RequestMethod.POST)
	public String savearticle(String title,String content,Integer category,String picture,HttpSession session) {
		Administrator administrator=(Administrator) session.getAttribute("admin");
		LearningArticle learningArticle=new LearningArticle();
		learningArticle.setCategory(category);
		learningArticle.setContent(content);
		learningArticle.setEditid(administrator.getId());
		learningArticle.setPicture(picture);
		learningArticle.setTitle(title);
		learningArticle.setCreatetime(new Date());
		learningArticle.setUpdatetime(new Date());
		learningArticle.setStatus(1);
		learningArticleService.insert(learningArticle);
		return "admin/learnadmin";
	}

}
