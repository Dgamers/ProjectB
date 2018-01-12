package com.serviceImpl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.AnimationMapper;
import com.github.pagehelper.PageHelper;
import com.pojo.Animation;
import com.pojo.AnimationExample;
import com.pojo.AnimationExample.Criteria;
import com.service.AnimationService;

@Service
public class AnimationServiceImpl implements AnimationService
{

	@Autowired
	private AnimationMapper animationMapper;

	@Override
	public int deleteByPrimaryKey(Integer id)
	{
		// TODO Auto-generated method stub
		return animationMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Animation record)
	{

		return animationMapper.insert(record);
	}

	@Override
	public int insertSelective(Animation record)
	{

		return animationMapper.insertSelective(record);
	}

	@Override
	public List<Animation> selectByPage(int pagenum, int type, int order)
	{
		AnimationExample example = new AnimationExample();
		Criteria criteria = example.createCriteria();
		if (type != 0)
		{
			criteria.andCategoryEqualTo(type);
		}
		if (order == 1)
		{
			example.setOrderByClause("createtime desc");
		}
		if (order == 2)
		{
			example.setOrderByClause("download desc");
		}
		if (order == 3)
		{
			example.setOrderByClause("grade desc");
		}
		PageHelper.startPage(pagenum, 4, true);
		List<Animation> list = animationMapper.selectByExample(example);
		if (list.size() != 0)
		{
			return list;
		}
		return null;
	}

	@Override
	public Animation selectByPrimaryKey(Integer id)
	{

		return animationMapper.selectByPrimaryKey(id);
	}

	@Override
	public List<Animation> selectBySearch(int limit, int pagenum, String search_title, String search_user,
	        Integer search_category, Date start_time, Date end_time, Integer search_status)
	{
		PageHelper.startPage(pagenum, limit, true);
		List<Animation> pendinganimations = animationMapper.selectBySearch(search_title, search_user, search_category,
		        start_time, end_time, search_status);
		if (pendinganimations.size() != 0)
		{
			return pendinganimations;
		}
		return null;
	}

	@Override
	public List<Animation> selectByuserId(int userid, int pagenum, int order)
	{
		AnimationExample example = new AnimationExample();
		Criteria criteria = example.createCriteria();
		criteria.andUseridEqualTo(userid);
		if (order == 1)
		{
			example.setOrderByClause("createtime desc");
		}
		if (order == 2)
		{
			example.setOrderByClause("download desc");
		}
		if (order == 3)
		{
			example.setOrderByClause("grade desc");
		}
		PageHelper.startPage(pagenum, 4, true);
		List<Animation> list = animationMapper.selectByExample(example);
		if (list.size() != 0)
		{
			return list;
		}
		return null;
	}

	@Override
	public List<Animation> selectOtherAnimationByUserIDs(int vid, int uid)
	{
		AnimationExample example = new AnimationExample();
		Criteria criteria = example.createCriteria();
		criteria.andUseridEqualTo(uid);
		criteria.andIdNotEqualTo(vid);
		example.setOrderByClause("createtime desc");
		PageHelper.startPage(1, 4, true);
		List<Animation> list = animationMapper.selectByExample(example);
		if (list.size() != 0)
		{
			return list;
		}
		return null;
	}

	@Override
	public int updateByPrimaryKey(Animation record)
	{
		// TODO Auto-generated method stub
		return animationMapper.updateByPrimaryKey(record);
	}

	@Override
	public int updateByPrimaryKeySelective(Animation record)
	{
		// TODO Auto-generated method stub
		return animationMapper.updateByPrimaryKeySelective(record);
	}

}
