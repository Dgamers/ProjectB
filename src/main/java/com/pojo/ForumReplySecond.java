package com.pojo;

import java.util.Date;

public class ForumReplySecond {
    private Integer id;

    private Integer userid;
    
    private String username;
    
    private String userpicture;

    private Integer reuserid;
    
    private String reusername;
    
    private String reuserpicture;

    private Date createtime;

    private Integer layerid;

    private String content;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public Integer getLayerid() {
		return layerid;
	}

	public void setLayerid(Integer layerid) {
		this.layerid = layerid;
	}

	public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
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
    
}