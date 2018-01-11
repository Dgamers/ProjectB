package com.service;

import java.util.List;

import com.pojo.Animationreview;

public interface AnimationreviewService {

	int insertAReview(Animationreview record);
	
	List<Animationreview>selectReviewByAid(Integer aid);
}
