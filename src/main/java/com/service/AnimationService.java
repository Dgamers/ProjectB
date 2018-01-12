package com.service;

import java.util.Date;
import java.util.List;

import com.pojo.Animation;

public interface AnimationService
{

	int deleteByPrimaryKey(Integer id);

	int insert(Animation record);

	int insertSelective(Animation record);

	List<Animation> selectByPage(int pagenum, int type, int order);

	Animation selectByPrimaryKey(Integer id);

	List<Animation> selectBySearch(int limit, int pagenum, String search_title, String search_user,
	        Integer search_category, Date start_time, Date end_time);

	List<Animation> selectByuserId(int userid, int pagenum, int order);

	List<Animation> selectOtherAnimationByUserIDs(int vid, int uid);

	int updateByPrimaryKey(Animation record);

	int updateByPrimaryKeySelective(Animation record);
}
