package com.cwb.finalproject.line.model;

public class LineVO {
	private int regNo;
	private String regName;
	private int memNo;
	private String lineDel;
	public int getRegNo() {
		return regNo;
	}
	public void setRegNo(int regNo) {
		this.regNo = regNo;
	}
	public String getRegName() {
		return regName;
	}
	public void setRegName(String regName) {
		this.regName = regName;
	}
	public int getMemNo() {
		return memNo;
	}
	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}
	public String getLineDel() {
		return lineDel;
	}
	public void setLineDel(String lineDel) {
		this.lineDel = lineDel;
	}
	@Override
	public String toString() {
		return "LineVO [regNo=" + regNo + ", regName=" + regName + ", memNo=" + memNo + ", lineDel=" + lineDel + "]";
	}
	
	
}
