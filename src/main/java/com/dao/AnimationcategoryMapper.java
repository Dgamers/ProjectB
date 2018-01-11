package com.dao;

import com.pojo.Animationcategory;
import com.pojo.AnimationcategoryExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface AnimationcategoryMapper {
    int countByExample(AnimationcategoryExample example);

    int deleteByExample(AnimationcategoryExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Animationcategory record);

    int insertSelective(Animationcategory record);

    List<Animationcategory> selectByExample(AnimationcategoryExample example);

    Animationcategory selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Animationcategory record, @Param("example") AnimationcategoryExample example);

    int updateByExample(@Param("record") Animationcategory record, @Param("example") AnimationcategoryExample example);

    int updateByPrimaryKeySelective(Animationcategory record);

    int updateByPrimaryKey(Animationcategory record);
}