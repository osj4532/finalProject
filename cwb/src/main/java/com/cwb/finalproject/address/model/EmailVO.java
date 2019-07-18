package com.cwb.finalproject.address.model;

import java.sql.Timestamp;

public class EmailVO {
	private int mailNo;
	private int mailRev;
	private String mailRevAddr;
	private String mailSenAddr;
	private String mailTitle;
	private String mailContent;
	private String mailFileName;
	private String mailOriginalFileName;
	private long mailFileSize;
	private Timestamp mailRegdate;
	public int getMailNo() {
		return mailNo;
	}
	public void setMailNo(int mailNo) {
		this.mailNo = mailNo;
	}
	public int getMailRev() {
		return mailRev;
	}
	public void setMailRev(int mailRev) {
		this.mailRev = mailRev;
	}
	public String getMailRevAddr() {
		return mailRevAddr;
	}
	public void setMailRevAddr(String mailRevAddr) {
		this.mailRevAddr = mailRevAddr;
	}
	public String getMailSenAddr() {
		return mailSenAddr;
	}
	public void setMailSenAddr(String mailSenAddr) {
		this.mailSenAddr = mailSenAddr;
	}
	public String getMailTitle() {
		return mailTitle;
	}
	public void setMailTitle(String mailTitle) {
		this.mailTitle = mailTitle;
	}
	public String getMailContent() {
		return mailContent;
	}
	public void setMailContent(String mailContent) {
		this.mailContent = mailContent;
	}
	public String getMailFileName() {
		return mailFileName;
	}
	public void setMailFileName(String mailFileName) {
		this.mailFileName = mailFileName;
	}
	public String getMailOriginalFileName() {
		return mailOriginalFileName;
	}
	public void setMailOriginalFileName(String mailOriginalFileName) {
		this.mailOriginalFileName = mailOriginalFileName;
	}
	public long getMailFileSize() {
		return mailFileSize;
	}
	public void setMailFileSize(long mailFileSize) {
		this.mailFileSize = mailFileSize;
	}
	public Timestamp getMailRegdate() {
		return mailRegdate;
	}
	public void setMailRegdate(Timestamp mailRegdate) {
		this.mailRegdate = mailRegdate;
	}
	@Override
	public String toString() {
		return "EmailVO [mailNo=" + mailNo + ", mailRev=" + mailRev + ", mailRevAddr=" + mailRevAddr + ", mailSenAddr="
				+ mailSenAddr + ", mailTitle=" + mailTitle + ", mailContent=" + mailContent + ", mailFileName="
				+ mailFileName + ", mailOriginalFileName=" + mailOriginalFileName + ", mailFileSize=" + mailFileSize
				+ ", mailRegdate=" + mailRegdate + "]";
	}
}
