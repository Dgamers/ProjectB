package com.serviceImpl;





import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.dao.ForumReplySecondMapper;

import com.pojo.ForumReplySecond;
import com.service.ForumReplySecondService;

@Service
public class ForumReplySecondServiceImpl implements ForumReplySecondService
{

	@Autowired
	private ForumReplySecondMapper forumReplySecondMapper;

	@Override
	public int insert(ForumReplySecond record) {
		// TODO Auto-generated method stub
		return forumReplySecondMapper.insertForumReplySecond(record);
	}




}
