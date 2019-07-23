package com.cwb.finalproject.message.model;

import java.sql.Timestamp;

public class MessageVO {
	private int msgNo;
	private int memNo;
	private String msgTitle;
	private String msgContent;
	private Timestamp msgRegdate;
	private String msgDel;
	public int getMsgNo() {
		return msgNo;
	}
	public void setMsgNo(int msgNo) {
		this.msgNo = msgNo;
	}
	public int getMemNo() {
		return memNo;
	}
	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}
	public String getMsgTitle() {
		return msgTitle;
	}
	public void setMsgTitle(String msgTitle) {
		this.msgTitle = msgTitle;
	}
	public String getMsgContent() {
		return msgContent;
	}
	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}
	public Timestamp getMsgRegdate() {
		return msgRegdate;
	}
	public void setMsgRegdate(Timestamp msgRegdate) {
		this.msgRegdate = msgRegdate;
	}
	public String getMsgDel() {
		return msgDel;
	}
	public void setMsgDel(String msgDel) {
		this.msgDel = msgDel;
	}
	@Override
	public String toString() {
		return "MessageVO [msgNo=" + msgNo + ", memNo=" + memNo + ", msgTitle=" + msgTitle + ", msgContent="
				+ msgContent + ", msgRegdate=" + msgRegdate + ", msgDel=" + msgDel + "]";
	}
	
	
}
