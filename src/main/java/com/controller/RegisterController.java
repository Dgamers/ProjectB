package com.controller;

import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pojo.User;
import com.pojo.VerifyingMailbox;
import com.service.UserService;
import com.service.VerifyingMailboxService;
import com.utils.CheckCode;
import com.utils.MailUtil;

@Controller
@RequestMapping("/user")
public class RegisterController {

	@Autowired
	private VerifyingMailboxService verifyingMailboxService;
	
	@Autowired
	private MailUtil mailUtil;


	@RequestMapping("/register1")
	public String initregister1() {
		return "register/register1";
	}

	@RequestMapping("/register2")
	public String initregister2(String email, String checkCode,Model model) {
		VerifyingMailbox verifyingMailbox = verifyingMailboxService.selectByemail(email);
		if(verifyingMailbox!=null&&verifyingMailbox.getStatus()==1)
			return "register/isExistUser";
		Date current = new Date();
		int day = (int) ((current.getTime() - verifyingMailbox.getUpdatetime().getTime()) / (1000 * 60 * 60 * 24));
		if (day > 0 || !verifyingMailbox.getCheckcode().equals(checkCode))
			return "register/error";
		else {
			verifyingMailbox.setStatus(1);
			verifyingMailbox.setUpdatetime(current);
			verifyingMailboxService.updateByPrimaryKey(verifyingMailbox);
			model.addAttribute("email", email);
			return "register/register2";
		}
			
	}

	@RequestMapping("/checkemail")
	public String checkemail(String email, HttpSession session, Model model) throws Exception {
		VerifyingMailbox checkemail=verifyingMailboxService.selectByemail(email);

		if (checkemail!=null&&checkemail.getStatus()==1)
			return "register/isExistUser";
		else {
			String checkCode = new CheckCode().getRandomString(10);
			VerifyingMailbox verifyingMailbox = new VerifyingMailbox();
			verifyingMailbox.setEmail(email);
			verifyingMailbox.setCheckcode(checkCode);
			verifyingMailbox.setCreatetime(new Date());
			verifyingMailbox.setUpdatetime(new Date());
			verifyingMailbox.setStatus(0);
			verifyingMailboxService.insert(verifyingMailbox);
			mailUtil.sendRegisterMail(email, checkCode);
			model.addAttribute("email", email);
			return "register/isNewUser";
		}
		
	}
	
	@RequestMapping("/sendagain")
	public void sendagain(String email, HttpServletResponse response) throws Exception {
		String checkCode = new CheckCode().getRandomString(10);
		VerifyingMailbox verifyingMailbox = verifyingMailboxService.selectByemail(email);
		verifyingMailbox.setCheckcode(checkCode);
		verifyingMailbox.setUpdatetime(new Date());
		verifyingMailboxService.updateByPrimaryKey(verifyingMailbox);
		mailUtil.sendRegisterMail(email, checkCode);
		PrintWriter out = response.getWriter();
		out.println("success");
	}


	


}
