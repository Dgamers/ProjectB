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
import com.pojo.Administrator;
import com.pojo.Animation;
import com.pojo.Animationcategory;
import com.pojo.Notify;
import com.service.AnimationService;
import com.service.AnimationcategoryService;
import com.service.NotifyService;
import com.utils.TableResult;

@Controller
@RequestMapping("/admin/animation")
public class AdminAnimationController
{

	@Autowired
	private AnimationcategoryService animationcategoryService;

	@Autowired
	private AnimationService animationService;

	@Autowired
	private NotifyService notifyService;

	@RequestMapping(value = "/changestatus", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String changeStatus(Integer Id, HttpSession session)
	{
		Animation animation = animationService.selectByPrimaryKey(Id);
		Administrator administrator = (Administrator) session.getAttribute("admin");
		if (animation.getStatus() == 0)
		{
			animation.setStatus(1);
			Notify notify = new Notify();
			notify.setAdmin(administrator.getId());
			notify.setTitle("恢复通知");
			notify.setContent("您的名为《" + animation.getTitle() + "》的作品已经重新上线");
			notify.setUser(animation.getUserid());
			notify.setCreatetime(new Date());
			notify.setUpdatetime(new Date());
			notifyService.insertnotify(notify);
		}
		else
		{
			animation.setStatus(0);
			Notify notify = new Notify();
			notify.setAdmin(administrator.getId());
			notify.setTitle("下线通知");
			notify.setContent("您的名为《" + animation.getTitle() + "》的作品已下线，如有疑问请联系客服");
			notify.setUser(animation.getUserid());
			notify.setCreatetime(new Date());
			notify.setUpdatetime(new Date());
			notifyService.insertnotify(notify);
		}
		animationService.updateByPrimaryKeySelective(animation);
		TableResult<Animation> result = new TableResult<Animation>();
		result.setRow(animation);
		return JSON.toJSONString(result);
	}

	@RequestMapping(value = "/getanimations", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String getPAnimations(Integer pageSize, Integer pageNumber,
	        @RequestParam(value = "search_title", required = false) String search_title,
	        @RequestParam(value = "search_user", required = false) String search_user,
	        @RequestParam(value = "search_category", required = false) Integer search_category,
	        @RequestParam(value = "start_time", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date start_time,
	        @RequestParam(value = "end_time", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date end_time,
	        Integer search_status)

	{
		List<Animation> animations = animationService.selectBySearch(pageSize, pageNumber, search_title, search_user,
		        search_category, start_time, end_time, search_status);
		PageInfo<Animation> info = new PageInfo<Animation>(animations);
		return JSON.toJSONString(new TableResult<Animation>(animations, info.getTotal()));
	}

	@RequestMapping("/initanimationsadmin")
	public String initPAnimationsAdmin(HttpSession session, Model model)
	{
			Administrator administrator=(Administrator) session.getAttribute("admin");
		if(administrator==null)
			return "redirect:/admin/initlogin";
		List<Animationcategory> category = animationcategoryService.selectAllCatagory();
		model.addAttribute("categorys", category);
		return "admin/animationadmin";
	}

}
