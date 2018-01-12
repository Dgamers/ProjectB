package com.pojo;

import java.util.Date;

public class Animation
{
	private Integer id;

	private Integer userid;

	private String username;

	private String title;

	private String content;

	private String picture;

	private String address;

	private Integer status;

	private Float grade;

	private Integer download;

	private Date createtime;

	private Date updatetime;

	private Integer category;

	private String categoryname;

	public String getAddress()
	{
		return address;
	}

	public Integer getCategory()
	{
		return category;
	}

	public String getCategoryname()
	{
		return categoryname;
	}

	public String getContent()
	{
		return content;
	}

	public Date getCreatetime()
	{
		return createtime;
	}

	public Integer getDownload()
	{
		return download;
	}

	public Float getGrade()
	{
		return grade;
	}

	public Integer getId()
	{
		return id;
	}

	public String getPicture()
	{
		return picture;
	}

	public Integer getStatus()
	{
		return status;
	}

	public String getTitle()
	{
		return title;
	}

	public Date getUpdatetime()
	{
		return updatetime;
	}

	public Integer getUserid()
	{
		return userid;
	}

	public String getUsername()
	{
		return username;
	}

	public void setAddress(String address)
	{
		this.address = address == null ? null : address.trim();
	}

	public void setCategory(Integer category)
	{
		this.category = category;
	}

	public void setCategoryname(String categoryname)
	{
		this.categoryname = categoryname;
	}

	public void setContent(String content)
	{
		this.content = content == null ? null : content.trim();
	}

	public void setCreatetime(Date createtime)
	{
		this.createtime = createtime;
	}

	public void setDownload(Integer download)
	{
		this.download = download;
	}

	public void setGrade(Float grade)
	{
		this.grade = grade;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public void setPicture(String picture)
	{
		this.picture = picture == null ? null : picture.trim();
	}

	public void setStatus(Integer status)
	{
		this.status = status;
	}

	public void setTitle(String title)
	{
		this.title = title == null ? null : title.trim();
	}

	public void setUpdatetime(Date updatetime)
	{
		this.updatetime = updatetime;
	}

	public void setUserid(Integer userid)
	{
		this.userid = userid;
	}

	public void setUsername(String username)
	{
		this.username = username;
	}

}