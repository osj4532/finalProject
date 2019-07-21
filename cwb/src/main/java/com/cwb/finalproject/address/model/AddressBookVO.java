package com.cwb.finalproject.address.model;

public class AddressBookVO {
	private int addrbookNo;
	private String addrbookName;
	private String addrbookComname;
	private String addrbookTel;
	private String addrbookEmail;
	private int memNo;
	private int deptNo;
	public int getAddrbookNo() {
		return addrbookNo;
	}
	public void setAddrbookNo(int addrbookNo) {
		this.addrbookNo = addrbookNo;
	}
	public String getAddrbookName() {
		return addrbookName;
	}
	public void setAddrbookName(String addrbookName) {
		this.addrbookName = addrbookName;
	}
	public String getAddrbookComname() {
		return addrbookComname;
	}
	public void setAddrbookComname(String addrbookComname) {
		this.addrbookComname = addrbookComname;
	}
	public String getAddrbookTel() {
		return addrbookTel;
	}
	public void setAddrbookTel(String addrbookTel) {
		this.addrbookTel = addrbookTel;
	}
	public String getAddrbookEmail() {
		return addrbookEmail;
	}
	public void setAddrbookEmail(String addrbookEmail) {
		this.addrbookEmail = addrbookEmail;
	}
	public int getMemNo() {
		return memNo;
	}
	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}
	public int getDeptNo() {
		return deptNo;
	}
	public void setDeptNo(int deptNo) {
		this.deptNo = deptNo;
	}
	@Override
	public String toString() {
		return "AddressBookVO [addrbookNo=" + addrbookNo + ", addrbookName=" + addrbookName + ", addrbookComname="
				+ addrbookComname + ", addrbookTel=" + addrbookTel + ", addrbookEmail=" + addrbookEmail + ", memNo="
				+ memNo + ", deptNo=" + deptNo + "]";
	}
	
	
}
