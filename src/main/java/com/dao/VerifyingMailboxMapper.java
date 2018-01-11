package com.dao;

import com.pojo.VerifyingMailbox;
import com.pojo.VerifyingMailboxExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface VerifyingMailboxMapper {
    int countByExample(VerifyingMailboxExample example);

    int deleteByExample(VerifyingMailboxExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(VerifyingMailbox record);

    int insertSelective(VerifyingMailbox record);

    List<VerifyingMailbox> selectByExample(VerifyingMailboxExample example);

    VerifyingMailbox selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") VerifyingMailbox record, @Param("example") VerifyingMailboxExample example);

    int updateByExample(@Param("record") VerifyingMailbox record, @Param("example") VerifyingMailboxExample example);

    int updateByPrimaryKeySelective(VerifyingMailbox record);

    int updateByPrimaryKey(VerifyingMailbox record);
}