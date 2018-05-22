package com.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pojo.Animation;
import com.pojo.AnimationExample;

public interface AnimationMapper
{
	int countByExample(AnimationExample example);

	int deleteByExample(AnimationExample example);

	int deleteByPrimaryKey(Integer id);

	int insert(Animation record);

	int insertSelective(Animation record);

	List<Animation> selectByExample(AnimationExample example);

	List<Animation> selectByType(@Param("keyword")String keyword,@Param("type")int type, @Param("order")int order);
	
	Animation selectByPrimaryKey(Integer id);

	List<Animation> selectBySearch(@Param("search_title") String search_title, @Param("search_user") String search_user,
	        @Param("search_category") Integer search_category, @Param("start_time") Date start_time,
	        @Param("end_time") Date end_time, @Param("search_status") Integer search_status);

	int updateByExample(@Param("record") Animation record, @Param("example") AnimationExample example);

	int updateByExampleSelective(@Param("record") Animation record, @Param("example") AnimationExample example);

	int updateByPrimaryKey(Animation record);

	int updateByPrimaryKeySelective(Animation record);
}