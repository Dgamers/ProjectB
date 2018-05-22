package com.dao;

import com.pojo.ForumCategory;
import com.pojo.ForumCategoryExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ForumCategoryMapper {
    int countByExample(ForumCategoryExample example);

    int deleteByExample(ForumCategoryExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(ForumCategory record);

    int insertSelective(ForumCategory record);

    List<ForumCategory> selectByExample(ForumCategoryExample example);

    ForumCategory selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") ForumCategory record, @Param("example") ForumCategoryExample example);

    int updateByExample(@Param("record") ForumCategory record, @Param("example") ForumCategoryExample example);

    int updateByPrimaryKeySelective(ForumCategory record);

    int updateByPrimaryKey(ForumCategory record);
}