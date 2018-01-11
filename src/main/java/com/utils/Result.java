package com.utils;

public class Result {

	private String result;
	private int state;
	private String message;
	private int type;
	private Object data;

	public Result(String message, String result, int state, int type) {
		super();
		this.result = result;
		this.state = state;
		this.message = message;
		this.type = type;
	}

	public Result(String message, int state) {
		super();
		this.state = state;
		this.message = message;
	}
	
	public Result(String message, Object data, int state) {
		super();
		this.state = state;
		this.message = message;
		this.data=data;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

	
}
