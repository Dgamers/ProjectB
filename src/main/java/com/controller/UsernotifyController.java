package com.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pojo.Notify;
import com.pojo.User;
import com.pojo.UserOperation;
import com.service.NotifyService;
import com.service.UserOperationService;


@Controller
@RequestMapping("/user")
public class UsernotifyController {

	@Autowired
	private NotifyService notifyService;
	
	@Autowired
	private UserOperationService UserOperationService;

	@RequestMapping("/notify")
	public String initnotify(Model model,HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null)
			return "redirect:/animation/index";
		List<Notify> notifies = notifyService.selectnotifyByuser(user.getId());
		UserOperation userOperation=UserOperationService.selectByUserId(user.getId());
		userOperation.setChecksystem(new Date());
		userOperation.setUpdatetime(new Date());
		UserOperationService.updateByPrimaryKeySelective(userOperation);
		model.addAttribute("notifies", notifies);
		return "user/notify";
	}
}
