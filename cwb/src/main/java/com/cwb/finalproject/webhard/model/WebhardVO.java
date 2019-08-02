package com.cwb.finalproject.webhard.model;

import java.util.Date;

public class WebhardVO {
	private int fileNo;
	private int webNo;
	private int memNo;
	private String fileName;
	private String fileOriginalfilename;
	private long fileFilesize;
	private Date fileRegdate;
	private Date fileChangedate;
	
	public int getFileNo() {
		return fileNo;
	}
	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}
	public int getWebNo() {
		return webNo;
	}
	public void setWebNo(int webNo) {
		this.webNo = webNo;
	}
	public int getMemNo() {
		return memNo;
	}
	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileOriginalfilename() {
		return fileOriginalfilename;
	}
	public void setFileOriginalfilename(String fileOriginalfilename) {
		this.fileOriginalfilename = fileOriginalfilename;
	}
	public long getFileFilesize() {
		return fileFilesize;
	}
	public void setFileFilesize(long fileFilesize) {
		this.fileFilesize = fileFilesize;
	}
	public Date getFileRegdate() {
		return fileRegdate;
	}
	public void setFileRegdate(Date fileRegdate) {
		this.fileRegdate = fileRegdate;
	}
	public Date getFileChangedate() {
		return fileChangedate;
	}
	public void setFileChangedate(Date fileChangedate) {
		this.fileChangedate = fileChangedate;
	}
	
	@Override
	public String toString() {
		return "WebhardVO [fileNo=" + fileNo + ", webNo=" + webNo + ", memNo=" + memNo + ", fileName=" + fileName
				+ ", fileOriginalfilename=" + fileOriginalfilename + ", fileFilesize=" + fileFilesize + ", fileRegdate="
				+ fileRegdate + ", fileChangedate=" + fileChangedate + "]";
	}
	

}
