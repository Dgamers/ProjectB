package com.service;

import com.pojo.VerifyingMailbox;

public interface VerifyingMailboxService {
	
	
	VerifyingMailbox selectByemail(String email);

	VerifyingMailbox selectByPrimaryKey(Integer id);

	int insert(VerifyingMailbox record);

	int insertSelective(VerifyingMailbox record);

	int deleteByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(VerifyingMailbox record);

	int updateByPrimaryKey(VerifyingMailbox record);
}
