package com.service;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pojo.User;

public interface UserService
{

	int deleteByPrimaryKey(Integer id);

	User findByEmail(String email);

	int insert(User record);

	int insertSelective(User record);

	boolean isExistUser(String email);

	List<User> selectByPage(int pageSize, int pagenum, String search_name, String search_email, String search_phone,
	        Date start_time, Date end_time, Integer search_status);

	User selectByPrimaryKey(Integer id);

	int updateByPrimaryKey(User record);

	int updateByPrimaryKeySelective(User record);
	
	List<User>selectByjoiner(List<Integer>joinerid);
}
