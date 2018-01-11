package com.serviceImpl;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.dao.AdministratorMapper;
import com.pojo.Administrator;
import com.pojo.AdministratorExample;
import com.pojo.AdministratorExample.Criteria;
import com.service.AdministratorService;


@Service
public class AdministratorServiceImpl  implements AdministratorService {


	@Autowired
	private AdministratorMapper administratorMapper;
	
	public Administrator selectByPrimaryKey(Integer id) {
		
		return administratorMapper.selectByPrimaryKey(id);
	}
	
	public Administrator selectByname(String name) {
		AdministratorExample example=new AdministratorExample();
		Criteria criteria = example.createCriteria();
		criteria.andNameEqualTo(name);
		List<Administrator>list=administratorMapper.selectByExample(example);
		if(list.size()!=0) {
			return list.get(0);
		}
		return null;
	}

	public int insert(Administrator record) {
		
		return administratorMapper.insert(record);
	}

	public int insertSelective(Administrator record) {
		
		return administratorMapper.insertSelective(record);
	}

	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return administratorMapper.deleteByPrimaryKey(id);
	}

	public int updateByPrimaryKeySelective(Administrator record) {
		// TODO Auto-generated method stub
		return administratorMapper.updateByPrimaryKeySelective(record);
	}

	public int updateByPrimaryKey(Administrator record) {
		// TODO Auto-generated method stub
		return administratorMapper.updateByPrimaryKey(record);
	}



}
