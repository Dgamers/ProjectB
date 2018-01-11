package com.pojo;

import java.util.Date;
import java.util.List;

public class Animationreview {

	private Integer id;
	
	private Integer aid;
	
	private String content;
	
	private Date time;
	
	private Integer userid;
	
	private String username;
	
	private String userpicture;
	
	private List<Animationsecondreview>secondreviews;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getAid() {
		return aid;
	}

	public void setAid(Integer aid) {
		this.aid = aid;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public Integer getUserid() {
		return userid;
	}

	public void setUserid(Integer userid) {
		this.userid = userid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUserpicture() {
		return userpicture;
	}

	public void setUserpicture(String userpicture) {
		this.userpicture = userpicture;
	}
	
	public List<Animationsecondreview> getSecondreviews() {
		return secondreviews;
	}

	public void setSecondreviews(List<Animationsecondreview> secondreview) {
		this.secondreviews = secondreview;
	}

	@Override
	public String toString() {
		return "Animationreview [id=" + id + ", aid=" + aid + ", content=" + content + ", time=" + time + ", userid="
				+ userid + ", username=" + username + ", userpicture=" + userpicture + "]";
	}
	
}
