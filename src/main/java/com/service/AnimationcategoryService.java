package com.service;

import java.util.List;

import com.pojo.Animationcategory;

public interface AnimationcategoryService {

	Animationcategory selectByPrimaryKey(Integer id);

	int insert(Animationcategory record);

	int insertSelective(Animationcategory record);

	int deleteByPrimaryKey(Integer id);

	int updateByPrimaryKeySelective(Animationcategory record);

	int updateByPrimaryKey(Animationcategory record);

	List<Animationcategory> selectAllCatagory();
	
}
