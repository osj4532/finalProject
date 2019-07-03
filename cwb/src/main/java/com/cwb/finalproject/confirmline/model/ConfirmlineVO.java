package com.cwb.finalproject.confirmline.model;

public class ConfirmlineVO {
	private int lineNo;
	private int regNo;
	private int memNo;
	private int lineOrder;
	
	public int getLineNo() {
		return lineNo;
	}

	public void setLineNo(int lineNo) {
		this.lineNo = lineNo;
	}

	public int getRegNo() {
		return regNo;
	}

	public void setRegNo(int regNo) {
		this.regNo = regNo;
	}

	public int getMemNo() {
		return memNo;
	}

	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}

	public int getLineOrder() {
		return lineOrder;
	}

	public void setLineOrder(int lineOrder) {
		this.lineOrder = lineOrder;
	}

	@Override
	public String toString() {
		return "ConfirmlineVO [lineNo=" + lineNo + ", regNo=" + regNo + ", memNo=" + memNo + ", lineOrder=" + lineOrder
				+ "]";
	}
}
