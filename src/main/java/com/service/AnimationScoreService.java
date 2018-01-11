package com.service;

import com.pojo.Animationscore;

public interface AnimationScoreService  {	
	
	
	Animationscore selectByPrimaryKey(Integer id);
	
    int insert(Animationscore record);

    int insertSelective(Animationscore record);
    
    int deleteByPrimaryKey(Integer id);
    
    int updateByPrimaryKeySelective(Animationscore record);

    int updateByPrimaryKey(Animationscore record);
    
    float getAVGByAID(int aid );
    
	Animationscore selectByUidAid(int uid,int aid);
	
	int countByAid(int aid);
    
}
