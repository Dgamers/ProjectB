package com.controller;

import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageInfo;
import com.pojo.Animation;
import com.pojo.Animationreview;
import com.pojo.Animationscore;
import com.pojo.Animationsecondreview;
import com.pojo.User;
import com.service.AnimationScoreService;
import com.service.AnimationService;
import com.service.AnimationreviewService;
import com.service.AnimationsecondreviewService;
import com.service.UserService;
import com.utils.Result;
import com.utils.ScoreResult;

@Controller
@RequestMapping("/animation")
public class AnimationPageController {
	
	@Autowired
	private AnimationService animationService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private AnimationScoreService animationScoreService;
	
	@Autowired
	private AnimationreviewService animationreviewService;
	
	@Autowired 
	private AnimationsecondreviewService animationsecondreviewService;
	
	
	@RequestMapping("/page")
	public String initVideoPage(Model model,int aid,HttpSession session) {
		Animation animation = animationService.selectByPrimaryKey(aid);
		User uper=userService.selectByPrimaryKey(animation.getUserid());
		List<Animation>others=animationService.selectOtherAnimationByUserIDs(aid,uper.getId());
		PageInfo<Animation>otherinfo=new PageInfo<Animation>(others);
		int scorecount= animationScoreService.countByAid(aid);
		List<Animationreview>reviews=animationreviewService.selectReviewByAid(aid);
		model.addAttribute("animation", animation);
		model.addAttribute("uper", uper);
		model.addAttribute("otherinfo", otherinfo);
		model.addAttribute("scorecount", scorecount);
		model.addAttribute("reviews", reviews);
		User user=(User) session.getAttribute("user");
		if(user!=null) {
			Animationscore score =animationScoreService.selectByUidAid(user.getId(), aid);
			if(score!=null)
				model.addAttribute("yourgrade", score.getGrade());
		}
			
		return "animation/show";
	}
	
	@RequestMapping("/download")
	public void download(HttpServletRequest request,String file,HttpServletResponse response,int aid)throws Exception {
		Animation animation=animationService.selectByPrimaryKey(aid);
		String filename=file.substring(file.lastIndexOf("/")+1);
		String endname=filename.substring(filename.lastIndexOf("."));
		response.setContentType(request.getSession().getServletContext().getMimeType(filename));
		response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(animation.getTitle()+endname,"UTF-8"));
		String fullFileName=request.getSession().getServletContext().getRealPath("animation/"+filename);
		InputStream in=new FileInputStream(fullFileName);
		OutputStream out= response.getOutputStream();
		int b;
		while((b=in.read())!=-1)
		{
			out.write(b);
		}
		in.close();
		out.close();
		animation.setDownload(animation.getDownload()+1);
		animationService.updateByPrimaryKeySelective(animation);
		
	}

	@RequestMapping(value="/insertgrade", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String insertgrade(HttpSession session,int aid,float grade,Model model)throws Exception {
		User user=(User) session.getAttribute("user");
		if(user==null)
			return JSON.toJSONString(new ScoreResult(100, null, null));
		if(animationScoreService.selectByUidAid(user.getId(), aid)!=null)
			return JSON.toJSONString(new ScoreResult(200, null, null));
        Animationscore score=new Animationscore();
        score.setCreatetime(new Date());
        score.setUpdatetime(new Date());
        score.setAid(aid);
        score.setUserid(user.getId());
        score.setGrade(grade);
        animationScoreService.insert(score);
        float avg=animationScoreService.getAVGByAID(aid);
        Animation animation=new Animation();
        animation.setId(aid);
        animation.setGrade(avg);
        animationService.updateByPrimaryKeySelective(animation);
		return JSON.toJSONString(new ScoreResult(300, animationScoreService.countByAid(aid), avg));

	}
	
	@RequestMapping(value="/savereview",method=RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String savereview(Animationreview review,Model model,HttpSession session) {
		User user=(User) session.getAttribute("user");
		if(user==null)
			return JSON.toJSONString(new Result("请登陆后再评论", 100));
		review.setTime(new Date());
		review.setUserid(user.getId());
		animationreviewService.insertAReview(review);
	    review.setUsername(user.getName());
	    review.setUserpicture(user.getPicture());
		return JSON.toJSONString(review);
	}
	
	@RequestMapping(value="/savesecondreview",method=RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String savesecondreview(Animationsecondreview secondreview,Model model,HttpSession session) {
		User user=(User) session.getAttribute("user");
		if(user==null)
			return JSON.toJSONString(new Result("请登陆后再回复", 100));
		secondreview.setTime(new Date());
		secondreview.setUserid(user.getId());
		animationsecondreviewService.insertSAReview(secondreview);
		secondreview.setUsername(user.getName());
		secondreview.setUserpicture(user.getPicture());
		User reuser= userService.selectByPrimaryKey(secondreview.getReuserid());
		secondreview.setReusername(reuser.getName());
		secondreview.setReuserpicture(reuser.getPicture());
    return JSON.toJSONString(secondreview);
	}
}
