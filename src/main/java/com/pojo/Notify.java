package com.pojo;

import java.util.Date;

public class Notify {

	private Integer id;

	private String title;

	private String content;

	private Integer admin;

	private Integer user;

	private Date createtime;

	private Date updatetime;

	public Integer getAdmin() {
		return admin;
	}

	public String getContent() {
		return content;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public Integer getId() {
		return id;
	}

	public String getTitle() {
		return title;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public Integer getUser() {
		return user;
	}

	public void setAdmin(Integer admin) {
		this.admin = admin;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}

	public void setUser(Integer user) {
		this.user = user;
	}

}
