package com.dao;

import com.pojo.Pendinganimation;
import com.pojo.PendinganimationExample;

import java.util.Date;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface PendinganimationMapper {
    int countByExample(PendinganimationExample example);

    int deleteByExample(PendinganimationExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Pendinganimation record);

    int insertSelective(Pendinganimation record);

    List<Pendinganimation> selectByExample(PendinganimationExample example);

    Pendinganimation selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Pendinganimation record, @Param("example") PendinganimationExample example);

    int updateByExample(@Param("record") Pendinganimation record, @Param("example") PendinganimationExample example);

    int updateByPrimaryKeySelective(Pendinganimation record);

    int updateByPrimaryKey(Pendinganimation record);
    
    List<Pendinganimation>selectBySearch(@Param("search_title")String search_title,@Param("search_user")String search_user,@Param("search_category")Integer search_category,@Param("start_time")Date start_time,@Param("end_time")Date end_time);
}