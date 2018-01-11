package com.dao;

import com.pojo.Animation;
import com.pojo.AnimationExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface AnimationMapper {
    int countByExample(AnimationExample example);

    int deleteByExample(AnimationExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Animation record);

    int insertSelective(Animation record);

    List<Animation> selectByExample(AnimationExample example);

    Animation selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Animation record, @Param("example") AnimationExample example);

    int updateByExample(@Param("record") Animation record, @Param("example") AnimationExample example);

    int updateByPrimaryKeySelective(Animation record);

    int updateByPrimaryKey(Animation record);
}