package com.serviceImpl;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.dao.AnimationscoreMapper;
import com.pojo.Animationscore;
import com.pojo.AnimationscoreExample;
import com.pojo.AnimationscoreExample.Criteria;
import com.service.AnimationScoreService;

@Service
public class AnimationScoreServiceImpl  implements AnimationScoreService {

	@Autowired
	private AnimationscoreMapper animationscoreMapper;
	

	public Animationscore selectByPrimaryKey(Integer id) {
		
		return animationscoreMapper.selectByPrimaryKey(id);
	}

	public int insert(Animationscore record) {
		
		return animationscoreMapper.insert(record);
	}

	public int insertSelective(Animationscore record) {
		
		return animationscoreMapper.insertSelective(record);
	}

	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return animationscoreMapper.deleteByPrimaryKey(id);
	}

	public int updateByPrimaryKeySelective(Animationscore record) {
		// TODO Auto-generated method stub
		return animationscoreMapper.updateByPrimaryKeySelective(record);
	}

	public int updateByPrimaryKey(Animationscore record) {
		// TODO Auto-generated method stub
		return animationscoreMapper.updateByPrimaryKey(record);
	}

	public float getAVGByAID(int aid) {
	
		return animationscoreMapper.getAvgByAid(aid);
	}

	public Animationscore selectByUidAid(int uid,int aid) {
		AnimationscoreExample example=new AnimationscoreExample();
		Criteria criteria = example.createCriteria();
		criteria.andAidEqualTo(aid);
		criteria.andUseridEqualTo(uid);
		List<Animationscore>list=animationscoreMapper.selectByExample(example);
		if(list.size()!=0)
			return list.get(0);
		else	
		return null;
	}

	public int countByAid(int aid) {
		AnimationscoreExample example=new AnimationscoreExample();
		Criteria criteria=example.createCriteria();
		criteria.andAidEqualTo(aid);
		return animationscoreMapper.countByExample(example);
		
	}



}
