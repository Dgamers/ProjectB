package com.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pojo.ChatRecord;

public interface ChatRecordService {
	Integer insert(ChatRecord record);
	
	List<ChatRecord>selectByRoomid(Integer roomid);
}
