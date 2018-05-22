package com.service;

import java.util.Date;
import java.util.List;

import com.pojo.Animation;
import com.pojo.LearningArticle;



public interface LearningArticleService
{

	int deleteByPrimaryKey(Integer id);

	int insert(LearningArticle record);

	int insertSelective(LearningArticle record);

	LearningArticle selectByPrimaryKey(Integer id);

	int updateByPrimaryKey(LearningArticle record);

	int updateByPrimaryKeySelective(LearningArticle record);
	
	List<LearningArticle>getarticles(Integer pageNum, Integer pageSize,String keyword,Integer category);
	
	List<LearningArticle> selectBySearch(int limit, int pagenum, String search_title, String search_search_edit,
	        Integer search_category, Date start_time, Date end_time, Integer search_status);
	
}
