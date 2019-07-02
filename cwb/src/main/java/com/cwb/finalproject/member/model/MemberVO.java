package com.cwb.finalproject.member.model;

import java.sql.Timestamp;

public class MemberVO {
	private int memNo; //사원번호
	private int ranksNo;	//사원등급번호
	private int deptNo;	//사원부서번호
	private String memName;	//사원이름
	private String memHp1;	//사원연락처1
	private String memHp2;	//사원연락처2
	private String memHp3;	//사원연락처3
	private String memEmail1;	//사원이메일1
	private String memEmail2;	//사원이메일2
	private String memZipcode;	//사원우편번호
	private String memAddress;	//사원주소
	private String memAddressDetail;	//사원상세주소
	private String memFileName;	//사원사진이름
	private String memOriginalFileName;	//사원사진원래이름
	private Timestamp memJoinDate;	//사원입사일
	private Timestamp memResignDate;	//사원퇴사일
	private String memAchievement;	//사원학력
	private int memPay;	//사원연봉
	private int memHoliday;	//사원연차
	private int memUseHoliday;	//사원사용한연차
	private int posNo;	//직급번호
	
	public int getMemNo() {
		return memNo;
	}
	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}
	public int getRanksNo() {
		return ranksNo;
	}
	public void setRanksNo(int ranksNo) {
		this.ranksNo = ranksNo;
	}
	public int getDeptNo() {
		return deptNo;
	}
	public void setDeptNo(int deptNo) {
		this.deptNo = deptNo;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getMemHp1() {
		return memHp1;
	}
	public void setMemHp1(String memHp1) {
		this.memHp1 = memHp1;
	}
	public String getMemHp2() {
		return memHp2;
	}
	public void setMemHp2(String memHp2) {
		this.memHp2 = memHp2;
	}
	public String getMemHp3() {
		return memHp3;
	}
	public void setMemHp3(String memHp3) {
		this.memHp3 = memHp3;
	}
	public String getMemEmail1() {
		return memEmail1;
	}
	public void setMemEmail1(String memEmail1) {
		this.memEmail1 = memEmail1;
	}
	public String getMemEmail2() {
		return memEmail2;
	}
	public void setMemEmail2(String memEmail2) {
		this.memEmail2 = memEmail2;
	}
	public String getMemZipcode() {
		return memZipcode;
	}
	public void setMemZipcode(String memZipcode) {
		this.memZipcode = memZipcode;
	}
	public String getMemAddress() {
		return memAddress;
	}
	public void setMemAddress(String memAddress) {
		this.memAddress = memAddress;
	}
	public String getMemAddressDetail() {
		return memAddressDetail;
	}
	public void setMemAddressDetail(String memAddressDetail) {
		this.memAddressDetail = memAddressDetail;
	}
	public String getMemFileName() {
		return memFileName;
	}
	public void setMemFileName(String memFileName) {
		this.memFileName = memFileName;
	}
	public String getMemOriginalFileName() {
		return memOriginalFileName;
	}
	public void setMemOriginalFileName(String memOriginalFileName) {
		this.memOriginalFileName = memOriginalFileName;
	}
	public Timestamp getMemJoinDate() {
		return memJoinDate;
	}
	public void setMemJoinDate(Timestamp memJoinDate) {
		this.memJoinDate = memJoinDate;
	}
	public Timestamp getMemResignDate() {
		return memResignDate;
	}
	public void setMemResignDate(Timestamp memResignDate) {
		this.memResignDate = memResignDate;
	}
	public String getMemAchievement() {
		return memAchievement;
	}
	public void setMemAchievement(String memAchievement) {
		this.memAchievement = memAchievement;
	}
	public int getMemPay() {
		return memPay;
	}
	public void setMemPay(int memPay) {
		this.memPay = memPay;
	}
	public int getMemHoliday() {
		return memHoliday;
	}
	public void setMemHoliday(int memHoliday) {
		this.memHoliday = memHoliday;
	}
	public int getMemUseHoliday() {
		return memUseHoliday;
	}
	public void setMemUseHoliday(int memUseHoliday) {
		this.memUseHoliday = memUseHoliday;
	}
	public int getPosNo() {
		return posNo;
	}
	public void setPosNo(int posNo) {
		this.posNo = posNo;
	}
	@Override
	public String toString() {
		return "MemberVO [memNo=" + memNo + ", ranksNo=" + ranksNo + ", deptNo=" + deptNo + ", memName=" + memName
				+ ", memHp1=" + memHp1 + ", memHp2=" + memHp2 + ", memHp3=" + memHp3 + ", memEmail1=" + memEmail1
				+ ", memEmail2=" + memEmail2 + ", memZipcode=" + memZipcode + ", memAddress=" + memAddress
				+ ", memAddressDetail=" + memAddressDetail + ", memFileName=" + memFileName + ", memOriginalFileName="
				+ memOriginalFileName + ", memJoinDate=" + memJoinDate + ", memResignDate=" + memResignDate
				+ ", memAchievement=" + memAchievement + ", memPay=" + memPay + ", memHoliday=" + memHoliday
				+ ", memUseHoliday=" + memUseHoliday + ", posNo=" + posNo + "]";
	}
	
	
}
