package com.serviceImpl;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.AnimationsecondreviewMapper;
import com.pojo.Animationsecondreview;
import com.service.AnimationsecondreviewService;

@Service
public class AnimationsecondreviewServiceImpl  implements AnimationsecondreviewService{

	@Autowired
	private AnimationsecondreviewMapper animationsecondreviewMapper;
	
	public int insertSAReview(Animationsecondreview record) {
		
		return animationsecondreviewMapper.insertSAReview(record);
	}

	public List<Animationsecondreview> selectSReviewByRid(Integer rid) {
		
		return animationsecondreviewMapper.selectSReviewByRid(rid);
	}

}
