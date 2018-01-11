package com.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.VerifyingMailboxMapper;
import com.pojo.VerifyingMailbox;
import com.pojo.VerifyingMailboxExample;
import com.pojo.VerifyingMailboxExample.Criteria;
import com.service.VerifyingMailboxService;

@Service
public class VerifyingMailboxServiceImpl implements VerifyingMailboxService{

	@Autowired
	private VerifyingMailboxMapper verifyingMailboxMapper;

	public VerifyingMailbox selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return verifyingMailboxMapper.selectByPrimaryKey(id);
	}

	public int insert(VerifyingMailbox record) {
		// TODO Auto-generated method stub
		return verifyingMailboxMapper.insert(record);
	}

	public int insertSelective(VerifyingMailbox record) {
		// TODO Auto-generated method stub
		return verifyingMailboxMapper.insertSelective(record);
	}

	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return verifyingMailboxMapper.deleteByPrimaryKey(id);
	}

	public int updateByPrimaryKeySelective(VerifyingMailbox record) {
		// TODO Auto-generated method stub
		return verifyingMailboxMapper.updateByPrimaryKeySelective(record);
	}

	public int updateByPrimaryKey(VerifyingMailbox record) {
		// TODO Auto-generated method stub
		return verifyingMailboxMapper.updateByPrimaryKey(record);
	}



	public VerifyingMailbox selectByemail(String email) {
		VerifyingMailboxExample example=new VerifyingMailboxExample();
		Criteria criteria=example.createCriteria();
		criteria.andEmailEqualTo(email);
		List<VerifyingMailbox>list=verifyingMailboxMapper.selectByExample(example);
		if(list.size()!=0)
		return list.get(0);
		else
		return null;
	}
}
