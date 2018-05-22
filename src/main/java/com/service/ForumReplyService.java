package com.service;

import java.util.List;

import com.pojo.ForumReply;

public interface ForumReplyService
{

	int insert(ForumReply record);
	
	List<ForumReply>selectReplyByThemeid(Integer id,Integer pageNum);
}
