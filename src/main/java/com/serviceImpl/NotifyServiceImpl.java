package com.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.NotifyMapper;
import com.pojo.Notify;
import com.service.NotifyService;

@Service
public class NotifyServiceImpl implements NotifyService{

	@Autowired
	private NotifyMapper notifyMapper;

	public Integer countnotifyByuser(Integer userid) {
		return notifyMapper.countnotifyByuser(userid);
	}

	public Integer insertnotify(Notify notify) {
		return notifyMapper.insertnotify(notify);
	}

	public List<Notify> selectnotifyByuser(Integer userid) {
		List<Notify> notifies = notifyMapper.selectnotifyByuser(userid);
		if (notifies.size() != 0) {
			return notifies;
		}
		return null;
	}

}
