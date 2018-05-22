package com.dao;

import com.pojo.ChatRoom;

import java.util.Date;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ChatRoomMapper {
	Integer insert(ChatRoom record);
	
	ChatRoom selectbyjoiner(@Param("joiner")String joiner);
	
	void updateupdatetime(@Param("roomid")Integer roomid,@Param("nowtime")Date nowtime);
	
	void updatestatus(@Param("roomid")Integer roomid,@Param("status")Integer status);
	
	List <ChatRoom>selectbyuserid(@Param("userid")Integer userid);
}