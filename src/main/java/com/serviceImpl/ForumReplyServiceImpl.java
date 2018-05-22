package com.serviceImpl;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.ForumReplyMapper;
import com.github.pagehelper.PageHelper;
import com.pojo.ForumReply;
import com.service.ForumReplyService;


@Service
public class ForumReplyServiceImpl implements ForumReplyService
{

	@Autowired
	private ForumReplyMapper forumReplyMapper;

	@Override
	public int insert(ForumReply record) {
		// TODO Auto-generated method stub
		return forumReplyMapper.insertForumReply(record);
	}

	@Override
	public List<ForumReply> selectReplyByThemeid(Integer Tid,Integer pageNum) {
		PageHelper.startPage(pageNum, 5);
		List<ForumReply>list=forumReplyMapper.selectReplyByTid(Tid);
		if(list.size()!=0)
		{
			return list;
		}
		return null;
	}



}
