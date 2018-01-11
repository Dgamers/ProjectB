package com.serviceImpl;


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
public class AnimationServiceImpl  implements AnimationService {

	@Autowired
	private AnimationMapper animationMapper;
	

	public Animation selectByPrimaryKey(Integer id) {
		
		return animationMapper.selectByPrimaryKey(id);
	}

	public int insert(Animation record) {
		
		return animationMapper.insert(record);
	}

	public int insertSelective(Animation record) {
		
		return animationMapper.insertSelective(record);
	}

	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return animationMapper.deleteByPrimaryKey(id);
	}

	public int updateByPrimaryKeySelective(Animation record) {
		// TODO Auto-generated method stub
		return animationMapper.updateByPrimaryKeySelective(record);
	}

	public int updateByPrimaryKey(Animation record) {
		// TODO Auto-generated method stub
		return animationMapper.updateByPrimaryKey(record);
	}

	public List<Animation> selectByPage(int pagenum,int type, int order) {
		AnimationExample example=new AnimationExample();
		Criteria criteria = example.createCriteria();
		if(type!=0)
			criteria.andCategoryEqualTo(type);
		if(order==1)
			example.setOrderByClause("createtime desc");
		if(order==2)
			example.setOrderByClause("download desc");
		if(order==3)
			example.setOrderByClause("grade desc");
		PageHelper.startPage(pagenum, 4, true);
		List<Animation>list=animationMapper.selectByExample(example);
		if(list.size()!=0) {
			return list;
		}
		return null;
	}

	public List<Animation> selectOtherAnimationByUserIDs(int vid,int uid) {
		AnimationExample example=new AnimationExample();
		Criteria criteria = example.createCriteria();
		criteria.andUseridEqualTo(uid);
		criteria.andIdNotEqualTo(vid);
		example.setOrderByClause("createtime desc");
		PageHelper.startPage(1, 4, true);
		List<Animation>list=animationMapper.selectByExample(example);
		if(list.size()!=0)
		{
			return list;
		}
		return null;
	}

	public List<Animation> selectByuserId(int userid, int pagenum,int order) {
		AnimationExample example=new AnimationExample();
		Criteria criteria = example.createCriteria();
		criteria.andUseridEqualTo(userid);
		if(order==1)
			example.setOrderByClause("createtime desc");
		if(order==2)
			example.setOrderByClause("download desc");
		if(order==3)
			example.setOrderByClause("grade desc");
		PageHelper.startPage(pagenum, 4, true);
		List<Animation>list=animationMapper.selectByExample(example);
		if(list.size()!=0) {
			return list;
		}
		return null;
	}

}
