package com.dao;

import com.pojo.LearningArticle;
import com.pojo.LearningArticleExample;

import java.util.Date;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface LearningArticleMapper {
    int countByExample(LearningArticleExample example);

    int deleteByExample(LearningArticleExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(LearningArticle record);

    int insertSelective(LearningArticle record);

    List<LearningArticle> selectByExampleWithBLOBs(LearningArticleExample example);

    List<LearningArticle> selectByExample(LearningArticleExample example);

    LearningArticle selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") LearningArticle record, @Param("example") LearningArticleExample example);

    int updateByExampleWithBLOBs(@Param("record") LearningArticle record, @Param("example") LearningArticleExample example);

    int updateByExample(@Param("record") LearningArticle record, @Param("example") LearningArticleExample example);

    int updateByPrimaryKeySelective(LearningArticle record);

    int updateByPrimaryKeyWithBLOBs(LearningArticle record);

    int updateByPrimaryKey(LearningArticle record);
    
    List<LearningArticle>selectBySearch(@Param("search_title")String search_title,@Param("search_edit") String search_edit,
	        @Param("search_category") Integer search_category, @Param("start_time") Date start_time,
	        @Param("end_time") Date end_time, @Param("search_status") Integer search_status);
}