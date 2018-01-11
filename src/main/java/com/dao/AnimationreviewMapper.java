package com.dao;

import java.util.List;

import com.pojo.Animationreview;

public interface AnimationreviewMapper {

	int insertAReview(Animationreview record);
	
	List<Animationreview>selectReviewByAid(Integer aid);
}
