package com.serviceImpl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.dao.UserOperationMapper;


import com.pojo.UserOperation;
import com.pojo.UserOperationExample;
import com.pojo.UserOperationExample.Criteria;
import com.service.UserOperationService;

@Service
public class UserOperationServiceImpl  implements UserOperationService {

	@Autowired
	private UserOperationMapper userOperationMapper;

	public UserOperation selectByPrimaryKey(Integer id) {
		
		return userOperationMapper.selectByPrimaryKey(id);
	}

	public int insert(UserOperation record) {
		
		return userOperationMapper.insert(record);
	}

	public int insertSelective(UserOperation record) {
		
		return userOperationMapper.insertSelective(record);
	}

	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return userOperationMapper.deleteByPrimaryKey(id);
	}

	public int updateByPrimaryKeySelective(UserOperation record) {
		// TODO Auto-generated method stub
		return userOperationMapper.updateByPrimaryKeySelective(record);
	}

	public int updateByPrimaryKey(UserOperation record) {
		// TODO Auto-generated method stub
		return userOperationMapper.updateByPrimaryKey(record);
	}

	public UserOperation selectByUserId(Integer userid) {
		UserOperationExample example=new UserOperationExample();
		Criteria criteria = example.createCriteria();
		criteria.andUseridEqualTo(userid);
		List<UserOperation>list=userOperationMapper.selectByExample(example);
		if(list.size()!=0)
			return list.get(0);
		return null;
	}
}
