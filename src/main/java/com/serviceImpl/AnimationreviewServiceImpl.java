package com.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.AnimationreviewMapper;
import com.pojo.Animationreview;
import com.service.AnimationreviewService;

@Service
public class AnimationreviewServiceImpl  implements AnimationreviewService{

	@Autowired
	private AnimationreviewMapper animationreviewMapper;
	
	public int insertAReview(Animationreview record) {
		
		return animationreviewMapper.insertAReview(record);
	}

	public List<Animationreview> selectReviewByAid(Integer aid) {
		List<Animationreview>list=animationreviewMapper.selectReviewByAid(aid);
		if(list.size()!=0)
			return list;
		return null;
	}

}
