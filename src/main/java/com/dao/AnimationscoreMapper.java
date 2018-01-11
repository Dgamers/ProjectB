package com.dao;

import com.pojo.Animationscore;
import com.pojo.AnimationscoreExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface AnimationscoreMapper {
    int countByExample(AnimationscoreExample example);

    int deleteByExample(AnimationscoreExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Animationscore record);

    int insertSelective(Animationscore record);

    List<Animationscore> selectByExample(AnimationscoreExample example);

    Animationscore selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Animationscore record, @Param("example") AnimationscoreExample example);

    int updateByExample(@Param("record") Animationscore record, @Param("example") AnimationscoreExample example);

    int updateByPrimaryKeySelective(Animationscore record);

    int updateByPrimaryKey(Animationscore record);
    
    float getAvgByAid(int aid);
}