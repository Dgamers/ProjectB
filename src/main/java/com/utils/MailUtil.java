package com.utils;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;

public class MailUtil {
 
	private SimpleMailMessage mailMessage;
	
	private JavaMailSenderImpl mailSender;

	public SimpleMailMessage getMailMessage() {
		return mailMessage;
	}

	public void setMailMessage(SimpleMailMessage mailMessage) {
		this.mailMessage = mailMessage;
	}

	public JavaMailSenderImpl getMailSender() {
		return mailSender;
	}

	public void setMailSender(JavaMailSenderImpl mailSender) {
		this.mailSender = mailSender;
	}
	
	public void sendEmail(String Subject,String Text,String To) {
		mailMessage.setSubject(Subject);
		mailMessage.setText(Text);
		mailMessage.setTo(To);
		mailSender.send(mailMessage);
	}
	
	public void sendHtmlEmail(String Subject,String Text,String To) throws Exception{
		MimeMessage message=mailSender.createMimeMessage();
		MimeMessageHelper messageHelper=new MimeMessageHelper( message,true,"GBK");
		messageHelper.setSubject(Subject);
		messageHelper.setFrom(mailMessage.getFrom());
		messageHelper.setTo(To);
		messageHelper.setText(Text,true);
        mailSender.send(message);
	}

	public void sendRegisterMail(String email, String checkCode) throws Exception {
		String url = "http://localhost:8080/BYSJ/user/register2?email=" + email + "&checkCode=" + checkCode;
		String Text = "<html>" + "尊敬的用户  " + email + ",你好<br>" + "您使用了邮箱" + email + "注册成为【广东药科大学动画网】的会员<br>"
				+ "请以下点击链接,确认您在本网站的注册：<br>" + "<a href=" + url + ">" + url + "</a><br>"
				+ "如果以上链接不能点击，你可以复制网址URL,然后粘贴到浏览器地址栏,完全确认。<br>" + "(这是一封自动发送的邮件，请不要直接回复)<br><br>" + "说明<br><br>"
				+ "－如果你没有注册过本网站，可能是有人尝试使用你的邮件来注册，请忽略本邮件。<br>" + "－24个小时以后, 没有被激活的注册会自动失效，你需要重新填写并注册。<br>" + "</html>";
		this.sendHtmlEmail("欢迎注册", Text, email);
	}
	
	public void sendchangeMail(String newemail,String checkCode)throws Exception {
		String Text = "<html>" + "尊敬的用户 ,你好<br>" + "您申请了把更改邮箱<br>" + "以下是本次操作所需验证码：<br>"
				+ checkCode+"<br>"
				+ "(这是一封自动发送的邮件，请不要直接回复)<br><br>" + "说明<br><br>" + "－20分钟以后, 验证码自动失效，你需要重新申请更改绑定邮箱。<br>" + "</html>";
		this.sendHtmlEmail("修改邮箱", Text, newemail);
	}
}
