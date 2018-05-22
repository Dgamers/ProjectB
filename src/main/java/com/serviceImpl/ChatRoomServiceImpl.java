package com.serviceImpl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.ChatRoomMapper;
import com.pojo.ChatRoom;
import com.service.ChatRoomService;
@Service
public class ChatRoomServiceImpl implements ChatRoomService{

	@Autowired
	private ChatRoomMapper chatRoomMapper;
	
	@Override
	public Integer insert(ChatRoom record) {
		return chatRoomMapper.insert(record);
	}

	@Override
	public ChatRoom selectbyjoiner(String joiner) {
		return chatRoomMapper.selectbyjoiner(joiner);
	}

	@Override
	public void updateupdatetime(Integer roomid, Date nowtime) {
		chatRoomMapper.updateupdatetime(roomid, nowtime);
		
	}

	@Override
	public List<ChatRoom> selectbyuserid(Integer userid) { 
		List<ChatRoom>list=chatRoomMapper.selectbyuserid(userid);
		if(list.size()!=0) {
			return list;
		}
		return null;
	}

	@Override
	public void updatestatus(Integer roomid, Integer status) {
		chatRoomMapper.updatestatus(roomid, status);
		
	}

}
