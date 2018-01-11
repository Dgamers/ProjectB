package com.Interceptor;

import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.pojo.User;
import com.pojo.UserOperation;
import com.service.NotifyService;
import com.service.UserOperationService;
import com.service.UserService;

public class LoginInterceptor implements HandlerInterceptor {

	@Autowired
	private UserService userService;

	@Autowired
	private NotifyService notifyService;
	
	@Autowired
	private UserOperationService userOperationService;

	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object object, Exception exception)
			throws Exception {

	}

	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		// TODO Auto-generated method stub

	}

	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object object) throws Exception {
		User loginUser = (User) request.getSession().getAttribute("user");
		Cookie[] cookies = request.getCookies();
		if (loginUser == null) {
			String loginemail = "";
			String loginpassword = "";

			if (null != cookies) {
				for (Cookie cookie : cookies) {
					if ("GDYKDHemail".equals(cookie.getName())) {
						loginemail = cookie.getValue();
					} else if ("GDYKDHpassword".equals(cookie.getName())) {
						loginpassword = cookie.getValue();
					}
				}
				if (loginemail != "") {
					User user = userService.findByEmail(loginemail);
					if (loginpassword.equals(user.getPassword())) {
						UserOperation userOperation=userOperationService.selectByUserId(user.getId());
						userOperation.setLogintime(new Date());
						userOperation.setUpdatetime(new Date());
						userOperationService.updateByPrimaryKeySelective(userOperation);
						request.getSession().setAttribute("user", user);
					}
				}
			}
		}
		User logineduser = (User) request.getSession().getAttribute("user");
		if (logineduser != null) {
			Integer countnotify = notifyService
					.countnotifyByuser(logineduser.getId());
			request.getSession().setAttribute("countnotify", countnotify);
		}
		return true;
	}

}
