package com.service;

import com.pojo.Administrator;

public interface AdministratorService  {
   
	Administrator selectByPrimaryKey(Integer id);
	
	Administrator selectByname(String name);
	
    int insert(Administrator record);

    int insertSelective(Administrator record);
    
    int deleteByPrimaryKey(Integer id);
    
    int updateByPrimaryKeySelective(Administrator record);

    int updateByPrimaryKey(Administrator record);
}
