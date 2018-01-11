package com.service;

public interface BaseService<T> {

	T selectByPrimaryKey(Integer id);
	
    int insert(T record);

    int insertSelective(T record);
    
    int deleteByPrimaryKey(Integer id);
    
    int updateByPrimaryKeySelective(T record);

    int updateByPrimaryKey(T record);
}
