package com.service;

import java.util.List;

import com.pojo.Notify;

public interface NotifyService {

	Integer countnotifyByuser(Integer userid);

	Integer insertnotify(Notify notify);

	List<Notify> selectnotifyByuser(Integer userid);
}
