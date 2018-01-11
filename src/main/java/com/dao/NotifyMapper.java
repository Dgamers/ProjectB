package com.dao;

import java.util.List;

import com.pojo.Notify;

public interface NotifyMapper {

	Integer countnotifyByuser(Integer userid);

	Integer insertnotify(Notify notify);

	List<Notify> selectnotifyByuser(Integer userid);
}
