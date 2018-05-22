package com.dao;

import java.util.List;

import com.pojo.ForumReplySecond;

public interface ForumReplySecondMapper {
  
	int insertForumReplySecond(ForumReplySecond forumReplySecond);
	
	List<ForumReplySecond>selectSecondReplyByLid(Integer lid);
	
	int deleteByPrimaryKey(Integer id);
}