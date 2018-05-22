package com.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.ChatRecordMapper;
import com.pojo.ChatRecord;
import com.service.ChatRecordService;
@Service
public class ChatRecordServiceImpl implements ChatRecordService{

	@Autowired
	private ChatRecordMapper chatRecordMapper;
	
	@Override
	public Integer insert(ChatRecord record) {
		return chatRecordMapper.insert(record);
	}

	@Override
	public List<ChatRecord> selectByRoomid(Integer roomid) {
	    List<ChatRecord>list=chatRecordMapper.selectByRoomid(roomid);
	    if(list.size()!=0) {
	    	return list;
	    }
		return null;
	}

}
