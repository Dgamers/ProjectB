package com.service;

import java.util.Date;
import java.util.List;

import com.pojo.User;

public interface UserService  {
	
	boolean isExistUser(String email);
	
	User findByEmail(String email);
   
	User selectByPrimaryKey(Integer id);
	
    int insert(User record);

    int insertSelective(User record);
    
    int deleteByPrimaryKey(Integer id);
    
    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    
    List<User>selectByPage(int pageSize,int pagenum,String search_name,String search_email,String search_phone,Date start_time,Date end_time);
}
