package com.cwb.finalproject.useResource.model;

public class UseResourceVO {
	private String typeName;
	private int reservNo;
	private int resNo;
	private int memNo;
	private String resName;
	private String useRegdate;
	private String returnRegdate;
	private String apprFlag;
	
	public int getReservNo() {
		return reservNo;
	}
	public void setReservNo(int reservNo) {
		this.reservNo = reservNo;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public int getResNo() {
		return resNo;
	}
	public void setResNo(int resNo) {
		this.resNo = resNo;
	}
	public int getMemNo() {
		return memNo;
	}
	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}
	public String getResName() {
		return resName;
	}
	public void setResName(String resName) {
		this.resName = resName;
	}
	public String getUseRegdate() {
		return useRegdate;
	}
	public void setUseRegdate(String useRegdate) {
		this.useRegdate = useRegdate;
	}
	public String getReturnRegdate() {
		return returnRegdate;
	}
	public void setReturnRegdate(String returnRegdate) {
		this.returnRegdate = returnRegdate;
	}
	public String getApprFlag() {
		return apprFlag;
	}
	public void setApprFlag(String apprFlag) {
		this.apprFlag = apprFlag;
	}
	@Override
	public String toString() {
		return "UseResourceVO [typeName=" + typeName + ", reservNo=" + reservNo + ", resNo=" + resNo + ", memNo="
				+ memNo + ", resName=" + resName + ", useRegdate=" + useRegdate + ", returnRegdate=" + returnRegdate
				+ ", apprFlag=" + apprFlag + "]";
	}
	
	
}
