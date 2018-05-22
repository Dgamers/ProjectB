package com.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.LearningCategoryMapper;
import com.pojo.LearningCategory;
import com.pojo.LearningCategoryExample;
import com.service.LearningCategoryService;

@Service
public class LearningCategoryServiceImpl implements LearningCategoryService
{

	@Autowired
	private LearningCategoryMapper learningCategoryMapper;

	@Override
	public int deleteByPrimaryKey(Integer id)
	{
		// TODO Auto-generated method stub
		return learningCategoryMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(LearningCategory record)
	{

		return learningCategoryMapper.insert(record);
	}

	@Override
	public int insertSelective(LearningCategory record)
	{

		return learningCategoryMapper.insertSelective(record);
	}

	@Override
	public LearningCategory selectByPrimaryKey(Integer id)
	{

		return learningCategoryMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKey(LearningCategory record)
	{
		// TODO Auto-generated method stub
		return learningCategoryMapper.updateByPrimaryKey(record);
	}

	@Override
	public int updateByPrimaryKeySelective(LearningCategory record)
	{
		// TODO Auto-generated method stub
		return learningCategoryMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public List<LearningCategory> selectAllLearningCategory() {
		LearningCategoryExample example=new LearningCategoryExample();
		List<LearningCategory>list=learningCategoryMapper.selectByExample(example);
		if(list.size()!=0) {
			return list;
		}
		return null;
	}


}
