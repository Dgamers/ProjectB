package com.controller;

import java.io.File;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.pojo.User;
import com.pojo.UserOperation;
import com.pojo.VerifyingMailbox;
import com.service.UserOperationService;
import com.service.UserService;
import com.service.VerifyingMailboxService;
import com.utils.CheckCode;
import com.utils.FileUploadUtil;
import com.utils.ImgCut;
import com.utils.MailUtil;
import com.utils.Result;

@Controller
@RequestMapping("/user")
public class UserController {


	@Autowired
	private UserService userService;
	
	@Autowired
	private VerifyingMailboxService verifyingMailboxService;
	
	@Autowired
	private MailUtil mailUtil;
	
	@Autowired
	private UserOperationService userOperationService;

	@RequestMapping("/insertuser")
	public String insertuser(User user)throws Exception {
		user.setName(new String(user.getName().getBytes("ISO8859-1"), "UTF-8"));
		user.setCreatetime(new Date());
		user.setUpdatetime(new Date());
		user.setStatus(1);
		userService.insertSelective(user);
		UserOperation userOperation=new UserOperation();
		userOperation.setUserid(user.getId());
		userOperation.setCreatetime(new Date());
		userOperation.setUpdatetime(new Date());
		userOperationService.insert(userOperation);
		return "register/success";
	}

	@RequestMapping("/inituserinfo")
	public String inituserinfo(HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null)
			return "redirect:/animation/index";
		else
			return "user/info";
	}
	
	@RequestMapping("/initcontact")
	public String initcontact(HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null)
			return "redirect:/animation/index";
		else
			return "user/contact";
	}
	
	@RequestMapping("/inithead")
	public String inithead(HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null)
			return "redirect:/animation/index";
		else
			return "user/headpicture";
	}
	
	@RequestMapping(value="/saveuserinfo",method=RequestMethod.POST,produces = "application/json; charset=utf-8")
	@ResponseBody
	public String saveuserinfo(User user,HttpSession session) throws Exception {
		userService.updateByPrimaryKeySelective(user);
		session.setAttribute("user", userService.selectByPrimaryKey(user.getId()));
		return JSON.toJSONString(new Result("success", user, 200));
	}
	
	@RequestMapping(value="/sendchangemail")
	public void sendchangemail(String newemail,HttpServletResponse response) throws Exception {
		PrintWriter out = response.getWriter();
		String checkCode = new CheckCode().getRandomString(10);
		VerifyingMailbox verifyingMailbox = verifyingMailboxService.selectByemail(newemail);
		if(verifyingMailbox==null)
		{
			VerifyingMailbox newemailbox=new VerifyingMailbox();
			newemailbox.setEmail(newemail);
			newemailbox.setCheckcode(checkCode);
			newemailbox.setCreatetime(new Date());
			newemailbox.setUpdatetime(new Date());
			newemailbox.setStatus(0);
			verifyingMailboxService.insert(newemailbox);
			mailUtil.sendchangeMail(newemail, checkCode);
			out.print("success");
		}else if(verifyingMailbox.getStatus()==1)
			    {out.print("failed");}
		else {
		verifyingMailbox.setCheckcode(checkCode);
		verifyingMailbox.setUpdatetime(new Date());
		verifyingMailboxService.updateByPrimaryKey(verifyingMailbox);	
		mailUtil.sendchangeMail(newemail, checkCode);
		out.print("success");
		}
	}
	
	@RequestMapping("/updateemail")
	public void updateemail(String oldemail,String newemail,String checkCode,HttpSession session,HttpServletResponse response)throws Exception {
		System.out.println(checkCode);
		PrintWriter out = response.getWriter();
		VerifyingMailbox Verifyingnewemail = verifyingMailboxService.selectByemail(newemail);
		Date current = new Date();
		int miniutes = (int) ((current.getTime() - Verifyingnewemail.getUpdatetime().getTime()) / (1000 * 60 ));
		if (miniutes >20 || !Verifyingnewemail.getCheckcode().equals(checkCode))
		{	out.print("failed");}
		else {
		VerifyingMailbox Verifyingoldemail = verifyingMailboxService.selectByemail(oldemail);
		Verifyingnewemail.setStatus(1);
		Verifyingoldemail.setStatus(0);
		verifyingMailboxService.updateByPrimaryKeySelective(Verifyingoldemail);
		verifyingMailboxService.updateByPrimaryKeySelective(Verifyingnewemail);
		User user=userService.findByEmail(oldemail);
		user.setEmail(newemail);
		userService.updateByPrimaryKeySelective(user);
		session.setAttribute("user", user);
		out.print("success");
		}
	}
	
	@RequestMapping(value="/uploadhead",method=RequestMethod.POST,produces="text/html;charset=utf-8")
	@ResponseBody
	public String uploadhead(Integer id,MultipartFile avatar_file,String avatar_data,HttpServletRequest request,Model model,HttpSession session){

		if (!FileUploadUtil.allowUpload(avatar_file.getContentType()))
			return JSON.toJSONString(new Result( "不支持的文件类型，仅支持图片！",200));
		String dir = "picture/userhead/";
		String path = request.getSession().getServletContext().getRealPath(dir);
		String fileName = FileUploadUtil.rename(avatar_file.getOriginalFilename());
      JSONObject joData = (JSONObject) JSONObject.parse(avatar_data);
      float x = joData.getFloatValue("x");
      float y = joData.getFloatValue("y");
      float w =  joData.getFloatValue("width");
      float h =  joData.getFloatValue("height");
      File targetFile = new File(path, fileName);
      //保存  
      try {  
          if(!targetFile.exists()){   
              InputStream is = avatar_file.getInputStream();
              ImgCut.cut(is, targetFile, (int)x,(int)y,(int)w,(int)h);  
              is.close();
          }  
      } catch (Exception e) {  
          e.printStackTrace();  
          return  JSON.toJSONString(new Result("上传失败，出现异常："+e.getMessage(),200));
      }  
      User user=new User();
      user.setId(id);
      user.setPicture(request.getSession().getServletContext().getContextPath()+"/"+dir+fileName);
      userService.updateByPrimaryKeySelective(user);
      session.setAttribute("user", userService.selectByPrimaryKey(id));
      return  JSON.toJSONString(new Result("上传成功!",request.getSession().getServletContext().getContextPath()+"/"+dir+fileName,200,1));
	}
}
