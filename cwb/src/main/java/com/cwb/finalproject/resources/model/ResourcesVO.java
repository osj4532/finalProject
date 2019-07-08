package com.cwb.finalproject.resources.model;

public class ResourcesVO {
	private int resNo; /* 자원번호 */
	private int typeNo; /* 종류번호 */
	private String resName; /* 자원명 */
	private int resPrice; /* 가격 */
	private String resRegdate; /* 등록일 */
	private String resLocation; /* 자원위치 */
	private String resInformation;   /* 자원정보 */
	private String apprFlag; /* 승인방식 */
	private String reservFlag;  /* 예약가능 */
	private String resFilename;  /* 사진파일이름 */
	private int resFilesize;  /* 사진파일크기 */
	private String resOriginalfilename;   /* 사진파일원래이름 */
	public int getResNo() {
		return resNo;
	}
	public void setResNo(int resNo) {
		this.resNo = resNo;
	}
	public int getTypeNo() {
		return typeNo;
	}
	public void setTypeNo(int typeNo) {
		this.typeNo = typeNo;
	}
	public String getResName() {
		return resName;
	}
	public void setResName(String resName) {
		this.resName = resName;
	}
	public int getResPrice() {
		return resPrice;
	}
	public void setResPrice(int resPrice) {
		this.resPrice = resPrice;
	}
	public String getResRegdate() {
		return resRegdate;
	}
	public void setResRegdate(String resRegdate) {
		this.resRegdate = resRegdate;
	}
	public String getResLocation() {
		return resLocation;
	}
	public void setResLocation(String resLocation) {
		this.resLocation = resLocation;
	}
	public String getResInformation() {
		return resInformation;
	}
	public void setResInformation(String resInformation) {
		this.resInformation = resInformation;
	}
	public String getApprFlag() {
		return apprFlag;
	}
	public void setApprFlag(String apprFlag) {
		this.apprFlag = apprFlag;
	}
	public String getReservFlag() {
		return reservFlag;
	}
	public void setReservFlag(String reservFlag) {
		this.reservFlag = reservFlag;
	}
	public String getResFilename() {
		return resFilename;
	}
	public void setResFilename(String resFilename) {
		this.resFilename = resFilename;
	}
	public int getResFilesize() {
		return resFilesize;
	}
	public void setResFilesize(int resFilesize) {
		this.resFilesize = resFilesize;
	}
	public String getResOriginalfilename() {
		return resOriginalfilename;
	}
	public void setResOriginalfilename(String resOriginalfilename) {
		this.resOriginalfilename = resOriginalfilename;
	}
	@Override
	public String toString() {
		return "ResourcesVO [resNo=" + resNo + ", typeNo=" + typeNo + ", resName=" + resName + ", resPrice=" + resPrice
				+ ", resRegdate=" + resRegdate + ", resLocation=" + resLocation + ", resInformation=" + resInformation
				+ ", apprFlag=" + apprFlag + ", reservFlag=" + reservFlag + ", resFilename=" + resFilename
				+ ", resFilesize=" + resFilesize + ", resOriginalfilename=" + resOriginalfilename + "]";
	}
	
	
}
