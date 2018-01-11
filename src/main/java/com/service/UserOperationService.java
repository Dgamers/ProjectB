package com.service;

import java.util.Date;
import java.util.List;

import com.pojo.UserOperation;

public interface UserOperationService  {
   
	UserOperation selectByPrimaryKey(Integer id);
	
    int insert(UserOperation record);

    int insertSelective(UserOperation record);
    
    int deleteByPrimaryKey(Integer id);
    
    int updateByPrimaryKeySelective(UserOperation record);

    int updateByPrimaryKey(UserOperation record);
    
    UserOperation selectByUserId(Integer userid);
}
