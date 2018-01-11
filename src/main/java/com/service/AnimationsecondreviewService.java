package com.service;

import java.util.List;

import com.pojo.Animationsecondreview;

public interface AnimationsecondreviewService {

	int insertSAReview(Animationsecondreview record);
	
	List<Animationsecondreview>selectSReviewByRid(Integer rid);
	
}
