package com.service;

import java.util.Date;
import java.util.List;

import com.pojo.Pendinganimation;

public interface PendinganimationService  {	
	
	Pendinganimation selectByPrimaryKey(Integer id);
	
    int insert(Pendinganimation record);

    int insertSelective(Pendinganimation record);
    
    int deleteByPrimaryKey(Integer id);
    
    int updateByPrimaryKeySelective(Pendinganimation record);

    int updateByPrimaryKey(Pendinganimation record);
    
    List<Pendinganimation>selectByPage(int limit,int pagenum,String search_title,String search_user,Integer search_category,Date start_time,Date end_time);
}
