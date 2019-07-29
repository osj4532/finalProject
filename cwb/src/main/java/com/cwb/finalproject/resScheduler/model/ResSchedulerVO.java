package com.cwb.finalproject.resScheduler.model;

public class ResSchedulerVO {
	private int reservNo; /* 예약번호 */
	private int memNo;  /* 사원번호 */
	private int resNo;  /* 자원번호 */
	private String useRegdate;  /* 사용날짜 */
	private String returnRegdate; /* 반납날짜 */
	private String reservTitle;  /* 예약내용 */
	private String reservContent;  /* 예약내용 */
	private String apprFlag; /* 승인여부 */
	
	private boolean isday;

	public String getReservTitle() {
		return reservTitle;
	}

	public void setReservTitle(String reservTitle) {
		this.reservTitle = reservTitle;
	}

	public int getReservNo() {
		return reservNo;
	}

	public void setReservNo(int reservNo) {
		this.reservNo = reservNo;
	}

	public int getMemNo() {
		return memNo;
	}

	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}

	public int getResNo() {
		return resNo;
	}

	public void setResNo(int resNo) {
		this.resNo = resNo;
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

	public String getReservContent() {
		return reservContent;
	}

	public void setReservContent(String reservContent) {
		this.reservContent = reservContent;
	}

	public String getApprFlag() {
		return apprFlag;
	}

	public void setApprFlag(String apprFlag) {
		this.apprFlag = apprFlag;
	}

	public boolean isIsday() {
		return isday;
	}

	public void setIsday(boolean isday) {
		this.isday = isday;
	}

	@Override
	public String toString() {
		return "ResSchedulerVO [reservNo=" + reservNo + ", memNo=" + memNo + ", resNo=" + resNo + ", useRegdate="
				+ useRegdate + ", returnRegdate=" + returnRegdate + ", reservContent=" + reservContent + ", apprFlag="
				+ apprFlag + ", isday=" + isday + "]";
	}
	
	
	
	
}
