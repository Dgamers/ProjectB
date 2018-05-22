package com.service;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pojo.LearningCategory;
import com.pojo.User;

public interface LearningCategoryService
{

	int deleteByPrimaryKey(Integer id);

	int insert(LearningCategory record);

	int insertSelective(LearningCategory record);

	LearningCategory selectByPrimaryKey(Integer id);

	int updateByPrimaryKey(LearningCategory record);

	int updateByPrimaryKeySelective(LearningCategory record);
	
	List<LearningCategory>selectAllLearningCategory();
}
