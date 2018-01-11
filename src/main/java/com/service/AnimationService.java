package com.service;

import java.util.List;

import com.pojo.Animation;

public interface AnimationService  {	
	
    Animation selectByPrimaryKey(Integer id);
	
    int insert(Animation record);

    int insertSelective(Animation record);
    
    int deleteByPrimaryKey(Integer id);
    
    int updateByPrimaryKeySelective(Animation record);

    int updateByPrimaryKey(Animation record);
    
    List<Animation>selectByPage(int pagenum,int type, int order);
    
    List<Animation>selectOtherAnimationByUserIDs(int vid,int uid);
    
    List<Animation>selectByuserId(int userid,int pagenum,int order);
}
