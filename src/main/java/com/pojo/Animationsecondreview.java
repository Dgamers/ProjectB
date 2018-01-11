package com.pojo;

import java.util.Date;

public class Animationsecondreview {

	private Integer id;
	
	private Integer rid;
	
	private String content;
	
	private Date time;
	
	private Integer userid;
	
	private Integer reuserid;
	
	private String username;
	
	private String userpicture;
	
	private String reusername;
	 
	private String reuserpicture;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getRid() {
		return rid;
	}

	public void setRid(Integer rid) {
		this.rid = rid;
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

	public Integer getReuserid() {
		return reuserid;
	}

	public void setReuserid(Integer reuserid) {
		this.reuserid = reuserid;
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

	public String getReusername() {
		return reusername;
	}

	public void setReusername(String reusername) {
		this.reusername = reusername;
	}

	public String getReuserpicture() {
		return reuserpicture;
	}

	public void setReuserpicture(String reuserpicture) {
		this.reuserpicture = reuserpicture;
	}

	@Override
	public String toString() {
		return "Animationsecondreview [id=" + id + ", rid=" + rid + ", content=" + content + ", time=" + time
				+ ", userid=" + userid + ", reuserid=" + reuserid + ", username=" + username + ", userpicture="
				+ userpicture + ", reusername=" + reusername + ", reuserpicture=" + reuserpicture + "]";
	}

}