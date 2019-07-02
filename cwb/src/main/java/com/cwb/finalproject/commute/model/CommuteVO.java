package com.cwb.finalproject.commute.model;

import java.sql.Timestamp;

public class CommuteVO {

	private int comNo;
	private int memNo;
	private Timestamp comIndate;
	private Timestamp comOutdate;
	private String comStatus;
	private String comEval;
	
	public CommuteVO() {
		super();
	}

	public CommuteVO(int comNo, int memNo, Timestamp comIndate, Timestamp comOutdate, String comStatus,
			String comEval) {
		super();
		this.comNo = comNo;
		this.memNo = memNo;
		this.comIndate = comIndate;
		this.comOutdate = comOutdate;
		this.comStatus = comStatus;
		this.comEval = comEval;
	}

	public int getComNo() {
		return comNo;
	}

	public void setComNo(int comNo) {
		this.comNo = comNo;
	}

	public int getMemNo() {
		return memNo;
	}

	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}

	public Timestamp getComIndate() {
		return comIndate;
	}

	public void setComIndate(Timestamp comIndate) {
		this.comIndate = comIndate;
	}

	public Timestamp getComOutdate() {
		return comOutdate;
	}

	public void setComOutdate(Timestamp comOutdate) {
		this.comOutdate = comOutdate;
	}

	public String getComStatus() {
		return comStatus;
	}

	public void setComStatus(String comStatus) {
		this.comStatus = comStatus;
	}

	public String getComEval() {
		return comEval;
	}

	public void setComEval(String comEval) {
		this.comEval = comEval;
	}

	@Override
	public String toString() {
		return "CommuteVO [comNo=" + comNo + ", memNo=" + memNo + ", comIndate=" + comIndate + ", comOutdate="
				+ comOutdate + ", comStatus=" + comStatus + ", comEval=" + comEval + "]";
	}
	
	
	

}
