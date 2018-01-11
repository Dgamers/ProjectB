package com.utils;

import java.util.List;

public class TableResult<T> {

	List<T> rows;
	
	long total;
	
	T row;


	public TableResult() {
		super();
	}

	public TableResult(List<T> rows, long total) {
		super();
		this.rows = rows;
		this.total = total;
	}

	public List<T> getRows() {
		return rows;
	}

	public void setRows(List<T> rows) {
		this.rows = rows;
	}

	public long getTotal() {
		return total;
	}

	public void setTotal(long total) {
		this.total = total;
	}

	public T getRow() {
		return row;
	}

	public void setRow(T row) {
		this.row = row;
	}
	
	
}
