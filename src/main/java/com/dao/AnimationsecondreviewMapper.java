package com.dao;

import java.util.List;

import com.pojo.Animationsecondreview;

public interface AnimationsecondreviewMapper {

	int insertSAReview(Animationsecondreview record);
	
	List<Animationsecondreview>selectSReviewByRid(Integer rid);
	
}
