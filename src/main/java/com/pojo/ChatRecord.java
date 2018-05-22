package com.pojo;

import java.util.Date;

public class ChatRecord {
    private Integer id;

    private Integer chatroom;

    private Integer sender;

    private Date createtime;

    private String record;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getChatroom() {
        return chatroom;
    }

    public void setChatroom(Integer chatroom) {
        this.chatroom = chatroom;
    }

    public Integer getSender() {
        return sender;
    }

    public void setSender(Integer sender) {
        this.sender = sender;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public String getRecord() {
        return record;
    }

    public void setRecord(String record) {
        this.record = record == null ? null : record.trim();
    }
}