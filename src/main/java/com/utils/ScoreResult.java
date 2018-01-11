package com.utils;

public class ScoreResult {

	private Integer state;
	private Integer count;
	private Float grade;
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	public Float getGrade() {
		return grade;
	}
	public void setGrade(Float grade) {
		this.grade = grade;
	}
	public ScoreResult(Integer state, Integer count, Float grade) {
		super();
		this.state = state;
		this.count = count;
		this.grade = grade;
	}
	
}
