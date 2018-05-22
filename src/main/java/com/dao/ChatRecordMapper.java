package com.dao;

import com.pojo.ChatRecord;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ChatRecordMapper {
Integer insert(ChatRecord record);

List<ChatRecord>selectByRoomid(@Param("roomid")Integer roomid);
}