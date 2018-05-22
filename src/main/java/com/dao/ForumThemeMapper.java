package com.dao;

import com.pojo.ForumTheme;
import com.pojo.ForumThemeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ForumThemeMapper {
    int countByExample(ForumThemeExample example);

    int deleteByExample(ForumThemeExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(ForumTheme record);

    int insertSelective(ForumTheme record);

    List<ForumTheme> selectByExample(ForumThemeExample example);

    ForumTheme selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") ForumTheme record, @Param("example") ForumThemeExample example);

    int updateByExample(@Param("record") ForumTheme record, @Param("example") ForumThemeExample example);

    int updateByPrimaryKeySelective(ForumTheme record);

    int updateByPrimaryKey(ForumTheme record);
    
    List<ForumTheme>selectAllForumTheme(@Param("order")Integer order,@Param("category")Integer category,@Param("keyword")String keyword,@Param("userid")Integer userid);
}