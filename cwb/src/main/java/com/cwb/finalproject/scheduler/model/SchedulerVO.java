package com.cwb.finalproject.scheduler.model;

public class SchedulerVO {
	private int scdNo; /* 스케줄번호 */
	private int memNo;/* 사원번호 */
	private String scdStart; /* 시작날짜 */
	private String scdEnd; /* 끝날짜 */
	private String scdContent; /* 스케줄내용 */
	
	public int getScdNo() {
		return scdNo;
	}
	public void setScdNo(int scdNo) {
		this.scdNo = scdNo;
	}
	public int getMemNo() {
		return memNo;
	}
	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}
	public String getScdStart() {
		return scdStart;
	}
	public void setScdStart(String scdStart) {
		this.scdStart = scdStart;
	}
	public String getScdEnd() {
		return scdEnd;
	}
	public void setScdEnd(String scdEnd) {
		this.scdEnd = scdEnd;
	}
	public String getScdContent() {
		return scdContent;
	}
	public void setScdContent(String scdContent) {
		this.scdContent = scdContent;
	}
	@Override
	public String toString() {
		return "SchedulerVO [scdNo=" + scdNo + ", memNo=" + memNo + ", scdStart=" + scdStart + ", scdEnd=" + scdEnd
				+ ", scdContent=" + scdContent + "]";
	}

	
	
	
}
