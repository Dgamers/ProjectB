package com.controller;

import java.io.File;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.pojo.Animationcategory;
import com.pojo.Pendinganimation;
import com.pojo.User;
import com.service.AnimationcategoryService;
import com.service.PendinganimationService;
import com.utils.FileUploadUtil;
import com.utils.Result;

@Controller 
@RequestMapping("/animation")
public class AnimationuploadController {
	
	
	@Autowired
	private AnimationcategoryService animationcategoryService;
	
	@Autowired
	private PendinganimationService PendinganimationService;
	
	@RequestMapping("/initupload")
	public String initupload(Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null)
			return "redirect:/animation/index";
		else {
			List<Animationcategory> category = animationcategoryService.selectAllCatagory();
			model.addAttribute("categorys", category);
			return "animation/upload";
		}
	}

	@RequestMapping(value="/uploadpicture",method=RequestMethod.POST)
	@ResponseBody
	public String uploadpicture(MultipartFile image,HttpServletRequest request) {
		String dir = "picture/animation/";
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
	
	@RequestMapping(value="/uploadanimation",method=RequestMethod.POST)
	@ResponseBody
	public String uploadvideo(MultipartFile video,HttpServletRequest request) {
		String dir = "animation/";
		String path = request.getSession().getServletContext().getRealPath(dir);
		String fileName = FileUploadUtil.rename(video.getOriginalFilename());
		File targetFile = new File(path, fileName);
		try {  
	          if(!targetFile.exists()){   
	        	  video.transferTo(targetFile);
	          }  
	      } catch (Exception e) {  
	          e.printStackTrace();  
	          return JSON.toJSONString(new Result("failed", 100));
	      }  
        return JSON.toJSONString(new Result(request.getSession().getServletContext().getContextPath()+"/"+dir+fileName, 100));
	}
	
	@RequestMapping(value="/saveanimation",method=RequestMethod.POST)
	public String savevideo(Pendinganimation pendinganimation,HttpSession session)throws Exception {
		User user=(User) session.getAttribute("user");
		pendinganimation.setUserid(user.getId());
		pendinganimation.setCreatetime(new Date());
		pendinganimation.setUpdatetime(new Date());
		PendinganimationService.insertSelective(pendinganimation);
        return "animation/success";
	}

}
