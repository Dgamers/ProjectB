package com.dao;

import java.util.List;

import com.pojo.ForumReply;

public interface ForumReplyMapper {

	int insertForumReply(ForumReply forumReply);
	
	List<ForumReply>selectReplyByTid(Integer Tid);
	
	int deleteByPrimaryKey(Integer id);
}