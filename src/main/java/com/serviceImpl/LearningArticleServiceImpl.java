package com.serviceImpl;



import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.dao.ForumThemeMapper;
import com.dao.LearningArticleMapper;
import com.github.pagehelper.PageHelper;
import com.pojo.Animation;
import com.pojo.ForumTheme;
import com.pojo.LearningArticle;
import com.pojo.LearningArticleExample;
import com.pojo.LearningArticleExample.Criteria;
import com.service.ForumThemeService;
import com.service.LearningArticleService;

@Service
public class LearningArticleServiceImpl implements LearningArticleService
{

	@Autowired
	private LearningArticleMapper learningArticleMapper;

	@Override
	public int deleteByPrimaryKey(Integer id)
	{
		// TODO Auto-generated method stub
		return learningArticleMapper.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(LearningArticle record)
	{

		return learningArticleMapper.insert(record);
	}

	@Override
	public int insertSelective(LearningArticle record)
	{

		return learningArticleMapper.insertSelective(record);
	}


	@Override
	public LearningArticle selectByPrimaryKey(Integer id)
	{

		return learningArticleMapper.selectByPrimaryKey(id);
	}


	@Override
	public int updateByPrimaryKey(LearningArticle record)
	{
		// TODO Auto-generated method stub
		return learningArticleMapper.updateByPrimaryKey(record);
	}

	@Override
	public int updateByPrimaryKeySelective(LearningArticle record)
	{
		// TODO Auto-generated method stub
		return learningArticleMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public List<LearningArticle> getarticles(Integer pageNum, Integer pageSize,String keyword,Integer category) {
		PageHelper.startPage(pageNum, pageSize);
		LearningArticleExample example=new LearningArticleExample();
		Criteria criteria=example.createCriteria();
		if(!keyword.isEmpty()&&!keyword.equals("")) {
			criteria.andTitleLike('%'+keyword+'%');
		}
		if(category!=null&&category!=0) {
			criteria.andCategoryEqualTo(category);
		}
		List<LearningArticle>list=learningArticleMapper.selectByExample(example);
		if(list.size()!=0) {
			return list;
		}
		return null;
	}

	@Override
	public List<LearningArticle> selectBySearch(int limit, int pagenum, String search_title, String search_edit,
			Integer search_category, Date start_time, Date end_time, Integer search_status) {
		PageHelper.startPage(pagenum, limit, true);
		List<LearningArticle>list=learningArticleMapper.selectBySearch(search_title, search_edit, search_category, start_time, end_time, search_status);
		if(list.size()!=0) {
			return list;
		}
		return null;
	}


}
