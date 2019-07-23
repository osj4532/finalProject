package com.cwb.finalproject.message.model;

import java.sql.Timestamp;

public class MsgRevVO {
	private int msgrevNo;
	private int memNo;
	private int msgNo;
	private String msgrevDel;
	private Timestamp msgrevDate;
	public int getMsgrevNo() {
		return msgrevNo;
	}
	public void setMsgrevNo(int msgrevNo) {
		this.msgrevNo = msgrevNo;
	}
	public int getMemNo() {
		return memNo;
	}
	public void setMemNo(int memNo) {
		this.memNo = memNo;
	}
	public int getMsgNo() {
		return msgNo;
	}
	public void setMsgNo(int msgNo) {
		this.msgNo = msgNo;
	}
	public String getMsgrevDel() {
		return msgrevDel;
	}
	public void setMsgrevDel(String msgrevDel) {
		this.msgrevDel = msgrevDel;
	}
	public Timestamp getMsgrevDate() {
		return msgrevDate;
	}
	public void setMsgrevDate(Timestamp msgrevDate) {
		this.msgrevDate = msgrevDate;
	}
	@Override
	public String toString() {
		return "MsgRevVO [msgrevNo=" + msgrevNo + ", memNo=" + memNo + ", msgNo=" + msgNo + ", msgrevDel=" + msgrevDel
				+ ", msgrevDate=" + msgrevDate + "]";
	}
	
}
