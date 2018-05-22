package com.pojo;

import java.util.Date;
import java.util.List;

public class ForumReply {
    private Integer id;

    private Date createtime;

    private Integer userid;
    
    private String username;
    
    private String userpicture;

    private Integer themeid;

    private String content;
    
    private List<ForumReplySecond>forumReplySeconds;
    

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public Integer getThemeid() {
        return themeid;
    }

    public void setThemeid(Integer themeid) {
        this.themeid = themeid;
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

	public List<ForumReplySecond> getForumReplySeconds() {
		return forumReplySeconds;
	}

	public void setForumReplySeconds(List<ForumReplySecond> forumReplySeconds) {
		this.forumReplySeconds = forumReplySeconds;
	}
    
    
}