package com.utils;

public class ForumPictureResult {

	Integer errno;
	
    String []data;

	public ForumPictureResult(Integer errno, String[] data) {
		super();
		this.errno = errno;
		this.data = data;
	}

	public Integer getErrno() {
		return errno;
	}

	public void setErrno(Integer errno) {
		this.errno = errno;
	}

	public String[] getData() {
		return data;
	}

	public void setData(String[] data) {
		this.data = data;
	}
    

	
	
}
