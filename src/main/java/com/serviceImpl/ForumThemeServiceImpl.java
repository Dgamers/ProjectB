package com.serviceImpl;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.ForumReplyMapper;
import com.dao.ForumReplySecondMapper;
import com.dao.ForumThemeMapper;
import com.github.pagehelper.PageHelper;
import com.pojo.ForumReply;
import com.pojo.ForumReplySecond;
import com.pojo.ForumTheme;

import com.service.ForumThemeService;

@Service
public class ForumThemeServiceImpl implements ForumThemeService
{

	@Autowired
	private ForumThemeMapper forumThemeMapper;
	
	@Autowired
	private ForumReplyMapper forumReplyMapper;
	
	@Autowired
	private ForumReplySecondMapper forumReplySecondMapper;

	@Override
	public int deleteByPrimaryKey(Integer id)
	{
	    List<ForumReply>rList=forumReplyMapper.selectReplyByTid(id);
	    for (ForumReply forumReply : rList) {
			for (ForumReplySecond rsList : forumReply.getForumReplySeconds()) {
				forumReplySecondMapper.deleteByPrimaryKey(rsList.getId());
			}
			forumReplyMapper.deleteByPrimaryKey(forumReply.getId());
		}
		return forumThemeMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(ForumTheme record)
	{

		return forumThemeMapper.insert(record);
	}

	@Override
	public int insertSelective(ForumTheme record)
	{

		return forumThemeMapper.insertSelective(record);
	}


	@Override
	public ForumTheme selectByPrimaryKey(Integer id)
	{

		return forumThemeMapper.selectByPrimaryKey(id);
	}


	@Override
	public int updateByPrimaryKey(ForumTheme record)
	{
		// TODO Auto-generated method stub
		return forumThemeMapper.updateByPrimaryKey(record);
	}

	@Override
	public int updateByPrimaryKeySelective(ForumTheme record)
	{
		// TODO Auto-generated method stub
		return forumThemeMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public List<ForumTheme> selectAllForumTheme(Integer pageNum,Integer pageSize,Integer order,Integer category,String keyword,Integer userid) {
		PageHelper.startPage(pageNum, pageSize, true);
		List<ForumTheme>list=forumThemeMapper.selectAllForumTheme(order,category,keyword,userid);
		if(list.size()!=0) {
			return list;
		}
		return null;
	}

}
