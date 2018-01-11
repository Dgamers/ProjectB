package com.serviceImpl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.dao.PendinganimationMapper;
import com.github.pagehelper.PageHelper;
import com.pojo.Pendinganimation;
import com.pojo.PendinganimationExample;
import com.pojo.PendinganimationExample.Criteria;

import com.service.PendinganimationService;

@Service
public class PendinganimationServiceImpl implements PendinganimationService {

	@Autowired
	private PendinganimationMapper pendinganimationMapper;

	public Pendinganimation selectByPrimaryKey(Integer id) {

		return pendinganimationMapper.selectByPrimaryKey(id);
	}

	public int insert(Pendinganimation record) {

		return pendinganimationMapper.insert(record);
	}

	public int insertSelective(Pendinganimation record) {

		return pendinganimationMapper.insertSelective(record);
	}

	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return pendinganimationMapper.deleteByPrimaryKey(id);
	}

	public int updateByPrimaryKeySelective(Pendinganimation record) {
		// TODO Auto-generated method stub
		return pendinganimationMapper.updateByPrimaryKeySelective(record);
	}

	public int updateByPrimaryKey(Pendinganimation record) {
		// TODO Auto-generated method stub
		return pendinganimationMapper.updateByPrimaryKey(record);
	}

	public List<Pendinganimation> selectByPage(int pageSize, int pagenum, String search_title,String search_user,Integer search_category,Date start_time,Date end_time) {
		PageHelper.startPage(pagenum, pageSize, true);
		List<Pendinganimation> pendinganimations = pendinganimationMapper.selectBySearch(search_title,search_user,search_category,start_time,end_time);
		if (pendinganimations.size() != 0)
			return pendinganimations;
		return null;
	}

}
