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
import com.pojo.Pendinganimation;
import com.service.AnimationService;
import com.service.AnimationcategoryService;
import com.service.NotifyService;
import com.service.PendinganimationService;
import com.utils.TableResult;

@Controller
@RequestMapping("/admin/panimation")
public class AdminPAnimationController
{

	@Autowired
	private PendinganimationService pendinganimationService;

	@Autowired
	private AnimationcategoryService animationcategoryService;

	@Autowired
	private AnimationService animationService;

	@Autowired
	private NotifyService notifyService;

	@RequestMapping(value = "/getpanimations", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String getPAnimations(Integer pageSize, Integer pageNumber,
	        @RequestParam(value = "search_title", required = false) String search_title,
	        @RequestParam(value = "search_user", required = false) String search_user,
	        @RequestParam(value = "search_category", required = false) Integer search_category,
	        @RequestParam(value = "start_time", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date start_time,
	        @RequestParam(value = "end_time", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date end_time)
	{
		System.out.println(search_category);
		List<Pendinganimation> pendinganimations = pendinganimationService.selectByPage(pageSize, pageNumber,
		        search_title, search_user, search_category, start_time, end_time);
		PageInfo<Pendinganimation> info = new PageInfo<Pendinganimation>(pendinganimations);
		return JSON.toJSONString(new TableResult<Pendinganimation>(pendinganimations, info.getTotal()));
	}

	@RequestMapping("/initpanimationsadmin")
	public String initPAnimationsAdmin(HttpSession session, Model model)
	{
		/*		Administrator administrator=(Administrator) session.getAttribute("admin");
		if(administrator==null)
			return "redirect:/admin/initlogin";*/
		List<Animationcategory> category = animationcategoryService.selectAllCatagory();
		model.addAttribute("categorys", category);
		return "admin/panimationadmin";
	}

	@RequestMapping(value = "/pass", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String pass(Integer Id, HttpSession session)
	{
		Pendinganimation pendinganimation = pendinganimationService.selectByPrimaryKey(Id);
		Animation animation = new Animation();
		animation.setUserid(pendinganimation.getId());
		animation.setTitle(pendinganimation.getTitle());
		animation.setContent(pendinganimation.getContent());
		animation.setPicture(pendinganimation.getPicture());
		animation.setAddress(pendinganimation.getAddress());
		animation.setStatus(1);
		animation.setGrade((float) 0);
		animation.setDownload(0);
		animation.setCategory(pendinganimation.getCategory());
		animation.setCreatetime(new Date());
		animation.setUpdatetime(new Date());
		animationService.insert(animation);
		Notify notify = new Notify();
		Administrator administrator = (Administrator) session.getAttribute("admin");
		notify.setAdmin(administrator.getId());
		notify.setUser(pendinganimation.getUserid());
		notify.setTitle("ͨ�����");
		notify.setContent("������Ϊ��" + pendinganimation.getTitle() + "������Ʒ��ͨ�����");
		notify.setCreatetime(new Date());
		notify.setUpdatetime(new Date());
		notifyService.insertnotify(notify);
		TableResult<Pendinganimation> result = new TableResult<Pendinganimation>();
		result.setRow(pendinganimation);
		pendinganimationService.deleteByPrimaryKey(pendinganimation.getId());
		return JSON.toJSONString(result);
	}

	@RequestMapping(value = "/unpass", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String unpass(Integer Id,
	        @RequestParam(name = "reason", required = false, defaultValue = "��Ʒ���������Ҫ��") String reason,
	        HttpSession session)
	{
		Pendinganimation pendinganimation = pendinganimationService.selectByPrimaryKey(Id);
		Notify notify = new Notify();
		Administrator administrator = (Administrator) session.getAttribute("admin");
		notify.setAdmin(administrator.getId());
		notify.setUser(pendinganimation.getUserid());
		notify.setTitle("��Ǹ�������Ʒ����ͨ�����");
		notify.setContent("������Ϊ��" + pendinganimation.getTitle() + "������ͨ����ˣ�ԭ��Ϊ" + reason);
		notify.setCreatetime(new Date());
		notify.setUpdatetime(new Date());
		notifyService.insertnotify(notify);
		TableResult<Integer> result = new TableResult<Integer>();
		result.setRow(Id);
		pendinganimationService.deleteByPrimaryKey(Id);
		return JSON.toJSONString(result);
	}
}
