package com.dao;

import com.pojo.UserOperation;
import com.pojo.UserOperationExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface UserOperationMapper {
    int countByExample(UserOperationExample example);

    int deleteByExample(UserOperationExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(UserOperation record);

    int insertSelective(UserOperation record);

    List<UserOperation> selectByExample(UserOperationExample example);

    UserOperation selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") UserOperation record, @Param("example") UserOperationExample example);

    int updateByExample(@Param("record") UserOperation record, @Param("example") UserOperationExample example);

    int updateByPrimaryKeySelective(UserOperation record);

    int updateByPrimaryKey(UserOperation record);
}