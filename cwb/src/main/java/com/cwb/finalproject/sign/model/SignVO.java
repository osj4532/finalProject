package com.cwb.finalproject.sign.model;

public class SignVO {
	private int memNo;
	private String signFileName;
	private long signFileSize;
	private String signOriginalFileName;
	public int getMemNo() {
		return memNo;
	}
	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}
	public String getSignFileName() {
		return signFileName;
	}
	public void setSignFileName(String signFileName) {
		this.signFileName = signFileName;
	}
	public long getSignFileSize() {
		return signFileSize;
	}
	public void setSignFileSize(long signFileSize) {
		this.signFileSize = signFileSize;
	}
	public String getSignOriginalFileName() {
		return signOriginalFileName;
	}
	public void setSignOriginalFileName(String signOriginalFileName) {
		this.signOriginalFileName = signOriginalFileName;
	}
	@Override
	public String toString() {
		return "SignVO [memNo=" + memNo + ", signFileName=" + signFileName + ", signFileSize=" + signFileSize
				+ ", signOriginalFileName=" + signOriginalFileName + "]";
	}
	
	
}
