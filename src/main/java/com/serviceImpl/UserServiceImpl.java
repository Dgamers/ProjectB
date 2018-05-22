package com.serviceImpl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.UserMapper;
import com.github.pagehelper.PageHelper;
import com.pojo.User;
import com.pojo.UserExample;
import com.pojo.UserExample.Criteria;
import com.service.UserService;

@Service
public class UserServiceImpl implements UserService
{

	@Autowired
	private UserMapper userMapper;

	@Override
	public int deleteByPrimaryKey(Integer id)
	{
		// TODO Auto-generated method stub
		return userMapper.deleteByPrimaryKey(id);
	}

	@Override
	public User findByEmail(String email)
	{
		UserExample example = new UserExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmailEqualTo(email);
		List<User> list = userMapper.selectByExample(example);
		if (list.size() != 0)
		{
			return list.get(0);
		}
		else
		{
			return null;
		}
	}

	@Override
	public int insert(User record)
	{

		return userMapper.insert(record);
	}

	@Override
	public int insertSelective(User record)
	{

		return userMapper.insertSelective(record);
	}

	@Override
	public boolean isExistUser(String email)
	{
		UserExample example = new UserExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmailEqualTo(email);
		List<User> list = userMapper.selectByExample(example);
		if (list.size() != 0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	@Override
	public List<User> selectByPage(int pageSize, int pagenum, String search_name, String search_email,
	        String search_phone, Date start_time, Date end_time, Integer search_status)
	{
		UserExample example = new UserExample();
		Criteria criteria = example.createCriteria();
		if (search_name != null && !search_name.isEmpty())
		{
			criteria.andNameLike("%" + search_name + "%");
		}
		if (search_email != null & !search_email.isEmpty())
		{
			criteria.andEmailLike("%" + search_email + "%");
		}
		if (search_phone != null && !search_phone.isEmpty())
		{
			criteria.andPhoneLike("%" + search_phone + "%");
		}
		if (start_time != null)
		{
			criteria.andCreatetimeGreaterThanOrEqualTo(start_time);
		}
		if (end_time != null)
		{
			criteria.andCreatetimeLessThanOrEqualTo(end_time);
		}
		if (search_status != 3)
		{
			criteria.andStatusEqualTo(search_status);
		}
		PageHelper.startPage(pagenum, pageSize, true);
		List<User> users = userMapper.selectByExample(example);
		if (users.size() != 0)
		{
			return users;
		}
		return null;
	}

	@Override
	public User selectByPrimaryKey(Integer id)
	{

		return userMapper.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKey(User record)
	{
		// TODO Auto-generated method stub
		return userMapper.updateByPrimaryKey(record);
	}

	@Override
	public int updateByPrimaryKeySelective(User record)
	{
		// TODO Auto-generated method stub
		return userMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public List<User> selectByjoiner(List<Integer> joinerid) {
		return userMapper.selectByjoiner(joinerid);
	}

}
