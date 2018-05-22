package com.service;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pojo.ForumTheme;


public interface ForumThemeService
{

	int deleteByPrimaryKey(Integer id);

	int insert(ForumTheme record);

	int insertSelective(ForumTheme record);

	ForumTheme selectByPrimaryKey(Integer id);

	int updateByPrimaryKey(ForumTheme record);

	int updateByPrimaryKeySelective(ForumTheme record);
	
	List<ForumTheme>selectAllForumTheme(Integer pageNum,Integer pageSize,Integer order,Integer category,String keyword,Integer userid);
}
