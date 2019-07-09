package com.cwb.finalproject.confirm.model;

public class ConfirmFileVO {
	private int fileNo;
	private String fileName;
	private String fileOriginalName;
	private long fileSize;
	private int cfNo;
	public int getFileNo() {
		return fileNo;
	}
	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileOriginalName() {
		return fileOriginalName;
	}
	public void setFileOriginalName(String fileOriginalName) {
		this.fileOriginalName = fileOriginalName;
	}
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	public int getCfNo() {
		return cfNo;
	}
	public void setCfNo(int cfNo) {
		this.cfNo = cfNo;
	}
	@Override
	public String toString() {
		return "ConfirmFileVO [fileNo=" + fileNo + ", fileName=" + fileName + ", fileOriginalName=" + fileOriginalName
				+ ", fileSize=" + fileSize + ", cfNo=" + cfNo + "]";
	}
	
	
}
