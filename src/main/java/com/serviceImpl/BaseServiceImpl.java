package com.serviceImpl;



import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;

import com.dao.BaseMapper;
import com.dao.UserMapper;
import com.service.BaseService;

public class BaseServiceImpl<T>implements BaseService<T> {
	
	private Class clazz=null;
	@Autowired
    protected BaseMapper<T>baseMapper;
    @Autowired
    protected UserMapper userMapper;
    
	public BaseServiceImpl() {
		ParameterizedType type=(ParameterizedType)this.getClass().getGenericSuperclass();
		clazz=(Class)type.getActualTypeArguments()[0];
	}
	
	@PostConstruct
	public void init() throws Exception
	{
		// 根据相应的clazz,吧相应  ****Dao 赋值给BaseDao即可
		// 1: 获取当前clazz的类型,然后获取相应的类名称
		String clazzName = clazz.getSimpleName();
	
		// 2:Account===>account===>account+Dao  Category====>CategoryDao
		String clazzDaoName = clazzName.substring(0,1).toLowerCase() + clazzName.substring(1) + "Mapper";//toLowerCase首字母小写
		
		// 3: 通过clazzDaoName获取相应 Field字段    this.getClass().getSuperclass():获取到相应BaseServiceImpl
		Field daoNameField = this.getClass().getSuperclass().getDeclaredField(clazzDaoName);
		
		Object object = daoNameField.get(this);
	
		// 4: 获取baseDao 字段
		Field baseDaoNameField = this.getClass().getSuperclass().getDeclaredField("baseMapper");
		baseDaoNameField.set(this, object);
		
	}	
	public T selectByPrimaryKey(Integer id) {
		return baseMapper.selectByPrimaryKey(id);
	}

	public int insert(T record) {
		return baseMapper.insert(record);
	}

	public int insertSelective(T record) {
		return insertSelective(record);
	}

	public int deleteByPrimaryKey(Integer id) {
		return deleteByPrimaryKey(id);
	}

	public int updateByPrimaryKeySelective(T record) {
		return updateByPrimaryKeySelective(record);
	}

	public int updateByPrimaryKey(T record) {
		return updateByPrimaryKey(record);
	}

}
