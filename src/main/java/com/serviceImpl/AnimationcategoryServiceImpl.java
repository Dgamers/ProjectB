package com.serviceImpl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.dao.AnimationcategoryMapper;
import com.pojo.Animationcategory;
import com.pojo.AnimationcategoryExample;
import com.pojo.AnimationcategoryExample.Criteria;
import com.service.AnimationcategoryService;

@Service
public class AnimationcategoryServiceImpl implements AnimationcategoryService {

	@Autowired
	private AnimationcategoryMapper animationcategoryMapper;

	public Animationcategory selectByPrimaryKey(Integer id) {

		return animationcategoryMapper.selectByPrimaryKey(id);
	}

	public int insert(Animationcategory record) {

		return animationcategoryMapper.insert(record);
	}

	public int insertSelective(Animationcategory record) {

		return animationcategoryMapper.insertSelective(record);
	}

	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return animationcategoryMapper.deleteByPrimaryKey(id);
	}

	public int updateByPrimaryKeySelective(Animationcategory record) {
		// TODO Auto-generated method stub
		return animationcategoryMapper.updateByPrimaryKeySelective(record);
	}

	public int updateByPrimaryKey(Animationcategory record) {
		// TODO Auto-generated method stub
		return animationcategoryMapper.updateByPrimaryKey(record);
	}

	public List<Animationcategory> selectAllCatagory() {
		AnimationcategoryExample example = new AnimationcategoryExample();
		List<Animationcategory> list = animationcategoryMapper.selectByExample(example);
		if (list.size() != 0) {
			return list;
		}
		return null;
	}


}
