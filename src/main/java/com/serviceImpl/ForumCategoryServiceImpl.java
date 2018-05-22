package com.serviceImpl;



import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.dao.ForumCategoryMapper;
import com.pojo.ForumCategory;
import com.pojo.ForumCategoryExample;
import com.pojo.ForumCategoryExample.Criteria;
import com.service.ForumCategoryService;


@Service
public class ForumCategoryServiceImpl implements ForumCategoryService
{

	@Autowired
	private ForumCategoryMapper forumCategoryMapper;

	@Override
	public int deleteByPrimaryKey(Integer id)
	{
		// TODO Auto-generated method stub
		return forumCategoryMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(ForumCategory record)
	{

		return forumCategoryMapper.insert(record);
	}

	@Override
	public int insertSelective(ForumCategory record)
	{

		return forumCategoryMapper.insertSelective(record);
	}


	@Override
	public ForumCategory selectByPrimaryKey(Integer id)
	{

		return forumCategoryMapper.selectByPrimaryKey(id);
	}


	@Override
	public int updateByPrimaryKey(ForumCategory record)
	{
		// TODO Auto-generated method stub
		return forumCategoryMapper.updateByPrimaryKey(record);
	}

	@Override
	public int updateByPrimaryKeySelective(ForumCategory record)
	{
		// TODO Auto-generated method stub
		return forumCategoryMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public List<ForumCategory> selectAllForumCategory() {
		ForumCategoryExample example=new ForumCategoryExample();
		List<ForumCategory>list=forumCategoryMapper.selectByExample(example);
		if(list.size()!=0) {
			return list;
		}
		return null;
	}


}
