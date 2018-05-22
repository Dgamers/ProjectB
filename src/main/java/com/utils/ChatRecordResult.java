package com.utils;

import java.util.List;

import com.pojo.ChatRecord;
import com.pojo.User;

public class ChatRecordResult {

	User chooseuser;
	
	List<ChatRecord>chatRecords;

	public User getChooseuser() {
		return chooseuser;
	}

	public void setChooseuser(User chooseuser) {
		this.chooseuser = chooseuser;
	}

	public List<ChatRecord> getChatRecords() {
		return chatRecords;
	}

	public void setChatRecords(List<ChatRecord> chatRecords) {
		this.chatRecords = chatRecords;
	}
	
}
