package com.dao;

import com.pojo.LearningCategory;
import com.pojo.LearningCategoryExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface LearningCategoryMapper {
    int countByExample(LearningCategoryExample example);

    int deleteByExample(LearningCategoryExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(LearningCategory record);

    int insertSelective(LearningCategory record);

    List<LearningCategory> selectByExample(LearningCategoryExample example);

    LearningCategory selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") LearningCategory record, @Param("example") LearningCategoryExample example);

    int updateByExample(@Param("record") LearningCategory record, @Param("example") LearningCategoryExample example);

    int updateByPrimaryKeySelective(LearningCategory record);

    int updateByPrimaryKey(LearningCategory record);
}