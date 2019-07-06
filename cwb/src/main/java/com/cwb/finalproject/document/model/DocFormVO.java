package com.cwb.finalproject.document.model;

public class DocFormVO {
	private int formNo;
	private String formName;
	private int typeNo;
	private int ranksNo;
	private String formDel;
	public int getFormNo() {
		return formNo;
	}
	public void setFormNo(int formNo) {
		this.formNo = formNo;
	}
	public String getFormName() {
		return formName;
	}
	public void setFormName(String formName) {
		this.formName = formName;
	}
	public int getTypeNo() {
		return typeNo;
	}
	public void setTypeNo(int typeNo) {
		this.typeNo = typeNo;
	}
	public int getRanksNo() {
		return ranksNo;
	}
	public void setRanksNo(int ranksNo) {
		this.ranksNo = ranksNo;
	}
	public String getFormDel() {
		return formDel;
	}
	public void setFormDel(String formDel) {
		this.formDel = formDel;
	}
	@Override
	public String toString() {
		return "DocFormVO [formNo=" + formNo + ", formName=" + formName + ", typeNo=" + typeNo + ", ranksNo=" + ranksNo
				+ ", formDel=" + formDel + "]";
	}
	
	
}
