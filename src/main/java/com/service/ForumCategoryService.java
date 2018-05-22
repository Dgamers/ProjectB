package com.service;

import java.util.List;

import com.pojo.ForumCategory;;


public interface ForumCategoryService
{

	int deleteByPrimaryKey(Integer id);

	int insert(ForumCategory record);

	int insertSelective(ForumCategory record);

	ForumCategory selectByPrimaryKey(Integer id);

	int updateByPrimaryKey(ForumCategory record);

	int updateByPrimaryKeySelective(ForumCategory record);
	
	List<ForumCategory>selectAllForumCategory();
}
