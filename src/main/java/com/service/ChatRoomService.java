package com.service;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.pojo.ChatRoom;

public interface ChatRoomService {

	Integer insert(ChatRoom record);
	
	ChatRoom selectbyjoiner(String joiner);
	
	void updateupdatetime(Integer roomid,Date nowtime);
	
	void updatestatus(Integer roomid,Integer status);
	
	List <ChatRoom>selectbyuserid(Integer userid);
}
