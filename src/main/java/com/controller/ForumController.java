package com.controller;

import java.io.File;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageInfo;
import com.pojo.ForumCategory;
import com.pojo.ForumReply;
import com.pojo.ForumReplySecond;
import com.pojo.ForumTheme;
import com.pojo.Notify;
import com.pojo.User;
import com.pojo.UserOperation;
import com.pojo.VerifyingMailbox;
import com.service.ForumCategoryService;
import com.service.ForumReplySecondService;
import com.service.ForumReplyService;
import com.service.ForumThemeService;
import com.service.NotifyService;
import com.service.UserOperationService;
import com.service.UserService;
import com.service.VerifyingMailboxService;
import com.utils.CheckCode;
import com.utils.FileUploadUtil;
import com.utils.ForumPictureResult;
import com.utils.ImgCut;
import com.utils.MailUtil;
import com.utils.Result;
import com.utils.TableResult;

@Controller
@RequestMapping("/forum")
public class ForumController {
	
	@Autowired
	private ForumThemeService forumThemeService;
	
	@Autowired
	private ForumReplyService forumReplyService;
	
	@Autowired
	private ForumReplySecondService forumReplySecondService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ForumCategoryService forumCategoryService;
	
	@Autowired
	private NotifyService notifyService;

	@RequestMapping("/detail")
	public String showdetail(Integer id,Model model,@RequestParam(value="PageNum",required=false,defaultValue="1") int PageNum) {
		ForumTheme forumTheme= forumThemeService.selectByPrimaryKey(id);
		if(forumTheme==null) {
			return"forum/error";
		}
		ForumCategory category=forumCategoryService.selectByPrimaryKey(forumTheme.getCategory());
		List<ForumReply>replylist=forumReplyService.selectReplyByThemeid(id,PageNum);
		PageInfo<ForumReply>info=new PageInfo<ForumReply>(replylist);
		model.addAttribute("forumTheme", forumTheme);
		model.addAttribute("replylist", replylist);
		model.addAttribute("info", info);
		model.addAttribute("category", category);
		return "forum/detail";
	}
	
	@RequestMapping("/initlist")
	public String initlist(Model model, 
			@RequestParam(value="PageNum",required=false,defaultValue="1") int PageNum,
			@RequestParam(value="order",required=false,defaultValue="1") int order,
			@RequestParam(value="keyword",required=false,defaultValue="")String keyword,
			@RequestParam(value="searchcategory",required=false,defaultValue="0")Integer category,
			HttpSession  session)throws Exception {
		keyword  = new String(keyword.getBytes("ISO8859-1"), "UTF-8");
		Integer userid=null;
		if(order==0) {
			User user=(User) session.getAttribute("user");
			userid=user.getId();
		}
		List<ForumTheme>list=forumThemeService.selectAllForumTheme(PageNum, 5,order,category,keyword,userid);
		PageInfo<ForumTheme>info=new PageInfo<ForumTheme>(list);
		List<ForumCategory>categories=forumCategoryService.selectAllForumCategory();
		model.addAttribute("order", order);
		model.addAttribute("categories", categories);
		model.addAttribute("list", list);
		model.addAttribute("info", info);
		model.addAttribute("keyword", keyword);
		model.addAttribute("searchcategory", category);
		return "forum/list";
	}
	
	@RequestMapping(value="/publish",method=RequestMethod.POST)
	public String publish(String title,String content,Integer category,HttpSession session) {
		User user=(User) session.getAttribute("user");
		ForumTheme forumTheme=new ForumTheme();
		forumTheme.setCategory(category);
		forumTheme.setCreatetime(new Date());
		forumTheme.setUpdatetime(new Date());
		forumTheme.setTitle(title);
		forumTheme.setUserid(user.getId());
		forumThemeService.insert(forumTheme);
		ForumReply forumReply=new ForumReply();
		forumReply.setContent(content);
		forumReply.setCreatetime(new Date());
		forumReply.setUserid(user.getId());
		forumReply.setThemeid(forumTheme.getId());
		forumReplyService.insert(forumReply);
		return "redirect:/forum/detail?id="+forumTheme.getId();
	}
	
	@RequestMapping(value="/reply",method=RequestMethod.POST,produces = "application/json; charset=utf-8")
	@ResponseBody
	public String reply(Integer themeId,String content,HttpSession session) {
		User user=(User) session.getAttribute("user");
		ForumReply forumReply=new ForumReply();
		forumReply.setContent(content);
		forumReply.setCreatetime(new Date());
		forumReply.setUserid(user.getId());
		forumReply.setThemeid(themeId);
		forumReplyService.insert(forumReply);
		forumReply.setUsername(user.getName());
		forumReply.setUserpicture(user.getPicture());
		ForumTheme forumTheme=new ForumTheme();
		forumTheme.setUpdatetime(new Date());
		forumTheme.setId(themeId);
		forumThemeService.updateByPrimaryKeySelective(forumTheme);
		forumTheme=forumThemeService.selectByPrimaryKey(themeId);
		if(user.getId()!=forumTheme.getUserid()) {
			Notify notify=new Notify();
			notify.setTitle("主题回复");
			notify.setContent("用户"+user.getName()+"在名为《"+forumTheme.getTitle()+"》的主题回复了您，请查看<br><a href='../forum/detail?id="+themeId+"'>点击连接</a>");
			notify.setCreatetime(new Date());
			notify.setUpdatetime(new Date());
			notify.setUser(forumTheme.getUserid());
			notifyService.insertnotify(notify);
		}
		return JSON.toJSONString(forumReply);
	}
	
	@RequestMapping(value="/replysecond",method=RequestMethod.POST,produces = "application/json; charset=utf-8")
	@ResponseBody
	public String replysecond(Integer themeId,Integer layerId,String replysecondcontent,Integer reuserId ,HttpSession session) {
		User user=(User) session.getAttribute("user");
        ForumReplySecond forumReplySecond =new ForumReplySecond();
        forumReplySecond.setContent(replysecondcontent);
        forumReplySecond.setCreatetime(new Date());
        forumReplySecond.setLayerid(layerId);
        forumReplySecond.setReuserid(reuserId);
        forumReplySecond.setUserid(user.getId());
        forumReplySecondService.insert(forumReplySecond);
        forumReplySecond.setUserpicture(user.getPicture());
        forumReplySecond.setUsername(user.getName());
        User reuser=userService.selectByPrimaryKey(reuserId);
        forumReplySecond.setReusername(reuser.getName());
    	ForumTheme forumTheme=new ForumTheme();
		forumTheme.setUpdatetime(new Date());
		forumTheme.setId(themeId);
		forumThemeService.updateByPrimaryKeySelective(forumTheme);
		if(user.getId()!=reuserId) {
			forumTheme=forumThemeService.selectByPrimaryKey(themeId);
			Notify notify=new Notify();
			notify.setTitle("主题回复");
			notify.setContent("用户"+user.getName()+"在名为《"+forumTheme.getTitle()+"》的主题回复了您，请查看<br><a href='../forum/detail?id="+themeId+"'>点击连接</a>");
			notify.setCreatetime(new Date());
			notify.setUpdatetime(new Date());
			notify.setUser(reuserId);
			notifyService.insertnotify(notify);
		}
		return JSON.toJSONString(forumReplySecond);
	}
	
	@RequestMapping(value="/uploadpicture",method=RequestMethod.POST)
	@ResponseBody
	public String uploadpicture(MultipartFile picturename,HttpServletRequest request) {
		String dir = "picture/forum/";
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
	@RequestMapping(value="/deleteforumtheme")
	@ResponseBody
	public String deleteforumtheme(Integer themeid) {
          forumThemeService.deleteByPrimaryKey(themeid);
          return "success";
	}
	
}
